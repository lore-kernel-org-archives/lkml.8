Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DE6C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68B52068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgEDRb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:31:58 -0400
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:58446 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729386AbgEDRb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:31:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 9EFCC180A55F0;
        Mon,  4 May 2020 17:31:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: twig62_4aee47edd0d24
X-Filterd-Recvd-Size: 1976
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 May 2020 17:31:54 +0000 (UTC)
Message-ID: <28790ee42242ecc0b0050943a27f569dd1aeec16.camel@perches.com>
Subject: Re: [PATCH 1/6] dt-bindings: phy: meson8b-usb2: Convert to
 json-schema
From:   Joe Perches <joe@perches.com>
To:     hex dump <hexdump0815@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 10:31:53 -0700
In-Reply-To: <CAKTihDVy6oSuQe4eP87hWO17tBu3=XZ-PM41YOqLVOtXJ8+YeQ@mail.gmail.com>
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
         <20200502114752.1048500-2-martin.blumenstingl@googlemail.com>
         <CAKTihDVy6oSuQe4eP87hWO17tBu3=XZ-PM41YOqLVOtXJ8+YeQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-04 at 12:55 +0200, hex dump wrote:
> On Sat, May 2, 2020 at 1:48 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> > Now that we have the DT validation in place, let's convert the device
> > tree bindings for the Amlogic Meson8, Meson8b, Meson8m2 and GXBB USB2
> > PHY over to a YAML schema.
> > 
> > While here, also add the fallback compatible string
> > "amlogic,meson-gxbb-usb2-phy" which is already used in
> > arch/arm/boot/dts/meson{,8,8b}.dtsi.
> > 
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Tested-by: hexdump <hexdump0815@googlemail.com>

Is the kernel now accepting "Tested-by" lines from robots?

If hexdump0815@googlemail.com is not a robot, can you please use
your full legal name instead?


