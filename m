Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80173C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 00:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A31206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 00:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584319539;
	bh=Wu9LeSZgFzjN0nGIZAax5SqyNp3n8Rq3XY7vQH34stw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lS/LEUMvvNp8BZc7quI8cSIR6fNsQlH1vY6+HLbe+lXyZNC2uKQBEMRHHQ0dtGj8D
	 YkYCYDiHrg+2tXjQ7tOGyHVtTilxWQpWPzzm2ZHhYmg5B7V+QMA2Nue9H2tGbgcq7X
	 GVNl8ofA2h1nMAplC9scyY5sOPdVXf57h9F5oQlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgCPApi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 20:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbgCPApi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 20:45:38 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6220F205C9;
        Mon, 16 Mar 2020 00:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584319537;
        bh=Wu9LeSZgFzjN0nGIZAax5SqyNp3n8Rq3XY7vQH34stw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUrmiMok0WFUSi/wlfVItgHEJUtL3v6QhkrSq+NLzphELasni6hvzQhkMxwdRYBeJ
         /mW1OuY/7IzH65go+9UaQWnxYxIjlMy4fWyfUjOC0PjRql2heJ/4g2sx5kWYTplztp
         bFVFcTxanMsJsSl08dcevo7ml6usWdhsI/jM7mL0=
Date:   Mon, 16 Mar 2020 08:45:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mn: Add CPU thermal zone support
Message-ID: <20200316004528.GA17221@dragon>
References: <1583650721-7912-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583650721-7912-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 02:58:41PM +0800, Anson Huang wrote:
> i.MX8MN shares same thermal sensor with i.MX8MM, add thermal zone
> support for i.MX8MN.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
