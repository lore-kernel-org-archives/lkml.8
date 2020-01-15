Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6648C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB092187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="HNS/MuCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgAOGCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:02:47 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39836 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgAOGCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:02:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id a67so14337929oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 22:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WyKlBkScoVZ6BBeE/lvKOUnxM2fwU6k2+3ORlYeQ1JU=;
        b=HNS/MuCyM2Y0rPTycj0ERFuxRvMu1QHpp95g6CP0C2mcOOP17W3rjfRnyo8mZNws9l
         Bcv17zUUAkkGTvOLwd1IP1Q6kQdxkNC/BtRTUsWN9in2f4VRO4DjkljU1DghPGI42WVQ
         jUuVLY3zCBFOvviuNPlx0NRWZKXOYYWOD0An0XLByT1bn95S8DuHxEUEKSnrL30YhlyT
         +h+l0ymO2e0tgatyf84uKe0HDE06uZYrHOHGYewqXSfc7NmSlTYA6qssHrbd2ft+e7BG
         Ov/+58wifUZ6rKsf/zQwYB50hnJMVNNyZF84Dl5dZNk3GBE3TR4AQ7f8vv5m0rnBpM3q
         yzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WyKlBkScoVZ6BBeE/lvKOUnxM2fwU6k2+3ORlYeQ1JU=;
        b=b6kUyGbWdEwDsUY9+XmvTnR1qV1J86FRTu3Z3DplPWpHRJZ5sRUIioDpw3wY0bfavg
         kD0Ijy9xrKRKfET0gajTJmbpUNvP2CsBYsi4jRawv2xXGh/X2neP6yDHwDe+UsxsQB0t
         foI3z3SD33t/15hLGwT0cVpCdHZSmRlJuLn0fkARR54clifxpSLPwp/XUhYNl++ypB8k
         Ayy0gQKO17uMayOmKAjk80K/+sOymx81qPIC0YrJxy60au9i1eKMudUuY5j/Wo7+7+8U
         wdnFo60RboDyyje7k3sg4RarW8h2xm8iVQzt4oW4TGd3lYXMoRSQEp7BZwCegRh/GWh2
         M0Rw==
X-Gm-Message-State: APjAAAW+olgRO95zQJLPEl8JPTv+sGxUW3+3hr062CUBHa6943ybOE9f
        +TD8cG1+qUu3ltWhpgkHR9OuZ0AHKXlPWIy+fu0S7B7q
X-Google-Smtp-Source: APXvYqzeuAG8OGRFPj/VxBeMJvbxWakGlATFxZiTEHM5ApidHx987T6zad1F65AWRIeqz6hwenMYEqMe9i/yHCxcJeM=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr20144974oij.149.1579068165602;
 Tue, 14 Jan 2020 22:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20191225054227.gii6ctjkuddjnprs@xzhoux.usersys.redhat.com>
In-Reply-To: <20191225054227.gii6ctjkuddjnprs@xzhoux.usersys.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 Jan 2020 22:02:34 -0800
Message-ID: <CAPcyv4hMPh0C+_OV+vuiYQikb8ZvRanna4vXfKN=10yrAyCjDA@mail.gmail.com>
Subject: Re: [PATCH] mm: get rid of WARN if failed to cow user pages
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Jia He <justin.he@arm.com>, Linux MM <linux-mm@kvack.org>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ drop Ross, add Kirill, linux-mm, and lkml ]

On Tue, Dec 24, 2019 at 9:42 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>
> By running xfstests with fsdax enabled, generic/437 always hits this
> warning[1] since this commit:
>
> commit 83d116c53058d505ddef051e90ab27f57015b025
> Author: Jia He <justin.he@arm.com>
> Date:   Fri Oct 11 22:09:39 2019 +0800
>
>     mm: fix double page fault on arm64 if PTE_AF is cleared
>
> Looking at the test program[2] generic/437 uses, it's pretty easy
> to hit this warning. Remove this WARN as it seems not necessary.

This is not sufficient justification. Does this same test fail without
DAX? If not, why not? At a minimum you need to explain why this is not
indicating a problem.
