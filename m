Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D2EC3524A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF2720661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="WEhZuzpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgBCCwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 21:52:09 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44137 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgBCCwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 21:52:09 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so13296464oia.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 18:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=m3kqulB4MngJzin9Ox3IxUFiL7JWpnNyf3px828cI9I=;
        b=WEhZuzpr0zqxBfAdiMmo162jSEqkoSPQCtQuglEDK3KGMmdwPzUm1EVEpFSQJV/TYK
         khAAcxJF12aBLZ15oVreQ3WGBX/w01hiOfzQnqib+qgPv1VBnD6obDkblfyFz6Xjil++
         6dBXh0hXcpgEklWwGR+UxDP281nE4bF0MEBf3cM5M0inRnsckAxKqNeGAm+R+Zr5DAhO
         PaK56MTU3m5lIhoO7PKFxnwG/rZaVVs5tSotC+o/W4nlPKsUvNvC7f0yY8iH/gjo5oaI
         OjBRxeki0bssuup7c+Xcn8CKZwv6GdmGpQjZy7wWFCCycVAhUamsyVPuyMaPZvR7d6/g
         EtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=m3kqulB4MngJzin9Ox3IxUFiL7JWpnNyf3px828cI9I=;
        b=uiYYhkoEmqOImEoZguXRLqTMsS7W9xyJtttHCV8m1nu/Nezu6M0UTX/6k8upcT6xFE
         +FTYwO1uEjQrvXwH4cO4BGiNEv0En/FGtfuUoN7v91MTgRpHhRt+aPq8ANjESNjnLmz8
         JnY2nNvRSDj8hl5WBhqsoq//iMOvzzV/dEeWq/MJsU03meUZygxearMeTx54qqsnVTHm
         obxLZCstOzU82rU+ngv+n8ffUWR0ta3yaW34HDNgyMSkpyzqTszROyVuOHTj12pffaVD
         D89MDJu7UjhGXZuDASpoOZ1joZ6bSBBeemDloSInL9E75+C/OCJarb0BTN9b/GVFQbyd
         Itag==
X-Gm-Message-State: APjAAAWDoeFmaOzdN6BreKjdI0cRMSKXv5fISPNdEPsVJ8SSHd2fA5CY
        0hhZMOKUu6NBLaX15nw110mFhmReli7xjOfWzpt3bw==
X-Google-Smtp-Source: APXvYqzR4MJugY/OI14PtGDvJ0VO8gTgpvqDvh02A7Zez1TARi1UwJAAHQMpF36qjXeS4roAF5y840azkKd0Mk6+wHw=
X-Received: by 2002:aca:3017:: with SMTP id w23mr12757003oiw.152.1580698326953;
 Sun, 02 Feb 2020 18:52:06 -0800 (PST)
MIME-Version: 1.0
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 3 Feb 2020 10:51:56 +0800
Message-ID: <CAB4CAwd6AanNEMyKDmkEPREbqUA_Q_iQ2oJ_UUw7rhFvk5eWfg@mail.gmail.com>
Subject: Fails to lauch X on laptop with Ryzen 7 4700U
To:     Alexander.Deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are working with new laptops that have the Ryzen 7 4700U.

It fails to launch X so I can only access via the virtual terminal.
I tried with the latest mainline kernel and kernel from
https://cgit.freedesktop.org/~agd5f/linux but no luck. I also boot
the kernel with parameter amdgpu.exp_hw_support=1, but
the system freezes after loading amdgpu and I can't even switch
to the virtual terminal.

I post the bug description and related information on
https://gitlab.freedesktop.org/drm/amd/issues/1031.

Please kindly advise what I should do next.

Thanks
Chris
