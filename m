Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ECEC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C114214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578961016;
	bh=ty5zfQkiRhAx57Hwj6NCRKyc2kPTZbupHVXQsQn3t5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gDbKE9hPam/URe/BPDlAM1btDsFlxBkLlP526kj21l7eNeq6i8jeSYvPjOzyjshj0
	 GRle3AcTphI2WRG2/1iGYqsBQZ9RABFnQs8WX9Jb8FotLICNx4QrWlyExyqSR88M9J
	 xynpSR4e/ys7EBYhRcZbffbxkjvfZ6vgOFbR89co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgANAQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:16:54 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40822 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgANAQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:16:54 -0500
Received: by mail-oi1-f195.google.com with SMTP id c77so10140182oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 16:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nnCP/oi7Z0mxzEO5kxr1fVYeBOYXbt9IQu/uVhgHHc8=;
        b=boKf+K1RSDYTNdC/+J+p81agZYBat17UPaNmg3pqqgbjHielqW0j2TV/IdkfBlPDlj
         UIa4Ns3Ha/tXa/++u0StaHG8jSNZp2JX5U985ydeyeWWn7l97TWn37/8yL7Dty3f0LI2
         uFE1fMRNXTet234EomXbYdH9Dzo7ICSDe/OmgGCegEuiwmxYiWr1tjeIalzcesazgXKo
         WmcZYogrT43D1q8TRt2FNzYM/hCTzoTHShJj5tkPjd97aJmZtBPYQC2K2z+/b0mUHnLS
         iFxXFN6ZI8N1iX3qgdE4CvRW9AfHacN769Od0FOTEUWwk8Zwtk9dsu7wQ1Or87XXyDrW
         s59Q==
X-Gm-Message-State: APjAAAXCWURRdcSBYjddc3yqsn1w37VzCUn/ZvFJpZYflFzoQ+sqRaA/
        und6SEPaGuzEiFpF+6BY/H9Eun0b8g==
X-Google-Smtp-Source: APXvYqyeY9FolZqWIosTUsU4tBSFcMI/9eynOsBt8o/cvodMA+7km2UwTyJV7uEOmD/bASOVTQAiVQ==
X-Received: by 2002:aca:ec50:: with SMTP id k77mr15430737oih.114.1578961012173;
        Mon, 13 Jan 2020 16:16:52 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z21sm4723079oto.52.2020.01.13.16.16.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:16:51 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219cf
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:16:49 -0600
Date:   Mon, 13 Jan 2020 18:16:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 07/17] dt-bindings: atmel-matrix: add
 microchip,sam9x60-matrix
Message-ID: <20200114001649.GA11024@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-8-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-8-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:17:59 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-matrix to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-matrix.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
