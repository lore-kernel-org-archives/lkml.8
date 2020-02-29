Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEECC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE19524672
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgB2XNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:13:18 -0500
Received: from baldur.buserror.net ([165.227.176.147]:54310 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgB2XNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:13:18 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1j8BI4-0002LE-3Z; Sat, 29 Feb 2020 17:13:01 -0600
Message-ID: <a8134f2ece5059bbf078e8369a485857ff4d6590.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     =?UTF-8?Q?=E7=8E=8B=E6=96=87=E8=99=8E?= <wenhu.wang@vivo.com>
Cc:     wangwenhu <wenhu.pku@gmail.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Rai Harninder <harninder.rai@nxp.com>
Date:   Sat, 29 Feb 2020 17:12:58 -0600
In-Reply-To: <AFEA1QBVCHZojVUNOs1Cfqrs.3.1579588704764.Hmail.wenhu.wang@vivo.com>
References: <AFEA1QBVCHZojVUNOs1Cfqrs.3.1579588704764.Hmail.wenhu.wang@vivo.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: wenhu.wang@vivo.com, wenhu.pku@gmail.com, galak@kernel.crashing.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, trivial@kernel.org, harninder.rai@nxp.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: Re: [PATCH] powerpc/Kconfig: Make FSL_85XX_CACHE_SRAM
 configurable
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-21 at 14:38 +0800, 王文虎 wrote:
> 发件人：Scott Wood <oss@buserror.net>
> 发送日期：2020-01-21 13:49:59
> 收件人："王文虎" <wenhu.wang@vivo.com>
> 抄送人：wangwenhu <wenhu.pku@gmail.com>,Kumar Gala <galak@kernel.crashing.org>,B
> enjamin Herrenschmidt <benh@kernel.crashing.org>,Paul Mackerras <
> paulus@samba.org>,Michael Ellerman <mpe@ellerman.id.au>,
> linuxppc-dev@lists.ozlabs.org,linux-kernel@vger.kernel.org,
> trivial@kernel.org,Rai Harninder <harninder.rai@nxp.com>
> 主题：Re: [PATCH] powerpc/Kconfig: Make FSL_85XX_CACHE_SRAM configurable>On
> Tue, 2020-01-21 at 13:20 +0800, 王文虎 wrote:
> > > From: Scott Wood <oss@buserror.net>
> > > Date: 2020-01-21 11:25:25
> > > To:  wangwenhu <wenhu.pku@gmail.com>,Kumar Gala <
> > > galak@kernel.crashing.org>,
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org>,Paul Mackerras <
> > > paulus@samba.org>,Michael Ellerman <mpe@ellerman.id.au>,
> > > linuxppc-dev@lists.ozlabs.org,linux-kernel@vger.kernel.org
> > > Cc:  trivial@kernel.org,wenhu.wang@vivo.com,Rai Harninder <
> > > harninder.rai@nxp.com>
> > > Subject: Re: [PATCH] powerpc/Kconfig: Make FSL_85XX_CACHE_SRAM
> > > configurable>On Mon, 2020-01-20 at 06:43 -0800, wangwenhu wrote:
> > > > > From: wangwenhu <wenhu.wang@vivo.com>
> > > > > 
> > > > > When generating .config file with menuconfig on Freescale BOOKE
> > > > > SOC, FSL_85XX_CACHE_SRAM is not configurable for the lack of
> > > > > description in the Kconfig field, which makes it impossible
> > > > > to support L2Cache-Sram driver. Add a description to make it
> > > > > configurable.
> > > > > 
> > > > > Signed-off-by: wangwenhu <wenhu.wang@vivo.com>
> > > > 
> > > > The intent was that drivers using the SRAM API would select the
> > > > symbol.  What
> > > > is the use case for selecting it manually?
> > > > 
> > > 
> > > With a repository of multiple products(meaning different defconfigs) and
> > > multiple
> > > developers, the Kconfigs of the Kernel Source Tree change frequently. So
> > > the
> > > "make menuconfig"
> > > process is needed for defconfigs' re-generating or updating for the
> > > complexity of dependencies
> > > between different features defined in the Kconfigs.
> > 
> > That doesn't answer my question of how the SRAM code would be useful other
> > than to some other driver that uses the API (which would use
> > "select").  There
> > is no userspace API.  You could use the kernel command line to configure
> > the
> > SRAM but you need to get the address of it for it to be useful.
> > 
> 
> Like you've asked below, via /dev/mem or direct calling within the Kernel.
> And they are not submitted yes, under development.

If they are calling within the kernel, then whatever driver that is should
select FSL_85XX_CACHE_SRAM.  Directly accessing /dev/mem without any way for
the kernel to advertise where it is or which parts of SRAM are available for
use sounds like a bad idea.

-Scott


