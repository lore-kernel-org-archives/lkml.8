Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30853C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE6B20873
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgEABSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 21:18:22 -0400
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:39138 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgEABSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 21:18:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4E244180A7341;
        Fri,  1 May 2020 01:18:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sky25_82f74d12d7925
X-Filterd-Recvd-Size: 2198
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 May 2020 01:18:19 +0000 (UTC)
Message-ID: <9844969151d1641a0bc68c1378b554d66cc0fcf9.camel@perches.com>
Subject: Re: [PATCH v1 2/2] mfd: Introduce QTI I2C PMIC controller
From:   Joe Perches <joe@perches.com>
To:     Guru Das Srinagesh <gurus@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 30 Apr 2020 18:18:18 -0700
In-Reply-To: <20200501011319.GA28441@codeaurora.org>
References: <cover.1588115326.git.gurus@codeaurora.org>
         <5644dea146f8b49a5b827c56392ff916bfb343e9.1588115326.git.gurus@codeaurora.org>
         <20200429075010.GX3559@dell> <20200501011319.GA28441@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-30 at 18:13 -0700, Guru Das Srinagesh wrote:
> On Wed, Apr 29, 2020 at 08:50:10AM +0100, Lee Jones wrote:
> > On Tue, 28 Apr 2020, Guru Das Srinagesh wrote:
> > > The Qualcomm Technologies, Inc. I2C PMIC Controller is used by
> > > multi-function PMIC devices which communicate over the I2C bus.  The
> > > controller enumerates all child nodes as platform devices, and
> > > instantiates a regmap interface for them to communicate over the I2C
> > > bus.
[]
> > > diff --git a/drivers/mfd/qcom-i2c-pmic.c b/drivers/mfd/qcom-i2c-pmic.c
[]
> > Please don't role your own debug helpers.
> > 
> > The ones the kernel provides are suitably proficient.
> 
> Sure. Would this be acceptable instead, with the custom string replaced by a
> macro that the kernel provides?
> 
> 	#define pr_fmt(fmt) "%s: %s: " fmt, KBUILD_MODNAME, __func__

trivia:

It's almost always smaller object code to use
the KBUILD_MODNAME as a fixed string instead of
as a printf argument.

	#define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__


