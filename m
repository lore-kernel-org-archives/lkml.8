Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3056AC38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124CD20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587405319;
	bh=86ZXwLRjB23MXeT4yzvCor31U/swaCeYvDBMy7d8VrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KlT3HbceKS3+HqYbhjg6UM5o6CC5+1obDd/e58lA2vUxkH88ten4T6dSERuyLJljt
	 9PU1M3BlN2h6ZyaLMk2Rs+IHrNvsYosPr0F3zCpmabh4t0rhcagy0F2VtkM+UXf9lT
	 a2X71/pzIKd8kJa+drklF6qF3vzJeK9xdOq4OSCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgDTRzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:55:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32850 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgDTRzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:55:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id m14so9623109oic.0;
        Mon, 20 Apr 2020 10:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pnrv9lM8OUTY4sC+Y+b2B4Yg/ImImSGXZBXHhlUhbQo=;
        b=m1V/fVQ22yA3PwSvWQYiaYI1e3eDYRH4QoyVjjdcpupqHGiboCXYNDNB0Mh0CKg97j
         bQKibL8wfuWwqnGEUJZ7xz/nrqlrgCJ+Dj9GBoMPwZoH9fZzworZ3KEgwWgdnURUCI/K
         tyYDZm/SWlXCfMgPo5U4RevNKKLj/NvkD8+/7ImzFzLnH0dte2Xe4nYMuOJ2wx4hUAPv
         UV75pcI2ij/Tx37kpwTukZWqBQCcRLALl3aNVFKcnymGZOUSsdIRIS21tyKBpG4w4dYq
         KQZq6E7tygzw1RmHKEb4RNboxDoDPpDmaMUVtyf1Qn6CjnWQZPVVZ3wTRVbgMV9c1Sdf
         9fSw==
X-Gm-Message-State: AGi0PuYu/DoYuDP0YSMnLd4hGV1CsqM+23h8r8hH6lRjfqT5yP/cIcFY
        ejKqWx0csDYcQcaPJYeOZw==
X-Google-Smtp-Source: APiQypKHszk2EWEj6YDqOxTUfHxKYjV5QQAmfU8m5CMhLH5+8GXPeri83oufl4B0ZfG2WOLRfc1+Kw==
X-Received: by 2002:aca:4b10:: with SMTP id y16mr435420oia.23.1587405317335;
        Mon, 20 Apr 2020 10:55:17 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k19sm25202oof.33.2020.04.20.10.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:55:16 -0700 (PDT)
Received: (nullmailer pid 29244 invoked by uid 1000);
        Mon, 20 Apr 2020 17:55:15 -0000
Date:   Mon, 20 Apr 2020 12:55:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: meson-ee-pwrc: add support
 for Meson8/8b/8m2
Message-ID: <20200420175515.GA28534@bogus>
References: <20200417190825.1363345-1-martin.blumenstingl@googlemail.com>
 <20200417190825.1363345-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417190825.1363345-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 21:08:22 +0200, Martin Blumenstingl wrote:
> The power domains on the 32-bit Meson8/Meson8b/Meson8m2 SoCs are very
> similar to what G12A still uses. The (known) differences are:
> - Meson8 doesn't use any reset lines at all
> - Meson8b and Meson8m2 use the same reset lines, which are different
>   from what the 64-bit SoCs use
> - there is no "vapb" clock on the older SoCs
> - amlogic,ao-sysctrl cannot point to the whole AO sysctrl region but
>   only the power management related registers
> 
> Add a new compatible string and adjust clock and reset line expectations
> for each SoC.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/power/amlogic,meson-ee-pwrc.yaml | 75 ++++++++++++++-----
>  include/dt-bindings/power/meson8-power.h      | 13 ++++
>  2 files changed, 71 insertions(+), 17 deletions(-)
>  create mode 100644 include/dt-bindings/power/meson8-power.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.example.dt.yaml: power-controller: 'reset-names' does not match any of the regexes: 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1272441

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
