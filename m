Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC54C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A4A21548
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592401710;
	bh=/WSk7qORPqa6zZW4wBawrFT3hKVpsXgyi8TneEQdbQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QsrYa6GF4BdwZ1VD4EQv7Wy4kJN4S0jdTvnFPDkHgGpMyeOhbT0IKYYmhue6ppKQu
	 kNzeez3CmcEj86VM8kquD0GrQvwtr/9sMuronS0g/82Cy5kOx7x7eg4RGKBp81Y4nA
	 gyJFiWWd1YPEmi8+7JEdXUuxgsw09eNuJRgtN6Xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFQNs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgFQNs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:48:28 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5291F208B8;
        Wed, 17 Jun 2020 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592401707;
        bh=/WSk7qORPqa6zZW4wBawrFT3hKVpsXgyi8TneEQdbQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0SPjckGIAsGEMO6pdj5MsgCDdy8IvavB2ARGaQCmr0b1/8YvUQdO1cEz4JmuOyuSd
         hUHHjkbDAu64x100rhNsWimz4uNWwEwzeQor+V6IFXlrtY1Nklp6na7SwhWmTRI5fL
         uW7B7HuxKj8ldkEKYJJzBNfAyfQ13ZeRBaKEf744=
Date:   Wed, 17 Jun 2020 21:48:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        ben.dooks@codethink.co.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] firmware: imx: make sure MU irq can wake up system
 from suspend mode
Message-ID: <20200617134813.GA30139@dragon>
References: <1587683231-18468-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587683231-18468-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 07:07:10AM +0800, Anson Huang wrote:
> IRQF_NO_SUSPEND flag is set for MU IRQ of IPC work, but with this
> flag set, IRQD_WAKEUP_ARMED flag will NOT be set during
> suspend_device_irq() phase, then when MU IRQ arrives, it will NOT
> wake up system from suspend.
> 
> To fix this issue, pm_system_wakeup() is called in general MU IRQ
> handler to make sure system can be waked up when MU IRQ arrives.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

I see you guys haven't got agreement on patch #2, so applied #1 only.

Shawn
