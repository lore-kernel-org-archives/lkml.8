Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50AEC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDABE2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWm5ApN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgCIKPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:15:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50145 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726487AbgCIKPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583748903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=77GwOo3dJvMMY5EsUFtosa5OLtVohxUzfDzSlHPcPtQ=;
        b=FWm5ApN386cb+pwhYw10WgzwAANosnFk3z2TUkVd2mzrnS+ZDHNJcZEmoQeVdU2ONvpaT0
        fR+RdVycpCPEYmH4HBKUxHhlrEJquHcUqZw5+q6ml6Gz3+Jb07cqoVap2BQz5vdNuCWjk/
        hBYs/K2AcnhVapZ/B+P0+Zqcpmspaf8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-FxeKOd15ML-b-WRMRzdYfw-1; Mon, 09 Mar 2020 06:15:02 -0400
X-MC-Unique: FxeKOd15ML-b-WRMRzdYfw-1
Received: by mail-qk1-f197.google.com with SMTP id w124so6911550qkd.19
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 03:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=77GwOo3dJvMMY5EsUFtosa5OLtVohxUzfDzSlHPcPtQ=;
        b=rhfHuzvlMwpcELO9uhj/tdexT1KHxoqWH1Qr8DqNVdmFCKKYYYwf+lkZZJUSuJNxfz
         1Ae8p8jGOCL9nZWLP2ZJjMw/EEBBxdjX08GrfY6lE7kE3AuyWmoLrAw+FJkwpirHWLbV
         dY1rBznwNNG1yugHFivLUBm4xqYPoKB5MfA40oilBS0hG/kFRla3fc7p9GWQtpxLwMXk
         xvoiHv7kK3YffXFdi1VnXLvaCUxsHUv6bo11mhvJY9+c3h2GZSZnCdlpqieUCxKYe/q6
         1Y7wzwKceRc50fTNhJSUf0UDxvgyt44mgJZF+oiyn8AeKo4c93eAtcKif81Tasw1JKON
         HqUw==
X-Gm-Message-State: ANhLgQ0cgxlDJIPl7T1q4RCz6oMxLPMyFGLtvGy7pzJdk3/PiWWfep4o
        7k7qd4RFm237fSDnsWKCAlE5DjFSnK3NgM+kE/aGJYwv3UUcMrq7uaGTiQohCOSmGmzMvG5dKT/
        efKI8Ir8Cju30jf3jTUX4eoBC
X-Received: by 2002:a05:620a:45:: with SMTP id t5mr14504889qkt.183.1583748901945;
        Mon, 09 Mar 2020 03:15:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtfD5xstQ+O6d+qn8lUbNErH2WtviwPZFrpi5EEEd3e9u07levRrO15iYSkAMgTmNP7vp20Mw==
X-Received: by 2002:a05:620a:45:: with SMTP id t5mr14504877qkt.183.1583748901718;
        Mon, 09 Mar 2020 03:15:01 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id 184sm5164615qkh.63.2020.03.09.03.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 03:15:00 -0700 (PDT)
Date:   Mon, 9 Mar 2020 06:14:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Tyler Sanderson <tysand@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Message-ID: <20200309061403-mutt-send-email-mst@kernel.org>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <f31eff75-b328-de41-c2cc-e55471aa27d8@redhat.com>
 <20200216044641-mutt-send-email-mst@kernel.org>
 <CAJuQAmqmOQMx3A8g81pnFLyTZ5E5joSCEGG5fBwPOBH7crdi2w@mail.gmail.com>
 <CAJuQAmphPcfew1v_EOgAdSFiprzjiZjmOf3iJDmFX0gD6b9TYQ@mail.gmail.com>
 <86453fed-1f39-dfcc-33c6-54241478e2ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86453fed-1f39-dfcc-33c6-54241478e2ab@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 10:03:14AM +0100, David Hildenbrand wrote:
> On 08.03.20 05:47, Tyler Sanderson wrote:
> > Tested-by: Tyler Sanderson <tysand@google.com>
> > 
> > Test setup: VM with 16 CPU, 64GB RAM. Running Debian 10. We have a 42
> > GB file full of random bytes that we continually cat to /dev/null.
> > This fills the page cache as the file is read. Meanwhile we trigger
> > the balloon to inflate, with a target size of 53 GB. This setup causes
> > the balloon inflation to pressure the page cache as the page cache is
> > also trying to grow. Afterwards we shrink the balloon back to zero (so
> > total deflate = total inflate).
> > 
> > Without patch (kernel 4.19.0-5):
> > Inflation never reaches the target until we stop the "cat file >
> > /dev/null" process. Total inflation time was 542 seconds. The longest
> > period that made no net forward progress was 315 seconds (see attached
> > graph).
> > Result of "grep balloon /proc/vmstat" after the test:
> > balloon_inflate 154828377
> > balloon_deflate 154828377
> > 
> > With patch (kernel 5.6.0-rc4+):
> > Total inflation duration was 63 seconds. No deflate-queue activity
> > occurs when pressuring the page-cache.
> > Result of "grep balloon /proc/vmstat" after the test:
> > balloon_inflate 12968539
> > balloon_deflate 12968539
> > 
> > Conclusion: This patch fixes the issue. In the test it reduced
> > inflate/deflate activity by 12x, and reduced inflation time by 8.6x.
> > But more importantly, if we hadn't killed the "grep balloon
> > /proc/vmstat" process then, without the patch, the inflation process
> > would never reach the target.
> > 
> > Attached is a png of a graph showing the problematic behavior without
> > this patch. It shows deflate-queue activity increasing linearly while
> > balloon size stays constant over the course of more than 8 minutes of
> > the test.
> 
> Thanks a lot for the extended test!


Given we shipped this for a long time, I think the best way
to make progress is to merge 1/3, 2/3 right now, and 3/3
in the next release.

> -- 
> Thanks,
> 
> David / dhildenb

