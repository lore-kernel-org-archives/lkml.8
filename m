Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDFEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BD82080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgCXKK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:10:28 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51253 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgCXKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:10:27 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 02ECA20026;
        Tue, 24 Mar 2020 10:10:24 +0000 (UTC)
Date:   Tue, 24 Mar 2020 11:10:24 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: rtc: Convert and update jz4740-rtc
 doc to YAML
Message-ID: <20200324101024.GL5504@piout.net>
References: <20200311182318.22154-1-paul@crapouillou.net>
 <20200311182318.22154-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311182318.22154-3-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2020 19:23:18+0100, Paul Cercueil wrote:
> Convert the jz4740-rtc doc to YAML, and update it to reflect the new
> changes in the driver:
> - More compatible strings are specified, with fallbacks if needed,
> - The vendor-specific properties are now properly prefixed with the
>   'ingenic,' prefix.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/rtc/ingenic,jz4740-rtc.txt       | 37 ---------
>  .../devicetree/bindings/rtc/ingenic,rtc.yaml  | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
