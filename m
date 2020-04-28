Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7CEC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6196206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k59JdLGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgD1FRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbgD1FRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:17:04 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAEBC03C1A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 22:17:04 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id h23so1813203oos.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 22:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyGUYMPdvcwoGpvOuDgk/aiEpv2rX0tt8SNVhsSMdQ4=;
        b=k59JdLGhiziCb+4hFP6QIdWUt4Ofe+zs6WedIQWT1gHSzlRwZHhfAXAIa3HCHdHynW
         g4KIs/Qvk1GVG1z0ZSwnpZ9L+h8z7E4BBos+jDyslnxs05Yp+ftyfR0XsJSv6MY/A7pr
         WdmqoFhAkOG8sb0wXyVFl6yZTdbKpDHqAGWWDD/9jA17dm1sr1mwYrAhevjGMi+ye95g
         rXbo7WLXB9iJOr61f/D57brg/gBMloeXaAX1/3dwQozpv1E+LOFeRebXJehFvLvXsyLc
         62eVjnm2nezM4FRRT3ans1kwnshlYkr3rpGmvmsNwDi3vHhY91Sgp4QuwFro/5r9ilkp
         m0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyGUYMPdvcwoGpvOuDgk/aiEpv2rX0tt8SNVhsSMdQ4=;
        b=PsLEtcLIPa/F3aCIye+il/xMU/FiWCEo782LokDDVFaiFbK+BuToHnlL1CQK5gY3jv
         IVjvQj+OIbp5LMjYBzzsLicnTQgAYdVtcx8kEIHco8Fkb+BP1XKAt4Endm8vWnmXG1aB
         ehuNWXZwJspMrQgVYtIMiHCQlpkbFOr8loSwdaPyu/mffSbUMqZSavjDmX8l1rhO2D+W
         ZFRDJ1J2P/XDWVDhlISs1e2142+CGJhO0bKCN+c1zEYpxvfwpuDQcHebuN2pqyUHK5GU
         QGfr2cgO1rgMXJfSIjlP7XRTsGHvmjxrhRX3i78QfPkfKSIrwQ1+8kficyySxkquz+ed
         KScA==
X-Gm-Message-State: AGi0PubTlVxIViT3B5bjyvm8dnKIGQumRA1g3OtZEVxDcd/eRLIi7269
        nm//EttuZ/G+gyLXnhlRRzN1R0KYLWwg+unG+LYzEg==
X-Google-Smtp-Source: APiQypIvpS4S8gWYymZ3shMB3u7JstrB56GpILA18vJ5FfXikOYHsplz9bL9GkUGDrMqfcNmmYcL8ImD47sB+UAk+Bg=
X-Received: by 2002:a4a:b4c1:: with SMTP id g1mr22015000ooo.58.1588051023570;
 Mon, 27 Apr 2020 22:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <1560337252-27193-1-git-send-email-nishakumari@codeaurora.org>
 <1560337252-27193-5-git-send-email-nishakumari@codeaurora.org> <20190613172738.GO5316@sirena.org.uk>
In-Reply-To: <20190613172738.GO5316@sirena.org.uk>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 28 Apr 2020 10:46:52 +0530
Message-ID: <CAO_48GEYAWBgzeEKx1kjjmLJ+F0chSkRs0EUC86Y2q20kyqjkA@mail.gmail.com>
Subject: Re: [PATCH 4/4] regulator: adding interrupt handling in labibb regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     Nisha Kumari <nishakumari@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org, lgirdwood@gmail.com,
        mark.rutland@arm.com, david.brown@linaro.org,
        LKML <linux-kernel@vger.kernel.org>, kgunda@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

I am looking to address review comments and push v2 of this series (we
need it for pixel3 and poco phones' mainline efforts): I have a query
on your review comment below:

On Thu, 13 Jun 2019 at 22:57, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jun 12, 2019 at 04:30:52PM +0530, Nisha Kumari wrote:
>
> > +static void labibb_sc_err_recovery_work(void *_labibb)
> > +{
> > +     int ret;
> > +     struct qcom_labibb *labibb = (struct qcom_labibb *)_labibb;
> > +
> > +     labibb->ibb_vreg.vreg_enabled = 0;
> > +     labibb->lab_vreg.vreg_enabled = 0;
> > +
> > +     ret = qcom_ibb_regulator_enable(labibb->lab_vreg.rdev);
>
> The driver should *never* enable the regulator itself, it should only do
> this if the core told it to.
>
> > +     /*
> > +      * The SC(short circuit) fault would trigger PBS(Portable Batch
> > +      * System) to disable regulators for protection. This would
> > +      * cause the SC_DETECT status being cleared so that it's not
> > +      * able to get the SC fault status.
> > +      * Check if LAB/IBB regulators are enabled in the driver but
> > +      * disabled in hardware, this means a SC fault had happened
> > +      * and SCP handling is completed by PBS.
> > +      */
>
> Let the core worry about this, the driver should just report the problem
> to the core like all other devices do (and this driver doesn't...).

I (and Bjorn too) looked to find the api that allows us to do this
short circuit reporting and recovery in the core, but couldn't find
anything except REGULATOR_ERROR_OVER_CURRENT which also looks like
it's used only once in the code.

I am sure I'm missing something, maybe you could please help me find it?

Best,
Sumit.
