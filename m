Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C295C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33BA21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581021967;
	bh=Gpq79vs6g0KI1yq9+ifnOnhggH6Ni50qtKscuHXUsAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MfrSKZnkK3uSDo/mGwpBGVmsgJh9KjiXKMFiWE7UXsDkobo6nNdKgkmPAs2FFy7MT
	 eHUVk6s2LFMkOqc4xcSnDJ9aKQZaI8gazhj6iJpo/NZiZH0gDnT51L+z4HArwnYJtB
	 PGQAgrbFBBeEMeZv/cJkVZ/qxq4DiQPWzK6ko7p4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgBFUqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:46:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42186 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgBFUp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:45:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id w21so3340533pgl.9;
        Thu, 06 Feb 2020 12:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TDSSUXzp+jY2mafKrqhbmPqt3x8XToH1UVPF0nShXrw=;
        b=UuvbW5AxB50syt66YGG0LQZddxQqanSBCtgSiAHBmGkAI5bcaxo7KjeTTId976R7rQ
         +ZpTCBN8h8aHEkmd2eEHNXfn0sDitDTlUbETD7as6pBBhJOnxOnHticK+jLU+/hqHbJ+
         wOIGsnPNA98HUDhTd7FfaT/Qd8+SQBtEChgyHv82ZV1ooeHPFkLX+w4VRfq4JhcMjFdC
         JcKuZ2H2cdzBj4yB/Kj4o/Fd50CGD9mhscGQyuRmsi57hHmz0lXU0lJ9fUkVnqjGn60z
         sPsPi18eVR+IiPGkjPE4ACXn9+cfuoY/bZwbEeeL0otABiX7V9VCNVZj09hOwwyoOirj
         3liQ==
X-Gm-Message-State: APjAAAU9lqQhycR+fKj5WhcpZ4TAKTn/q9YxdG7PLqgiqWGctlUEKZbP
        Fo+LOLWd/Iuxwqgktm5gmQ==
X-Google-Smtp-Source: APXvYqyKjJUU76EY2SMDKH/N4kc6OvY/ZOAHowg2c6/pV5A8+7AkkIOuBxeq4e48NlDl4hjXDTlmrA==
X-Received: by 2002:a63:ed14:: with SMTP id d20mr5610058pgi.267.1581021956822;
        Thu, 06 Feb 2020 12:45:56 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id x12sm287256pfr.47.2020.02.06.12.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:45:56 -0800 (PST)
Received: (nullmailer pid 13377 invoked by uid 1000);
        Thu, 06 Feb 2020 19:24:37 -0000
Date:   Thu, 6 Feb 2020 19:24:37 +0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Maxime Ripard <mripard@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "james.tai" <james.tai@realtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 00/12] dt-bindings: arm: bcm: Convert boards to YAML
Message-ID: <20200206192437.GB30325@bogus>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:55:40PM -0800, Florian Fainelli wrote:
> Hi Rob, Maxime,
> 
> This patch series converts most files under D/dt-bindings/arm/bcm/ with
> the exception of bcm63138 and brcmstb to the YAML format. Those two may
> be split accordingly later on since document not just the root node.
> 
> Changes in v2:
> 
> - fixed typo in Vulcan binding
> - simplified how SoC compatible strings are specified
> - fixed filename in bcm2835 firmware binding
> - added 'secondary-boot-reg' constraint
> 
> 
> Florian Fainelli (12):
>   dt-bindings: arm: bcm: Convert Cygnus to YAML
>   dt-bindings: arm: bcm: Convert Hurricane 2 to YAML
>   dt-bindings: arm: bcm: Convert Northstar Plus to YAML
>   dt-bindings: arm: bcm: Convert Northstar 2 to YAML
>   dt-bindings: arm: bcm: Convert Stingray to YAML
>   dt-bindings: arm: bcm: Convert BCM21664 to YAML
>   dt-bindings: arm: bcm: Convert BCM23550 to YAML
>   dt-bindings: arm: bcm: Convert BCM4708 to YAML
>   dt-bindings: arm: bcm: Convert BCM11351 to YAML
>   dt-bindings: arm: bcm: Convert Vulcan to YAML
>   dt-bindings: arm: Document Broadcom SoCs 'secondary-boot-reg'

For all the above,

Reviewed-by: Rob Herring <robh@kernel.org>

>   dt-bindings: arm: bcm: Convert BCM2835 firmware binding to YAML
> 
