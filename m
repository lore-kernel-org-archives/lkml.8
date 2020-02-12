Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967D4C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0B120661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUVL+4E/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgBLIih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:38:37 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46768 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgBLIih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:38:37 -0500
Received: by mail-vs1-f66.google.com with SMTP id t12so615674vso.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHqIf5M4paWRQqNMsUfuUrTYwOKU9w45APayE5qNVvs=;
        b=vUVL+4E/ghJvS34Gw+Yj3FC8/V75VOYPhxzpJQgUT6tMqtb9vakYs2GI0k47MFdUq3
         hQ1YQcUXc0R3WTcUgNgO26qcrxwrfbqBk8S03K72PonAAM+wa+C7YAI/+/h1u75Nz7/6
         bXs/K7tD0boEOfEK1j5rFSpxQ77Uht/WRcvdkmaS3Qj/Koerbc7RXmgQiNpT2BqMIviV
         c1aPNJQ2gzdl+kOtoNYtLEv30u82JjAHSQ6Ha2Pvzj9QtPHdRuICR1mVFVspd4LEEt2F
         HLSKF5IedVsH0ZCyqPErwfyRP6aU38jYRni922g7VV6DWoY0s4Hj+QxK6PLixQimyXkh
         AKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHqIf5M4paWRQqNMsUfuUrTYwOKU9w45APayE5qNVvs=;
        b=sy4AFsXhh0dXqxXBo6ELqsURPw49CUE0i1Ve2GkosYTlO99Z5/3DwxT6CvG9qymR0u
         X7Nv0BE0Aoib7PZECUkW+pNQAMCe56KgnzNLcpOwu6P33JtPGRAHKxFAiH04em9AgMXZ
         nBgqas1ZjkZf65VAQOvDfYpNCnbDEzWFmjNo4ZsH3XjuGeVkPvBMe1yIxs8US9MSojI3
         OYOCZxVUZsjC0Odlqao3s0qUIPj+C3gt0rZCjmaQJjNu5oECmJviap1G2SlT9evrJmXm
         5gc8D90BSl9MH+w0CIFq29GCsUnF8XWw8C8knYUXTNpc+fw6dAcB0vqYSJcI/2K7MuHP
         OUnQ==
X-Gm-Message-State: APjAAAWiKP648Ef7HkNG8v42mczpx/vMGDWT94LeaDIc2DcmGtJDsV+M
        DR574ML2FQR/FwLUay69RVCg32nknlIDeIs+gU76MvW7
X-Google-Smtp-Source: APXvYqxbfXdatWIwHYUuqWnHyNbcSLk+ziuVt3G+MpDqiO/zFVXyM6TIy0v6BZusgksxp8Nbds6bc8i2h3q/OgH6Deg=
X-Received: by 2002:a67:f591:: with SMTP id i17mr605202vso.34.1581496715171;
 Wed, 12 Feb 2020 00:38:35 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Feb 2020 09:37:59 +0100
Message-ID: <CAPDyKFrcRzDE9=A28uf2sp=zaJpbEGrW5jm3L6CBVVc=GaL-Jg@mail.gmail.com>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU
 latency QoS interface
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 at 00:39, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> This series of patches is based on the observation that after commit
> c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
> in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
> code dedicated to the handling of global PM QoS classes in general.  That code
> takes up space and adds overhead in vain, so it is better to get rid of it.
>
> Moreover, with that unuseful code removed, the interface for adding QoS
> requests for CPU latency becomes inelegant and confusing, so it is better to
> clean it up.
>
> Patches [01/28-12/28] do the first part described above, which also includes
> some assorted cleanups of the core PM QoS code that doesn't go away.
>
> Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
> "define stubs, migrate users, change the API proper" manner), patches
> [26-27/28] update the general comments and documentation to match the code
> after the previous changes and the last one makes the CPU latency QoS depend
> on CPU_IDLE (because cpuidle is the only user of its target value today).
>
> The majority of the patches in this series don't change the functionality of
> the code at all (at least not intentionally).
>
> Please refer to the changelogs of individual patches for details.
>
> Thanks!

A big thanks for cleaning this up! The PM_QOS_CPU_DMA_LATENCY and
friends, has been annoying me for a long time. This certainly makes
the code far better and more understandable!

I have looked through the series and couldn't find any obvious
mistakes, so feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Note, the review tag also means, that's fine for you to pick the mmc
patch via your tree.

Kind regards
Uffe
