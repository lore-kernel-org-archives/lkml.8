Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F5DC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6DD20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583914082;
	bh=xsLW9J8hrEXme4KW+LbiQ0nAzyzjT2qxAEo9+tCXXi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DqQUcDt1xlc3EP/ychVSeJR+AEmpMMm844VeqJs6+GZggaIfCKMOEeKbLgvGb10a5
	 gzX8eQulGkH5x+JaUuzLSPdtbw0pROcIpEMtRZFxmVnQ0coTbID1IcPf07/RlejZST
	 MuJ4DVQSpuuotF55Xdk7KyxiGaYrSSIZpJSLwId0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgCKIIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgCKIIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:08:00 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 197EA2051A;
        Wed, 11 Mar 2020 08:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583914080;
        bh=xsLW9J8hrEXme4KW+LbiQ0nAzyzjT2qxAEo9+tCXXi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lonDtZOuRelgRGfUlPwNMOm3PhDYwgWRcHg14SRV4TjvjvF51cP0Gk4PSk5HAl04D
         lIDhsFeTcyRMllt2A2UD5a1WVTKeRGDa0l02Kn3JVwH+oXNAaD8gzkZcFjsiMbXhF4
         udDQirbaXbaAQWThbuhjdmkMVXn+NmBAirHMgG9I=
Date:   Wed, 11 Mar 2020 16:07:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp-evk: Add i2c3 support
Message-ID: <20200311080754.GY29269@dragon>
References: <1582985786-2198-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582985786-2198-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 10:16:25PM +0800, Anson Huang wrote:
> Enable i2c3 for i.MX8MP EVK board.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
