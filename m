Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B12C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 09:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E086420857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 09:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wg0TuyX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgBPJqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 04:46:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22466 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725951AbgBPJqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 04:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581846380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZtasoyQFCb5RWLLV8eTtZLdqEWZ7911rlj1gtV4FhTo=;
        b=Wg0TuyX7ug56VKv/ZBlVQp3XJWIGjqUTIxljhNVDXDxT+wxlen8KpYrfXliDXHlY55Zb3V
        7q3ex3dIOp/zoBvgx2eto+ulGeQoK93sYmTssXL9csDN53wg4PcGa8QwGObUd4+siVirJi
        e0byWmU3bDaieU1FA4q0fcWcZdW9LXo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-UdVWlisMNsumlX0v-C0EUw-1; Sun, 16 Feb 2020 04:46:18 -0500
X-MC-Unique: UdVWlisMNsumlX0v-C0EUw-1
Received: by mail-wr1-f69.google.com with SMTP id l1so7093910wrt.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 01:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZtasoyQFCb5RWLLV8eTtZLdqEWZ7911rlj1gtV4FhTo=;
        b=mzZK6ZoUJnHxCejeuC82GwpO8XnUYvv5XxZVcOWKziOCGAwRt+nEELQ6WyNcKesf/y
         avvQmoEJKmQgFyeYHxkHpnGvO1+5yYG6isIw9EVShURVCG+oQJ5T8euiWucKbB58geTv
         7LqJJMhJaQ5sPKkH4KpOEKB/unupgsv1twuuNSKO6cujqaZoieE0c9wSCp9uPySOu1o7
         e3T5LbtKNTkoe3070uB81RKs1g2o3wcP/qqS+eXyyCxHFxZZY/HaEn9ngc1v1x6Yh/26
         yx5UiwSIx/ea2cppI9NB13d9NWj0hV4F8sMnGkKMbN82eORWM7JJJsKlTM7TE5u6MhRq
         SPww==
X-Gm-Message-State: APjAAAWIcuA8PE4+85Tj+XJQU270tnBa+I5uywvGoYSfrOKVUB/UHm+d
        Iv3z6erecpmBWsOpYy2XdZB9A6lUsiR5BGdP53QzNnglRUkhpikf68leziYeF6ZMScUWmFUC8F8
        upaAjtJ9ljNQ49y3Ej3pr7wrJ
X-Received: by 2002:a05:600c:2406:: with SMTP id 6mr15804473wmp.30.1581846376893;
        Sun, 16 Feb 2020 01:46:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqxiJrJeE35F57XE7BYaxi/pj3GggCLXzH7A0bPaUDDuXSCX0jIpgP45E++A8xFP+UtWDibEKA==
X-Received: by 2002:a05:600c:2406:: with SMTP id 6mr15804448wmp.30.1581846376650;
        Sun, 16 Feb 2020 01:46:16 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
        by smtp.gmail.com with ESMTPSA id o15sm15619180wra.83.2020.02.16.01.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 01:46:15 -0800 (PST)
Date:   Sun, 16 Feb 2020 04:46:12 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tyler Sanderson <tysand@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Message-ID: <20200216044551-mutt-send-email-mst@kernel.org>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <20200214140641.GB31689@dhcp22.suse.cz>
 <802f93b1-1588-bd2c-8238-c12ec7f7ae9e@redhat.com>
 <CAJuQAmpGKcyWo8Ojnia_pXZAaOt98u0c_Sk-8ieCO218hutW1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuQAmpGKcyWo8Ojnia_pXZAaOt98u0c_Sk-8ieCO218hutW1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 12:48:42PM -0800, Tyler Sanderson wrote:
> Regarding Wei's patch that modifies the shrinker implementation, versus this
> patch which reverts to OOM notifier:
> I am in favor of both patches. But I do want to make sure a fix gets back
> ported to 4.19 where the performance regression was first introduced.
> My concern with reverting to the OOM notifier is, as mst@ put it (in the other
> thread):
> "when linux hits OOM all kind of error paths are being hit, latent bugs start
> triggering, latency goes up drastically."
> The guest could be in a lot of pain before the OOM notifier is invoked, and it
> seems like the shrinker API might allow more fine grained control of when we
> deflate.
> 
> On the other hand, I'm not totally convinced that Wei's patch is an expected
> use of the shrinker/page-cache APIs, and maybe it is fragile. Needs more
> testing and scrutiny.
> 
> It seems to me like the shrinker API is the right API in the long run, perhaps
> with some fixes and modifications. But maybe reverting to OOM notifier is the
> best patch to back port?

In that case can I see some Tested-by reports pls?


> On Fri, Feb 14, 2020 at 6:19 AM David Hildenbrand <david@redhat.com> wrote:
> 
>     >> There was a report that this results in undesired side effects when
>     >> inflating the balloon to shrink the page cache. [1]
>     >>      "When inflating the balloon against page cache (i.e. no free memory
>     >>       remains) vmscan.c will both shrink page cache, but also invoke the
>     >>       shrinkers -- including the balloon's shrinker. So the balloon
>     >>       driver allocates memory which requires reclaim, vmscan gets this
>     >>       memory by shrinking the balloon, and then the driver adds the
>     >>       memory back to the balloon. Basically a busy no-op."
>     >>
>     >> The name "deflate on OOM" makes it pretty clear when deflation should
>     >> happen - after other approaches to reclaim memory failed, not while
>     >> reclaiming. This allows to minimize the footprint of a guest - memory
>     >> will only be taken out of the balloon when really needed.
>     >>
>     >> Especially, a drop_slab() will result in the whole balloon getting
>     >> deflated - undesired.
>     >
>     > Could you explain why some more? drop_caches shouldn't be really used in
>     > any production workloads and if somebody really wants all the cache to
>     > be dropped then why is balloon any different?
>     >
> 
>     Deflation should happen when the guest is out of memory, not when
>     somebody thinks it's time to reclaim some memory. That's what the
>     feature promised from the beginning: Only give the guest more memory in
>     case it *really* needs more memory.
> 
>     Deflate on oom, not deflate on reclaim/memory pressure. (that's what the
>     report was all about)
> 
>     A priority for shrinkers might be a step into the right direction.
> 
>     --
>     Thanks,
> 
>     David / dhildenb
> 
> 

