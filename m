Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142BDC35246
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 00:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3DF2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 00:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aboehler.at header.i=@aboehler.at header.b="YIXMu3lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAZATq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 19:19:46 -0500
Received: from mail.aboehler.at ([176.9.113.11]:53256 "EHLO mail.aboehler.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgAZATp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 19:19:45 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Jan 2020 19:19:44 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.aboehler.at (Postfix) with ESMTP id E04B26180273;
        Sun, 26 Jan 2020 01:11:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aboehler.at
Received: from mail.aboehler.at ([127.0.0.1])
        by localhost (aboehler.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zMbK01Yd37bQ; Sun, 26 Jan 2020 01:11:37 +0100 (CET)
Received: from [192.168.177.144] (80-110-155-152.static.upcbusiness.at [80.110.155.152])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: andreas@aboehler.at)
        by mail.aboehler.at (Postfix) with ESMTPSA id 5CDCD618023C;
        Sun, 26 Jan 2020 01:11:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aboehler.at;
        s=default; t=1579997496;
        bh=kxkmvgHj3xXyIjRkaszhiEj4vWFy2WnXWgZRaK5SupY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YIXMu3lcZ4l0nF//X4l/b2NBj0AqclS5Bn870TCpNJkdigWwjLgu4Rcc242B6LJHA
         KQLEExfdNxyYiSuGoHewqXcFksEavcnj2eaoWt32EK3KmSHsgUM+s5U5x6c5r+sITp
         iiyamYO2M4+yLpCGheB+fPMtQeeXsKnVJVs68BL8=
Subject: Re: [PATCH v6 0/5] usb: xhci: Add support for Renesas USB controllers
To:     Vinod Koul <vkoul@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200113084005.849071-1-vkoul@kernel.org>
From:   =?UTF-8?Q?Andreas_B=c3=b6hler?= <dev@aboehler.at>
Message-ID: <9b63675e-36f4-292a-4bcc-579cb59ed855@aboehler.at>
Date:   Sun, 26 Jan 2020 01:11:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113084005.849071-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/01/2020 09:40, Vinod Koul wrote:
> This series add support for Renesas USB controllers uPD720201 and uPD720202.
> These require firmware to be loaded and in case devices have ROM those can
> also be programmed if empty. If ROM is programmed, it runs from ROM as well.
> 
> This includes two patches from Christian which supported these controllers
> w/o ROM and later my patches for ROM support and multiple firmware versions,
> debugfs hook for rom erase and export of xhci-pci functions.
> 
I tested this on an AVM FRITZ!Box 3490, backported to 4.19: Firmware
upload works fine.

However, I'm seeing read errors afterwards which, I suppose, are a
different story.

Here is the log:

[  498.115808] ifx_pcie_bios_map_irq port 0 dev 0000:01:00.0 slot 0 pin 1
[  498.121154] ifx_pcie_bios_map_irq dev 0000:01:00.0 irq 144 assigned
[  498.488541] renesas xhci 0000:01:00.0: xHCI Host Controller
[  498.492820] renesas xhci 0000:01:00.0: new USB bus registered,
assigned bus number 1
[  498.506123] renesas xhci 0000:01:00.0: hcc params 0x014051cf hci
version 0x100 quirks 0x0000000101000090
[  498.516869] hub 1-0:1.0: USB hub found
[  498.519631] hub 1-0:1.0: 2 ports detected
[  498.525641] renesas xhci 0000:01:00.0: xHCI Host Controller
[  498.530217] renesas xhci 0000:01:00.0: new USB bus registered,
assigned bus number 2
[  498.537846] renesas xhci 0000:01:00.0: Host supports USB 3.0 SuperSpeed
[  498.545095] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[  498.554921] hub 2-0:1.0: USB hub found
[  498.557588] hub 2-0:1.0: 2 ports detected
[  523.013361] usb 1-1: new full-speed USB device number 2 using renesas
xhci
[  523.182725] usb 1-1: no configurations
[  523.185085] usb 1-1: can't read configurations, error -22
[  523.317423] usb 1-1: new full-speed USB device number 3 using renesas
xhci
[  523.493710] usb 1-1: no configurations
[  523.496069] usb 1-1: can't read configurations, error -22
[  523.501951] usb usb1-port1: attempt power cycle

Regards and thanks for the patch,
Andreas
