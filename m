Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55903C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA8720736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7iFJBLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgDWU7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDWU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:59:50 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A3C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:59:49 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id v18so3629987qvx.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ihVUWvH7naN45tEl+tGyxd0ZwoDtNc3umBeh695OPSw=;
        b=F7iFJBLsSL5MxRQq3dyES6rsfpTKqNCnHlY6UZmEy1QRFOanmMrTKTVijiE8tTvsuB
         +jsw3jt99cjCHMPAzJlca4IftxweXwJIqfjihrVcUC622jlUBDLr3q5MdTINT4yDxnS+
         WJQSyFORRBgNXje13MmhGen8Ylwh+0KBT5xTMrSdagu7mKiazISkQy4VjnCRfPolVcGN
         URhgjASdPTgEiuzB0NTXKuulkLOXSvro/WJIe49ilkLB5lSbYCOIZUO8Nu+4slKQLStO
         KVtWHMC7P9gj2pcfL5V4zjdOKOWLTg6VYNPwAb99B4kfZLE+L8bHNVFbFEIHWpwR935Z
         zzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ihVUWvH7naN45tEl+tGyxd0ZwoDtNc3umBeh695OPSw=;
        b=dOfASx76Lz/wxVGLtesLA2uk+8v+9Rzbylm4Nhgt7Z4mzrRWrEB91Ybayq4KBJF18e
         9RMtPPsfmJ/QAOLqMhYGUQ2H2QFNc12Bda56AW4LHAj462j72hs1s2yiz6Mpn9C5ENOE
         jw7JwzQwx8zrrN438+XlnQcHGuRM5k3gWDfM8ZFNra1YkYhP7gk5t00LXW8swak3D5Gm
         jN2EVsEPeFmjEiMJ4nznzOztymYaU2tBvkM5rWBQwkCMqlkw24qc0mDr5byB0UmCYvXQ
         Fsn1Vy1PrGpSjPd6caK9lKfsEJjdOu8V+96wCG+fK1BaWUBBfwFC0wA3UIwFpTBKwtTk
         rxQA==
X-Gm-Message-State: AGi0PubZt+WbsBfCx3q9ElXeEYGMoDUCbcXPWzWmY4k9s12k75U9p441
        nj1E8+yyUWqKTD+klypaDfI=
X-Google-Smtp-Source: APiQypJHXpYYUR5/MDUJvrbaDeEG58t7M2St+MPpPFseuRWjUAvumM40T/5oREyhgFfDS1/o90AOwA==
X-Received: by 2002:a0c:8222:: with SMTP id h31mr6142237qva.106.1587675588472;
        Thu, 23 Apr 2020 13:59:48 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h25sm2586381qte.37.2020.04.23.13.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 13:59:47 -0700 (PDT)
Date:   Thu, 23 Apr 2020 16:59:47 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        khazhy@google.com, kernel@collabora.com
Subject: Re: [PATCH 0/2] Historical Service Time Path Selector
Message-ID: <20200423205947.GA13657@lobo>
References: <20200416211336.2423618-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416211336.2423618-1-krisman@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16 2020 at  5:13P -0400,
Gabriel Krisman Bertazi <krisman@collabora.com> wrote:

> Hello,
> 
> This small series implements a new path selector that leverages
> historical path IO time in order to estimate future path performance.
> Implementation details can be found on Patch 2.
> 
> This selector yields better path distribution, considering the mean
> deviation from the calculated optimal utilization, for small IO depths
> when compared to the Service Time selector with fio benchmarks.  For
> instance, on a multipath setup with 4 paths, where one path is 4 times
> slower than the rest, issuing 500MB of randwrites, we have the following
> path utilization rates:
> 
>       |    depth=1    |    depth=64   |       |
>       |   ST  |   HST |   ST  |   HST |  Best |
> |-----+-------+-------+-------+-------+-------|
> | sda | 0.250 | 0.294 | 0.297 | 0.294 | 0.307 |
> | sdb | 0.250 | 0.297 | 0.296 | 0.297 | 0.307 |
> | sdc | 0.250 | 0.296 | 0.298 | 0.296 | 0.307 |
> | sdd | 0.250 | 0.112 | 0.106 | 0.112 | 0.076 |
> 
> For small depths, HST is much quicker in detecting slow paths and has a
> better selection than ST.  As the iodepth increases, ST gets close to
> HST, which still behaves steadily.
> 
> The raw performance data for different depths types of IO can be found
> at:
> 
>   <https://people.collabora.com/~krisman/GOO0012/hst-vs-st-bench.html>
> 
> This was tested primarily on a Google cloud SAN with real data and usage
> patterns and with artificial benchmarks using fio.
> 
> Khazhismel Kumykov (2):
>   md: Expose struct request to path selector
>   md: Add Historical Service Time Path Selector

Looks like you've put a lot of time to this and I'd be happy to help
you get this to land upstream.

But... (you knew there'd be at least one "but" right? ;) I'm not
liking making this path selector request-based specific.  All other
selectors up to this point are request-based vs bio-based agnostic.

Would you be open to dropping patch 1/2 and replacing it with
something like the following patch?

Then you'd pass 'u64 start_time_ns' into the path_selector_type's
.end_io (and possibly .start_io).

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index df13fdebe21f..50121513227b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -674,6 +674,16 @@ static bool md_in_flight(struct mapped_device *md)
 		return md_in_flight_bios(md);
 }
 
+u64 dm_start_time_ns_from_clone(struct bio *bio)
+{
+	struct dm_target_io *tio = container_of(bio, struct dm_target_io, clone);
+	struct dm_io *io = tio->io;
+
+	/* FIXME: convert io->start_time from jiffies to nanoseconds */
+	return (u64)jiffies_to_msec(io->start_time) * NSEC_PER_MSEC;
+}
+EXPORT_SYMBOL_GPL(dm_start_time_ns_from_clone);
+
 static void start_io_acct(struct dm_io *io)
 {
 	struct mapped_device *md = io->md;
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 475668c69dbc..e2d506dd805e 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -329,6 +329,8 @@ void *dm_per_bio_data(struct bio *bio, size_t data_size);
 struct bio *dm_bio_from_per_bio_data(void *data, size_t data_size);
 unsigned dm_bio_get_target_bio_nr(const struct bio *bio);
 
+u64 dm_start_time_ns_from_clone(struct bio *bio);
+
 int dm_register_target(struct target_type *t);
 void dm_unregister_target(struct target_type *t);
 
