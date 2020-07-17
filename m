Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03449C433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A0020768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594990156;
	bh=+V25eAigqJyAqO3qU/I8EgowzZWhl5WGU8izIKEiQ9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=it0d2X6uVvROGKyXmfBAww6P8Hu2Az+gpAj0KlAZFPspQ9GM3KqBtPBu/4Ba32nX9
	 utP+/RothK3TUiewjzkI/49sjZejhM+pslMP99BmZ9vOBW7i+EQekS+/EXr69yXOLc
	 BwRrvy+3coYMJFhM1UEEIp+6BgpGm1zCce7QkxOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgGQMtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgGQMs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:48:58 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23D9120829;
        Fri, 17 Jul 2020 12:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594990138;
        bh=+V25eAigqJyAqO3qU/I8EgowzZWhl5WGU8izIKEiQ9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbwEQxU9cdujhtKlnV1pohpNhS1NKLX8UzTqFIE28aoEIc3vlYCZlhpj712m3fQq1
         HuRQJcmCyOgC6eM2fekBmtsvbo4GLTkzlVZPx69M0dq2g4qfThKit1PXOATE3ke0wZ
         Cm6ypytpMHx7JtChNKi4+Oq8HNecbNQ7HY1ulOVM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jwPnM-00Ccsm-MR; Fri, 17 Jul 2020 13:48:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Cc:     linux-kernel@vger.kernel.org, marex@denx.de,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH -next] irqchip: mips-gic: Make some symbols static
Date:   Fri, 17 Jul 2020 13:48:47 +0100
Message-Id: <159499001592.546505.12368103656173164713.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714142245.16124-1-weiyongjun1@huawei.com>
References: <20200714142245.16124-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: alexandre.torgue@st.com, jason@lakedaemon.net, tglx@linutronix.de, weiyongjun1@huawei.com, hulkci@huawei.com, linux-kernel@vger.kernel.org, marex@denx.de, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 22:22:45 +0800, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/irqchip/irq-mips-gic.c:49:1: warning:
>  symbol '__pcpu_scope_pcpu_masks' was not declared. Should it be static?
> drivers/irqchip/irq-mips-gic.c:620:6: warning:
>  symbol 'gic_ipi_domain_free' was not declared. Should it be static?
> drivers/irqchip/irq-mips-gic.c:634:5: warning:
>  symbol 'gic_ipi_domain_match' was not declared. Should it be static?
> 
> [...]

Applied to irq/irqchip-5.9, thanks!

[1/1] irqchip/mips-gic: Make local symbols static
      commit: 63bf3444359c94d647c2afa79b5e732585469581

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


