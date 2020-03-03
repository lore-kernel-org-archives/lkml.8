Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E55C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A90214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mirlab-org.20150623.gappssmtp.com header.i=@mirlab-org.20150623.gappssmtp.com header.b="a5uUjNdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgCCKOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:14:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40936 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgCCKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:14:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id p5so2221092lfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirlab-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HZLJdyompUEUfGaYkKC4//Srq4/t18wcP+yf/P65E7A=;
        b=a5uUjNdkPvsrGH3XeHiv1khDvumuDRVBlNJFC6lUcfnUmuEr9PE65vkxV2uphGI8I+
         3UDxl8sCAJQepm6KrwdpYMCFAy4EhMEfbAtQadb5vks/qYfRrfHpQmiOnHv3zLQHSL64
         LsKSugPrYvGKzFfo8Wcxx57HXmjc6Rh5nN3sM0/Vc7MX01beFpdLGSt6E72oLxzAtRQo
         4hbRPYZQs8ryVm7Mxw3O7gto5lZutkgVkcNa7CFh/DpvT8w2plqfGGrWnnV4TP8cgK6O
         ET/tJ71P9YBvAv1wQtLs9YjEUD7/VNYhhflzk+EiIRITC1vrifpAWn3tuqabLLlztiXE
         2WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HZLJdyompUEUfGaYkKC4//Srq4/t18wcP+yf/P65E7A=;
        b=B9O/9hPeWbwm9KouIeBjbBSzHOIokYzQYg6LitFFEbVrM8qJ8Vwr548Oam8ECuLfCQ
         M/nUQ3GnlBHz1edIOcZF93j/6ikicUAiLNtmv4RszZqrqb0KGdKgkmhiS6Q4dbqKDTSW
         Bbcy7X3uCLNYB8EuLzOrVYyv5WSYzZUdSsurzsAj03qfny7bXOJacReTUGzbxqr1Le9v
         xNGr+1ouZIB+R6PFP05VloMMk5/NsZ7dp8s9ZExYHgAcPok/RZyxrWN3DEKrO83Kscc/
         RC1VyBUtuThIVJ3aagdTrWa4LJWXf861uxZWWFoeZCFi+Inv7/I24tFCbR/giqObpEkq
         6t/A==
X-Gm-Message-State: ANhLgQ3syNjOIKiIpHIUUIQzkL5uHK9X/QFx4KK/n+xSiKxvLhC1ALLB
        Jc7B+kq+E6KgwnlXhT43xuDHOlun7FEpIoYO+Elu3g==
X-Google-Smtp-Source: ADFU+vu5Z+2UkQtHXzD5lzUdpVS3/bgA81N4t8QmWWStrtzKpM10C+DUPxwjWYbFyWaEbFuH3qhuWk3LkwXpW6YO3Nw=
X-Received: by 2002:ac2:5699:: with SMTP id 25mr2373610lfr.54.1583230449412;
 Tue, 03 Mar 2020 02:14:09 -0800 (PST)
MIME-Version: 1.0
References: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
 <20200302103754.nsvtne2vvduug77e@yavin> <20200302104741.b5lypijqlbpq5lgz@yavin>
 <CAB3eZfuAXaT4YTBSZ4sGe=NP8=71OT8wu7zXMzOjkd4NzjtXag@mail.gmail.com> <20200303070928.aawxoyeq77wnc3ts@yavin>
In-Reply-To: <20200303070928.aawxoyeq77wnc3ts@yavin>
From:   lampahome <pahome.chen@mirlab.org>
Date:   Tue, 3 Mar 2020 18:13:56 +0800
Message-ID: <CAB3eZfu1=-FwJTnnH=sfg=J2gkeF0bgMs43V5tSkxdqP+m+R9A@mail.gmail.com>
Subject: Re: why do we need utf8 normalization when compare name?
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Unicode normalisation will take the strings "=C3=B1" (U+00F1) and "n=E2=
=97=8C=CC=83"
> (U+006E U+0303) and turn them into the same Unicode string. Note that
> there are four kinds of Unicode normalisation (NFD, NFC, NFKD, NFKC), so
> what precise string you end up with depends on which form you're using.
> Linux uses NFD, I believe.


> And yes, once the strings are normalised and encoded as UTF-8 you then
> do a byte-by-byte comparison (if the comparison is case-insensitive then
> fs/unicode/... will case-fold the Unicode symbols during normalisation).
>

What I'm confused is why encoded as utf-8 after normalize finished?
From above, turn "=C3=B1" (U+00F1) and "n=E2=97=8C=CC=83" (U+006E U+0303) i=
nto the same
Unicode string. Then why should we just compare bytes from normalized.
