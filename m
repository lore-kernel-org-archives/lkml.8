Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F2BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA76206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbgGVMjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:39:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53308 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVMjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:39:44 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7AB5E1C0BD8; Wed, 22 Jul 2020 14:39:41 +0200 (CEST)
Date:   Wed, 22 Jul 2020 14:39:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, robh@kernel.org, marek.behun@nic.cz,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v31 03/12] leds: lp50xx: Add the LP50XX family of the RGB
 LED driver
Message-ID: <20200722123941.GA3448@ucw.cz>
References: <20200716182007.18389-1-dmurphy@ti.com>
 <20200716182007.18389-4-dmurphy@ti.com>
 <20200721210554.GC5966@amd>
 <c774fab9-124b-da2e-6f7c-614f34322942@ti.com>
 <20200722071055.GA8984@amd>
 <c4e2b2db-483f-27ef-9869-3b0c56d0d8ba@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4e2b2db-483f-27ef-9869-3b0c56d0d8ba@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > +			ret = fwnode_property_read_u32_array(child,
> > > > > +							     "reg",
> > > > > +							     led_banks,
> > > > > +							     ret);
> > > > Move this to subfunction to reduce the indentation? (Or, just refactor
> > > > it somehow).
> > > Actually I can just put it all on the same line since the 80 character
> > > requirement is relaxed.
> > No.
> > 
> > You have too long and too complex function, with too many blocks
> > inside each other. Please fix it.
> 
> I will refactor

Thank you.
									Pavel
