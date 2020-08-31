Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFC3C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F01A20719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmHLOChA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgHaWPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 18:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHaWPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:15:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95A1C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:15:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id bh1so3896983plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PRLbHKUvs0I2F8OqSSyY/je3WABZbVxz3sgvDxCiaE=;
        b=gmHLOChAjhuiG4feYUyWIPaLsJlwLy9HM7atWQo0zZTU44Y0uB6PeNWXtOHcSE0h0v
         QOH3EK952sdHvEMBfMIq0jjsFlJeUh2St+lgKD3G+GLX3MNOIjXGkCrAQL2si6UCKBZP
         sAdVlMW4IyWlcxAuPknYUabsDuct6U3Y6ft2SyB3lN9zrNjBSAfizW9YE07FbDZX2DDU
         W8wZgheUbKFqchzIKEtCbfmpvZ/kQ+DWL8A8m5AcQeL9OjCHGvCTvypTpp3fpFVZsgRU
         +M0RMuo48C7dktSL+E46ZTCCSPMIrv6kuqc3F99ZdblyHNeCDfYMRV+ciJfoSuyIiJce
         Sfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PRLbHKUvs0I2F8OqSSyY/je3WABZbVxz3sgvDxCiaE=;
        b=e1CTxOGVLtuKFXzaA2VajJy53mEND1xvkTeygHOpbeqb5/34jdC/PAFhGEgSm1XVAL
         qJ27HzPH44rGB4g+p8iouDyR1ec2jrHr5h+VIAxMKCQiIkGGh3uak6CEsIHHQqAM/IAm
         ZQh6W7mFClXTFgubQHEJgW87AKbzM4TvG4dTi6ooG9o1jJMya8F25Jwy2AD/keerMuXm
         +pu/qnEy9Wu2d4uUwsNFYnGqQoGCFtqsWmHB5eARhi1kUQ3rvlXuSZej2WS2QA19GW7L
         YrEpWPSWxp5B8Bns8NE7WtoorgGMPc+b4Zfz1+W2hko019kOCvcQA6u54OsdblJuORgk
         u6UQ==
X-Gm-Message-State: AOAM530oZMu2yqyzXXPhEJYLJsGsF8fr+FcdFLMHJ9cdDaNn8hmwNRiz
        6d052HsTe+LMDQrKzXCE4Ql6rNNqc8SbBnAu6kq2Ig==
X-Google-Smtp-Source: ABdhPJwh1BCHoYlcKEJrxCwDmt1Ca4b+Acw6nX1a5B4CPevXFzCadq/cF4hUJNblW2CPSDrgo7T6GZBgwlYBpdoeNBo=
X-Received: by 2002:a17:90b:384b:: with SMTP id nl11mr1258486pjb.91.1598912138963;
 Mon, 31 Aug 2020 15:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAA+hA=S4eAreb7vo69LAXSk2t5=DEKNxHaiY1wSpk4xTp9urLg@mail.gmail.com>
 <CAGETcx8Ums+mkD54BCkCvBtU1qx13VZH=DOPqepyiQz62REfCw@mail.gmail.com>
In-Reply-To: <CAGETcx8Ums+mkD54BCkCvBtU1qx13VZH=DOPqepyiQz62REfCw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 31 Aug 2020 15:15:03 -0700
Message-ID: <CAGETcx_=Da7hVUCfOFd13Q6YAGPC65VSJD7BiCK_fCegYMCJbQ@mail.gmail.com>
Subject: Re: Lockdep warning caused by "driver core: Fix sleeping in invalid
 context during device link deletion"
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:17 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Aug 20, 2020 at 8:50 PM Dong Aisheng <dongas86@gmail.com> wrote:
> >
> > Hi ALL,
> >
> > We met the below WARNING during system suspend on an iMX6Q SDB board
> > with the latest linus/master branch (v5.9-rc1+) and next-20200820.
> > v5.8 kernel is ok. So i did bisect and finally found it's caused by
> > the patch below.
> > Reverting it can get rid of the warning, but I wonder if there may be
> > other potential issues.
> > Any ideas?
> >
> > Defconfig used is: imx_v6_v7_defconfig
> >
>
> ----- 8< ----- Snipped text that was a bit misleading
>
> >
> > Error log:
> > # echo mem > /sys/power/state
> > [   39.111865] PM: suspend entry (deep)
> > [   39.148650] Filesystems sync: 0.032 seconds
> > [   39.154034]
> > [   39.155537] ======================================================
> > [   39.161723] WARNING: possible circular locking dependency detected
> > [   39.167911] 5.9.0-rc1-00103-g7eac66d0456f #37 Not tainted
> > [   39.173315] ------------------------------------------------------
> > [   39.179500] sh/647 is trying to acquire lock:
> > [   39.183862] c15a310c (dpm_list_mtx){+.+.}-{3:3}, at:
> > dpm_for_each_dev+0x20/0x5c
> > [   39.191200]
> > [   39.191200] but task is already holding lock:
> > [   39.197036] c15a37e4 (fw_lock){+.+.}-{3:3}, at: fw_pm_notify+0x90/0xd4
> > [   39.203582]
> > [   39.203582] which lock already depends on the new lock.
> > [   39.203582]
> > [   39.211763]
> > [   39.211763] the existing dependency chain (in reverse order) is:
> > [   39.219249]
> > [   39.219249] -> #2 (fw_lock){+.+.}-{3:3}:
> > [   39.224673]        mutex_lock_nested+0x1c/0x24
> > [   39.229126]        firmware_uevent+0x18/0xa0
> > [   39.233411]        dev_uevent+0xc4/0x1f8
> > [   39.237343]        uevent_show+0x98/0x114
> > [   39.241362]        dev_attr_show+0x18/0x48
> > [   39.245472]        sysfs_kf_seq_show+0x84/0xec
> > [   39.249927]        seq_read+0x138/0x550
> > [   39.253774]        vfs_read+0x94/0x164
> > [   39.257529]        ksys_read+0x60/0xe8
> > [   39.261288]        ret_fast_syscall+0x0/0x28
> > [   39.265564]        0xbed7c808
> > [   39.268538]
> > [   39.268538] -> #1 (kn->active#3){++++}-{0:0}:
> > [   39.274391]        kernfs_remove_by_name_ns+0x40/0x94
> > [   39.279450]        device_del+0x144/0x3fc
>
> Rafael/Greg,
>
> I'm not very familiar with the #0 and #2 calls stacks. But poking
> around a bit, they are NOT due to the device-link-device. But the new
> stuff is the above two lines that are deleting the device-link-device
> (that's used to expose device link details in sysfs) when the device
> link is deleted.
>
> Kicking off a workqueue to break this cycle is easy, but the problem
> is that if I queue a work to delete the device, then the sysfs folder
> won't get removed immediately. And if the same link is created again
> before the work is completed, then there'll be a sysfs name collision
> and warning.
>
> So, I'm kinda stuck here. Open to suggestions. Hoping you'll have
> better ideas for breaking the cycle. Or point out how I'm
> misunderstanding the cycle here.
>

Aisheng,

Sent out a fix that I think should work.
https://lore.kernel.org/lkml/20200831221007.1506441-1-saravanak@google.com/T/#u

I wasn't able to reproduce it in my hardware. So, if you can test that
patch (and respond to that thread), that'd be great.

-Saravana
