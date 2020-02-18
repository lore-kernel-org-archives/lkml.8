Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32D9C34048
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6342208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBRREk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:04:40 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:35877 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgBRREk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:04:40 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 2C33D3C057C;
        Tue, 18 Feb 2020 18:04:37 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OHopyV6qEM96; Tue, 18 Feb 2020 18:04:31 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 5F1653C00C5;
        Tue, 18 Feb 2020 18:04:31 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 18 Feb
 2020 18:04:30 +0100
Date:   Tue, 18 Feb 2020 18:04:27 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Alexander Graf <graf@amazon.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Reid <preid@electromag.com.au>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v5 0/5] gpio: Add GPIO Aggregator
Message-ID: <20200218170427.GA7423@lxhi-065.adit-jv.com>
References: <20200218151812.7816-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200218151812.7816-1-geert+renesas@glider.be>
X-Originating-IP: [10.72.93.66]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Feb 18, 2020 at 04:18:07PM +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> GPIO controllers are exported to userspace using /dev/gpiochip*
> character devices.  Access control to these devices is provided by
> standard UNIX file system permissions, on an all-or-nothing basis:
> either a GPIO controller is accessible for a user, or it is not.
> Currently no mechanism exists to control access to individual GPIOs.
> 
> Hence this adds a GPIO driver to aggregate existing GPIOs, and expose
> them as a new gpiochip.  This is useful for implementing access control,
> and assigning a set of GPIOs to a specific user.  Furthermore, this
> simplifies and hardens exporting GPIOs to a virtual machine, as the VM
> can just grab the full GPIO controller, and no longer needs to care
> about which GPIOs to grab and which not, reducing the attack surface.
> 
> Recently, other use cases have been discovered[1]:
>   - Describing simple GPIO-operated devices in DT, and using the GPIO
>     Aggregator as a generic GPIO driver for userspace, which is useful
>     for industrial control.
> 
> Changes compared to v4[2]:
>   - Add Reviewed-by, Tested-by,
>   - Fix inconsistent indentation in documentation.

I confirm that the diff between v4 and v5 comprises whitespace only.
Thanks for your time to develop this useful functionality!

-- 
Best Regards
Eugeniu Rosca
