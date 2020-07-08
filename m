Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6300C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FFA20775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594204663;
	bh=0K2QzsfNelW++5Lvh8gz2k4nB6G2WJ2ICZu9P6XPq+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0PPrusoVMJmyDaO92RsgJ9uPcVwybv6nmmbHhMfXjWi96kQApA3lkht0qHbLZc4ph
	 wNSkDRzwvYlmiCEUm4ea+0ZihIP5B4WayzPY76h9lCHn7qRf3mazJwH5+IkB9KS/TR
	 rXNC9ZfJX+YrHUZ4m/z571rk+uSIfv98oy7HGXeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgGHKhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgGHKhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:37:42 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E016920739;
        Wed,  8 Jul 2020 10:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594204661;
        bh=0K2QzsfNelW++5Lvh8gz2k4nB6G2WJ2ICZu9P6XPq+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGBQlhpOaIWdqaXi74S5X8MbBWxxmc1jjHWIW4GRTZHRG34UWGUCidR5OQPuJnyeG
         1eiXmFYu6zqYzkNVCOGEWSfAqYQXip4VHAJsGjP/LekU7vrgY3mqyT4wznzUremoU+
         BeS+EM5wQBtgYj3eZT7U8ivApmApOs7rtCbxgaJ4=
Date:   Wed, 8 Jul 2020 16:07:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: defcondfig: Enable USB ACM and FTDI drivers
Message-ID: <20200708103736.GC34333@vkoul-mobl>
References: <20200703185354.1814337-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703185354.1814337-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-07-20, 11:53, Bjorn Andersson wrote:
> Enable USB serial drivers to provide UART access to various development
> boards from an ARM64 host.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
