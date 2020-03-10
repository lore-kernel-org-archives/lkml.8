Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD78C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B852D24679
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583820173;
	bh=1qU2dN2D9iT9iz9xcw7xh6AsOJbP/pTimqmMLVf+cTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xo2PqjNVglPM9fMIpHDvxeyK9LI3yYWcUsiXLLu6d7sQSMts/iCJheIkEoqIO5K/O
	 q2roFqPcQoI3gNdaA6NbEfNpw08cKSwAbb2O+cgerDsW08Txf/l9hnqV8jp/er77pF
	 bn+7aIJL0fVmfaPOwaiq8yB5MryLRdZk/6jNn2XY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCJGCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgCJGCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:02:51 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1FD2222D9;
        Tue, 10 Mar 2020 06:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583820171;
        bh=1qU2dN2D9iT9iz9xcw7xh6AsOJbP/pTimqmMLVf+cTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z599R8u7pluw6gYoy0ucpWJOHxIY6Jer3PbRJiENCYdOsxV+QVEzHRhL6JYBs+iO6
         tC0ETZUSjz6bYh67NKY0sHyTDxc0MTbRU5pppotgA7lDssq4uhuBReFsXAeMZON4go
         2F/sk9gJ1IPfIRrnbWwt0p0f2+cnVd7QX0hpPSBk=
Date:   Tue, 10 Mar 2020 14:02:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, sboyd@kernel.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        abel.vesa@nxp.com
Subject: Re: [PATCH v2 04/14] clk: imx: pfdv2: switch to use determine_rate
Message-ID: <20200310060235.GG15729@dragon>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-5-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582099197-20327-5-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 03:59:47PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per clk_ops, compared with round_rate, determine_rate could optionally
> support the parent clock that should be used to provide the clock rate.
> 
> In this patch, the parent clock is just parent->rate as round_rate.
> 
> The following patch will calculate the best parent clock.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
