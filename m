Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19A7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998EC2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AqplO3LA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgHZLz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:55:29 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:28788 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbgHZLy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:54:56 -0400
IronPort-SDR: TCTGQqSM6U2eUG0vN3E4uLKkZ/RHJrfnxwUULU+78Ly/T+D+lLyCSDAVXSPGGngia1g/k/R54C
 cUsehoxl7cNFVVxXUVtcUyYbF+Lr2xkzyHcrYM31i/WOTsFDhUOzQJVi/3c+fMCsGmNtliMIL7
 IeVXh8TTwa46wogakfz6n1QlymYM4SHiWhQI40OIDLnsXCFEp4F8FQjwO1jRAoAkj1sJgYFWFu
 T1sn1NHDY0NOSueqaVHYPPdG8ADapUQcvHTvBqotrRPdYrQ+zl7/jJWlHsUHYHYstStDH+en0l
 NZ4=
X-IronPort-AV: E=Sophos;i="5.76,355,1592863200"; 
   d="scan'208";a="13607573"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Aug 2020 13:54:52 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Aug 2020 13:54:52 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Aug 2020 13:54:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598442892; x=1629978892;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LEac3+lPiHdi3A0mBo7CX9cFFLpaHAmhqAriPCujtbw=;
  b=AqplO3LAVCmLHIaLDyUgxUjzgw4PYgiuJ8/dIMEa7KYMtZSCbRMIBvkA
   nHISGe7k60LvDuCXWdCk83NLnEO14MQG2wUr2YEhrONhBR6ZFQcin/62+
   F7gQIGKlS0UeYAuapXMTf86oJDQlUFcurl7WtxACbQk+zawsEtEkr69bk
   IXBtOEyjQF9qpdy8xr/QavWmI74btJxpspt6cQYBcNxpn5V3eUWcldtv7
   /sWd1ynSvhnTJrXz84N4EDgyQXuB7YyfGPG6LTnb1lCx5rlD2nac8JlvT
   hfURa9vvHkTZvUTcuzrR3CP5z6czYIA1groV5hVGpc+JcQyF7x8DYt0y7
   Q==;
IronPort-SDR: 4xhFUCdKlo3ZxFLsTtj5eQUiLZp8k2rahrb2IW+OUpjy7Z43NFAZ6tV1bIdFqZ+aI6qhJpR3MB
 Ptkw/2x/5JAJuMmqb1Qc4uay0qGoX+Cp6aRW/rbfaeu8R82k66FUfuzjTQeU7Uit45rlfLcK/L
 VL3E//RGe8M3QiP+1tzKkPH8x6dWv25U7Nljh8LVCRvTREZosaOZah8g275igim4uVJjfMZjvT
 BGltejxzyrsiedrSYXyj8EMY9v0Lg0I9H7e2npr0afm3B31giz+nkiWPrvUbqUSUCKPBB/CCIL
 Sgo=
X-IronPort-AV: E=Sophos;i="5.76,355,1592863200"; 
   d="scan'208";a="13607572"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Aug 2020 13:54:52 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 93C48280065;
        Wed, 26 Aug 2020 13:54:52 +0200 (CEST)
Message-ID: <aa0b7ad149a7bd4e681e4ebee12ffaaab2803832.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH 2/2] ARM: dts:
 imx6qdl: tqma6: minor fixes
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Aug 2020 13:54:50 +0200
In-Reply-To: <CAOMZO5ADeXEHWiG7Xja1W1GnahV08ZEYSkNsrOzautn2mROCNA@mail.gmail.com>
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
         <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
         <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
         <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
         <CAOMZO5DYrkEb_G+EYAGrc+qjSsbjRdeBUU3tJUfkU6tjgNm_7g@mail.gmail.com>
         <7a59492e46f34d213b83f7182c7db73954c5a9c7.camel@ew.tq-group.com>
         <CAOMZO5CP=wtJ5ZScyb0NrRMW0FR0FAGVKRFq9JpFcAoZppn_bA@mail.gmail.com>
         <53f5f17735fc2f0ca061a321969bbb131e55efff.camel@ew.tq-group.com>
         <CAOMZO5ADeXEHWiG7Xja1W1GnahV08ZEYSkNsrOzautn2mROCNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-26 at 07:59 -0300, Fabio Estevam wrote:
> Hi Matthias,
> 
> On Wed, Aug 26, 2020 at 7:32 AM Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> wrote:
> 
> > But the previous platform data that was removed in 8cdcd8aeee281
> > ("spi:
> > imx/fsl-lpspi: Convert to GPIO descriptors") set different values
> > for
> > different boards. So maybe some DTS should be using num-cs?
> 
> Could you provide an example of an imx dts that should use num-cs?

I'm not sure, does anything break when num_chipselect is set too high?

Before 8cdcd8aeee281, num_chipselect was set to 3 for spi0 and to 1 for
spi1 in arch/arm/mach-imx/mach-mx31lite.c. My understanding is that it
would make sense to add this as num-cs to
arch/arm/boot/dts/imx31-lite.dts.


