Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4221C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B37F21582
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579279064;
	bh=QITaCsdXo+beqVbpmLEHNnO8yN5UaTe2pdDbiDeEz6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yTDt0uH6iamISOfoWbEi+Yheu2Hw67Ocd46rQWGaMlp+TV+23jiwCC2M7AuZWHJRy
	 JyWkV0EgfK3xStDrCfpd8+EimhVzjW4VPIj1qHVkjEgvuz3eNsnghSPrglG7qezVTR
	 I69GUNYBSG+FmxPAQpSnFNauNeHWN2rdOou04Igo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAQQhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:37:43 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36000 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgAQQhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:37:43 -0500
Received: by mail-ot1-f68.google.com with SMTP id m2so18207658otq.3;
        Fri, 17 Jan 2020 08:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=YOEsOn/2ceJnOpjp8uwYUwADDl3plvKBrE/DaARo/5Q=;
        b=FLqBm3vLnfyxLfT5w1EuzFMNXRGzGClQEs92whLt5qBWnZmIdmXP+lrkWMjFKMJm6g
         14vKOsMlXVFXU48ot0mMKFnNkXl6KvIGAm5hpNghJlEn0VMFwe5B5GT0rd0QtqEqBwLq
         8jajuGptfF3rd4NEOc0MC8mwa4wKrU+eNMQOEgjWskRZ45vMkDnXbSE0HwdbAbNBjpgY
         /lXVj2tfxz8YdUf+E1LX/uS2uRb3Bt4BuWWwpUOld+MGMjQ+MmKndnieqOy9Xm20EMDR
         9KJNF3y4vliY25QXx2rWNkCYgiLRqhzhN/ouTkoRByyNlqg3sTnAgDjczn1L4UKZje5q
         I78w==
X-Gm-Message-State: APjAAAVM9n7hwTF6v77Lwep9dg+wafhPfrdY4H2blzTbC08b3nzp4hT/
        oqG9Oi9PfqCz62eBQyQ5KQ==
X-Google-Smtp-Source: APXvYqxEp02bOdsOrY4x2V8OzMEjYATtM+Wclbr3Jw3HUtzLC89EUmNfZSLi42oRdwh4RdqgmiCWyg==
X-Received: by 2002:a05:6830:612:: with SMTP id w18mr6793151oti.264.1579279062684;
        Fri, 17 Jan 2020 08:37:42 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 15sm4068557otv.20.2020.01.17.08.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:37:41 -0800 (PST)
Received: (nullmailer pid 3439 invoked by uid 1000);
        Fri, 17 Jan 2020 16:37:40 -0000
Date:   Fri, 17 Jan 2020 10:37:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "maz@kernel.org" <maz@kernel.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Andy Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH V6 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt  multiplexer
Message-ID: <20200117163740.GA3378@bogus>
References: <20200117060653.27485-1-qiangqing.zhang@nxp.com>
 <20200117060653.27485-2-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117060653.27485-2-qiangqing.zhang@nxp.com>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 06:10:05 +0000, Joakim Zhang wrote:
> 
> This patch adds the DT bindings for the NXP INTMUX interrupt multiplexer
> for i.MX8 family SoCs.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  .../interrupt-controller/fsl,intmux.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
