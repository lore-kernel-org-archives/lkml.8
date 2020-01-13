Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ABFC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F8F207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578953124;
	bh=5Lk0I84bdIIGN9uM7n135AuqzI73cu9k6WUFDpAYPWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LMXoj+1JVtF/2VI3HZjKU9Rr1f0kHqQ565b5Y0mUdO9Og+v9NQbv+1UBdNn+LlJgl
	 eY7hZMY8PfLuCnouIvlCHXVvCCEKsGoJZJIKD20eDqUP4Vr8VSMjB/pOXcnI0+cNmy
	 Nw1y0BLIUfI2G0xJRpfIhiVSSOFOuS1sAvw+KlEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgAMWFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:05:23 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40790 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgAMWFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:05:22 -0500
Received: by mail-ot1-f66.google.com with SMTP id w21so10514173otj.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 14:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TPVDmHPgyswCSzHUpaO4xXgku0uEWmnDxxOITskBC8M=;
        b=f+cFSPWDKNQNelHf4PXwX445UiG7Ic2L6Te1NceoMoHXDBC8MrMF+Z+iooEo9CSXgv
         SI3jqosp69ZDEm1tq2Da428jObRqARxL3uxcf35NPevnGrFbgPU4YZjE8s/nlU8p0S/N
         gJDuTWygCvO0QVnIYNYf76sVrdll2cpIUkylwzqmVUidQKASKpB4r2UpVcxrKOCzOG6Y
         lfgFUDNdXJZ8XrM1Rah1b1qs1gbv30F1nxsJ12TJPY+wYiBQY+hIB8dQkIFOXddQck05
         qyLfigX3R/Z/4Ce3ADLvR2+6pLBJqFo1rS//tXfqYT1EBbEXFVlCo2fgNqrouvyatRNs
         y4fw==
X-Gm-Message-State: APjAAAXyWsyeUTROTybqEkDrmkqpTO0tiSWQDr3oS8OtRz1U+4z8EdyA
        3WKKWEi/38RLWVswmAyU3eVGS78=
X-Google-Smtp-Source: APXvYqxXhqdg2HpnLFT6VyY9JQz1A9LPUYQQiJoINdU+AciYPJIOxUGAPoCAQpRr7M5QWuwT/6Fsew==
X-Received: by 2002:a05:6830:1d7b:: with SMTP id l27mr13469943oti.251.1578953121595;
        Mon, 13 Jan 2020 14:05:21 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n16sm4589145otk.25.2020.01.13.14.05.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 14:05:20 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 16:03:18 -0600
Date:   Mon, 13 Jan 2020 16:03:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     skomatineni@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, broonie@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/21] dt-bindings: clock: tegra: Add DT id for OSC
 clock
Message-ID: <20200113220318.GA1891@bogus>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <1578457515-3477-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578457515-3477-4-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 20:24:57 -0800, Sowjanya Komatineni wrote:
> OSC is one of the parent for Tegra clocks clk_out_1, clk_out_2, and
> clk_out_3.
> 
> This patch adds DT id for OSC clock to allow parent configuration
> through device tree.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  include/dt-bindings/clock/tegra114-car.h        | 2 +-
>  include/dt-bindings/clock/tegra124-car-common.h | 2 +-
>  include/dt-bindings/clock/tegra210-car.h        | 2 +-
>  include/dt-bindings/clock/tegra30-car.h         | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
