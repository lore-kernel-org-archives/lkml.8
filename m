Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69742C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527D720882
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgELBJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 21:09:38 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57246 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgELBJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 21:09:38 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jYJQJ-00070l-IM; Tue, 12 May 2020 03:09:31 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include: dt-bindings: rockchip: mark RK_GPIO defines as deprecated
Date:   Tue, 12 May 2020 03:09:30 +0200
Message-ID: <2039286.bXBTDbpnOK@diego>
In-Reply-To: <20200511213605.GA14679@bogus>
References: <20200424151105.18736-1-jbx6244@gmail.com> <20200511213605.GA14679@bogus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 11. Mai 2020, 23:36:05 CEST schrieb Rob Herring:
> On Fri, Apr 24, 2020 at 05:11:05PM +0200, Johan Jonker wrote:
> > The defines RK_GPIO0, RK_GPIO1, RK_GPIO2, RK_GPIO3,
> > RK_GPIO4 and RK_GPIO6 are no longer used. Mark them as
> > "deprecated" to prevent that someone start using them again.
> 
> What changed exactly? The binding changed, or just using raw 0-6 instead 
> of the defines? 

This ... they are just dumb mappings of RK_GPIOx -> x so we switched
over to just using the raw numbers, as the constants do not provide any
additional information.


> If there's not anything using these in tree, just delete them.

Ok, good to know that we can just delete them if noone is using them
anymore.


> It is still used in the binding doc.

I think Johan will provide a v2 with that.


Heiko



