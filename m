Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C2EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD79E2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591814594;
	bh=vk+TyI0YXDcw/F4oBBcx2/OX0Q8DCn+GCXhtsjoEvUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AmhZP6MygAC0P29NVMTW2trX0XLJEc3f2s/IpVWW1F3xrormXR3wnufjD6e1/EWdF
	 EZH3QemK3UPROcMQOtjrn3mPBMQ9/ZJxmJGrX293lDylq+JmmT/WZlC/4MHqWAHgEa
	 sQtHjF/8Zma2HHYDRNhiMLyvt+uhqpnJri/X8d+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgFJSnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgFJSnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:43:12 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 610962070B;
        Wed, 10 Jun 2020 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591814592;
        bh=vk+TyI0YXDcw/F4oBBcx2/OX0Q8DCn+GCXhtsjoEvUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdP3NhHuaEqkiOhDW44QUO6Iw2GjL+5wD56VnCs+XjZUNDuVZEZ4gogpsz/dur0Mg
         XpQD+R+KfiehPnLIpulDDFblTJoF8qD3qWzt2gtI2dmwttpIWvOpmryGKbLtsLQot0
         B/R5TTjaAvruddHmxV4T1l46G2akDfah86nQBoUQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jj5gs-001rXS-U4; Wed, 10 Jun 2020 19:43:11 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc:     tglx@linutronix.de, jason@lakedaemon.net
Subject: Re: [PATCH] irqchip/gic-v4.1: Use readx_poll_timeout_atomic() to fix sleep in atomic
Date:   Wed, 10 Jun 2020 19:43:07 +0100
Message-Id: <159181454880.1512339.2705658130320062146.b4-ty@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605052345.1494-1-yuzenghui@huawei.com>
References: <20200605052345.1494-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020 13:23:45 +0800, Zenghui Yu wrote:
> readx_poll_timeout() can sleep if @sleep_us is specified by the caller,
> and is therefore unsafe to be used inside the atomic context, which is
> this case when we use it to poll the GICR_VPENDBASER.Dirty bit in
> irq_set_vcpu_affinity() callback.
> 
> Let's convert to its atomic version instead which helps to get the v4.1
> board back to life!
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/gic-v4.1: Use readx_poll_timeout_atomic() to fix sleep in atomic
      commit: a87d4e00eacbc95b44466e3470529f4de49b450a

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


