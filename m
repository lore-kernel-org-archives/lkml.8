Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECF3C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED01206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594990147;
	bh=5POnxabUMyqHA1KxDC3Te6qQKnu8fFa8/yigj7vMA2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O/rhtkAPU6WRrHgFhUwmtWZDbRZ/wPFxB/inWbTrOKSJFC6BKpelsK5c7q2/ARvOg
	 IEqzgQSe7rm1b6OdZ1TOSaYh5Rbb8emD7wdhTHiUksfc2qwdlIz0X4ICOWTkkq6cE7
	 LmFB0i+qM4gRQaTS4F2gfjbJf+/GHcSPHkDI6sU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgGQMtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbgGQMs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:48:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7118B207FB;
        Fri, 17 Jul 2020 12:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594990139;
        bh=5POnxabUMyqHA1KxDC3Te6qQKnu8fFa8/yigj7vMA2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2uJXQ1KfkRiG4WbZZf4pM/IYginKG2nTtWy/qrZp7ICtuC25ONpKgTlR0nhflNE5t
         u4nTdxiavRPloJYgVH1tyKiL+mVOXDqf9h5PcQVnPU6JCzvQPhm+Q1mFa8Ey1vj8MU
         AugpzmI4sHeoRDoyLqhcsAhurpb+Cu5GEF3pqqBM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jwPnO-00Ccsm-0z; Fri, 17 Jul 2020 13:48:58 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-kernel@vger.kernel.org, marex@denx.de,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] genirq/irqdomain: Remove redundant NULL pointer check on fwnode
Date:   Fri, 17 Jul 2020 13:48:49 +0100
Message-Id: <159499001592.546505.17916680802608483979.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716083905.287-1-yuzenghui@huawei.com>
References: <20200716083905.287-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: alexandre.torgue@st.com, jason@lakedaemon.net, tglx@linutronix.de, yuzenghui@huawei.com, linux-kernel@vger.kernel.org, marex@denx.de, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 16:39:05 +0800, Zenghui Yu wrote:
> The is_fwnode_irqchip() helper will check if the fwnode_handle is empty.
> There is no need to perform a redundant check outside of it.

Applied to irq/irqchip-5.9, thanks!

[1/1] genirq/irqdomain: Remove redundant NULL pointer check on fwnode
      commit: 47903428b0e9db7a6251aa696fd1b2fc5de98545

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


