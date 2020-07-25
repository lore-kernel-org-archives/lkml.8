Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A959EC433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F14F20714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595687037;
	bh=HgKb2gMwLhyoVgicuPtR2MT47iWJoelMNq4UC+XQ968=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mJFpW3Djgj9EjcYUm2S/ZlqPr6RmtC93+Y+gZYtUGTMqYVk4BKUOtgejg6h6kDLas
	 GjOxaJorWuttcR/v4r+4LTtn1n/BW8rE0m6gvPlDjd9PnS/vqKKbM1zbKgbGE0G1Gt
	 ezSl5hySDsQau2OfHjLMORq9tRzbP75TeDyzQVrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgGYOXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 10:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgGYOXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 10:23:53 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92CAC2074A;
        Sat, 25 Jul 2020 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595687032;
        bh=HgKb2gMwLhyoVgicuPtR2MT47iWJoelMNq4UC+XQ968=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtPTk/PkmwauIApJUo7+g3hHyOOyUUj6eTTExaOtlePSByjL7a3erBMEzio5DkdKG
         JEyUty6h9YKBmT4C/hm4mzKrirHw6eCac8/mZKLcKxFTGkC3cZANnDSd/gq2JjyYRA
         mHkl0FCQd6aq4baBYiK88Rt6FkKnnSKZLW5Ad7KE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jzL5b-00Er45-3s; Sat, 25 Jul 2020 15:23:51 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, marex@denx.de,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH v2] irqchip/gic-v4.1: Ensure accessing the correct RD when writing INVALLR
Date:   Sat, 25 Jul 2020 15:23:35 +0100
Message-Id: <159568680935.564881.3670480595242978406.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720092328.708-1-yuzenghui@huawei.com>
References: <20200720092328.708-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jason@lakedaemon.net, alexandre.torgue@st.com, tglx@linutronix.de, yuzenghui@huawei.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, marex@denx.de, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 17:23:28 +0800, Zenghui Yu wrote:
> The GICv4.1 spec tells us that it's CONSTRAINED UNPREDICTABLE to issue a
> register-based invalidation operation for a vPEID not mapped to that RD,
> or another RD within the same CommonLPIAff group.
> 
> To follow this rule, commit f3a059219bc7 ("irqchip/gic-v4.1: Ensure mutual
> exclusion between vPE affinity change and RD access") tried to address the
> race between the RD accesses and the vPE affinity change, but somehow
> forgot to take GICR_INVALLR into account. Let's take the vpe_lock before
> evaluating vpe->col_idx to fix it.

Applied to irq/irqchip-5.9, thanks!

[1/1] irqchip/gic-v4.1: Ensure accessing the correct RD when writing INVALLR
      commit: fdccf1d9d10395abfe082f50694f374997c6e101

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


