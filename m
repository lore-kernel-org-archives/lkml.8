Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D07C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583FE20714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582530247;
	bh=FyUoC2EifZIEI4JxqsRsk6ZT1rO+AmxwSvqCAZX42Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tGLeYhEywB4MXDKIOdEP9OtTO1ZtsrZT3+uK9w7UuDSnlRppmJJyhzfvbtWkdPNO+
	 QYAtMLw2z8/n0QznbmaSqh2Ni1NidWWPWsLSU03Xi+5aDsCqcuiwlsadb33YBjAJxK
	 wTkEi6MQrXroc8btSL2LBpo9TW2MZvSzsl2QxME0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgBXHoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgBXHoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:44:06 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA5720675;
        Mon, 24 Feb 2020 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582530245;
        bh=FyUoC2EifZIEI4JxqsRsk6ZT1rO+AmxwSvqCAZX42Lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsWSyFvB0vNVY83mGmNc/sDIEJVXk3RAeAA/wuazyh08bgYFT69P7dXU6BOte+NYM
         mq7YFlPRT9rvdYH4/qchKWSG7eDVKX6GVWofRSdkQu3i9t9/WKusmlKPKrTwh+r9LG
         5aqmStZV3AGISHuoMdlo8oYfSX9h6ysjR+D5CDtQ=
Date:   Mon, 24 Feb 2020 15:43:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        peng.fan@nxp.com, yuehaibing@huawei.com, ping.bai@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx: pll14xx: Return error if pll type is invalid
Message-ID: <20200224074356.GY27688@dragon>
References: <1582266716-19821-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582266716-19821-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 02:31:56PM +0800, Anson Huang wrote:
> When pll type is invalid, ONLY output error message is NOT enough,
> should return error immediately.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
