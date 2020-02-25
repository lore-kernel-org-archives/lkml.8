Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D364C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F8B20732
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MASHOfjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgBYRQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:16:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41466 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbgBYRQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:16:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so7179631pgf.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=nA6XtHfCbnQ+UrxP5iH37BANlB2snp9+FgCCs6LFMHc=;
        b=MASHOfjqGNYT1tp6DvmruXzocvsetadvExcpfODmmFENiPMhWeeGCkLkwK5CrSPHYu
         xS0lIIYIC9oJ2y3y7AB5I4+/sYx9Jar/0wKwBcM1V1KB88ETjoj2O0jYgcw6SiX6afr8
         KdyVnvRqEpAhmxEj6V6AY6f3w0FecY9EkYR68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=nA6XtHfCbnQ+UrxP5iH37BANlB2snp9+FgCCs6LFMHc=;
        b=szA8WQpBVS/GkA1n0kDdXBERfw9wJMQYc0UZMVNl4ocM3irqVjD4P1TSIenYmBDooZ
         IWa5Lbpa0iLmcRCUgArusCakqLyPgBSmVp/zwj/vDo6DIywUtfe2uk4NN1NCSnaWCD5D
         FaUh9qxaczIKYFqperKAYpDOt+2Fjsf8sDy8gejToMc3oiS5nijl0+ZItncyZXGagrqE
         mlLr3PiT1e2S0lZKtUO1Bexa43l8hRw3Jx0Xv7jCZq2Hjcbi4OcjKRYBFbWidCiqK5Jq
         ThQ6Lhv1k+rBpwnW3awNmWPMbujs+403rbKxz9WQjEcVBudOBHXGptjZx/wEjTTXx6p/
         EDaA==
X-Gm-Message-State: APjAAAWTA3z/yTDXrTpXOxVM5Gu/VwysfzPPSpgThRIHPhgFQuy6yC1q
        K6QHEcgbEEm13quzksDwwJf7v7isn7c=
X-Google-Smtp-Source: APXvYqz+jv0qTKXQ6FaD+VS8Rw4zthTocRAiqn9uBFJunwpJ3inVjQ7HkA/RT9pN2Kq7aXC8OPj0uA==
X-Received: by 2002:a63:18d:: with SMTP id 135mr33641250pgb.32.1582650962218;
        Tue, 25 Feb 2020 09:16:02 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y5sm18329689pfr.169.2020.02.25.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:16:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4c80783d-8ad0-9bd8-c42e-01659fa81afe@codeaurora.org>
References: <1581944408-7656-1-git-send-email-mkshah@codeaurora.org> <1581944408-7656-2-git-send-email-mkshah@codeaurora.org> <158216527227.184098.17500969657143611632@swboyd.mtv.corp.google.com> <4c80783d-8ad0-9bd8-c42e-01659fa81afe@codeaurora.org>
Subject: Re: [RFC 1/2] irqchip: qcom: pdc: Introduce irq_set_wake call
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, linus.walleij@linaro.org, tglx@linutronix.de,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Date:   Tue, 25 Feb 2020 09:16:00 -0800
Message-ID: <158265096050.177367.409185999509868538@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-02-21 03:20:59)
>=20
> On 2/20/2020 7:51 AM, Stephen Boyd wrote:
>=20
>     How are wakeups supposed to work when the CPU cluster power is disabl=
ed
>     in low power CPU idle modes? Presumably the parent irq controller is
>     powered off (in this case it's an ARM GIC) and we would need to have =
the
>     interrupt be "enabled" or "unmasked" at the PDC for the irq to wakeup
>     the cluster.
>=20
> Correct. Interrupt needs to be "enabled" or "unmasked" at wakeup capable =
PDC
> for irqchip to wakeup from "deep" low power modes where parent GIC may no=
t be
> monitoring interrupt and only PDC is monitoring.
> these "deep" low power modes can either be triggered by kernel "suspend" =
or
> "cpuidle" path for which drivers may or may not have registered for suspe=
nd or
> cpu/cluster pm notifications to make a decision of enabling wakeup capabi=
lity.
>=20
>=20
>     We shouldn't need to enable irq wake on any irq for the CPU
>     to get that interrupt in deep CPU idle states.
>=20
> + *
> + *     Note: irq enable/disable state is completely orthogonal
> + *     to the enable/disable state of irq wake.
>=20
> i think that's what above documentation said to have wakeup capability is
> orthogonal to enable/disable state of irq, no?
>=20
> A deep cpuidle entry is also orthogonal to drivers unless they register f=
or cpu
> pm notifications.
>=20
> so with this change,
> if the drivers want their interrupt to be wakeup capable during both "sus=
pend"
> and "cpuidle" they can call "enable_irq_wake" and leave it there to be wa=
ke up
> capable.

Where is there a mention about drivers registering for cpu PM
notifications? I'm not aware of this being mentioned as a requirement.
Instead, my understanding is that deep idle states shouldn't affect irqs
from being raised to the CPU. If such an irq is enabled and can't wake
the system from deep idle and it's expected to interrupt during this
idle time then perhaps the PDC driver needs to block deep idle states
until that irq is disabled.

Does this scenario exist? It sounds like broken system design to have an
irq that can't wake from deep idle, but I see that PDC has a selective
set of pins so maybe some irqs just aren't expected to wake the system
up during idle.

>=20
> This way they don't need to worry about cpu entering to deep low power mo=
de and
> enabling wakeup capability "only when" deep low power mode get triggered.
>
