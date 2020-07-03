Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D67C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA772088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgGCOuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:50:05 -0400
Received: from foss.arm.com ([217.140.110.172]:41038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgGCOuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:50:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B11A1063;
        Fri,  3 Jul 2020 07:50:02 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3DE9E3F73C;
        Fri,  3 Jul 2020 07:50:01 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        lukasz.luba@arm.com, Arnd Bergmann <arnd@arndb.de>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] firmware: arm_scmi: Use HAVE_ARM_SMCCC_DISCOVERY instead of ARM_PSCI_FW
Date:   Fri,  3 Jul 2020 15:49:49 +0100
Message-Id: <159378750699.7612.3747943343943399740.b4-ty@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <159378754443.7674.9124886575137501969.b4-ty@arm.com>
References: <159378759580.7741.1360234334350850998.b4-ty@arm.com>
 <159378764840.7835.7289029317816454363.b4-ty@arm.com>
 <159378754443.7674.9124886575137501969.b4-ty@arm.com>
In-Reply-To: <20200625101937.51939-1-sudeep.holla@arm.com>
References: <20200625101937.51939-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 11:19:37 +0100, Sudeep Holla wrote:
> Commit e5bfb21d98b6 ("firmware: smccc: Add HAVE_ARM_SMCCC_DISCOVERY to
> identify SMCCC v1.1 and above") introduced new config option to identify
> the availability of SMCCC discoverability of version and features
> transparently hiding the indirect dependency on ARM_PSCI_FW.
> 
> Commit 5a897e3ab429 ("firmware: arm_scmi: fix psci dependency") just
> worked around the build dependency making SCMI SMC/HVC transport depend
> on ARM_PSCI_FW at the time. Since it really just relies on SMCCC directly
> and not on ARM_PSCI_FW, let us move to use CONFIG_HAVE_ARM_SMCCC_DISCOVERY
> instead of CONFIG_ARM_PSCI_FW.


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Use HAVE_ARM_SMCCC_DISCOVERY instead of ARM_PSCI_FW
      https://git.kernel.org/sudeep.holla/c/d764282377

--
Regards,
Sudeep

