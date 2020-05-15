Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCD4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C1A20756
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589561885;
	bh=Jr8RWO2hebBgByv9c7P4kyiawF8c8Qgaavm6YeRiLs0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kNiBA5RYrd0gsvqKHHsk8A4cfUmch5ojCxzAMtvlSq2O61VYoM6cKM0mxseG+0Yy8
	 AaouvbM8cFVhpCpvfN/+qjrjaAVm4HONFWTlJFjiil5WKl0ZMRPulzxeTjNEr3u5t1
	 XrcoqwHAopTNd/+Pn/lKYVChkro3ii7GcNCvh0k4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgEOQ6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEOQ6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:58:03 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041CF206C0;
        Fri, 15 May 2020 16:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589561883;
        bh=Jr8RWO2hebBgByv9c7P4kyiawF8c8Qgaavm6YeRiLs0=;
        h=From:To:Cc:Subject:Date:From;
        b=cKKw8kejPfZBRQDJkXrbTZUYlBpzB0WtP1ZPDXuFHRUkglSDPf0KJHjrRZyFCidrn
         oqITzG9xZod2XWzfkdyWj9MunZLEz+sPTbXtC5Vf9nxtUP0T6kqf26b6thkHg7kDQ+
         0fJgIXoNsNdK/9UuVofb8U8ziQh+4qATer/Ttu3c=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jZder-00Cdec-CP; Fri, 15 May 2020 17:58:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     John Garry <john.garry@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Subject: [PATCH v4 0/2] irqchip/gic-v3-its: Balance LPI affinity across CPUs
Date:   Fri, 15 May 2020 17:57:50 +0100
Message-Id: <20200515165752.121296-1-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, john.garry@huawei.com, chenxiang66@hisilicon.com, wangzhou1@hisilicon.com, ming.lei@redhat.com, jason@lakedaemon.net, tglx@linutronix.de, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mapping a LPI, the ITS driver picks the first possible
affinity, which is in most cases CPU0, assuming that if
that's not suitable, someone will come and set the affinity
to something more interesting.

It apparently isn't the case, and people complain of poor
performance when many interrupts are glued to the same CPU.
So let's place the interrupts by finding the "least loaded"
CPU (that is, the one that has the fewer LPIs mapped to it).
So called 'managed' interrupts are an interesting case where
the affinity is actually dictated by the kernel itself, and
we should honor this.

* From v3:
  - Always pre-decrement/post-increment affinity to avoid useless
    changes of affinity (John)
  - Don't use the node mask as a superset of the proposed affinity
    as the ACPI tables can't really describe this (John)
  - Rebased on v5.7-rc5

* From v2:
  - Split accounting from CPU selection
  - Track managed and unmanaged interrupts separately

Marc Zyngier (2):
  irqchip/gic-v3-its: Track LPI distribution on a per CPU basis
  irqchip/gic-v3-its: Balance initial LPI affinity across CPUs

 drivers/irqchip/irq-gic-v3-its.c | 170 ++++++++++++++++++++++++++-----
 1 file changed, 143 insertions(+), 27 deletions(-)

-- 
2.26.2

