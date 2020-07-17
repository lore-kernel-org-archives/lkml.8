Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953F7C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B78D20684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgGQTsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:48:08 -0400
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:50058 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728480AbgGQTsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:48:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A5E6B180A8158;
        Fri, 17 Jul 2020 19:48:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fan56_0b1792026f0d
X-Filterd-Recvd-Size: 2283
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Jul 2020 19:48:05 +0000 (UTC)
Message-ID: <278ef62c230d69d51ca1bb4a0bbd978483f6f501.camel@perches.com>
Subject: Re: [PATCH 07/25] Documentation: gpio/driver.h: fix sphinx warnings
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, corbet@lwn.net,
        mchehab@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 17 Jul 2020 12:48:04 -0700
In-Reply-To: <684c5c2e-1b2d-bcb4-1320-a3a0dbed9b70@infradead.org>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
         <20200717185624.2009393-7-dwlsalmeida@gmail.com>
         <684c5c2e-1b2d-bcb4-1320-a3a0dbed9b70@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-17 at 12:37 -0700, Randy Dunlap wrote:
> On 7/17/20 11:56 AM, Daniel W. S. Almeida wrote:
> > From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> > 
> > Fix the following warnings:
> > 
> > warning: Function parameter or member 'gc' not described in
> > 'gpiochip_add_data'
> > 
> > warning: Excess function parameter 'chip' description in
> > 'gpiochip_add_data'
> > 
> > Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> 
> Mauro has already fixed this one.

Not quite fixed though.

Both patches did not update the text for chip->base where
it should have been changed to gc->base

---
 include/linux/gpio/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index db82451776fc..91ae7ad8730d 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -497,7 +497,7 @@ extern int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 /**
  * gpiochip_add_data() - register a gpio_chip
- * @gc: the chip to register, with chip->base initialized
+ * @gc: the chip to register, with gc->base initialized
  * @data: driver-private data associated with this chip
  *
  * Context: potentially before irqs will work



