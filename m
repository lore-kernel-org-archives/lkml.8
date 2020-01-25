Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20765C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 17:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EB02071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 17:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXekawrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgAYRuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 12:50:02 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38843 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAYRuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 12:50:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id k6so5502117qki.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 09:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3muEsSJhzMBr6bStz5/aZm1+29dYJOpxSAbwSPEf1Ns=;
        b=AXekawrU0Zv983Cm/0OdaLaIjCisK1FlyFq+FVw286xO2CaPlpYXJO1nWfkK+JTqri
         xqrGkxIB9SdvcYL8+3aM876Lw7DSxI/WYF5W2tIm2K1Yj/dwUTOSmbAXn9h/pFQA+1D7
         qMaBcTZgdMfuIMDbW4gsQxuKuUU262kQbCk+iKYQFRwOs9jz/ZlByY88LByJerZIZCt3
         qfWJBDKE5+JLhPuR/JdFa0VZi6mMWC+3aSqz4F0DMBC7WgxMEQCvsu6xKtmV3StZIvFC
         n0CizVBKRHEv9x5Zs/DdAasAXg1ViPedd9cH2V5HJeAOuV7g013/GQb2Q0CIOPwYBAsU
         qjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3muEsSJhzMBr6bStz5/aZm1+29dYJOpxSAbwSPEf1Ns=;
        b=IfEkmcvFd2aL/uCUyuYBH5Kr83e1aV0GzoCK1YdK4jJZ2W3uqiTrSK1oauKquhVPOJ
         g2tGOBSSBsRUidmPU8a8a2iyXrOhajKnK6pf9YqWtwbZYMvcRGo05Oj4sPdnY30rf9EP
         S+xuSDyaixPAGuyx3Iof83Gt4k3S2xsGzKEIEVI2BDfXilLUIfmGCcmTmss00kdmIkHU
         ZCJWSFhY0RfbsghPTpanez7i0smDZSfDSd7Ajoe+DV1silHkd9Q/Vt63Tzt2vvjh0joz
         2dsnOZCCj4MUysrbz+xQbKvddhHUwkrx0LlLNt1XzW2rFf6R9MtIv/l/hRBxHfnvvvDL
         F4cA==
X-Gm-Message-State: APjAAAVKOGceX46z20r+6YGmRhaPh0GP8kk1KpE2PULUWIFJX+i+9CAB
        EkNcs7Fgfabj7mdYgufPR5CoP4D2xP6z34iZ3OiCjg==
X-Google-Smtp-Source: APXvYqyuHRUV3EEiPIwNqXVWDHTD2j7oGUIxvgQxvkPsaqpwREVxmwDFmJUNlxddrAEetn2QRgCkSU7kOgkWwBmq7GE=
X-Received: by 2002:a37:5841:: with SMTP id m62mr8660237qkb.256.1579974600650;
 Sat, 25 Jan 2020 09:50:00 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 25 Jan 2020 18:49:49 +0100
Message-ID: <CACT4Y+bg1UKXzZF4a9y+5CfNYRwBc5Gx+GjPS0Dhb1n-Qf50+g@mail.gmail.com>
Subject: binderfs interferes with syzkaller?
To:     Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi binder maintainers,

It seems that something has happened and now syzbot has 0 coverage in
drivers/android/binder.c:
https://storage.googleapis.com/syzkaller/cover/ci-upstream-kasan-gce-root.html
It covered at least something there before as it found some bugs in binder code.
I _suspect_ it may be related to introduction binderfs, but it's
purely based on the fact that binderfs changed lots of things there.
And I see it claims to be backward compatible.

syzkaller strategy to reach binder devices is to use
CONFIG_ANDROID_BINDER_DEVICES to create a bunch of binderN devices (to
give each test process a private one):
https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-kasan.config#L5671

Then it knows how to open these /dev/binderN devices:
https://github.com/google/syzkaller/blob/master/sys/linux/dev_binder.txt#L22
and do stuff with them.

Did these devices disappear or something?
