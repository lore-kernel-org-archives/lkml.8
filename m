Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5D3C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 08:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59739222D9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 08:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohjD73jh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbgALIrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 03:47:20 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37468 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732455AbgALIrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 03:47:19 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so6383954qtk.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 00:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=bYPMb/iHlHgUPNXzY+xjP/+wG4RUl7tATKn1/OzFEVQ=;
        b=ohjD73jhpzOnMpeZEWBvNtNuXJMtHJxn3QCZRhGNikso0VwwrJ2xa8o7uAt30i4KIA
         t8yLIFMjwKzSbtcLr8AkUGrWqfzQ8XYt3Lc+/t09cqZjjIAOVh0wMy1d/d+5g2UBaU85
         dgz4ZfYyKp8VEr1OsnaARfmr48dqMHSsbkGNgb9AppRzlpkEzYBchlkkA2215tOVyLP0
         cihkbFXyATNDpeqfWqBxY10WYgGlXZkH4fZ1YIqMciot/1rmK/ACYptA/D94N43Ek1wN
         ONL/GYiIJE8j12c6i5aigqKyORoxHfOMtDazDr4FXg14/uDCD8c0g7aghdmMSsuOd5G4
         RR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=bYPMb/iHlHgUPNXzY+xjP/+wG4RUl7tATKn1/OzFEVQ=;
        b=ZtX0KzfRplEjwbN8zRUYl1M4WsIWuW7H11BJV2pEEyZFqPaGqdANaHQu9ddhwdFFEK
         V4jjrFWUvbALVHX+iaNWdGalgxfm937FPPlxWuejNFIhcJNsh8l9aABonsjY/4Yz9Wsa
         WxBI1yck8KQr3HYQcg1vjo2H07RSc4ha/UoTuhmtUE66u76k2Z805/baqW+phNoep6eB
         yr7Qg0+v8zg7/+g7lBr1mFTfxm/DONDUrVCUF8bikwVxJE7zWNhFrOUZoU53IeG0sQtc
         +5leu2bl1O4eeH3Mycnytmh8hcuzxBTz8Vx9H+Rcqgom9bSZmkZ+Gt9SZItO4uq21zgN
         EdJA==
X-Gm-Message-State: APjAAAUU9nMuP85SElE89fHVgUuf/VyBhNrR7LPGW4w1SxNXbq9nMIh8
        fHBYTlm69crZK2ET2rge4S+RHkqs/TU1yxHFAelclg==
X-Google-Smtp-Source: APXvYqyxaEp2iiMODdlU7aQLfnJpV0btYyUnMx14530gt0LQyJ1/J6zhUWnb430sL65bmKYB7W9CqEc6NK3hX3czZJo=
X-Received: by 2002:ac8:2bcd:: with SMTP id n13mr5952422qtn.21.1578818838551;
 Sun, 12 Jan 2020 00:47:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:aed:3243:0:0:0:0:0 with HTTP; Sun, 12 Jan 2020 00:47:18
 -0800 (PST)
In-Reply-To: <157425606271.12247.62239776985279233.tip-bot2@picmy.matchervip.com>
References: <1570015525-27018-3-git-send-email-zhouyanjie@zoho.com> <157425606271.12247.62239776985279233.tip-bot2@picmy.matchervip.com>
From:   Jade <akasoror62@gmail.com>
Date:   Sun, 12 Jan 2020 09:47:18 +0100
Message-ID: <CACF4=OmnAEgXjySd9-gs+_8vo2RX4uRWKpJ1LU+=Nt1v7FvQLw@mail.gmail.com>
Subject: Re: Hii akasoror62@gmail.com,Your No-cost quote for a new home
 security system Offer ref: oQZA
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi admin

you hope you doing well

thanks for contacting me

i really was a wonderfull day on your office

i hope we can talk together again

vanessa
