Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2116C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734E4207ED
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Sc4kpxm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgESKVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:21:51 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:33550 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgESKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589883709; x=1621419709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CsKj8Kuj1IbnbFOhV7YM/UtfQRXVj8rj3zOQpiZ/WF4=;
  b=Sc4kpxm63I+jFnn44wpbA2bT/KANQPHi98ZqjcnCe2ibpwhmBkEpj33b
   DRStKbO7Ki+Ej8Nelh6LObi06fkvdytc8jHNQ4aI8OvgMir2DDdIji9An
   /5oJpNRpwFAr6K+r33MUtD56HmTOP/8SINMh28x25pc2EMBG/LkVbRnjd
   hJRq8vdRgKNHUlH6lrOKxYPnLibEPsDM7SLcxIRW0mAiyZ2chhT8OBmVc
   3Zc8SLucYPcO/rN4nGt0KK89YqPcNYqK5l6w3nWmQkyj52nKcaBsxJURr
   +W4LT1IbqNJh/AupNDrNs0Q3CzG3M75Vi31amzL4UFF5Djt/yNqlFP4d2
   w==;
IronPort-SDR: 9qhl5kGKNOKLh9hl3xxT6jcZB+uwNX1sM4EFvkXp33o6GksLQoD5emk71KwJOdrx0G0m/SvSIw
 e3AIIUOTP5YNtoLq8y6wP8Sxey/QxM/Bbb+Dgvmp5CDE8rw+sE7fczmwo8qNgUUgAa8WtIED8j
 YGYn27lafrgcGmss/Bw/zWwCWYup81AaUtUShKDEgjQvJinGXGxFghcDu2ojxR2ieWscHxNIv6
 TBX0q1oISeeAi3J9vumVlHrPqwYlY2k38q1OKxCQtBsAxUqQwecBjPOdsB8quqi6GnaIIYLPX/
 pLM=
X-IronPort-AV: E=Sophos;i="5.73,409,1583218800"; 
   d="scan'208";a="73862619"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2020 03:21:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 May 2020 03:21:48 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 19 May 2020 03:21:49 -0700
Date:   Tue, 19 May 2020 12:21:47 +0200
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>
List-Id: <soc.lore.kernel.org>
CC:     SoC Team <soc@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 01/10] spi: dw: Add support for polled operation via no
 IRQ specified in DT
Message-ID: <20200519102147.GC24801@soft-dev15.microsemi.net>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
 <20200513140031.25633-2-lars.povlsen@microchip.com>
 <20200513143753.GI4803@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200513143753.GI4803@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/20 15:37, Mark Brown wrote:
> Date: Wed, 13 May 2020 15:37:53 +0100
> From: Mark Brown <broonie@kernel.org>
> To: Lars Povlsen <lars.povlsen@microchip.com>
> Cc: SoC Team <soc@kernel.org>, Microchip Linux Driver Support
>  <UNGLinuxDriver@microchip.com>, linux-spi@vger.kernel.org,
>  devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
>  linux-arm-kernel@lists.infradead.org, Alexandre Belloni
>  <alexandre.belloni@bootlin.com>
> Subject: Re: [PATCH 01/10] spi: dw: Add support for polled operation via no
>  IRQ specified in DT
> User-Agent: Mutt/1.10.1 (2018-07-13)
> 
> On Wed, May 13, 2020 at 04:00:22PM +0200, Lars Povlsen wrote:
> 
> > +#define VALID_IRQ(i) (i >= 0)
> > +
> 
> This isn't something that should be defined by an individual driver, it
> should be in a generic header.

Thanks, I will work with Serge on getting this integrated right.

---Lars


