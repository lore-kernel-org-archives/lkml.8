Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AAEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 13:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00349206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 13:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgEPNxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 09:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726880AbgEPNxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 09:53:25 -0400
Received: from omr1.cc.vt.edu (omr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:c6:2117:b0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D564C05BD09
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 06:53:24 -0700 (PDT)
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04GDrMtA013003
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 09:53:22 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04GDrH3S000400
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 09:53:22 -0400
Received: by mail-qt1-f199.google.com with SMTP id s65so5722102qtd.21
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 06:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=NJnN+kqSVSuh9gYl21o4tggUBvzQ1oZPUZrQPbWnWM4=;
        b=gROqoqN+KyLakfhXSbrGy2bc9fKRWXvblMHfv8dFp7axUM+TPaQbpr0P03O67TKL0v
         zYzApraFTt6/MeQ8HbLzMrUGlppQgkl4aSkawQ+hcuAl/67VYWDysvT55hGszuGvWQux
         6BDowcydopl4aOtFNoy24EcCttMBGUA+ESTjRXrZgIXfbi9VPRjxg7uQCWnPcig6czOK
         M3VyFrl7ry1PcYDmejsRGS40kIjheQWW2v6EfLJM3dS6Scd4z/4yKCSxl2BJ9WRHsUxM
         kpNcTIngDudcC59QiB4DaNoBz4iey3hR0tT6y4gGxun6t8cSgKS8RggzZCZuP0+jcPQz
         kk4Q==
X-Gm-Message-State: AOAM5314V3H99SiHHpmBBuRrIzDg2pBib/MkNJKQmrcUxVIOK4WD63P2
        6Ao7l5Sl/R69E+egLtQkgb43SSaxAnFccpppGYkYKgkLacZF/kW33OReeH+3TKkoxQZn9NVBFdi
        Q5rsd7rmfva6/7LQTC1ip8W1bNxbs6KhAD3k=
X-Received: by 2002:ac8:5241:: with SMTP id y1mr8715925qtn.165.1589637196649;
        Sat, 16 May 2020 06:53:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrkONq+M0bkRR1Dwh4ZZf0CNT1BCSY3TbJEnC8GwaOrbA+HCLHd/J5k7yxwovJgx2tqd9kHA==
X-Received: by 2002:ac8:5241:: with SMTP id y1mr8715913qtn.165.1589637196314;
        Sat, 16 May 2020 06:53:16 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 99sm3441007qte.93.2020.05.16.06.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 06:53:14 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
Subject: Re: general protection fault vs Oops
In-Reply-To: <CAPY=qRQ6gzN1BWh=ianVDBQ1C9kibWHwxs5Z0+QSwGxKymLDTQ@mail.gmail.com>
References: <CAPY=qRQ6gzN1BWh=ianVDBQ1C9kibWHwxs5Z0+QSwGxKymLDTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1589637193_23225P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 16 May 2020 09:53:13 -0400
Message-ID: <374485.1589637193@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1589637193_23225P
Content-Type: text/plain; charset=us-ascii

On Sat, 16 May 2020 18:05:07 +0530, Subhashini Rao Beerisetty said:

> In the first attempt when I run that test case I landed into “general
> protection fault: 0000 [#1] SMP" .. Next I rebooted and ran the same
> test , but now it resulted the “Oops: 0002 [#1] SMP".

And the 0002 is telling you that there's been 2 previous bug/oops since the
reboot, so you need to go back through your dmesg and find the *first* one.

> In both cases the call trace looks exactly same and RIP points to
> “native_queued_spin_lock_slowpath+0xfe/0x170"..

The first few entries in the call trace are the oops handler itself. So...


> May 16 12:06:17 test-pc kernel: [96934.567347] Call Trace:
> May 16 12:06:17 test-pc kernel: [96934.569475]  [<ffffffff8183c427>]__raw_spin_lock_irqsave+0x37/0x40
> May 16 12:06:17 test-pc kernel: [96934.571686]  [<ffffffffc0606812>] event_raise+0x22/0x60 [osa]
> May 16 12:06:17 test-pc kernel: [96934.573935]  [<ffffffffc06aa2a4>] multi_q_completed_one_buffer+0x34/0x40 [mcore]

The above line is the one where you hit the wall.

> May 16 12:59:22 test-pc kernel: [ 3011.405602] Call Trace:
> May 16 12:59:22 test-pc kernel: [ 3011.407892]  [<ffffffff8183c427>] _raw_spin_lock_irqsave+0x37/0x40
> May 16 12:59:22 test-pc kernel: [ 3011.410256]  [<ffffffffc0604812>] event_raise+0x22/0x60 [osa]
> May 16 12:59:22 test-pc kernel: [ 3011.412652]  [<ffffffffc06b72a4>] multi_q_completed_one_buffer+0x34/0x40 [mcore]

And again.

However,  given that it's a 4.4 kernel from 4 years ago, it's going to be
hard to find anybody who really cares.

In fact. I'm wondering if this is from some out-of-tree or vendor patch,
because I'm not finding any sign of that function in either the 5.7 or 4.4
tree.  Not even a sign of ## catenation abuse - no relevant hits for
"completed_one_buffer" or "multi_q" either

I don't think anybody's going to be able to help unless somebody first
identifies where that function is....


--==_Exmh_1589637193_23225P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXr/wSQdmEQWDXROgAQLmLQ//TxlbNV2RGPp3REQ8H1b2HJ7NxUwvwg9v
UeVv+9WCMn2w6Ra/UKBybERvFWIrS2BSRDXrdl1L6J5Kw7gEbeUEyl73DR0qHO8e
B8ahq4yuvwivG6jd2uN2qYsfCgvIgpYki/Rkb/72FtO+nY/VmzrxpYfVF+1mGHLd
O5quR4peIOUgm+8XPZLmZJu6SIUcVAc6iXuei08MhaRqxtRw0sPcM7M++HelbEg5
+MqbiH/R87FcHVIP5x/BRw79drf2hQ7Fz+9VfAaQBpi6j2Y0HcgilTvnegyNk1qM
ZITt4TLWgzbCeqFjwAq+cyF674mnSyFYv5Ef+sGfcuwwOxXkDKPlavaezRjunz1H
XVIX9ENws/SITj/gS90SNJ32vmomnxICCBJGyGLUm8DZdyVim07h7tcaW7t9vjGe
ZuID1kgm1xkr6c++SD+pCMlNu2Xk74SkOvox2ylbcln9xF2hO+mlZoHjSWGcg3co
h+gocMcSVVHlWg5dmCR6ZpGZ5J88Mv/l3k2cpDE70lGyYy3rutjYcX0jrLHlTVCy
McjFpaQi+HaDCiMTfLgZfg0wkhaANd1B4MOmDLOYiKW4ErxvywEEnjzEpj7iLJmt
y+L1OXdZCdiRTPneLThvxGsGVtTiUJDKwAtGjcR0sJb8f1dkpIs035Vkjz1JGNm9
K6VW2Glkfy0=
=1zv1
-----END PGP SIGNATURE-----

--==_Exmh_1589637193_23225P--
