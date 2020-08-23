Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C381C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CD22074D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598172170;
	bh=wPHHynZ8wXpznE548gb8T0VkD0SCWg7q/BqD14/vlwM=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=0JuAGUyTEJvQuBH7GyxnL8d4TzDQgJI67yfw7D28VPWZzT6vyDSJXmSrZWQyt3aJO
	 pTV+hjaYeNrinNuzchUqAftvf5nMEcJdVzdVJFuv6EKJF/vofnqw9nODvDLzene3z4
	 meVYpjNgBjuqSvN8a5Ts+QoL+0bf9aW21hv2stOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgHWIms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 04:42:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32898 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHWImq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 04:42:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id o4so1679821wrn.0;
        Sun, 23 Aug 2020 01:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pIEExo4zmDjRLEImoub+ih8awSkem1c2osObskHGAIM=;
        b=kLvkCu3zJa+EnX+Hjk5nqU6JoPIrJtPT4b7v/seHAkDSBvUku7KCB4ipm+YYhELfU7
         nyYH4iM9qRraOu1yLq5/POugdqohyZlBwY7QjhMrioT9Cjvqr2irGKLZiLr7+skoewcv
         HDFDhyuiivBq021IvCuDjk7ptGeBU6wiQFo0JQ7rBHorfCFfmfaX1DBDied2EaYqXVCF
         nmi4SJx4+F6AyhRyz051+3zDpp/79q1a4gla5u8iBncvZap3zDNHATZxxtiEEubItjq2
         TKb0F2ce56ROCXaV4/mOqCO/xdmMo09kXWslpHIWBBBuzkADSN2j/tsIEVIlJkudlr6k
         sGpw==
X-Gm-Message-State: AOAM531xRXRXrnsMfK5V3pJ+w7pTz7zGb8o4rJoPRlEAQF2kvfLLSXAS
        63POsXBn50vdTjA7bjJ0XpI=
X-Google-Smtp-Source: ABdhPJwnk5UwLhacVVFi/x2XKKHRfm91exlxOzeGN6dguMsFPqbNWS8dFyQzPkOGMrHQDXIFh32vWg==
X-Received: by 2002:adf:ba10:: with SMTP id o16mr777693wrg.100.1598172164634;
        Sun, 23 Aug 2020 01:42:44 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id 126sm17215985wme.42.2020.08.23.01.42.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Aug 2020 01:42:44 -0700 (PDT)
Date:   Sun, 23 Aug 2020 10:42:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        arm@kernel.org, soc@kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2 1/2] arm64: defconfig: Enable USB gadget with configfs
Message-ID: <20200823084241.GA2886@kozik-lap>
References: <20200817065654.4419-1-krzk@kernel.org>
 <20200823014600.GH30094@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200823014600.GH30094@dragon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 09:46:01AM +0800, Shawn Guo wrote:
> On Mon, Aug 17, 2020 at 08:56:53AM +0200, Krzysztof Kozlowski wrote:
> > USB OTG connections are pretty common for embedded and development
> > boards, for example to have networking or serial access to the device.
> > Build as a module the USB gadget configfs options so the defconfig can
> > be used in such development configurations.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Applied both, thanks.

Thanks, although few days ago I got confirmation from patchwork that
Olof already applied them to arm-soc.  I cannot find them in arm-soc
or next trees, though.

Dear Olof,
Did you pick these up already?

Best regards,
Krzysztof

