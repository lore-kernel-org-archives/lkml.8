Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A830FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972312068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgFCSAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:00:30 -0400
Received: from foss.arm.com ([217.140.110.172]:36336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgFCSAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:00:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0A7531B;
        Wed,  3 Jun 2020 11:00:29 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 096543F305;
        Wed,  3 Jun 2020 11:00:28 -0700 (PDT)
References: <20200603173150.GB1551@shell.armlinux.org.uk>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: v5.7: new core kernel option missing help text
In-reply-to: <20200603173150.GB1551@shell.armlinux.org.uk>
Date:   Wed, 03 Jun 2020 19:00:26 +0100
Message-ID: <jhjh7vshvwl.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/06/20 18:31, Russell King - ARM Linux admin wrote:
> Hi,
>
> A new kernel configuration option ("SCHED_THERMAL_PRESSURE") was
> recently added, but has no help text. This is most unhelpful when
> trying to configure the kernel, since one does not know what the
> effect of answering yes or no to this option would be.
>
> Please supply a proper help text when adding core kernel options
> so that people can make an informed decision when answering the
> prompt, rather than just guessing.
>

Right; does the below look good enough?

---
diff --git a/init/Kconfig b/init/Kconfig
index 74a5ac65644f..f40cf852d00a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -441,6 +441,10 @@ config HAVE_SCHED_AVG_IRQ
 config SCHED_THERMAL_PRESSURE
        bool "Enable periodic averaging of thermal pressure"
        depends on SMP
+	help
+	  This option allows the scheduler to be aware of CPU thermal throttling
+	  (i.e. thermal pressure), providing arch_scale_thermal_pressure() is
+	  implemented.

 config BSD_PROCESS_ACCT
        bool "BSD Process Accounting"
---
