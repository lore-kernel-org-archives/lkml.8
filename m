Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C20C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A2E207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="gD/PAM/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHTIPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgHTIOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:14:46 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8FAC061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:14:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id bo3so1414758ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g0v1TVbYwAwmSoj7QGga3H4kAFy2bpvMW+yENdu88bQ=;
        b=gD/PAM/5z1gJRM2L/hhs83u2G6dxhrlGRNjPZAcXA3Ps9AmnRfVlDkONc+Q8/z3MqF
         r7CLU1FiuK5MYHIjYMmYsZNiOXnJ40x7r+54XF3GM5ZDO0+q6Nfl1TycK48mzcYKZxHj
         Neuc0LfbNED/FWHLB6rJseceEqy3BbaZXj9aF38/V2eTs7cW+D8J27UMsyUIIJFpEWDD
         kTjTdv1yUm3JFqAEuxmPgQzq+0pC/rDTM9iWveV5N/muRWClRvxBK9H70Ew42Dn9aDw8
         gh/tDB2uatVehzTr5FzdomsNecR8voBgz6+mW+JUwFtSdENL6cVmGxjrJmf3lDuaAwHX
         ChAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g0v1TVbYwAwmSoj7QGga3H4kAFy2bpvMW+yENdu88bQ=;
        b=ZU6+xGQMLQgvb33zdqMKY7XP0fB17PywW1ulXAEVvG87ELmsTmRbx+TTCZNMyqE/zs
         /O8Dlt+xoGqfmUueLf3c+ESWMqoZJKiQ8U6/BVvI6HJ0QuQ0CRoAzHMhNocYOyBMDHFL
         ctUn1r6y56m9a31N3WuAF9agWNnYwH+VFJP+cPjKVX8hPhabpCwgLDAEgKdK37Yq0X7y
         acR8oserVce+QCjurnwP8j/gqzc7Z6PrNR9jdNmvq9vlm++plKZ3IXiYN4p8HBEIsaGu
         nf0Y8Z6AXDvIqsiG86XuaRmpCvZKEd1lSFTgXSytY9XNImPCUIsrC3xiBXoKBMNbgkvc
         Y6pw==
X-Gm-Message-State: AOAM532ulrLtTUC69+6RH8qHzKdrxIJzgTaTftrOhOft2pEFw/WEv4/i
        LnJuyST/PxjTHT4Aksfz5p7aZA==
X-Google-Smtp-Source: ABdhPJyn8U936iLeaPbvcl7H9ouAf63VVQN83bsoVOmETCnR61Of4Sv7JsOqloslCk6sXLAbzCclGg==
X-Received: by 2002:a17:906:1757:: with SMTP id d23mr1017684eje.126.1597911284556;
        Thu, 20 Aug 2020 01:14:44 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id v7sm912049edd.48.2020.08.20.01.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 01:14:43 -0700 (PDT)
From:   Javier Gonzalez <javier@javigon.com>
X-Google-Original-From: Javier Gonzalez <javier.gonz@samsung.com>
Date:   Thu, 20 Aug 2020 10:14:43 +0200
To:     Kanchan Joshi <joshiiitr@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        David Fugate <david.fugate@linux.intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820081443.fwu7z3webjkhpeuv@mpHalley.local>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <20200819214248.GA26769@dhcp-10-100-145-180.wdl.wdc.com>
 <CA+1E3rJgvvebEex-zVBGtqK_BAaQUtcwq9nDoFm+Rd=DD20zxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+1E3rJgvvebEex-zVBGtqK_BAaQUtcwq9nDoFm+Rd=DD20zxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.2020 13:07, Kanchan Joshi wrote:
