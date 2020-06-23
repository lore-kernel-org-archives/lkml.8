Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482EFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DF120771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592895414;
	bh=jVMHdRXX61VJuRx1XAA38aPFL3YG+HVrrJ+cU76Iqpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sS9mhaFgPrRgX5j9KaPJkIwTlKeX9w3qCbzTEckiLDmHDM65E2U1IUEPYJJ/QaUvY
	 otIorYY98fLDRbDloQFsPLYHZQ2zOWOmSlCY22aboj6vDt7AT8mc70d7bnjMucDMc8
	 N6PTRjqCiN5R6Jg7mWxTIFroO+jkQybr93vlybJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgFWG4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730583AbgFWG4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:56:52 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 977EB20724;
        Tue, 23 Jun 2020 06:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592895411;
        bh=jVMHdRXX61VJuRx1XAA38aPFL3YG+HVrrJ+cU76Iqpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDqoxBvN72MbSZ4hB4pgsrAnswr2MUmhqWahkvv0Ujz3SxF7YZrpQLHFfMdqyEGOw
         y3kClJxulRZnLPGk/gvAX3TZRRGsN02/2rjTyle2Y9I4R6qH0pYSepAZN3ouAKEqQu
         aPFXT+vE3qCl4x/SDyfk8WkUsRckxbudQQ0Laj7w=
Date:   Tue, 23 Jun 2020 14:56:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx: vf610: add CAAM clock
Message-ID: <20200623065646.GR30139@dragon>
References: <20200601230607.31740-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601230607.31740-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 04:06:07PM -0700, Andrey Smirnov wrote:
> According to Vybrid Security RM, CCM_CCGR11[CG176] can be used to gate
> CAAM ipg clock.
> 
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-imx@nxp.com

Applied, thanks.
