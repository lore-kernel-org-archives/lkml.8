Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947D0C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C002068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SekfQuef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgEFK0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726354AbgEFK0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:26:37 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71158C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 03:26:37 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t3so926254otp.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JJrxKPKyOXug7kU6AgNPvK7plqXWXoHNTpGsuarqFzQ=;
        b=SekfQuefrtyx42HHqwoLFcYCcC79SWr0OXKjN7EgL6zWOvBD4g9cPXiiH/FrFQqf3+
         rXiLd2HyZy7Crug0B37GaDRzSvbS3vckfqNUwMnTOMHElo1bbLCfVPCiKgn/JlI/ePjQ
         1X3SckJefNGcuJF6emDdfsKWaYJ2F9lKQl5+mb7dYZE4FEnxtzFWITXIKRYG94g5TyiP
         NiN5Uu9/bRkcLzupI0Xze5lBibS/ucXP0ai46TdM8X4HDjYo5yPwdWDRcq6LjE3R7M25
         1G34FwfG32DpPvmPQZOdJUWEN/HRuY/p9GPybH7I7SvuzDWRf1wJKsadqoEaC/3rIl4v
         kBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JJrxKPKyOXug7kU6AgNPvK7plqXWXoHNTpGsuarqFzQ=;
        b=TB50oAyM0VJ/M01tMJGq776EJDq0YboOevrye/gtEkYt9Y0Tuv45Yu94ac3DVOBJDP
         S58j2/2wKUZGousT4vKiv0la6n7b6MlA+bC5P6sw0lKpkUsn2GgnoK4uGUlya366zP3L
         y5S9IwZx0LPbkQ70pgRuB1/JESDDsarc8CmZtqqYAJykAtCPKQHWPLVr7EPC3HbC/3uo
         RdpxE7SJgcraOQRR8wfepRVi0j7E5M7kNd+qSiZIdpcgkIhkeFqzOGuVNm9TaLtm3K57
         3RBUOnLyLmlhI8m1Zfj9ASFIDchu06I/btgOp0lJkt0kOwpvHR5bAerNOBSxV+cC+wT/
         9aBw==
X-Gm-Message-State: AGi0PuZ31h9zyNMTrbjwY5SnKItS0XGU269suKAe8hu7GbWUzEWUjX98
        ROUV6hJUnIsh+wGUo4tSt8F35TrsAusbDtVspULBdQ==
X-Google-Smtp-Source: APiQypJDEvmH4DB/BFLw1Wf5WXfph/cfi9fYkC5byfv43JmLgpAi8ubvNRXoYU3eCWqaMH+CxvFaUG9TsnxbZtFpx6I=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr474295oto.251.1588760796552;
 Wed, 06 May 2020 03:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200505182821.47708-1-elver@google.com> <CABVgOSmg8z1TpMh7NPy0M+9Gs2JT097-j_XGBRGhKk_3y2J-oA@mail.gmail.com>
In-Reply-To: <CABVgOSmg8z1TpMh7NPy0M+9Gs2JT097-j_XGBRGhKk_3y2J-oA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 6 May 2020 12:26:25 +0200
Message-ID: <CANpmjNOF5mPzU+TT+LftpfLFEhWUy1s1To1rsPXZBORTgfM_fw@mail.gmail.com>
Subject: Re: [PATCH v2] kcsan: Add test suite
To:     David Gow <davidgow@google.com>
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

On Wed, 6 May 2020 at 06:45, David Gow <davidgow@google.com> wrote:
>
> On Wed, May 6, 2020 at 2:30 AM Marco Elver <elver@google.com> wrote:
> >
> > This adds KCSAN test focusing on behaviour of the integrated runtime.
> > Tests various race scenarios, and verifies the reports generated to
> > console. Makes use of KUnit for test organization, and the Torture
> > framework for test thread control.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Thanks, this works much better on my setup: having an explicit error
> for there not being enough CPUs is a lot better than hanging. It'd
> still be nice to have these be "skipped" rather than "failed" at some
> stage, but that's a nice-to-have for the future once we've implemented
> such a thing in KUnit.

Will keep an eye on KUnit adding support for this, and in future we
can change it. Although I'd argue that these tests failing is a signal
that a particular KCSAN based CI setup isn't terribly useful at
finding data races, which can still be a valuable signal to have.

> I'm still a little hesitant about non-deterministic tests in general =E2=
=80=94
> even if they're only run when CONFIG_KCSAN is enabled, it's possible
> that a future CI system could run under KCSAN and report false
> breakages on unrelated patches. Given no such setup exists yet,
> though, I think it's probably a problem for the future rather than a
> blocker at the moment.

True. But as noted above, it might also highlight an issue with the CI
system's ability to detect data races if KCSAN is enabled, which is
the whole point of having a KCSAN test setup. But yes, let's cross
that bridge when such a system actually exists.

> Regardless, I hit no unexpected issues in my testing, so,
>
> Tested-by: David Gow <davidgow@google.com>

Thank you for testing!

-- Marco