>On Thu, Aug 20, 2020 at 3:22 AM Keith Busch <kbusch@kernel.org> wrote:
>>
>> On Wed, Aug 19, 2020 at 01:11:58PM -0600, David Fugate wrote:
>> > Intel does not support making *optional* NVMe spec features *required*
>> > by the NVMe driver.
>>
>> This is inaccurate. As another example, the spec optionally allows a
>> zone size to be a power of 2, but linux requires a power of 2 if you
>> want to use it with this driver.
>>
>> > Provided there's no glaring technical issues
>>
>> There are many. Some may be improved through a serious review process,
>> but the mess it makes out of the fast path is measurably harmful to
>> devices that don't subscribe to this. That issue is not so easily
>> remedied.
>>
>> Since this patch is a copy of the scsi implementation, the reasonable
>> thing is take this fight to the generic block layer for a common
>> solution. We're not taking this in the nvme driver.
>
>I sincerely want to minimize any adverse impact to the fast-path of
>non-zoned devices.
>My understanding of that aspect is (I feel it is good to confirm,
>irrespective of the future of this patch):
>
>1. Submission path:
>There is no extra code for non-zoned device IO. For append, there is
>this "ns->append_emulate = 1" check.
>Snippet -
>        case REQ_OP_ZONE_APPEND:
>-               ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
>+               if (!nvme_is_append_emulated(ns))
>+                       ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
>+               else {
>+                       /* prepare append like write, and adjust lba
>afterwards */
>
>2. Completion:
> Not as clean as submission for sure.
>The extra check is "ns && ns->append_emulate == 1" for completions if
>CONFIG_ZONED is enabled.
>A slightly better completion-handling version (than the submitted patch) is -
>
>-       } else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>-                  req_op(req) == REQ_OP_ZONE_APPEND) {
>-               req->__sector = nvme_lba_to_sect(req->q->queuedata,
>-                       le64_to_cpu(nvme_req(req)->result.u64));
>+       } else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
>+               struct nvme_ns *ns = req->q->queuedata;
>+               /* append-emulation requires wp update for some cmds*/
>+               if (ns && nvme_is_append_emulated(ns)) {
>+                       if (nvme_need_zone_wp_update(req))
>+                               nvme_zone_wp_update(ns, req, status);
>+               }
>+               else if (req_op(req) == REQ_OP_ZONE_APPEND)
>+                       req->__sector = nvme_lba_to_sect(ns,
>+                                       le64_to_cpu(nvme_req(req)->result.u64));
>
>Am I missing any other fast-path pain-points?
>
>A quick 1 minute 4K randwrite run (QD 64, 4 jobs,libaio) shows :
>before: IOPS=270k, BW=1056MiB/s (1107MB/s)(61.9GiB/60002msec)
>after:  IOPS=270k, BW=1055MiB/s (1106MB/s)(61.8GiB/60005msec)

It is good to use the QEMU "simulation" path that we implemented to test
performance with different delays, etc., but for these numbers to make
sense we need to put them in contrast to the simulated NAND speed, etc.

>
>This maynot be the best test to see the cost, and I am happy to
>conduct more and improvise.
>
>As for the volume of the code - it is same as SCSI emulation. And I
>can make efforts to reduce that by moving common code to blk-zone, and
>reuse in SCSI/NVMe emulation.
>In the patch I tried to isolate append-emulation by keeping everything
>into "nvme_za_emul". It contains nothing nvme'ish except nvme_ns,
>which can be turned into "driver_data".
>
>+#ifdef CONFIG_BLK_DEV_ZONED
>+struct nvme_za_emul {
>+       unsigned int nr_zones;
>+       spinlock_t zones_wp_offset_lock;
>+       u32 *zones_wp_offset;
>+       u32 *rev_wp_offset;
>+       struct work_struct zone_wp_offset_work;
>+       char *zone_wp_update_buf;
>+       struct mutex rev_mutex;
>+       struct nvme_ns *ns;
>+};
>+#endif
>
>Will that be an acceptable line of further work/discussions?

I know we spent time enabling this path, but I don't think that moving
the discussion to the block layer will have much more benefit.

Let's keep the support for these non-append devices in xNVMe and focus
on the support for the append-enabled ones in Linux. We have a lot of
good stuff in the backlog that we can start pushing.

