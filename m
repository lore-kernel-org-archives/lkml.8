Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF3EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99802080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyvCYGNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgH0PRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgH0Lg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:36:57 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9852C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:36:52 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id k1so1160509vkb.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ooHzlcK9ygV09BpTK5pdlKAaPmSuGBA3cYk3HsnGhI=;
        b=gyvCYGNTxFHy28eyjnJaOniu3Ngpdp7FgF/p36fg9mx0sA+iQINbuS4hvhSRgQZG4K
         M+praVM2M8rDtJE7oKQfrwNOlajEgitaFZ8KpSeGAgp/KojD+cIX5zlMCVGzOsQKlQyt
         pn9rgMBtz7Vo0inQZZ6f8dOZyO/B/86EIiCgW01LQI+LSfo0KB6Eup4DDxOEChXFXVYb
         VPQ49zrePMz2XHowV2ZJ7YId4fRiik+AUkqioR5XowJ5khWUi/UZRIl/z//ErbCUw8i6
         lqZNx4cuUfQYKlWVDbtoB7wzyjoQOA+zcQmP1fZC/iCVWRMKlOmZL3sMkZNfXFHyHKUi
         qx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ooHzlcK9ygV09BpTK5pdlKAaPmSuGBA3cYk3HsnGhI=;
        b=HBzRE5XermT46/dAGIKZQV1w4TTrIzAI4QRCpKrsdFoReaqcOKiqiTdzRkfaG1ZidV
         Ro2Dao3hFUih62rBD+uEzMFx6VfNxx1UeBFEm+UXmi4fC1Y1mABZUz5w+G6756ITY+vc
         oppMiUCxMeCnPrWC5W4WD0ew4i89lAxaG2pUHTwUNYd5/uomBBmEoS1s+J/VuynKyn4K
         hd52s0I5HgJd+gEAkxzhpu8oFAYUYeNup5vjgVAfCCkgbJjovtlm5XORVMFdKaawmq1c
         YE+cyhd/FEwxJCCjE3s+mkQURnnEGtQOSn5XU0E6Y6gRSpH5J5KugCAtNlfQu067DX4+
         YDFg==
X-Gm-Message-State: AOAM5337wYjYrwQqx0evPEcvn0CqKwS94ZRS5XsWlUdahSHtnN+hWtAG
        2vHBdxYvPlBShH0kEyXBAQS1hRcmpDNH8EiYl88PDQ==
X-Google-Smtp-Source: ABdhPJz2Kvyqr5m8SmXHIOwki3A50F7P9NH0AKIKPv9pKYpv2hoW0Imfg7W4iRAq/QvR+EZlcoBfEV1GThBF0OW1ank=
X-Received: by 2002:a05:6122:5ad:: with SMTP id w13mr1188574vko.11.1598528210107;
 Thu, 27 Aug 2020 04:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvUwH2FA9GOeA_7GYpLA31uOmEpg32VKnJ8-d5QSK4PdQ@mail.gmail.com>
 <20200827090813.fjugeqbb47fachy7@vireshk-i7> <CAK8P3a2zxybiMDzHXkTsT=VpHJOLkwd1=YTtCNU04vuMjZLkxA@mail.gmail.com>
 <20200827101231.smqrhqu5da6jlz6i@vireshk-i7>
In-Reply-To: <20200827101231.smqrhqu5da6jlz6i@vireshk-i7>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 27 Aug 2020 17:06:38 +0530
Message-ID: <CA+G9fYv=XLtsuD=tVR1HHotwpKLkbwZVyPr4UhY-jD+6-duTmw@mail.gmail.com>
Subject: Re: Kernel panic : Unable to handle kernel paging request at virtual
 address - dead address between user and kernel address ranges
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, John Stultz <john.stultz@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        madhuparnabhowmik10@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 at 15:42, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 27-08-20, 11:48, Arnd Bergmann wrote:
> > > > [    3.680477]  dev_pm_opp_put_clkname+0x30/0x58
> > > > [    3.683431]  sdhci_msm_probe+0x284/0x9a0
> >
> > dev_pm_opp_put_clkname() is part of the error handling in the
> > probe function, so I would deduct there are two problems:
> >
> > - something failed during the probe and the driver is trying
> >   to unwind
> > - the error handling it self is buggy and tries to undo something
> >   again that has already been undone.
>
> Right.
>
> > This points to Viresh's
> > d05a7238fe1c mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
>
> I completely forgot that Ulf already pushed this patch and I was
> wondering on which of the OPP core changes I wrote have done this :(
>
> > Most likely this is not the entire problem but it uncovered a preexisting
> > bug.
>
> I think this is.
>
> Naresh: Can you please test with this diff ?

I have applied your patch and tested but still see the reported problem.
Link to test job,
https://lkft.validation.linaro.org/scheduler/job/1715677#L1886

- Naresh
