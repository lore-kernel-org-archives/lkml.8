Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDC3C352A3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451C722464
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581025916;
	bh=L3OWlSAx20NWD+iXhm1i9zco+WDXp1YvgSyLhmxj1p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JQY2CTj1+Q/85C8I1dUMdp4jF+wXwhkbHS1R7upS0ING+ymx01qGton4EwGdhA+SL
	 qBzTwUanMv2ANqKqT8XUodmSNWfjHHHEEDgGmoMrPA27ao4zbstAgP0+f0j8n1bR8d
	 bMdvVHotH58wUjyq5kLoO0p1FbT4PoGPq2r0/pWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgBFVvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 16:51:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38428 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFVvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 16:51:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so105943plj.5;
        Thu, 06 Feb 2020 13:51:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iz85MmRiE9rW06Ut/PVFpOf2uBDxnpNB+UaYiY3zwJg=;
        b=EgC9mPRfdl/yDpKMazZpVostrccEy9XJ+Q7Q+ED3SuJPiAL/SZbe3FbNTCsmNZguVT
         +lLBt3bhFhZR8G/NY58atdKMmgps/Ng763Z6OTX6gtioJ615bt3vDmO2da4hgSut/WrW
         rEpOu+DoKN4r1HedE+ZpMPyfyRThh3JwaMAIbYMYYncSKQUlsEk292mq1bt81fatDxdG
         WoigO2rjZRfbmCGN8rS65dK4s9TmhmD5hNDh9jiCpLss/Y2iNg07XQK/8t7lBZ0ecoqG
         04zME05ImEVBGc8uoMubs/+aQi/4XLvgHjwTM3ohHWvZwalXkVRkj88iWxfsI2gkMN7f
         maLg==
X-Gm-Message-State: APjAAAUKjmVWYd3q2ei9xx0x/W3Uqz8t573ZSOBJsQnjdIgIwkkle+w/
        ZhrUBK+EtviRrIE09m3noA==
X-Google-Smtp-Source: APXvYqzsjQHh+Y8UWbIyQxUqon1VTSyaStKgHn7olYOehoc7PGKXMBs7r1WzMLqnWyRSlHrdgMcLFw==
X-Received: by 2002:a17:90a:f013:: with SMTP id bt19mr5579089pjb.47.1581025914205;
        Thu, 06 Feb 2020 13:51:54 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id j14sm342951pgs.57.2020.02.06.13.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 13:51:53 -0800 (PST)
Received: (nullmailer pid 10401 invoked by uid 1000);
        Thu, 06 Feb 2020 21:51:52 -0000
Date:   Thu, 6 Feb 2020 14:51:52 -0700
From:   Rob Herring <robh@kernel.org>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime@cerno.tech, jsarha@ti.com, tomi.valkeinen@ti.com,
        praneeth@ti.com, mparab@cadence.com, sjakhade@cadence.com,
        yamonkar@cadence.com
Subject: Re: [PATCH v4 01/13] dt-bindings: phy: Remove Cadence MHDP PHY dt
 binding
Message-ID: <20200206215152.GA10342@bogus>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
 <1580969461-16981-2-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580969461-16981-2-git-send-email-yamonkar@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2020 07:10:49 +0100, Yuti Amonkar wrote:
> Remove the Cadence MHDP PHY bindings. The binding is added
> in next commit in YAML format. It is renamed to adopt
> torrent nomenclature.
> This will not affect ABI as the driver has never been functional,
> and therefore do not exist in any active use case.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>  .../bindings/phy/phy-cadence-dp.txt           | 30 -------------------
>  1 file changed, 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> 

Acked-by: Rob Herring <robh@kernel.org>
