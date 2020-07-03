Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E7DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D39321531
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTyBfb6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGCHtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgGCHtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:49:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B117C08C5C1;
        Fri,  3 Jul 2020 00:49:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e8so1589426ljb.0;
        Fri, 03 Jul 2020 00:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPH2st2Pqe2VTT1oPxnRHqMVaOG4iEFkIyKYIfsbc+U=;
        b=NTyBfb6MC/K5Sd6KyVNZKzEbpAik9J+b6aw3s41DDaJeWEtVid9Gy9Mulpo9CQT/qk
         WlfNGgGBRtzo6y86l+XsTPfiDRqYrrlJPY6Fn86X41UWfKF/6fhmH1iUikQ3qVctS/8Y
         Y3qNr2/REEG9OU5BtskvsuhN50jOTU9dsU4xwTth1z6rjwPpTO1QEiRA9tUgfH41FaC2
         YBXVDlMFkmochv4W7tg2yOy2YABH2d8Pcv4d6jQrbIVCkNn3u6VgMk3Mb4K+Tf83fHxV
         bhTeIJqut0rRowIe2OO7ZtRqKsFPZysWZ6lubgc8v86cR0t9DFk3ABf3eBEob8xso9+4
         kF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPH2st2Pqe2VTT1oPxnRHqMVaOG4iEFkIyKYIfsbc+U=;
        b=mBZdU1vdb9JAF+8AFVd4TK8eeFPw3lrWM+HgPf9IWCX9ZlOERbE40fsEvH5pme3I2z
         K1ZGlQEaAHR59UxjeOMzfqzwmdUMgsCrLAh4tWJj3gN047GH36aW9N4aDjhEIMts3JCX
         ZhYPQLta2RxlTpCYGzzeCzse4xf0ny3GdYwBt7Xow+8SMtFPuUhuDY2ykmw57wcc7XSI
         CULdYAGixQnJWiAZJQU6bDuD/2ljud9EBER8RdebVGc2jD80gHZ4Wj0oO+RgYThscjci
         B61JPWL9AodO2ZJzjwamP0L37gsXaC/uFfxsVYrgPO/cYvajS4+5FD02XQ2KJGVnKWqh
         NbjA==
X-Gm-Message-State: AOAM530VB7qV3yqB4Ugz8PJpKn75okmYgrg3RwE/Spi33iQhRXT4yfOX
        c8B0bPHHej9YEcS1zZmdphvSlf/SVfoWpR++Klszmcpn9M4=
X-Google-Smtp-Source: ABdhPJyaP/rrmSPjy3RcimVB0S5EWbzspouE7IaasobfxWfTADJFI9jmKIiPw6kf4/ctQru1yOUTfnH56mocespH/JE=
X-Received: by 2002:a2e:b167:: with SMTP id a7mr9779767ljm.83.1593762589556;
 Fri, 03 Jul 2020 00:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200703001212.207565-1-danny@kdrag0n.dev> <CANiq72k2rrByxzj1c4azAVJq-V7BqQcmBwtm3XM9T8r3r3-ysQ@mail.gmail.com>
 <16043769.gqpzGLO8mG@pinwheel>
In-Reply-To: <16043769.gqpzGLO8mG@pinwheel>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 3 Jul 2020 09:49:37 +0200
Message-ID: <CANiq72k_DrinWLNUVdc_DoOQu5wB8uD5Yns=Jw7PMDC_TbEETw@mail.gmail.com>
Subject: Re: [PATCH] editorconfig: Add automatic editor configuration file
To:     Danny Lin <danny@kdrag0n.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 9:31 AM Danny Lin <danny@kdrag0n.dev> wrote:
>
> Most of the other exceptions can be accomodated for with more specific
> rules below the base [*] section. I just went through most of the
> kernel's files and added rules for the vast majority of the exceptinos
> to the 8-column tab indent style, though there are still some that
> haven't been covered.

Very good! That looks much better.

Are there too many file types that use tabs? If not, then I think it
is best to add a section for "General tab" files like for the others,
in order to be explicit and to have the list around.

> It looks like some types of files lack consistent indentation, e.g.
> arch/mips/*/Platform and some shell scripts in scripts/ tools/testing/
> selftests/ftrace/test.d/kprobe/*.tc. There are also some files that were
> highly inconsistent even within themselves (e.g. drivers/gpu/drm/amd/
> amdkfd/cwsr_trap_handler_gfx*.asm), so setting indentation settings to
> something sane by default doesn't make them any worse. After all, no
> automated code style tooling is perfect and there will be edge cases
> where it breaks down.

Yeah, do not worry about inconsistencies. For `.clang-format`, I
picked the options based on 1) whether there was an official code
style guideline and 2) if not, the one that minimizes the number of
changes, i.e. the most popular one across files.

Cheers,
Miguel
