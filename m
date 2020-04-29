Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC85C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6362E2076A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588128924;
	bh=xquNFMLDfLZib8aq7iKWDAq0gBSPuoXgBAhfsarUS3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rVGnP6fhOpugRZz9Ydg2+g6/CgLeAT4N4mn2sWLekD4CS8D81y1BbvWvRCWwCP7+V
	 ROl5qEOoV6glsP4wB0QktEMfr6HshGJycS9Y+2lQy/tgaoy43fWq43qp3WMPTle77e
	 NIU8SYFsPgssOSLn8iDETtXKezQR+NWz+LNkEGYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgD2CzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 22:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgD2CzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:55:23 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C66BE20737;
        Wed, 29 Apr 2020 02:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588128923;
        bh=xquNFMLDfLZib8aq7iKWDAq0gBSPuoXgBAhfsarUS3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XkV0gZPA1BtL5ppuUHd1TwkAiKaTuXY2ImxjnhbZRNNH9A6JRvRh/twyxvGEslq1P
         riWBPxzljgh3nvpx8GsmcgiDD2vxZyS9qqsjdTmMNn5YhuSwtugpNyOhWwG8ib+sp6
         qWqkCDT9DHCZhqcuNs/oO580Z5b/wSVZLpjGLevQ=
Date:   Wed, 29 Apr 2020 10:55:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8qxp-mek: Sort labels alphabetically
Message-ID: <20200429025515.GM32592@dragon>
References: <1587101946-19495-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587101946-19495-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 01:39:05PM +0800, Anson Huang wrote:
> Sort the labels alphabetically for consistency.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
