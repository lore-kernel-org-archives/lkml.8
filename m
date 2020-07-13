Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ABBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D672074F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594610842;
	bh=STGp2ZUz63RRCqrXyG2JLhnXkAw6U/ZZfYgZku3W/4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q+w4mYkSptvBwZo9MTBVB0dZ1tPrBCQhv82indTfJMsTiPVsry0AuUuJrC4+voCoY
	 DKYxODMa39JCE08KmzaOl4hIgdU+0vU1r+Wzt7ukbgoezqLx1xwb61ZX8fjUUMngsC
	 xhNpYiUSIHz01EXHIa5beYdiYSZ2PyoIMEuaAgZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgGMD1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMD1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:27:20 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 636D520725;
        Mon, 13 Jul 2020 03:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594610840;
        bh=STGp2ZUz63RRCqrXyG2JLhnXkAw6U/ZZfYgZku3W/4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F45/0Z3DlK6+GbH0tVFdt/4eAOjBWuSZITdtmPRqyIMefhsO0jdqOa9ruSU5gZbWB
         OmJ2+sUrWYtjbDk7bYPM4Y7E/mnBhfCyqe903s3wknvv69y1i61PNVW0EmYdtJnY4w
         F+Yv66JUrqKCU/cEGzUuqykovw0sHAAl5CWnBkpI=
Date:   Mon, 13 Jul 2020 11:27:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: imx: Remove imx_add_imx_dma() unused irq_err
 argument
Message-ID: <20200713032706.GE21277@dragon>
References: <20200701221040.3667868-1-helgaas@kernel.org>
 <20200701221040.3667868-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701221040.3667868-2-helgaas@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 05:10:39PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> No callers of imx_add_imx_dma() need an error IRQ, so they supply 0 as
> "irq_err", which means we register a resource of IRQ 0, which is invalid
> and causes a warning if used.
> 
> Remove the "irq_err" argument altogether so there's no chance of trying to
> use the invalid IRQ 0.
> 
> Fixes: a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: kernel@pengutronix.de
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org

Applied, thanks.
