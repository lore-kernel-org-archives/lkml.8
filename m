Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F96BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499422074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593537974;
	bh=UX4LNw0FS/ZhCgJ7Ajk3hHxhW/1ixDfkdXFZJJe+7K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S+Texy3mQnSAdEhlrkC+lDduYrrenYa7a6B2/A7jUJyyIqYdp1WEDLh8Ur01DunWU
	 C9PuZ4O+RAIFjjegZtbExXrs7ajPEoIITQhzV+8luf53MSh8Tg09ek1aGZ+PIyAN+y
	 EUp0FcY8Gx35RCEhwT+Ev+jJZ4zUYJPA7GYWhDWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbgF3R0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbgF3R0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:26:12 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32B23206C0;
        Tue, 30 Jun 2020 17:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593537972;
        bh=UX4LNw0FS/ZhCgJ7Ajk3hHxhW/1ixDfkdXFZJJe+7K8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xj7h0zP9RMlPnHrQlPpqjPoP2AuUHNpm6Sxon3Zx1UKQD9qSdJ78kE0TafXDLjra6
         BBY24Vke4NflqXKSnfX6IkPaQS+qHb/jb2dR1cWyt/DNESxWKPKtW1Of4p6U3mwTgj
         NCgPw2apFCYTE8kEs2sclKGO0mLcTyb4vMHJeTDE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jqK1K-007oaL-GP; Tue, 30 Jun 2020 18:26:10 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, Zenghui Yu <yuzenghui@huawei.com>
Cc:     wanghaibin.wang@huawei.com
Subject: Re: [PATCH] irqchip/gic-v3: Remove the unused register definition
Date:   Tue, 30 Jun 2020 18:26:04 +0100
Message-Id: <159353791986.882710.14067280307027336552.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630134126.880-1-yuzenghui@huawei.com>
References: <20200630134126.880-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, yuzenghui@huawei.com, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 21:41:26 +0800, Zenghui Yu wrote:
> As per the GICv3 specification, GIC{D,R}_SEIR are not assigned and the
> locations (0x0068) are actually Reserved. GICR_MOV{LPI,ALL}R are two IMP
> DEF registers and might be defined by some specific micro-architecture,
> Linux doesn't use them.
> 
> As they're not used anywhere in the kernel, just drop all of them.

Applied to irq/irqchip-5.9, thanks!

[1/1] irqchip/gic-v3: Remove unused register definition
      commit: c15c35a83c01fb25a995fbc4f58fe499f0493813

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


