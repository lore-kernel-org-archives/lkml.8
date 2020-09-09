Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9076C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38DB20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgIIVHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgIIVHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:07:36 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04345C061573;
        Wed,  9 Sep 2020 14:07:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id 4BAF1140A64;
        Wed,  9 Sep 2020 23:07:27 +0200 (CEST)
Date:   Wed, 9 Sep 2020 23:07:26 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>,
        =?UTF-8?B?T25kxZllag==?= Jirman <megous@megous.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next + leds v2 1/7] dt-bindings: leds: document
 binding for HW controlled LEDs
Message-ID: <20200909230726.233b4081@nic.cz>
In-Reply-To: <20200909205923.GB3056507@bogus>
References: <20200909162552.11032-1-marek.behun@nic.cz>
        <20200909162552.11032-2-marek.behun@nic.cz>
        <20200909182730.GK3290129@lunn.ch>
        <20200909203310.15ca4e42@dellmb.labs.office.nic.cz>
        <20200909205923.GB3056507@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Sep 2020 14:59:23 -0600
Rob Herring <robh@kernel.org> wrote:

> > 
> > I don't know :) I copied this from other drivers, I once tried setting
> > up environment for doing checking of device trees with YAML schemas,
> > and it was a little painful :)  
> 
> pip3 install dtschema ?
> 
> Can you elaborate on the issue.
> 
> Rob
> 

I am using Gentoo and didn't want to bloat system with non-portage
packages, nor try to start a virtual environment. In the end I did it
in a chroot Ubuntu :)

The other thing is that the make dt_binding_check executed for
quite a long time, and I didn't find a way to just do the binding check
some of the schemas.

But I am not criticizing anything, I think that it is a good thing to
have this system.

Marek
