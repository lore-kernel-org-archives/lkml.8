Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC41CC4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2BF24683
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHy2I9VW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgB0DP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 22:15:28 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:44725 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgB0DP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 22:15:27 -0500
Received: by mail-lj1-f180.google.com with SMTP id q8so1557018ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 19:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jS5D82NiDv72IKQ6Cd+ElpVsclr0RVRpAhLw93a8mic=;
        b=SHy2I9VWjygIpTShJhsMYNI6fXH55yBPXnuW24prkNsFCGrDrHpg/SuY36ZEmF2d0a
         o9kQbZLbGz45g8zrNaMDeVdSe4IlvvU+TWtFvKeFW6anjRw2SL9X0bz45l9i2LjK0pxm
         fNMZiiKgAXK3mz/CBll16yHlKonGfqP4An1iqKRbInvlBHJ1j0n/6LB7aG02y/ecJPsp
         1YwDGOvQcXt4J8WshDMgZj9a0Q3mh6O1LPSd32hbJDJXDrQFph7d0DcAqQMiI3OCnq9J
         FRbue6PeWyTZd+osSHjkKzQt9GfWIdwSu7AaKjYB+7IDELacytBO5KolX6f8pppr+Jjl
         fT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jS5D82NiDv72IKQ6Cd+ElpVsclr0RVRpAhLw93a8mic=;
        b=RapLDL44rYcVCHJLA2CNYU40r9ufGnMmUDBZcPlkgcS/n7sMgOBDyltaRi9ac+qBEC
         51I/f3pCnelZST0K5KJkMzM5UOYGivPsKCRTisRQ9XHpLxvyuOlNmlkIsvcAuaWt47pa
         QEdH0iXWnmO0PvppCANsPXvO3ChLxY/5YVg7vnEqknQBfF1j8BREQml7Q+XK8uFEXN6T
         F5MenMu8KZJTvZyl9eHDcg6Yd/6kcAsNlCnUSw59/bYwWq0OknRiRwv5kpVQMiZKuC8a
         6+5OPFF+RzoH2nB6IlA7oVvGbp70SRsZ9xe+zEi09ioXQhsy3RC02CmJPnxpXVufuzy9
         /eJQ==
X-Gm-Message-State: ANhLgQ22vWUMLe8McEt4PeDNEoUZ5C4m1AMy/zelD0cxPtnVZU+fhtRf
        6pGQVzJQO9VIaAK3fkgwuLJfG07URjA0PGKJVA==
X-Google-Smtp-Source: ADFU+vv6dRXoNXkbk5SMrq6ZmD4p/VKn/6Gx/ZgpTGSlhAeN24cRAPHsf9hsZJexRb3LhxiFOKElIDd3+rcfsSfXdSc=
X-Received: by 2002:a05:651c:216:: with SMTP id y22mr1380058ljn.277.1582773324252;
 Wed, 26 Feb 2020 19:15:24 -0800 (PST)
MIME-Version: 1.0
References: <ae2dc143-8d38-1942-9ebd-87c9c9c09960@blueyonder.co.uk>
In-Reply-To: <ae2dc143-8d38-1942-9ebd-87c9c9c09960@blueyonder.co.uk>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Thu, 27 Feb 2020 04:14:57 +0100
Message-ID: <CAEJqkgiXE-ye_P99FGcFM8j7Qqd3npKM9kY44MEnxGZF2_Hntw@mail.gmail.com>
Subject: Re: 5.6-rc3 nouveau failure, 5.6-rc2 OK
To:     sboyce@blueyonder.co.uk
Cc:     LKML Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do., 27. Feb. 2020 um 01:24 Uhr schrieb Sid Boyce <sboyce@blueyonder.co.uk>:

Hello,

>
> [94.455712] [T411] nouveau 0000:07:00.0 disp ctor failed, -12
>
> Welcome to openSUSE Tumbleweed 20200224 - Kernel 5.6.0-rc3 (tty1)
>
> ens3s0: 192.168.10.214 .......
>
> login:
>
>
> I can login here but X does not start -- lspci
>
> 07:00.0 VGA compatible controller: NVIDIA Corporation TU117 [GeForce GTX
> 1650] (rev a1)
>
> from dmesg:-
>
> [Wed Feb 26 22:42:39 2020] nouveau 0000:07:00.0: NVIDIA TU117 (167000a1)
> [Wed Feb 26 22:42:39 2020] nouveau 0000:07:00.0: bios: version
> 90.17.2a.00.39
> [Wed Feb 26 22:44:12 2020] nouveau 0000:07:00.0: disp ctor failed, -12
> [Wed Feb 26 22:44:12 2020] nouveau: probe of 0000:07:00.0 failed with
> error -12
>

*Warning* I have no idea bout Nvidia GPU HW :-). I saw this commit in
linux-firmware git added 8 days ago:

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=2277987a593d54c1e922a9f25445802071015f42

Maybe you just need to update your firmware package.

BR,

Gabriel C.
