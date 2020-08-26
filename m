Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC1FC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4532071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTGLn1x/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHZGih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgHZGiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:38:15 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE6FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 23:38:14 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id p186so370620vsa.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 23:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hDQRRI78D3Sk/YTewL1Qk0xdUUz1zPK2EJmRrgeUM0s=;
        b=vTGLn1x/zJIY52K4Di+3Teh/ssAgCH5yCwousRZq+WecxuiBZEquiPQ9UNFYv6go+3
         cxi9hrbf2PwEWTBq9ymWzvNM9qStJcOI/VzzqoFk3NpF4g3qH7J2F19ht/JJlu3ryxSN
         QQLSDGi9S/5vRxqgCcBcSrmgspZbBbXmmZfE8YjUe415ruvrb1/taSGkJjYKYCnCwmBy
         W7N5w2m83JU88vI4Y8ZBW1sRBlpZoDDr1BQl/dAiLyjyZNPvRccfwRVDjiW5oBZL5gCY
         PIaopB27colyHJy/KItN20mbxURukeTX37yvpDdatb1doKoHcDElNQX5XjOOpgJiSKl9
         pByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDQRRI78D3Sk/YTewL1Qk0xdUUz1zPK2EJmRrgeUM0s=;
        b=Pf8I293H6eJAIvOqgvThR4ZEwXwu1He8kMnspSFVCnlkXaTkBa+P9HhHE5F1qnz30v
         MK1cFiiheGL6nQHGKretLN7N42UOgzY2egE9LBKopzfGbcqN9VABWwNWel8yJawmOFh4
         X3Sy6tvYmnp6si2XMuVxLxBkC9VJUzZZ7i7Csm5ae36+Vz9k7liIpnKzobRhuYvhghZa
         u2hmF0k/LblfGm1nnaaDZd00eR/vS5DnzrdTl6HCtR9SPCz8z1r00cA84dEfcRuDxdS/
         X6UkqCJ4e8BQVTd6chtOp1u/pnR838+YcEiyGxGKJHHfkZvJEkgIo2ruVzcXXGy1n5fB
         5JPg==
X-Gm-Message-State: AOAM531UoF9qP59+LBpe8n+8SDenBmUy/7W8fxiCQw3ljLbacwvyG4SD
        XmFV9JKNKxmvX3e1sJeQG1nsm2jRfWBefGcClSGHXA==
X-Google-Smtp-Source: ABdhPJxskoXtY/RFvHibrA9E3iOGod97S56DxYjdnW850ds8AvXYJR6KR4cZHsxljH82T1HmX9SZMy0I8dsWlSV6bzI=
X-Received: by 2002:a67:fb43:: with SMTP id e3mr7397682vsr.91.1598423892321;
 Tue, 25 Aug 2020 23:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200819104057.318230-1-ulf.hansson@linaro.org>
 <20200819104057.318230-4-ulf.hansson@linaro.org> <20200825161602.GE12523@codeaurora.org>
In-Reply-To: <20200825161602.GE12523@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Aug 2020 08:37:35 +0200
Message-ID: <CAPDyKFrMUf4y5kVjr=dW-wf2kqBwcGePf=55U1Ck8O6tp-OuqQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM / Domains: Add support for PM domain on/off
 notifiers for genpd
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 at 18:16, Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Wed, Aug 19 2020 at 04:41 -0600, Ulf Hansson wrote:
> >A device may have specific HW constraints that must be obeyed to, before
> >its corresponding PM domain (genpd) can be powered off - and vice verse at
> >power on. These constraints can't be managed through the regular runtime PM
> >based deployment for a device, because the access pattern for it, isn't
> >always request based. In other words, using the runtime PM callbacks to
> >deal with the constraints doesn't work for these cases.
> >
> >For these reasons, let's instead add a PM domain power on/off notification
> >mechanism to genpd. To add/remove a notifier for a device, the device must
> >already have been attached to the genpd, which also means that it needs to
> >be a part of the PM domain topology.
> >
> >To add/remove a notifier, let's introduce two genpd specific functions:
> > - dev_pm_genpd_add|remove_notifier()
> >
> >Note that, to further clarify when genpd power on/off notifiers may be
> >used, one can compare with the existing CPU_CLUSTER_PM_ENTER|EXIT
> >notifiers. In the long run, the genpd power on/off notifiers should be able
> >to replace them, but that requires additional genpd based platform support
> >for the current users.
> >
> >Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >---
> > drivers/base/power/domain.c | 130 ++++++++++++++++++++++++++++++++++--
> > include/linux/pm_domain.h   |  15 +++++
> > 2 files changed, 141 insertions(+), 4 deletions(-)
> >
> >diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> >index 4b787e1ff188..9cb85a5e8342 100644
> >--- a/drivers/base/power/domain.c
> >+++ b/drivers/base/power/domain.c
> >@@ -545,13 +545,21 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
> >       if (!genpd->gov)
> >               genpd->state_idx = 0;
> >
> >+      /* Notify consumers that we are about to power off. */
> >+      ret = raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_OFF,
> >+                                    NULL);
> >+      if (ret)
> >+              return ret;
> >+
> >       /* Don't power off, if a child domain is waiting to power on. */
> >-      if (atomic_read(&genpd->sd_count) > 0)
> >-              return -EBUSY;
> >+      if (atomic_read(&genpd->sd_count) > 0) {
> >+              ret = -EBUSY;
> >+              goto busy;
> >+      }
> >
> >       ret = _genpd_power_off(genpd, true);
> >       if (ret)
> >-              return ret;
> >+              goto busy;
> >
> >       genpd->status = GENPD_STATE_OFF;
> >       genpd_update_accounting(genpd);
> >@@ -564,6 +572,9 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
> >       }
> >
> >       return 0;
> >+busy:
> >+      raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_ON, NULL);
> It would be helpful to abstract these notification related calls into
> functions of their own. So, for CPU PM domains, it would help to add
> RCU_NONIDLE() around the notifiers, allowing the callbacks to add trace
> functions.

Thanks for the suggestion! It makes perfect sense to me - and would
also be consistent with how CPU PM notifiers are managed,

[,,,]

Kind regards
Uffe
