Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14CFC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3562177B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595215298;
	bh=5Ce6Fn23kftLFu/23R3QrOFgjowinyYkVpoCqjWNCsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=quHA5V5nR//tYIEKQeF3ZmeWlfH9MMwoAp+MVL6jDeosH6F8yW0fqppE7R6sr25QY
	 LahVGSfmpbHU6FvsYC13cyvB112I6Jo46kMinN9GJuhbFpyzE61t3iGEUIQ7BxZY5z
	 CApmPXEL7oUKhdNGbpGFHwfRruRmQtJDkbVYjjRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgGTDVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbgGTDVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:21:37 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6905720724;
        Mon, 20 Jul 2020 03:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595215296;
        bh=5Ce6Fn23kftLFu/23R3QrOFgjowinyYkVpoCqjWNCsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAzZRZ1sne0RFHtVAABjKRj8bu2k/+72KTxi3TxvBDSMJ3WnXYsS2dvPYQ1qXs0PM
         2mqSuM7U0Ed/M3u8xvRDqK9p1g5XKJctbepfV6cIve3RslKW6Cb0MxLfrrlSSBjCsq
         FzQucrVDnz4bCbAcOUztwarINEuaECrS9oAisPk4=
Date:   Mon, 20 Jul 2020 11:21:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     s.hauer@pengutronix.de, stefan@agner.ch, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com
Subject: Re: [PATCH] ARM: dts: vf610-zii-ssmb-spu3: Add node for switch
 watchdog
Message-ID: <20200720032127.GL11560@dragon>
References: <20200715220758.3106-1-cphealy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715220758.3106-1-cphealy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 03:07:58PM -0700, Chris Healy wrote:
> Add I2C child node for switch watchdog present on SPU3
> 
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Applied, thanks.
