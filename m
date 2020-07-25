Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0524C433ED
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFF6206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595687044;
	bh=htCQhDyTlNg3GTpYQ9dDkGNrL4Hm0w7jMSwSmpYWjyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jy7IMhdRiYMJaZNf7TIMSS90d4MhX2Rfm1Ps3rA/djTo+NtT10WQVmgX1L+4TkJbf
	 1lYPJDY2V+733UqdLELkIXpxqfRm4lxbOt3Tg1XpOZNJIA0G7ogT7tCqMnksEWFpWJ
	 5KhfdwWTmhOUtYSDfVSZ7bwCs2zEx7TzGPnaZhkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgGYOXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 10:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgGYOXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 10:23:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E92CD2070C;
        Sat, 25 Jul 2020 14:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595687031;
        bh=htCQhDyTlNg3GTpYQ9dDkGNrL4Hm0w7jMSwSmpYWjyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qa3URvJ40Y6CThiV40vigy+cDQVXqXBxRsrjFX/LdKmq/jwb23TeUslihMKIhwB9Z
         olv1jO037m3vZWrfXjJhQbv/smXFc+PtnI5PW1b3cgaao96YWatAEmQjwhrCHb7zj6
         yQQ96EKFnlRXyqjTbH1Jy/hWNgFaxpJS5uY3reKw=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jzL5Z-00Er45-Gm; Sat, 25 Jul 2020 15:23:49 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-gpio@vger.kernel.org, marex@denx.de,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] irqchip: irq-bcm2836.h: drop a duplicated word
Date:   Sat, 25 Jul 2020 15:23:33 +0100
Message-Id: <159568680935.564881.4388804136193057202.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200719002853.20419-1-rdunlap@infradead.org>
References: <20200719002853.20419-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jason@lakedaemon.net, alexandre.torgue@st.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, rdunlap@infradead.org, linux-gpio@vger.kernel.org, marex@denx.de, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 17:28:53 -0700, Randy Dunlap wrote:
> Drop the repeated word "the" in a comment.

Applied to irq/irqchip-5.9, thanks!

[1/1] irqchip: irq-bcm2836.h: drop a duplicated word
      commit: b48489d82fcf61f229a892c7e1b559be15c95916

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


