Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A205AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FC420709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="RAz2XKqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391344AbgAXSY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:24:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39518 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388688AbgAXSY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:24:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so1121324plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=9mhOOBaln1zZhror14LKgz2QMImQbKxsvSx5EqJTYco=;
        b=RAz2XKqzUHmBbVViY3hzlE3l8UVNZTFV4R+rsWtCs2WWvWycSFgjQB0QbRKtiuHx8Q
         7mzLNFFxaoX9TPngj3lekw2U83W5j/BbhKwipJC/tZ0ewoJvxDhqykwnehGnL0DcMzUm
         j2BtFGCkgtb1YZEpyd3vipcrhZScVHRs1AS4JzOpWO2Ic9cYMs7pEiMCVjVZS2Tgl20v
         QDsYWsaGTmJy0sxi9VP+gy6ou4hQL0cMoa1/dLDPmZ1K7j4Brnj7cEGiRQu1zL9aKFc+
         TrXVsEV+WlozkDDHAUIlrsHu29qHKZSl66fzKVmLznnZOLGs8Ae7nO+dtl8rS8GeHKzQ
         tsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9mhOOBaln1zZhror14LKgz2QMImQbKxsvSx5EqJTYco=;
        b=gk2RPvXMSdyqsg1RABqh8AZh9KGWnlwChMyZMaKxYV1XSvGr+Nk04JpBPhMpIcFf4e
         tZk+JS0tIalk4FXnQ20vgWNEmVKmrxo9n3uGv3pcnLIqyGYU203boEZxCEut7fQxvAri
         kGF2ZhwlPoOKJEcOLt7z16nh0zTyd4MAK6dGKDqpr97rYNKmT48KOEMu5M8QPftSKg5f
         yCkDWzaKhaqKB6VqT4G2RLTOXm9YuVISiJvBf6Pfab4jJNcffgLhwRuAK4HUIER/3p7D
         zKy9B31SzGZPLBqwDVIgPNoS9C3TIG4kDLs0DcNBOxSw2FimLzm5u+jbUdZOXUDXuHah
         9HcA==
X-Gm-Message-State: APjAAAX9LBHH0ti7fOUAcAPt4BNwVFhWXUprKhfe+RoqVLhyjfKYCrif
        bjkEpw2xuzXE8c6Ts280k983xqUNTZU=
X-Google-Smtp-Source: APXvYqz/Nn0EvR3fZ/8XzkbrpbepHfprN5iqIfzR2ty5TkA9H8LjZP+imqSS7DLm7+F4I1f7Vr1Gyw==
X-Received: by 2002:a17:90a:1785:: with SMTP id q5mr534719pja.143.1579890265307;
        Fri, 24 Jan 2020 10:24:25 -0800 (PST)
Received: from ?IPv6:2600:1012:b014:f2f6:cce4:b529:529e:9b98? ([2600:1012:b014:f2f6:cce4:b529:529e:9b98])
        by smtp.gmail.com with ESMTPSA id l2sm7153286pjt.31.2020.01.24.10.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 10:24:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: Don't clare __force_order in kaslr_64.c
Date:   Fri, 24 Jan 2020 10:24:19 -0800
Message-Id: <E184715B-30CD-4951-BAF4-E95135AEE938@amacapital.net>
References: <20200124181811.4780-1-hjl.tools@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
In-Reply-To: <20200124181811.4780-1-hjl.tools@gmail.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 24, 2020, at 10:18 AM, H.J. Lu <hjl.tools@gmail.com> wrote:
>=20
> =EF=BB=BFGCC 10 changed the default to -fno-common, which leads to
>=20
>  LD      arch/x86/boot/compressed/vmlinux
> ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple definition o=
f `__force_order'; arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): first def=
ined here
> make[2]: *** [arch/x86/boot/compressed/Makefile:119: arch/x86/boot/compres=
sed/vmlinux] Error 1
>=20
> Since __force_order is already provided in pgtable_64.c, there is no
> need to declare __force_order in kaslr_64.c.

Why does anything actually define that variable?  Surely any actual referenc=
es are just an outright bug.  Is it needed for LTO?=
