Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11A8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD3B20897
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X27pYeMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFQUBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQUBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:01:11 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D62C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:01:09 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so1592091pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=caNCPxuwnsfme3cJQ3yFnZipKvQl8RiDyCwsEjsLsMc=;
        b=X27pYeMzeBegpSXYr94WQ9cQIx8qfoKI7mRjZFuswG0wtv2Fk0MvxnXTKKZn2wySjq
         XdXkAxGseiME2d5R6P6OTH3Hu3IXnbw6OaWe4/UQHwh8egU/Zeb/T/Yoa7mgMmoyDvmO
         Mf5NUUL0VBTx07Qg5Vblr2/bsdgQoz2/oi92w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=caNCPxuwnsfme3cJQ3yFnZipKvQl8RiDyCwsEjsLsMc=;
        b=CncqHi6sFSVBvnOVy5ZPNK0Phk/aD/siZTdhTm+sh0Rz3US61JEYPMhuhbHXXrHssG
         UH42m6FawNy5+xklE7rd0sm68bH7XqzBK/b7zceDPNTRUrHj4yGIn/CJufNUZiT+gWLM
         RWTSKaPonAJjx6IU2JIo7Ssqc3D1iyLDoXgebbOa3W7ao161Lwl+t+SrloaenKytw7zy
         pDi8ExvW8v49TchL7DGJyaCNl/soRmXDaus/FzaSTmvVCY+mSl7X9NxI4iXVkXC4RMmt
         unILpMLG4asoujKqbu+f8oNDJ3tcQHkcrxNOkfjeS1TMbE2PbDYIE2bmav7sme7zicwT
         5/LQ==
X-Gm-Message-State: AOAM533RMpBYeA4rdnpoIm9/3MwdMJixsztKv3pJxvjdgvj2EnfXYXvV
        Ce88zW9YMXd4fVSDw8EwJtj6Y+7K3gQ=
X-Google-Smtp-Source: ABdhPJyPwoUI6HSyoEhh3ukwzEqMPFmJ63d2Boybwl/wQzQT0a3lfMeOWwHvgWFA8yyGf8DRLkfEnQ==
X-Received: by 2002:a17:90a:ce11:: with SMTP id f17mr654054pju.123.1592424069090;
        Wed, 17 Jun 2020 13:01:09 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h7sm599873pgg.17.2020.06.17.13.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:01:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200617113851.607706-2-alexandru.elisei@arm.com>
References: <20200617113851.607706-1-alexandru.elisei@arm.com> <20200617113851.607706-2-alexandru.elisei@arm.com>
Subject: Re: [PATCH v5 1/7] arm64: perf: Add missing ISB in armv8pmu_enable_event()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mark.rutland@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, maz@kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, catalin.marinas@arm.com,
        Namhyung Kim <namhyung@kernel.org>, will@kernel.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 17 Jun 2020 13:01:07 -0700
Message-ID: <159242406774.62212.13909672383879587787@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru Elisei (2020-06-17 04:38:45)
> Writes to the PMXEVTYPER_EL0 register are not self-synchronising. In
> armv8pmu_enable_event(), the PE can reorder configuring the event type
> after we have enabled the counter and the interrupt. This can lead to an
> interrupt being asserted because the of the previous event type that we

'because the of the' doesn't read properly.

> were counting, not the one that we've just enabled.
>=20
> The same rationale applies to writes to the PMINTENSET_EL1 register. The =
PE
> can reorder enabling the interrupt at any point in the future after we ha=
ve
> enabled the event.
>=20
> Prevent both situations from happening by adding an ISB just before we
> enable the event counter.
>=20
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_even=
t.c
> index 4d7879484cec..ee180b2a5b39 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -605,6 +605,7 @@ static void armv8pmu_enable_event(struct perf_event *=
event)
>          * Enable interrupt for this counter
>          */
>         armv8pmu_enable_event_irq(event);
> +       isb();

Please add a comment before the isb() explaining the situation. Nobody
knows what this is for when reading the code and they don't want to do
git archaeology to figure it out.
