Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0B3C433F8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9147A2071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594826860;
	bh=pd1KRNwdr6dNRTt+fz8M+If2IOA/euVVDP3NJec0v2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oreG4pLlcNBapP7YPNBNkZji5uKKVoLl4QjWPlz1nu4QYsFwokCd5W35Ww8wrpf6u
	 C9OvmxyfbbCv7K+2P6BhiIHhvu34y8SJOo2GTHkA5O5/XR9Uu5lBJhlRVlUcrwo+ti
	 SyZTUPb3ZYnHRTf9MFwiXO4AmMWThv9P6k/SO7lA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGOP1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgGOP1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:27:36 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 494E8206D5;
        Wed, 15 Jul 2020 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594826856;
        bh=pd1KRNwdr6dNRTt+fz8M+If2IOA/euVVDP3NJec0v2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrLic7g1CDBl7et7jqZXJ7pVzRWFyU0Ngir56bA7NSqYDWZvNwLYalATxabHrQ9g/
         /zWFBdV6j56drzy+KQAxybFkkB7cwW/EwclG0QkT+lvwbqlr0O+Byp27fLkAKoHOcq
         W6yHfnruoDB+11StWz6aqiJ0N7gWJcoaRvN8+KR0=
Date:   Wed, 15 Jul 2020 20:57:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     dmaengine@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: remove always true comparisons
Message-ID: <20200715152732.GA52592@vkoul-mobl>
References: <20200715130122.39873-1-vkoul@kernel.org>
 <CAOMZO5AYWKw2RBjt+sEveejzwmD1o0768FiCfa9ObHupENsweQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5AYWKw2RBjt+sEveejzwmD1o0768FiCfa9ObHupENsweQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 15-07-20, 10:16, Fabio Estevam wrote:
> Hi Vinod,
> 
> On Wed, Jul 15, 2020 at 10:01 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > sdmac->event_id0 is of type unsigned int and hence can never be less
> > than zero. Driver compares this at couple of places with greater than or
> > equal to zero, these are always true so should be dropped
> >
> > drivers/dma/imx-sdma.c:1336:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> > drivers/dma/imx-sdma.c:1637:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> I have already fixed this problem and you have already applied my patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?h=next&id=2f57b8d57673af2c2caf8c2c7bef01be940a5c2c

My bad that I didnt run this on -next :-)

-- 
~Vinod
