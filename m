Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4928DC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6D020775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585070553;
	bh=bp10Mc3LqwR+gWIk4APSHLbda5xk89sidknnuv0bdm8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=czZVZPuO1WCYLLbUH+SGwasEMb9RwERoI0lJAITDrAOfR34qDoPYor97PWdL5+cOV
	 2C8r3o1khFWeDWQeSfLqa3vAOU15LfxcZWvjGlcHyr1bBVb+CnRPtGlmt6OkFKe+5a
	 U9I2NB9LErx4dWevJMSau8/0zAze9AeFlKnOTY0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCXRWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbgCXRWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:22:31 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A32A20789
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585070551;
        bh=bp10Mc3LqwR+gWIk4APSHLbda5xk89sidknnuv0bdm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TARocf7sBQj7ls/goJ+3p5ExlEas9ycfg5RJCbV+92DNQHfVlzWvVimDS4HeaBGPs
         tkl112VjpdagQn/Mu31TWqyw1dbyKL9lgcZC+CLxf7qFevo+LJc9PvtmNy877Lzjsu
         TPfZuG2o/ZDDLl6uRIlc6SfxZth417m7SwFkCV9I=
Received: by mail-wm1-f53.google.com with SMTP id 26so3022843wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 10:22:31 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0D8hkH/ns2fLSDSuW4H9MKI3rMpV6wf56WLR8nc8EwbANW7QOr
        mOb6sVpCL/Kf2quZ8uw3Q9a6tl+/wLnfBmSNnSYpaw==
X-Google-Smtp-Source: ADFU+vuTP/sjpgu7PiSnr/YVpY1CTTUfMjcZ1larcHyvpiup0Xp2j2NELmfyiILtE6gG1uE+GZo2Co4gWCOVGVBUaQA=
X-Received: by 2002:a1c:f407:: with SMTP id z7mr6596789wma.36.1585070549715;
 Tue, 24 Mar 2020 10:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200324145120.42194-1-vincenzo.frascino@arm.com> <20200324145120.42194-3-vincenzo.frascino@arm.com>
In-Reply-To: <20200324145120.42194-3-vincenzo.frascino@arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 24 Mar 2020 10:22:18 -0700
X-Gmail-Original-Message-ID: <CALCETrUPaJCgY_herAUJAfqUbXS6S9xOaLz9abFEWOjEouNf+A@mail.gmail.com>
Message-ID: <CALCETrUPaJCgY_herAUJAfqUbXS6S9xOaLz9abFEWOjEouNf+A@mail.gmail.com>
Subject: Re: [PATCH 2/3] kselftest: Extend vDSO selftest
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 7:51 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> The current version of the multiarch vDSO selftest verifies only
> gettimeofday.
>
> Extend the vDSO selftest to the other library functions:
>  - time
>  - clock_getres
>  - clock_gettime
>
> The extension has been used to verify the unified vdso library on the
> supported architectures.

The code in tools/testing/selftests/x86/test_vdso.c actually checks
that the times returned by the vDSO are correct.  Perhaps that code
should be copied or moved here?
