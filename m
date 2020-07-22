Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ED3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D240120729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAs2/hCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbgGVJS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVJS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:18:57 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D71C0619DC;
        Wed, 22 Jul 2020 02:18:57 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id q15so756285vso.9;
        Wed, 22 Jul 2020 02:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kinsg49RAoAeoKFx4gE6QT8ur/XktSQO/apO/E1SUuk=;
        b=MAs2/hCaFfZeqtU62i0g5NZLteR8wQMQhlEZxQ3+w4bPb6XtDyQvxMJuPeXlrIOqJR
         vpGG7cjO36cu4B+DRoVkjsfelhrvASK9oMG9c5is99YPGVN1X3/WytqJgkg5MKJEJcmA
         iSiDPGLk8usr2Z26x7LmW9j1i9bVijfjculv2CVUmXPnAxaoTNQDwXFg7j6PqBNIX51+
         cJ4IVlbArWhWNCgnkNZ+xL9h5iz/eBq0sdwMruYCxGHNQs2hNGq/fFRQbD2xd14tdwXN
         xpvWHw0eVsSuPZR4dyvSFfFmhNC+DfHV2HyWreg2tevxI/NMvwUFpduos9hw/y45c498
         tNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kinsg49RAoAeoKFx4gE6QT8ur/XktSQO/apO/E1SUuk=;
        b=LmJiuzftqakQCsUz9BoY/+cdBPM+CFPY30kDtQZ52OZX0C2GNdsWfo8TyX1gSciark
         IIAyd+U9RVB2mfxCdAVx6ZDEcpNbJF7Nq21H3B1v4EKAXduO8RYr9d5KW5cYqRdSPoj6
         IaEZ6c+VGIVsKKJPn/DO0CtsrqraRNVrjEXcWkvgGT//hpT/LAOfcFhTvybh+xAcFmnB
         /ivmFHGebNBzArd3KaFctV9O1fzTY/yffC1AkzFhoQTsNnC5MPmH33tVb2b7cThpOuAQ
         CWlOpalFVShwkg8NBhQMbLvuHnVAi3v63F5jD90sXW4Mhhe0K/A64lM7Ut2MmWtK9iey
         o0WA==
X-Gm-Message-State: AOAM530Fu+vVpcgYgNL62qZifEaIUFlisGfAsPAaSPgoe2WzIhiQV7R6
        Me8voT+6m4GVf1SXdGagJM6+1LPch1aRG1PEEnA=
X-Google-Smtp-Source: ABdhPJww+U423trzUzEsoS7wlKp+8bFRoI7RJGcypygmuZnFcx1FEDMKYSEKzljd2WthEMxN7WTvoK/RR2PBeRitGoY=
X-Received: by 2002:a67:d086:: with SMTP id s6mr24027045vsi.130.1595409536016;
 Wed, 22 Jul 2020 02:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200722031640.nobv2bfgex46sngo@pesu.pes.edu> <0000000000001fd19405aaffdc0a@google.com>
 <20200722091201.2076-1-hdanton@sina.com>
In-Reply-To: <20200722091201.2076-1-hdanton@sina.com>
From:   B K Karthik <bk.bk2000.kb@gmail.com>
Date:   Wed, 22 Jul 2020 14:48:44 +0530
Message-ID: <CAOEiV1ehZoknZ6b-DOjYxwH2F8UpXO3WXByuM_FcPDOy6=RSSA@mail.gmail.com>
Subject: Re: WARNING in pvr2_i2c_core_done
To:     Hillf Danton <hdanton@sina.com>
Cc:     Markus.Elfring@web.de, andreyknvl@google.com,
        bkkarthik@pesu.pes.edu, dan.carpenter@oracle.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+e74a998ca8f1df9cc332@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 at 14:42, Hillf Danton <hdanton@sina.com> wrote:
>
>
> From: syzbot <syzbot+e74a998ca8f1df9cc332@syzkaller.appspotmail.com>
>
> Tue, 21 Jul 2020 21:06:10 -0700
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > general protection fault in kernfs_find_ns
> >
> > pvrusb2: Invalid write control endpoint
> > pvrusb2: Invalid write control endpoint
> > pvrusb2: Invalid write control endpoint
> > pvrusb2: Invalid write control endpoint
> > general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
> > CPU: 0 PID: 78 Comm: pvrusb2-context Not tainted 5.7.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:kernfs_find_ns+0x31/0x370 fs/kernfs/dir.c:829
> > Code: 49 89 d6 41 55 41 54 55 48 89 fd 53 48 83 ec 08 e8 f4 61 af ff 48 8d 7d 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 1e 03 00 00 48 8d bd 98 00 00 00 48 8b 5d 70 48
> > RSP: 0018:ffff8881d419f938 EFLAGS: 00010202
> > RAX: dffffc0000000000 RBX: ffffffff863789c0 RCX: ffffffff85a79ba7
> > RDX: 000000000000000e RSI: ffffffff81901d1c RDI: 0000000000000070
> > RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff873ed1e7
> > R10: fffffbfff0e7da3c R11: 0000000000000001 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff863790e0
> > FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f3a7e248000 CR3: 00000001d2224000 CR4: 00000000001406f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  kernfs_find_and_get_ns+0x2f/0x60 fs/kernfs/dir.c:906
> >  kernfs_find_and_get include/linux/kernfs.h:548 [inline]
> >  sysfs_unmerge_group+0x5d/0x160 fs/sysfs/group.c:366
> >  dpm_sysfs_remove+0x62/0xb0 drivers/base/power/sysfs.c:790
>
> [3]
>
> >  device_del+0x18b/0xd20 drivers/base/core.c:2834
> >  device_unregister+0x22/0xc0 drivers/base/core.c:2889
> >  i2c_unregister_device include/linux/err.h:41 [inline]
>
> [2]
>
> >  i2c_client_dev_release+0x39/0x50 drivers/i2c/i2c-core-base.c:465
> >  device_release+0x71/0x200 drivers/base/core.c:1559
>
> [1] kobject_del() goes before the release cb in kobject_cleanup() and
> kobj is removed from sysfs, see [3] above.

Oh, thank you for letting me know about this. Forgive me, but I did
not understand you very clearly.
I presume you are saying that the second call to
i2c_unregister_device() is where the problem occurs?

please let me know.
thanks,

karthik
