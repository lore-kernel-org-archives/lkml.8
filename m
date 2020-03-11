Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFED3C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23AA20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583914062;
	bh=culj2ZVb1YkzuYMmBPDBiyKzZ2bpF4vVWyXAAjHvgCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GgT75BiPdptLmjk4CTM5zJhv3TpLc1l5x2vOr/Zxi4bI9kEZodE/ZJ8sM614mLW7q
	 38Xevgf5uwCDEmCkLAbq07AiCpWOyROTySRJK710Wh+p0TvZ+8MnqKvhDHSJWLkonT
	 HM9B7a0b7LxTnExT3b1rQn2/w0+NQidrGaevrpwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgCKIHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgCKIHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:07:41 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D8B2051A;
        Wed, 11 Mar 2020 08:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583914061;
        bh=culj2ZVb1YkzuYMmBPDBiyKzZ2bpF4vVWyXAAjHvgCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bf/PxpJMqiJuhNg/kLpWE+IbjwS6+zDM9C9NMei01C9AgmGXeWTJ/eWXHhyprafup
         PleVhD3qz5Ghc2xqU3kWKJjWZ+V+3HcBJT3bPxhL8EoQFRZpPByihUYXAWwO4I5X2x
         HD7Xlnkp45vSi/LdLnQuaYyZGxpWlK+fJpKTo2RE=
Date:   Wed, 11 Mar 2020 16:07:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, daniel.baluta@nxp.com,
        jun.li@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn-evk: Add i2c3 support
Message-ID: <20200311080732.GX29269@dragon>
References: <1582984982-29151-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582984982-29151-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 10:03:01PM +0800, Anson Huang wrote:
> Enable i2c3 for i.MX8MN EVK board.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
