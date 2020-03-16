Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8484C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBDE20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584321009;
	bh=B+RgY4eWmKYIohuPnnLlZsHGg0C9YbXktLg86yPQHpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BjPaBj5rnaq3/erAXnduw98csEcy7KTlmnNzCpQjbAHQBRvMvJ1SFRonxEXAsJsxH
	 eUngIiPlIvk+GOhPJz8FCluwwDGgWBKYizuJ6KjcKUm/j2X3eBHnsN9g+nZaF+xjf7
	 L3CCpdFsCq/OZ9Qjx2VyAucAMfZr5841ihVSE3bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgCPBKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 21:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbgCPBKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:10:08 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01AF4205ED;
        Mon, 16 Mar 2020 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584321007;
        bh=B+RgY4eWmKYIohuPnnLlZsHGg0C9YbXktLg86yPQHpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1vmtg6Y0xDCQPlT5x6tSnUX7Mve4kKeNP0RVXXYRk1Bvcl+A7kI3XkzPbIQxvYRGR
         xS/xRNwZmMdrNvrYGtyeVSqGzWzzNgG2jyoQK4ix/O2SBdiUKICfZnhJbSND/ZLnC6
         Yv03F7zm4E0ZoUb67hGKZevkJM4J4LO1p9Jhnmdk=
Date:   Mon, 16 Mar 2020 09:10:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: imx8m: fix aips dts node
Message-ID: <20200316011001.GK17221@dragon>
References: <1583911076-31551-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583911076-31551-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 03:17:56PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per binding doc fsl,aips-bus.yaml, compatible and reg is
> required. And for reg, the AIPS configuration space should be
> used, not all the AIPS bus space.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
