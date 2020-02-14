Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A7FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509292187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581689209;
	bh=/bPKhoaD4etvOi7C9q8mw5/sTB1HKiUtxrEH2C5Pz2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qoWgt3My9yhFAoYYY6KAJUXTZ6qPzuZ3p/KVNrTunhzjfQQ8PATVFTq8muiJ8PTMz
	 xwmr43STZPmYpVUugAHZB0ssOHkzvTg2ZipIpXGA8ovmlIc7F0I1cne45jgRL5aoWO
	 65qdtXkMOVhPvmLK/I0fg7jjHJAyJP+HfUbkMmqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbgBNOGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:06:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42797 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbgBNOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:06:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so11030612wrd.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 06:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4/DviMTLAqxW+NTVLow2DllCrC7LZyuIIAbFynwyDuk=;
        b=c1I8KGZKe5TO/p4kt5zipgo1sQwR9pNOAG3slgku6LoOoLlyl2zuDXrkDH4+PbNAIn
         ocLtmvtPPXvyxnmFaaYuKqj+EO+BUhJQmCmbiY8EMF/OZ+dfcun7k8se85FiqaqTbz2g
         yak+2aZMGFYJH0CVhDfoHXq3qZR0sOzUju2yYcQ0CxTn3UMt5826FdItFeydkOcPDSFE
         P+6BGrYqm/Vj71ObVN6Oqpkt7y7eXZDIUFLPZ/ka9TaP/a4qLUuL39CQm6IhXODqhlZR
         XkHzaS5q6doxUFc1INbSvTc3Xcxb0Ra+Mc99FbcFWjZ8cam4X5Wp2htcZ71P7lTkTcml
         2NRQ==
X-Gm-Message-State: APjAAAV98I90B1gSivaJ8dd0XS8pmGIURgo+9640GrClQrkagsddG1Hz
        WU8lQghw2LaAfhUiUJ2SyxQ=
X-Google-Smtp-Source: APXvYqwqAYkIzT1DaMbqwJUULUwsZd6efBR4EsJ+5TXnBVtDKLC5Wnyppu4eiSOPMu38VVysNStKhA==
X-Received: by 2002:adf:fa43:: with SMTP id y3mr4204102wrr.65.1581689203326;
        Fri, 14 Feb 2020 06:06:43 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id q14sm7263208wrj.81.2020.02.14.06.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 06:06:42 -0800 (PST)
Date:   Fri, 14 Feb 2020 15:06:41 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Tyler Sanderson <tysand@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Message-ID: <20200214140641.GB31689@dhcp22.suse.cz>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205163402.42627-4-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-02-20 17:34:02, David Hildenbrand wrote:
> Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
> changed the behavior when deflation happens automatically. Instead of
> deflating when called by the OOM handler, the shrinker is used.
> 
> However, the balloon is not simply some slab cache that should be
> shrunk when under memory pressure. The shrinker does not have a concept of
> priorities, so this behavior cannot be configured.

Adding a priority to the shrinker doesn't sound like a big problem to
me. Shrinkers already get shrink_control data structure already and
priority could be added there.

> There was a report that this results in undesired side effects when
> inflating the balloon to shrink the page cache. [1]
> 	"When inflating the balloon against page cache (i.e. no free memory
> 	 remains) vmscan.c will both shrink page cache, but also invoke the
> 	 shrinkers -- including the balloon's shrinker. So the balloon
> 	 driver allocates memory which requires reclaim, vmscan gets this
> 	 memory by shrinking the balloon, and then the driver adds the
> 	 memory back to the balloon. Basically a busy no-op."
> 
> The name "deflate on OOM" makes it pretty clear when deflation should
> happen - after other approaches to reclaim memory failed, not while
> reclaiming. This allows to minimize the footprint of a guest - memory
> will only be taken out of the balloon when really needed.
> 
> Especially, a drop_slab() will result in the whole balloon getting
> deflated - undesired.

Could you explain why some more? drop_caches shouldn't be really used in
any production workloads and if somebody really wants all the cache to
be dropped then why is balloon any different?

-- 
Michal Hocko
SUSE Labs
