Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9208C4725D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E1A206F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNYljanB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgEFEpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 00:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgEFEpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 00:45:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D41C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 21:45:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so857520wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 21:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Iqotp4Pzqr9RQqsgLMpXGPLAwQseruKWmRPMUXLKxY4=;
        b=dNYljanBzrbTS1pIe5fVzt2wPBuZEBnSMI5xTqSjKCm5pBWo45oj87/rEcsvAj+fyG
         ejziA6igQ3J1BuLiRKf7QfkZovsocQgMp7sfLa2hkfS5hSRp+Wd2n3TSCIahHFKxf+0F
         wXePzIJqbhUN3fJiQ6SC+EL5KmtH4nSwA6ytYDVwk7yA1GiOZqg7u6EiiMFWHTue8CRR
         j2WbBxKtVthNdffzVFJ5fd9tvadNHjoj6WD+CjYQF7e6CRfUzH2hhOfAjkeiTpzIdn/R
         qZ23jkSjPLJh8rzPu7EAVlBU2EZszA9/qDPGv6JWLZbZe6mChM3IfVVGyR1QzfVJlNy0
         /Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Iqotp4Pzqr9RQqsgLMpXGPLAwQseruKWmRPMUXLKxY4=;
        b=U8U2mNEdRvfX27CHf+5/1n4WTnwnaAC1oQx+kFaAR2z2DbkCYTBlxICdNzv5tjrV1C
         z1GlKfXGowTygdXM+U10Iw4nVNXUC42gv/kp0Ke8l3Xv0ymvJrjZLxY04QieH/jqf72A
         t+hmcocaD4vaUCpORplpKtqx42vsQBnrwT3qln5dVdkrakruk7T29gSpvd5s7XRjTI9l
         mC9MJm1IazGC3z5ak+X2bP9J5bI17R4ZPAmw5hl5x/PN+lwxFh0KZWDinrMRtpeKq2OH
         +oUuGpPxkFpIO35JmsE8TpPQKQtZZ9TT2pwFUvYrIPrxt8wlTJX3MKOG7U7BGUnFrf64
         bKFw==
X-Gm-Message-State: AGi0Pua2B+J+eO6izmgShMsR0f2aofU31JA5XU21UrNxu2X8UaSS1wOB
        S37aYaACJILg8sexxIpAGJZdghHyK25YCE2eAr9elQ==
X-Google-Smtp-Source: APiQypLlWoyB8MsiBPPwrCnj6rFRlzdL+3LDkvIkmUwWB4W78Fye3W+wePNZ9OADmwbwWZLxi6pRuvX3lw5wcg7eR1Y=
X-Received: by 2002:a1c:1fcf:: with SMTP id f198mr2157051wmf.16.1588740314500;
 Tue, 05 May 2020 21:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200505182821.47708-1-elver@google.com>
In-Reply-To: <20200505182821.47708-1-elver@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 6 May 2020 12:45:03 +0800
Message-ID: <CABVgOSmg8z1TpMh7NPy0M+9Gs2JT097-j_XGBRGhKk_3y2J-oA@mail.gmail.com>
Subject: Re: [PATCH v2] kcsan: Add test suite
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 2:30 AM Marco Elver <elver@google.com> wrote:
>
> This adds KCSAN test focusing on behaviour of the integrated runtime.
> Tests various race scenarios, and verifies the reports generated to
> console. Makes use of KUnit for test organization, and the Torture
> framework for test thread control.
>
> Signed-off-by: Marco Elver <elver@google.com>

Thanks, this works much better on my setup: having an explicit error
for there not being enough CPUs is a lot better than hanging. It'd
still be nice to have these be "skipped" rather than "failed" at some
stage, but that's a nice-to-have for the future once we've implemented
such a thing in KUnit.

I'm still a little hesitant about non-deterministic tests in general =E2=80=
=94
even if they're only run when CONFIG_KCSAN is enabled, it's possible
that a future CI system could run under KCSAN and report false
breakages on unrelated patches. Given no such setup exists yet,
though, I think it's probably a problem for the future rather than a
blocker at the moment.

Regardless, I hit no unexpected issues in my testing, so,

Tested-by: David Gow <davidgow@google.com>

-- David
