Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC86C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3F0207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AviZ1SR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgHTHiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgHTHiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:38:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9720DC061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:38:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so676641wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQmGB+boenn+8AWQYGoZFj5ruu/kBTP0OjM4DoRcBzM=;
        b=AviZ1SR1z3KYs/8oZaCL1cwH2GoTYKUaG1Mf7v+i8czULqXqUw5TOw+ZLKDfIYI+/P
         5pgLSO7AAtAcdIC6ilZqNd58/QJbswRzm2H8QTbkGMxazUqSDiN7Op6SUAPOGmfnrrc6
         je7fyhZTZ/iSQoIrjYE2/KbBrcX3nAY8KH5a3lzZLNofdM8/VZyNOMfChro5Sk2SEYTP
         TriwhY59mSH9pR9JTMlh34jQKmHdZbasI5wR8+JP+UHImu0Tr5QPMfucQW75o6yAM9ey
         7s8tKEwQS3s5MJrRHaDV5z5efziaDVP1okOS27kT0lXZItiM8iqWshBv5aXY3bPjXT1Z
         yGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQmGB+boenn+8AWQYGoZFj5ruu/kBTP0OjM4DoRcBzM=;
        b=U6drgT2icHnx494P2BwONCE95NXYWtx8UYBSbHIkYB783rLZA6dF1RpF6+GyTeGaZd
         /RorUZEBnQbNzSiA2GXbm3fmq0uFodI0tUy30DnO7PJW7p9Ji/9qZVzMFYW0PJvf70/4
         la4VxBfq/uHazw4w+FAYx92fyKuiGbSXtw58HwWm9AMj2G6/DR6MSD0UdB5+4NnT4SLD
         Pz8pkwa0nRHzhjI3biEGTqgmIoXoc7MgOAvgPKZsB1Fdyu+ImDofYjn98+tSE3hYIv4a
         dx7OcfaQHvIXKY+/4yIlzgopygEeX5+zEx9rLph00XPBub99k3V4aqfPnzL56n34W09h
         3FxA==
X-Gm-Message-State: AOAM531W97annbAJf+J5woNcflfZI3JEsUWdSaOWav3bLBGtMi4bbyvX
        /LY7xTTl9h4j39MnZU8BDaNUyffFT/xIy/qgF6E=
X-Google-Smtp-Source: ABdhPJyrhHyKEtU55iuD+ebeNI3eJX/NhcCqjNEYNHfndZ9F16tloec+To42PB17tAUBxv8xmPrMo8joNdVnrXkAe7Q=
X-Received: by 2002:a7b:c384:: with SMTP id s4mr2082840wmj.138.1597909093072;
 Thu, 20 Aug 2020 00:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com> <20200819214248.GA26769@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200819214248.GA26769@dhcp-10-100-145-180.wdl.wdc.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Thu, 20 Aug 2020 13:07:46 +0530
Message-ID: <CA+1E3rJgvvebEex-zVBGtqK_BAaQUtcwq9nDoFm+Rd=DD20zxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
To:     Keith Busch <kbusch@kernel.org>
Cc:     David Fugate <david.fugate@linux.intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 3:22 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Aug 19, 2020 at 01:11:58PM -0600, David Fugate wrote:
> > Intel does not support making *optional* NVMe spec features *required*
> > by the NVMe driver.
>
> This is inaccurate. As another example, the spec optionally allows a
> zone size to be a power of 2, but linux requires a power of 2 if you
> want to use it with this driver.
>
> > Provided there's no glaring technical issues
>
> There are many. Some may be improved through a serious review process,
> but the mess it makes out of the fast path is measurably harmful to
> devices that don't subscribe to this. That issue is not so easily
> remedied.
>
> Since this patch is a copy of the scsi implementation, the reasonable
> thing is take this fight to the generic block layer for a common
> solution. We're not taking this in the nvme driver.

I sincerely want to minimize any adverse impact to the fast-path of
non-zoned devices.
My understanding of that aspect is (I feel it is good to confirm,
irrespective of the future of this patch):

1. Submission path:
There is no extra code for non-zoned device IO. For append, there is
this "ns->append_emulate = 1" check.
Snippet -
        case REQ_OP_ZONE_APPEND:
-               ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
+               if (!nvme_is_append_emulated(ns))
+                       ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
+               else {
+                       /* prepare append like write, and adjust lba
afterwards */

2. Completion:
 Not as clean as submission for sure.
The extra check is "ns && ns->append_emulate == 1" for completions if
CONFIG_ZONED is enabled.
A slightly better completion-handling version (than the submitted patch) is -

-       } else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-                  req_op(req) == REQ_OP_ZONE_APPEND) {
-               req->__sector = nvme_lba_to_sect(req->q->queuedata,
-                       le64_to_cpu(nvme_req(req)->result.u64));
+       } else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+               struct nvme_ns *ns = req->q->queuedata;
+               /* append-emulation requires wp update for some cmds*/
+               if (ns && nvme_is_append_emulated(ns)) {
+                       if (nvme_need_zone_wp_update(req))
+                               nvme_zone_wp_update(ns, req, status);
+               }
+               else if (req_op(req) == REQ_OP_ZONE_APPEND)
+                       req->__sector = nvme_lba_to_sect(ns,
+                                       le64_to_cpu(nvme_req(req)->result.u64));

Am I missing any other fast-path pain-points?

A quick 1 minute 4K randwrite run (QD 64, 4 jobs,libaio) shows :
before: IOPS=270k, BW=1056MiB/s (1107MB/s)(61.9GiB/60002msec)
after:  IOPS=270k, BW=1055MiB/s (1106MB/s)(61.8GiB/60005msec)

This maynot be the best test to see the cost, and I am happy to
conduct more and improvise.

As for the volume of the code - it is same as SCSI emulation. And I
can make efforts to reduce that by moving common code to blk-zone, and
reuse in SCSI/NVMe emulation.
In the patch I tried to isolate append-emulation by keeping everything
into "nvme_za_emul". It contains nothing nvme'ish except nvme_ns,
which can be turned into "driver_data".

+#ifdef CONFIG_BLK_DEV_ZONED
+struct nvme_za_emul {
+       unsigned int nr_zones;
+       spinlock_t zones_wp_offset_lock;
+       u32 *zones_wp_offset;
+       u32 *rev_wp_offset;
+       struct work_struct zone_wp_offset_work;
+       char *zone_wp_update_buf;
+       struct mutex rev_mutex;
+       struct nvme_ns *ns;
+};
+#endif

Will that be an acceptable line of further work/discussions?

-- 
Kanchan
