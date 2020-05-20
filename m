Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A36AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABE120829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589937361;
	bh=TwPwgTYvTEYaQWEjnZhfryxbLYyPyfXaMLzE2omlkKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OiBDL47DgT8uKYjzOj4fR8oXksJa7HMKhRcziouE9QRuuBfm7ZxTGMo0/LJ5EJ+Dc
	 GCDgSyMKwdPF7L/C5wzv+Y3R26aIIgtCUVva1P0EqjkaINLsMO8mnNdeOt/m/kbOwW
	 mrUCqFAp6tk4i9hIcM4RKJDf1vVhsZhGRPUfrxw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgETBQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728432AbgETBP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:15:59 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74DC420708;
        Wed, 20 May 2020 01:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589937359;
        bh=TwPwgTYvTEYaQWEjnZhfryxbLYyPyfXaMLzE2omlkKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7Ut8+wNuQRERggPEgOf4c+nmjtd6XoYxyF/Brh3lBf86yb8TVVysUT2Uiq2ZNAV9
         430dMJbypg6RO/AEvQmoZczVLpts9azdxt+u1MWWrxdgeCemkKdoLaAU6+KhEhzBHz
         80AMgAgd2p1qGs/gRfNHaULWsNv9ahOchefScL4U=
Date:   Wed, 20 May 2020 09:15:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] firmware: imx: scu: Fix possible memory leak in
 imx_scu_probe()
Message-ID: <20200520011545.GI11739@dragon>
References: <20200506051410.27219-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506051410.27219-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 05:14:10AM +0000, Wei Yongjun wrote:
> 'chan_name' is malloced in imx_scu_probe() and should be freed
> before leaving from the error handling cases, otherwise it will
> cause memory leak.
> 
> Fixes: edbee095fafb ("firmware: imx: add SCU firmware driver support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied, thanks.
