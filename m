Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ADEC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E395924679
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583820304;
	bh=taS/6JJWqMqGCKcofsLbdSu7c2QmBYPy83RsKgdAwDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2tK/xv1bi0Rab8daTHeHjoeqq4xU00Uqn+ekgGfl4NrFRmlYbz0NvR8KbQBbON0al
	 V5DiTtfGPVheYRXFSJr0paDnsfBkPZSYNrDfShAJH9gzWxAp49fitMahk2toKviZI8
	 YHx6C1/h/znlkF7Ejt1nxLRGDtYeSBEt93AHZdM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCJGFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgCJGFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:05:02 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 710D3222D9;
        Tue, 10 Mar 2020 06:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583820302;
        bh=taS/6JJWqMqGCKcofsLbdSu7c2QmBYPy83RsKgdAwDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ruwbFV0VsxrLXQEM6izld2ugZf8pfO2Ec4RtPAS47tWMU3SDHkW2SnUturscBivu7
         UzLvClOp0zwNROpWhpEtULCU/MuEPruGZC3nnoOnqorWM9r+G2Q6lEu4q35+4xuLYc
         SYd9GwZmiqDLWy0/E6EaCULFn48uYFYG37M1DnxQ=
Date:   Tue, 10 Mar 2020 14:04:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, sboyd@kernel.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        abel.vesa@nxp.com
Subject: Re: [PATCH v2 06/14] clk: imx: pllv4: use prepare/unprepare
Message-ID: <20200310060455.GI15729@dragon>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-7-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582099197-20327-7-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 03:59:49PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> It is not good to use enable/disable for PLLv4 which needs time to
> lock, because enable/disable is expected to be able run in
> interrupt context. So use prepare/unprepare.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
