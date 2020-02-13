Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81601C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E22217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="JcQgXXp2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jhimdcRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgBMBpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 20:45:52 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36961 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729302AbgBMBpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:45:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 78B77223F7;
        Wed, 12 Feb 2020 20:45:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Feb 2020 20:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=+
        OiiUTivHdmH9KQ7jtR4n13EhH4lgC0fTu891WGMH+o=; b=JcQgXXp2trrWcrsw2
        1Ct3k2CYTajGRHmKw/H2oePHTHQ5PJiZJz25Ar6nTWxvAsVHEjttgUccXxU1p67m
        eEQf87GnD8B/TTUCrBQ7OXCbPGvBsCjAL2b6GIiXY+gZX7XkWQKRnNdaXLvFhFqC
        +4CQB/t4fNnBPQDfFuNEBObYjeN90eRay8QEbZjnfXe8YyxNAflWlE+Rusx5noSj
        G2JKaNNgDP9nS2J9IK9x8KbeuoBWtVWRds8XWWOlDqF6xvgtLjGCPG+w1Qdqvc88
        SzZMyg+2j2DAyQTQTU7TvLjlNXSOJr0lWPFVKkTf/uCO7EIPoorUxTi2X7K+n3P/
        c9FMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=+OiiUTivHdmH9KQ7jtR4n13EhH4lgC0fTu891WGMH
        +o=; b=jhimdcRUwwSpSESDDyMF/vkDPXwPUD7BmNSno3FXQHycd5Ntx02Xs4JFG
        yHk1WtAWWfhkKeDg8i/o7/jP15FiVulIOptLC5f9dsbSzZ1vWuowhyh0sbYY1nMj
        hBxiPVH6kGG5vppCL89NMEGg/XBwG1zhIOPGlrHERWLyaqSxF5eni2/qZaI/JS/u
        n2WBqIxWGjklmOc9zDwpXxXNUtAltQZPixuJZOXOVBjpevdwzfHcYd2o6dXIbzpj
        vo6m+hYxR1E2DVhGLdsBf6LddyhZMV/d8f8pVWYPsH4XcHLBUU8d+WhGkFzZo/Qh
        gvZKr3Ov5shbpNId3DDoqPM9Puzgg==
X-ME-Sender: <xms:T6pEXl12cMgxPGJZosP426IUR2MUAmZaJcRtvDCD6UK-0IxIQ31FTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieejgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:T6pEXm9bW1IA0QeK4VrEzr6oqFR--cwv2sDafJ1Q5KhUArQoUv2IHw>
    <xmx:T6pEXm2IZx_gxYZs32xNZQgyt5U2Pts4Cr1LiUe8TNCjzRBYeyJLXQ>
    <xmx:T6pEXp1i-agx7GLAH6EZLXEAj0NkpZPlPsWaWI5IOSaNVE9EKvcVNA>
    <xmx:T6pEXk6Iy9fgU_ku8WPn9kZv5HS7irhRgXj5OlLTkyaAhRoqHdhJNg>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C7D2D3060A08;
        Wed, 12 Feb 2020 20:45:50 -0500 (EST)
Subject: Re: [PATCH 1/2] pinctrl: sunxi: Forward calls to irq_set_irq_wake
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20200117213340.47714-1-samuel@sholland.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <9103f638-b733-5f4d-1a64-ee35cbfd8236@sholland.org>
Date:   Wed, 12 Feb 2020 19:45:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117213340.47714-1-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All,

On 1/17/20 3:33 PM, Samuel Holland wrote:
> The pinctrl irqchip may be connected to an irqchip that implements the
> .irq_set_wake callback, such as the R_INTC on A31 and newer sunxi SoCs.
> In order for GPIOs to be able to trigger wakeup, the IRQ from the
> pinctrl to the upper irqchip must also be enabled for wakeup. Since the
> kernel's IRQ core already manages the "wake_depth" of each IRQ, no
> additional accounting is needed in the pinctrl driver.

Ping. Any comments on these two patches?

Thanks,
Samuel Holland
