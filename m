Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E8DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7C2207F9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgFDKAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:00:25 -0400
Received: from smtprelay0084.hostedemail.com ([216.40.44.84]:40988 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbgFDKAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:00:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1F58E837F24D;
        Thu,  4 Jun 2020 10:00:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bulb80_04152dd26d96
X-Filterd-Recvd-Size: 2074
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jun 2020 10:00:17 +0000 (UTC)
Message-ID: <32232229031e02edcc268b1074c9bac44012ee35.camel@perches.com>
Subject: Re: [PATCH] pinctrl: pxa: pxa2xx: Remove 'pxa2xx_pinctrl_exit()'
 which is unused and broken
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Date:   Thu, 04 Jun 2020 03:00:16 -0700
In-Reply-To: <alpine.DEB.2.21.2006041147360.2577@hadrien>
References: <20200531073716.593343-1-christophe.jaillet@wanadoo.fr>
                 <87h7vvb1s3.fsf@belgarion.home>
                 <a2e34c9a-676f-d83f-f395-7428af038c16@wanadoo.fr>
                 <20200601183102.GS30374@kadam>
                 <CACRpkdasbS-4_ZwC-Ucm8tkSUW5tAQdUrXjxHXQ3J0goVYfgHw@mail.gmail.com>
         <20200604083120.GF22511@kadam>
         <2aa49a543e6f48a6f428a37b63a06f9149870225.camel@perches.com>
         <alpine.DEB.2.21.2006041147360.2577@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-04 at 11:52 +0200, Julia Lawall wrote:
> Should Fixes also be used when the change will make it hard to port other
> fixes over it?

If it's a logic defect or regression that's being fixed,
shouldn't the logic defect or regression be fixed as
reasonably soon as possible?

The nature of the fix should ideally be optimal for
backporting, but I believe that should not stop any
consideration for the standalone fix itself.

What do you think?

