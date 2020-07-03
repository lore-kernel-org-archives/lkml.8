Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6E5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A001C208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGCOuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:50:00 -0400
Received: from foss.arm.com ([217.140.110.172]:41004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgGCOt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:49:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56D7D1042;
        Fri,  3 Jul 2020 07:49:59 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D9EF3F73C;
        Fri,  3 Jul 2020 07:49:58 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        lukasz.luba@arm.com, dan.carpenter@oracle.com
Subject: Re: [PATCH v11 0/9] SCMI Notifications Core Support
Date:   Fri,  3 Jul 2020 15:49:47 +0100
Message-Id: <159378764840.7835.7289029317816454363.b4-ty@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <159378759580.7741.1360234334350850998.b4-ty@arm.com>
References: <159378759580.7741.1360234334350850998.b4-ty@arm.com>
In-Reply-To: <20200701155348.52864-1-cristian.marussi@arm.com>
References: <20200701155348.52864-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 16:53:39 +0100, Cristian Marussi wrote:
> this series wants to introduce SCMI Notification Support, built on top of
> the standard Kernel notification chain subsystem.
> 
> At initialization time each SCMI Protocol takes care to register with the
> new SCMI notification core the set of its own events which it intends to
> support.
> 
> [...]


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/9] firmware: arm_scmi: Add notification protocol-registration
      https://git.kernel.org/sudeep.holla/c/1fc2dd1864
[2/9] firmware: arm_scmi: Add notification callbacks-registration
      https://git.kernel.org/sudeep.holla/c/e7c215f358
[3/9] firmware: arm_scmi: Add notification dispatch and delivery
      https://git.kernel.org/sudeep.holla/c/bd31b24969
[4/9] firmware: arm_scmi: Enable notification core
      https://git.kernel.org/sudeep.holla/c/6b8a69131d
[5/9] firmware: arm_scmi: Add power notifications support
      https://git.kernel.org/sudeep.holla/c/e27077bc04
[6/9] firmware: arm_scmi: Add perf notifications support
      https://git.kernel.org/sudeep.holla/c/fb5086dc47
[7/9] firmware: arm_scmi: Add sensor notifications support
      https://git.kernel.org/sudeep.holla/c/128e3e9311
[8/9] firmware: arm_scmi: Add reset notifications support
      https://git.kernel.org/sudeep.holla/c/469ca1822d
[9/9] (korg_sudeep/for-next/scmi) firmware: arm_scmi: Add base notifications support
      https://git.kernel.org/sudeep.holla/c/585dfab3fb

--
Regards,
Sudeep

