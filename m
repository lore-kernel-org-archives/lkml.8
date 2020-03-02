Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E26C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054CA24677
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="CPr77l7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCBFys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 00:54:48 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40581 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBFys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 00:54:48 -0500
Received: by mail-ua1-f67.google.com with SMTP id t20so3183031uao.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 21:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xaVFZKXkYwadGJPmxWSyTrfKN4QDA7x77UvzbDi6hYw=;
        b=CPr77l7kD5D+rAiwuZyWv8zJQjAQzrZ2SaX5O2HwQfDvb7nfHwgMHYMKB/gDZFMkU/
         hp4j50gGKIAeYlYuClcTqi6vwyt/nf3iceTzGL7aNCOe3LpLnTo9xxtuLd9s2u4emmki
         d1AiObF/E9n73EjuUtApBgiVqckrKAiE4IJ9mgutkBLgyp1BcRCAOnONvw3fteUiFVVA
         79dkuS2hylinTvRyOh14/8EHEGPAfdVK7ZHcHofybDXihzL9HSjGPKukITYYTxHjSHKM
         FpUcaY+ypDV92ZR62HEp5QvYKo4CTQEDvovh+34M5achweW6EW8YfmTOkPv+29Hd5ZeG
         YvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xaVFZKXkYwadGJPmxWSyTrfKN4QDA7x77UvzbDi6hYw=;
        b=bZEBrYPfdcSFTotUA8tujWogTHyaKP+9+j6LOoFI/+qs72nbM3CFDh7balBJSsStWE
         aIsq7Ms96NHf5d6DBi0fcf1UcNW1upLVVpxRwq3zHpWviqgZu4/cvsg+uQuL885IFjRm
         yHQaQSc3NYAsN45cdkoMMGVLmdGkF1ByPnoVj2g8APb9gXT17hUx6xMxwQiMKwa8Hw4Z
         yxc8WT+cEvt8wmLh2pUeDIcGOrHOb6Zx27x8JPYfwa5JlTSAAMmPxNqI43DmzL5kOTSf
         Xg/gBAlkf/6pjw2NUd3jNorhQzM4JIFVX5c7JSc7l64vmCCXpNFszcj/sSBZ2qGzultO
         6r+w==
X-Gm-Message-State: ANhLgQ3cNyd71OnJaIQNQxTrBeRTD3pfNTE7WEQmjlsRQ0Pxp2mCI3zy
        JcW9Xo0U7r5hiyGVSgnueNBFshD6v3+cRGsqvv666Q==
X-Google-Smtp-Source: ADFU+vtnQNxDfyhIydJNfyBpdE0lGq6GsJ6tyObK59DOF5xuyYZSJgq3fkaYxljupt7e3lTfBookfoG23Ynd14+Qjt0=
X-Received: by 2002:ab0:2758:: with SMTP id c24mr6576762uap.94.1583128485802;
 Sun, 01 Mar 2020 21:54:45 -0800 (PST)
MIME-Version: 1.0
References: <2094703.CetWLLyMuz@kreacher> <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
In-Reply-To: <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Mon, 2 Mar 2020 13:53:56 +0800
Message-ID: <CAPpJ_edfTg11QZs25MrThj2+FKUo2103rv7iYNzo=kr-jeg1MA@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: EC: Updates related to initialization
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Drake <drake@endlessm.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake <drake@endlessm.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8828=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Feb 27, 2020 at 10:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wr=
ote:
> > The purpose of this series of update of the ACPI EC driver is to make i=
ts
> > initialization more straightforward.
> >
> > They fix a couple of issues, clean up some things, remove redundant cod=
e etc.
> >
> > Please refer to the changelogs of individual patches for details.
> >
> > For easier access, the series is available in the git branch at
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  acpi-ec-work
> >
> > on top of 5.6-rc3.
>
> Jian-Hong, can you please test this on Asus UX434DA?
> Check if the screen brightness hotkeys are still working after these chan=
ges.

Hi Rafael,

Thanks for your patches, but we found an issue:
The laptops like ASUS UX434DA's screen brightness hotkeys work before
this patch series.  However, the hotkeys are failed with the patch
"ACPI: EC: Unify handling of event handler installation failures".

Jian-Hong Pan
