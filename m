Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C988C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A4F2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="eewqj94g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgH0HbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:31:13 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:27818 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0HbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:31:12 -0400
IronPort-SDR: ro0lLG7VpTZaj9id+eUf1ZoWi72n5jJDjqUzViWInR8W5fpozq3AlAOpLyUiG8gtwd3EJilaqs
 QHbDouzJ0RkysOX/LDnw1q0QiOEVdz4RFPDHSzZXAxFoX1j/QiGJz6pJbCQI6BXB03BQgipi5p
 ZDD5lSs+HQa1A+KKW2AAUrgv5408RYwtEm9ZABkeXdN0Q6icxydlqY8QqH0gbZEVOC0O7aGKhT
 JnDZEHDSRBOP/94WTYUMLrCf466zSCiP+aPQiTNPGQKHEow1GbKwuuaaBwUFqIXM9cr15nuL+m
 eoA=
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="13618905"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Aug 2020 09:31:11 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 27 Aug 2020 09:31:11 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 27 Aug 2020 09:31:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598513471; x=1630049471;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XZs5KTGaK4y1WPEexfyCKGpQ8qNeT8l713J6zYTNBo4=;
  b=eewqj94gjAEwzUkkA6g7hFGsPE5KCznnqPrPAX2RlYAmUq0POms3MT3r
   yK1ySPFbK8tBhABQRcChhgUQCSPxF4zgCClsZymEF6tB/VYumNUvslHhL
   xQYvUmIoVow18nEo7CvP7ZUCYcc6v7UcdAkRrNx5JVBNEAAAOUSmYk2RD
   Iv6Zgm9MmSPQcmLLKKYuUAqCC2zkJNZuEV6/xGhOnDMRv+jV5p+Vrq4aV
   0iJacSBPKLm7h2V9vb56tAB+Zhldrxgc32dTO/Ro/XEqX+ZXwzaPezMmV
   CB9OMfoOATeNhMaxWItQOmy5HML1K3IoeUL4dbbfkhudaPnPVNcj02aLt
   A==;
IronPort-SDR: Pp0LPSTN2fFhGg+J1hSjhivY8rWFwI2yA19M8wb6nr8q8dzC5u+vedPy0tHcRJiOjk4bMJnrpc
 SnFAo8GkoCWknxbl7ymb8oun5y/hLg1VzE3Xu2T9jjuVeiunaqCITmkDZAJtRkCZhzQN1wdfsd
 zjRxomcXGGv9KgukalisLoVAN020uzyGcc+nHqN85tx4Th7jqeVcTei9ssWlrGA/nvMlCMOkGz
 1gJG6g/KXygTUggFYWrNYGBJg6gt1fsYaB85xhIbOrNoKaBTy2DaffGx7gqIBB759r4k6PYTRV
 b5Q=
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="13618904"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Aug 2020 09:31:11 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 58777280065;
        Thu, 27 Aug 2020 09:31:11 +0200 (CEST)
Message-ID: <9978aff9c90f5e4aa2049a5c65768b9695a910c5.camel@ew.tq-group.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6qdl: tqma6: minor fixes
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 27 Aug 2020 09:31:09 +0200
In-Reply-To: <CAOMZO5AfuPXfOmRSXAmyG-bdqGSzvTRm51NuTJ-B2PzKbLy9mw@mail.gmail.com>
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
         <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
         <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
         <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
         <CAOMZO5DYrkEb_G+EYAGrc+qjSsbjRdeBUU3tJUfkU6tjgNm_7g@mail.gmail.com>
         <7a59492e46f34d213b83f7182c7db73954c5a9c7.camel@ew.tq-group.com>
         <CAOMZO5CP=wtJ5ZScyb0NrRMW0FR0FAGVKRFq9JpFcAoZppn_bA@mail.gmail.com>
         <53f5f17735fc2f0ca061a321969bbb131e55efff.camel@ew.tq-group.com>
         <CAOMZO5ADeXEHWiG7Xja1W1GnahV08ZEYSkNsrOzautn2mROCNA@mail.gmail.com>
         <aa0b7ad149a7bd4e681e4ebee12ffaaab2803832.camel@ew.tq-group.com>
         <CAOMZO5B_Jm8SX9N9V5oq+LAa0Yc4CmrEp2n=2t3XUyBCtnGVTA@mail.gmail.com>
         <d433e8a47d721a65903db68c38eb1c337c81e395.camel@ew.tq-group.com>
         <CAOMZO5AfuPXfOmRSXAmyG-bdqGSzvTRm51NuTJ-B2PzKbLy9mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-26 at 10:49 -0300, Fabio Estevam wrote:
> On Wed, Aug 26, 2020 at 10:13 AM Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> wrote:
> 
> > Using GPIOs for chipselect would require different pinmuxing. Also,
> > why
> > use GPIOs, when the SPI controller has this built in?
> 
> In the initial chips with the ECSPI controller there was a bug with
> the native chipselect controller and we had to use GPIO.

Ah, I see.

Nevertheless, hardware that uses the native chipselects of newer chips
exists (for example our TQ-Systems starterkit mainboards, the DTS of
which we're currently preparing for mainline submission). Shouldn't
num-cs be set for boards (or SoM DTSI) where not all CS pins of the SoC
are usable?

In any case, my original question was about the intended logic for
num_chipselects for SPI drivers. My proposal was:

- If num-cs is set, use that
- If num-cs is unset, use the number of cs-gpios
- If num-cs is unset and no cs-gpios are defined, use a driver-provided 
default

How do other SPI controller drivers deal with this?

