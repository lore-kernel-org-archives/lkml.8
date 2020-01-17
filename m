Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ACFC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567A12082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="srZ+20gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgAQErg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 23:47:36 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32827 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgAQErg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 23:47:36 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so17363370lfl.0;
        Thu, 16 Jan 2020 20:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aSjDVv9JoqdRFNRmrpFljiUgmnl/7hIY0uQZp9U/Uwo=;
        b=srZ+20ghz5frg4vqdy9kGLPJXA30XRnGCT+amPgAu+7t661DXBw9/0q3pCfMF/HXA8
         KeRVJ2Gk3u99T6xArMCFZ9ifKSTF5fEkt59ALHfRkT1qWdUWydHpizAZikc3WdoD9gsL
         s1tHe/Z5A4uK7+QYsdzlfGFUeNCjeK/O2xB0Zrq1sfOtQeyw0D+Tx5c2avG5JnhVB3ob
         wnT/HMd95z3wMHccw43mqAhy/ofXWAUYl6KKXfu7a+2k23tGlvVvjYVzBZZalxksCKBS
         T2L7RUXZ5YPwlfcFcSz0gfn+srYkRDNNpJcNim4gMTFnAI3WObP9kmaB8q4HKSyTgqp/
         8Nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aSjDVv9JoqdRFNRmrpFljiUgmnl/7hIY0uQZp9U/Uwo=;
        b=WFieerdvpEoEeZiwnce0r7brRIxCe72bSI1hrvu80o3JWGyM9jStjKtyLeDt9mUO2b
         HWA5Hkf0lipaC27P5XMTLdjBY8QCHXFkGbK2pVXNKjZqR4CGoqZvBNQ41PN5AfPfHPkD
         HmNog0cP4OhlGmgn5QanIGheysd/2p0Hd1nJfIdXFhr04LFQ9+aAoGUrtLDX0Lmya0NY
         KYFi1XlqzmTGSob19N1cSZRlBQg/SUD9SWfQLTOxTh2q7NwfdhCEoqJsuttiJNJktstp
         hvElgZOi9JpjJCiEEF1UlKoDleW7dCiZrrcx2khPqOTdMOjjSP0viXlhjHYi2SeNFeYr
         lTvw==
X-Gm-Message-State: APjAAAWIUUKcDmjJMAPdxkI3UITHCCZeEzrYX7zNQ7jAIE0nsXkmVKdb
        lC4PYji6S47bNbi78as9qJBqgtkjaCVBYF1bJw/eRhUSA+syYQ==
X-Google-Smtp-Source: APXvYqwSIcqTfZASwPpr+36OGEhITnENCPGBF0oOPL4egX+ehrL9vs7PlmhBMX0Uuxj3KFgfLpwbhxFRiKeKc5uvjto=
X-Received: by 2002:ac2:5604:: with SMTP id v4mr4126634lfd.152.1579236454202;
 Thu, 16 Jan 2020 20:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20200116141800.9828-1-linux@roeck-us.net> <CANVEwpZVZs5gnvQTgwZGcT6JG7WdGrOVpbHWGD08bjPascjL=g@mail.gmail.com>
 <964a5977-8d67-b0fd-4df4-c6bd41a8ad58@roeck-us.net>
In-Reply-To: <964a5977-8d67-b0fd-4df4-c6bd41a8ad58@roeck-us.net>
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Fri, 17 Jan 2020 04:47:23 +0000
Message-ID: <CANVEwpZnaHBfF_NWp_3_wM4S3fhFrFuDXQWRMrp=-K4L0m1b6w@mail.gmail.com>
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 at 03:58, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi Ken,
>
> SMBUSMASTER 0 is the CPU, so we have a match with the temperatures.
>
OK, thanks for that information.

>
> Both Vcore and Icore should be much less when idle, and higher under
> load. The data from the Super-IO chip suggests that it is a Nuvoton
> chip. Can you report its first voltage (in0) ? That should roughly
> match Vcore.
>
> All other data looks ok.
>
> Thanks,
> Guenter

Hi Guenter,

unfortunately I don't have any report of in0. I'm guessing I need some
module(s) which did not seem to do anything useful in the past.

All I have in the 'in' area is
nct6779-isa-0290
Adapter: ISA adapter
Vcore:                  +0.30 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:                    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
AVCC:                   +3.39 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
+3.3V:                  +3.39 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
in4:                    +1.90 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
in5:                    +0.90 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
in6:                    +1.50 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
3VSB:                   +3.47 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
Vbat:                   +3.26 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
in9:                    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
in10:                   +0.32 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
in11:                   +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
in12:                   +1.70 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
in13:                   +0.94 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M
in14:                   +1.84 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALAR=
M

and at that point Vcore was reported as 1.41V (system idle)

=C4=B8en
--=20
                     Also Spuke Zerothruster
                                     (Finnegans Wake)
