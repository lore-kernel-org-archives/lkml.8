Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B1BC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E712064C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWLYeAtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgAXDCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:02:16 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36933 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730537AbgAXDCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 22:02:15 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so412248pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 19:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vTpqRdteOFP7ZcUKKdjIBwigRkGTjIfqlFVk01LKeUs=;
        b=AWLYeAtQi+DDW+tQOMkc23VJYZNYDwCGM1IVtnrGRGaFNMOla/hH2Vou0nCBvIQmjf
         YcDzV0SCP2nK9OxCkILwOybQSLYbGkUyvVvJvkk+77Rth+MRvlobNyHkjSULTYLJyNzE
         uhSAGwwHPXEcN5uOdYI34kEB2c7m8UJ3t+kWvzunHmlg3sV6J97JLTJJzAwyvBu7Qs1p
         K6Rmj6RmO/FGB9n4vAQr+LstTBdURtNnSleaRwgyqNdifUBujb/SkopMMvbEf48ctpPu
         dDoB9r3QSA89vOLu7YeDPFZTWLaguagfmV+1V3eDrnwVjj1/aLk74nGznbvgLlYWVtk1
         1rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vTpqRdteOFP7ZcUKKdjIBwigRkGTjIfqlFVk01LKeUs=;
        b=rYTR6ds4RikwfvFEd0c6C08QqmtWrhtm8JyO9qqsWzW3Bxrrbve6QAJ81b7s85I4tc
         GzTc05IIf+8KObRI7xwta2gC/S2E5sk83R4js725yu4L9kLX3DbjpFblFwI+MTwg0J3H
         o6eCjpYk2ev60hS9tgeB7FzXJVsWww35/OzizBzw/YGE6zD1cuY7XFPlooRYoEG2/OER
         ztJS90GbEdPD/La2MqCDkDQm/WgLx5idFxv+yvTa28RUlQC4teItEw36rY1Y6PW23j3W
         q2uAABDcuscid6YAo8/40iW+whNKmtTdC+YX2yxLQjxorT6NQxFuBAGifNlRLCUbH7Lg
         nZiA==
X-Gm-Message-State: APjAAAWTE/QnulEeyYMI3JNOyEWkx3TSKJeu2OqYo2c89awT6HsbGGlk
        fqYRoPuKsU3ULR3U83o64Rg/AA==
X-Google-Smtp-Source: APXvYqxFmHyQNmdE9Cw5xHuQqhPiMRcWFPKciwPTJk2JTeinIi9gmZqfrNUUJiK4j5ttuD1ioSjAZA==
X-Received: by 2002:a17:902:708c:: with SMTP id z12mr1285339plk.15.1579834934905;
        Thu, 23 Jan 2020 19:02:14 -0800 (PST)
Received: from localhost ([122.167.18.14])
        by smtp.gmail.com with ESMTPSA id o184sm4239310pgo.62.2020.01.23.19.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 19:02:13 -0800 (PST)
Date:   Fri, 24 Jan 2020 08:32:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     arnd@arndb.de, jassisinghbrar@gmail.com, cristian.marussi@arm.com,
        peng.fan@nxp.com, peter.hilber@opensynergy.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4] firmware: arm_scmi: Make scmi core independent of the
 transport type
Message-ID: <20200124030212.qjlzz75dgt5kla7t@vireshk-i7>
References: <20200121183818.GA11522@bogus>
 <a9ec58818b5e0c982810e74efe3f5f22b930ae40.1579660436.git.viresh.kumar@linaro.org>
 <20200122121538.GA31240@bogus>
 <20200123103033.GA7511@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123103033.GA7511@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-20, 10:30, Sudeep Holla wrote:
> WARNING: CPU: 1 PID: 187 at drivers/base/dd.c:519 really_probe+0x11c/0x418
> Modules linked in:
> CPU: 1 PID: 187 Comm: kworker/1:2 Not tainted 5.5.0-rc7-00026-gf7231cd3108d-dirty #20
> Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan 16 2020
> Workqueue: events deferred_probe_work_func
> pstate: 80000005 (Nzcv daif -PAN -UAO)
> pc : really_probe+0x11c/0x418
> lr : really_probe+0x10c/0x418
> Call trace:
>  really_probe+0x11c/0x418
>  driver_probe_device+0xe4/0x138
>  __device_attach_driver+0x90/0x110
>  bus_for_each_drv+0x80/0xd0
>  __device_attach+0xdc/0x160
>  device_initial_probe+0x18/0x20
>  bus_probe_device+0x98/0xa0
>  deferred_probe_work_func+0x90/0xe0
>  process_one_work+0x1ec/0x4a8
>  worker_thread+0x210/0x490
>  kthread+0x110/0x118
>  ret_from_fork+0x10/0x18
> ---[ end trace 06f96d55ce6093a8 ]---

linux-next didn't had a WARN at line 519 and so I looked at the
difference between your and my branch and reached to this patch:

commit 7c35e699c88bd60734277b26962783c60e04b494
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Fri Dec 6 14:22:19 2019 +0100

    driver core: Print device when resources present in really_probe()
    
    If a device already has devres items attached before probing, a warning
    backtrace is printed.  However, this backtrace does not reveal the
    offending device, leaving the user uninformed.  Furthermore, using
    WARN_ON() causes systems with panic-on-warn to reboot.
    
    Fix this by replacing the WARN_ON() by a dev_crit() message.
    Abort probing the device, to prevent doing more damage to the device's
    resources.
    
    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
    Link: https://lore.kernel.org/r/20191206132219.28908-1-geert+renesas@glider.be
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/dd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d811e60610d3..b25bcab2a26b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -516,7 +516,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
        atomic_inc(&probe_count);
        pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
                 drv->bus->name, __func__, drv->name, dev_name(dev));
-       WARN_ON(!list_empty(&dev->devres_head));
+       if (!list_empty(&dev->devres_head)) {
+               dev_crit(dev, "Resources present before probing\n");
+               return -EBUSY;
+       }
 
 re_probe:
        dev->driver = drv;


-------------------------8<-------------------------

I think this defines the problem somewhat, though I wasn't able to
reproduce the problem on my platform :)

-- 
viresh
