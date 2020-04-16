Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD9AC3815B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652A221BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgDPTg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 15:36:28 -0400
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:39730 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725894AbgDPTg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 15:36:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 18888100E7B47;
        Thu, 16 Apr 2020 19:36:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dress88_71e6f49a6bc61
X-Filterd-Recvd-Size: 2200
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu, 16 Apr 2020 19:36:22 +0000 (UTC)
Message-ID: <7713a931e4475294de85b74aca298dde8be4242d.camel@perches.com>
Subject: Re: [PATCH v2] i2c: busses: remove duplicate dev_err()
From:   Joe Perches <joe@perches.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Dejin Zheng <zhengdejin5@gmail.com>, linux-i2c@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Patrick Williams <alpawi@amazon.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Barry Song <baohua@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        George Cherian <gcherian@marvell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Date:   Thu, 16 Apr 2020 12:34:10 -0700
In-Reply-To: <6ca3cd57-de73-5327-5773-e08bf12c4a85@web.de>
References: <20200416152345.23077-1-zhengdejin5@gmail.com>
         <6ca3cd57-de73-5327-5773-e08bf12c4a85@web.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-16 at 20:22 +0200, Markus Elfring wrote:
> > it will print an error message by itself when platform_get_irq()
> > goes wrong. so don't need dev_err() in here again.
> 
> I suggest to improve the commit message considerably.

I suggest you ignore Markus' suggestion.

The commit message is OK.

The subject _could_ have included "platform_get_irq" something like

Subject: [PATCH v2] i2c: busses: Remove platform_get_irq()'s duplicated dev_err()

but I believe it's not important enough to redo.


