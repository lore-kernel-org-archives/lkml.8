Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DE5C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A353207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598099036;
	bh=L4CMNRidGTUoMkmtjPhiJ/HLx4ECOZsldZc0oqf287M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XnZics2awgYTMLWSxWskGIHk6rOfOryzoxe3ULHRPbBo6V58CFXLJEPUdxaG1fV89
	 1LBwMzI6CMFLKICKC+pZ4B4nyL5Nyl+g2LH3l6ATN5oXRyxbeblCDuXg6yOdzc823N
	 5D9FhBJh1KKRakIPtaPl9LUOb7JR12T9tiiMg9eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHVMXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 08:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgHVMXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 08:23:50 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD70A20738;
        Sat, 22 Aug 2020 12:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598099029;
        bh=L4CMNRidGTUoMkmtjPhiJ/HLx4ECOZsldZc0oqf287M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0migo/1208Xx01PFLCgdx4IXUB31RhPpXB6jfzIqCZfH+L8H9Ssead6FfXACEfzl
         OoCIxheoIK2fK14Flge9Qy9/Ietb5MjMbho4Q0RnJnzdSaw3PwY2ElxSsveI389xpl
         sTIUyTM79oFZsWiFYflwbtxnRi+XuEZjC1CmtuDA=
Date:   Sat, 22 Aug 2020 20:23:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx7ulp: Correct gpio ranges
Message-ID: <20200822122344.GI27575@dragon>
References: <1596441684-30127-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596441684-30127-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 04:01:24PM +0800, Anson Huang wrote:
> Correct gpio ranges according to i.MX7ULP pinctrl driver:
> 
> gpio_ptc: ONLY pin 0~19 are available;
> gpio_ptd: ONLY pin 0~11 are available;
> gpio_pte: ONLY pin 0~15 are available;
> gpio_ptf: ONLY pin 0~19 are available;
> 
> Fixes: 20434dc92c05 ("ARM: dts: imx: add common imx7ulp dtsi support")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
