Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCFBC33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E892082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580724323;
	bh=Dvb/o2l3gfXzlhoeCaVp4liCnwQuEagqrziI3jFG9ek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pnTDABYgeBATvRTPMLUUEK0nr2j9r9qUY7p2boUWyZbNSx8ZFyoIJAZ0Gh1BYUIek
	 U3lmbz70AbjR6Nv6hsuK4lMijqVtwp7g7l3zW1s0Zw5+dvjvM3lA4+XGrlWcMXe5ik
	 FwYFjVDrXHEAzyUvlzZBQE0HRBCzP3hif7jXuoI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgBCKFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbgBCKFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:05:22 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F38020661;
        Mon,  3 Feb 2020 10:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580724321;
        bh=Dvb/o2l3gfXzlhoeCaVp4liCnwQuEagqrziI3jFG9ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jWrIHDvXXFabPd138bxqY/qFVmzo04QQm8gKpHWnocHxH+4+mXaCPFuBGYELEqXCj
         6eFzO299/Qmi6nh8ajIcNZMrsoAK0XJWwA1ETsZaTCG5gR+AwyhEnDRwkViGDfuqLS
         qS/czUFcCwr+Y9F6Hi793G4MBf4INnhhI3+8Y9TM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1iyYbX-002jpG-71; Mon, 03 Feb 2020 10:05:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 03 Feb 2020 10:05:19 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH RESEND] irqchip/gic-v3-its: Use the its_invall_cmd
 descriptor when building INVALL
In-Reply-To: <20200203041821.1862-1-yuzenghui@huawei.com>
References: <20200203041821.1862-1-yuzenghui@huawei.com>
Message-ID: <11f7a8ab2f23db10100578506a49fa24@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-03 04:18, Zenghui Yu wrote:
> It looks like an obvious mistake to use its_mapc_cmd descriptor when
> building the INVALL command block. It so far worked by luck because
> both its_mapc_cmd.col and its_invall_cmd.col sit at the same offset of
> the ITS command descriptor, but we should not rely on it.
> 
> Fixes: cc2d3216f53c ("irqchip: GICv3: ITS command queue")
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
> 
> This patch has been originally posted at:
> https://lore.kernel.org/r/20191202071021.1251-1-yuzenghui@huawei.com
> but somehow has been missed for 5.5.  So repost it.

Oops, sorry about that. Now applied and pushed out.

         M.
-- 
Jazz is not dead. It just smells funny...
