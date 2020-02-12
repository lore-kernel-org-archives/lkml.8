Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A0DC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAC320873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581494288;
	bh=l4Ydi+YAkhSWMA7Xt1/lLVzT50jm4UuMqPacNHvAN7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UYlophg9/ka07w9dNj2yKygvPmoTsF7QXVnXrKEWbyEpzA/VpZAr1+UZ2vSVd1/Em
	 /2ECVvX/ayeuy9rdR1rxTubRmPeJnvghzx34cYinawVxw7KuGPvl+EC0cb+9U466O6
	 cybLmhLGLdOuy9EFzQU9RAv6GoYbKOM9pm0Y8YL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgBLH6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:58:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbgBLH6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:58:07 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC058206DB;
        Wed, 12 Feb 2020 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581494287;
        bh=l4Ydi+YAkhSWMA7Xt1/lLVzT50jm4UuMqPacNHvAN7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8E+xqPwytUirJUKTx6MIE63P70ai95J0dVyl61gmmMC4dlF9IikVo7L5dJUVWEcS
         lpf8NFiyp1lvekfJMnV0waskC9rcCn2absnEXcPZjEOYc66rkXuYTl9ozmymFG1NsF
         Eq+EQcOL4vR483ITihCOCkA0kN4uyokPKuwfLocU=
Date:   Wed, 12 Feb 2020 15:57:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] dt-bindings: clock: Convert i.MX8MQ to json-schema
Message-ID: <20200212075758.GF11096@dragon>
References: <1578965167-31588-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578965167-31588-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 09:26:05AM +0800, Anson Huang wrote:
> Convert the i.MX8MQ clock binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
