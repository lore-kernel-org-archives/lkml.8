Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37107C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1371B206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiuvA1wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGGToT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGGToS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:44:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898ADC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 12:44:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so46542967wrv.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 12:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=zScjXTrxSTJ3dohGAFUR+84/DZ3AN/4LGI9OKdBT7IA=;
        b=UiuvA1wo7VBl7Y2EYR02JzHJ1S0OHtKPhzInhJfUWd8475paiqkI3mtp2mkXqVdk8b
         wAQxctRQ38kgKy+8+BY8Ckm0eJxJLSqX54LoynAIP/sS0rKII7bKTgqirfw7IoXb4e65
         wKZb+vw2txRAFxYhTWGV+6qnJPnPsKOPXmXWeLXRaxTEkWKiS0rriqPu3tX39PhGA1/u
         BDvsSAzoCBzQ+kBwq7Qg1taWoz84A2qaHr8LlHU8k3PJDB7y5R4Gwkdl3Zfeudts9Ia4
         XsJRJfmcukfu94iopQ7tJ3BpMS0/f3A96Ca96XRRwsfWgTkuvNJ81+FsahZPTuKhbfVj
         vmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=zScjXTrxSTJ3dohGAFUR+84/DZ3AN/4LGI9OKdBT7IA=;
        b=IrUE4RfV9Cff2zx/675Lqd1hGOscD8p3pPXXTzzUAHSMpcYQfyWb/6WgcxUMIiSiHi
         OOl0Lxz0SW3erKAAKVM11LaMT/5mJkeWl3A1n/XBs+6MuyABsF/AKt7AkZek9xScY0Gx
         20F+WJOuFAsdUdOCj2/pFCIE+8xZ2BpX70kDUR/goV5TJuKrbFeUZ1qmbPIE+WVx8zaJ
         gX1Yt3rtDCzF5flkQhX4NUg6/tmZR8xVPDYUrTMrYAEcf5jgtjwtbyFE4iwMWA0LkZ7T
         hB1OwxI7cxO2OpxTk+7YaAHWR52D4KPaZyz/AbPyjsabNUPd33byW56tdyl5NaTlFQkj
         LxeQ==
X-Gm-Message-State: AOAM532c2TokzD8yadB0a04OWdvvllkSxwZ1X2TRrxC8MPhzz8oRzOPf
        vG4vFMI968FGeYMKATGjfbb4UKDU
X-Google-Smtp-Source: ABdhPJx5PhcJlBWNpd4YrwbBRj55X+CecjNHYsBlcS/9uVTdTqM/OX++peUcncmMT1Qz2cjVu0TX7g==
X-Received: by 2002:a05:6000:ca:: with SMTP id q10mr56920888wrx.135.1594151057023;
        Tue, 07 Jul 2020 12:44:17 -0700 (PDT)
Received: from [10.11.11.4] ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id m16sm2486845wro.0.2020.07.07.12.44.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 12:44:16 -0700 (PDT)
From:   Martin Zaharinov <micron10@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Bug Report High CPU Usage events_power_efficient
Date:   Tue, 7 Jul 2020 22:44:15 +0300
References: <E2C5FE67-C85E-469C-9B81-10F7555F836B@gmail.com>
To:     "linux-kernel@vger kernel. org" <linux-kernel@vger.kernel.org>
In-Reply-To: <E2C5FE67-C85E-469C-9B81-10F7555F836B@gmail.com>
Message-Id: <91805D0F-2D74-4EA3-A2D7-13E4FBBEAB51@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the problem is hear with kernel 5.7.7=20

last work kernel without this problem is 5.6.7

hear is more info:

cat /proc/57259/stack
root@megacableamarilis:~# cat /proc/57259/stack
[<0>] gc_worker+0x1be/0x380 [nf_conntrack]
[<0>] process_one_work+0x1bc/0x3b0
[<0>] worker_thread+0x4d/0x460
[<0>] kthread+0x10d/0x130
[<0>] ret_from_fork+0x1f/0x30

PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ =
COMMAND                            57259 root      28   0       0      0 =
     0 R  69.8   0.0  82:42.14 kworker/5:2+events_power_efficient        =
                                                 =20
32 root      21   0       0      0      0 R  31.0   0.0  87:06.33 =
ksoftirqd/4


Please help to fix this problem

> On 22 Apr 2020, at 15:55, Martin Zaharinov <micron10@gmail.com> wrote:
>=20
> Hello Qian and Greg=20
> With latest 5.6.x kernel have problem with events_power_efficient =
28488 root      28   0       0      0      0 R  95.5   0.0 101:38.19 =
kworker/2:1+events_power_efficient Process start to load machine after =
3-4 hour and load not stop only reboot machine remove process . Server =
runing on AMD EPIC CPU 2x 7301 32Gb Ram Have 2 x 10G card Intel when =
machine load over 1G traffic machine locked and only restart fix problem =
to next load . After move traffic and server stop load process still =
hear and load server ?
> And after reboot process move to other core .
>=20
> Best Regards,
> Martin

