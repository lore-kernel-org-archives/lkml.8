Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F42C2BA1A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 03:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D272087E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 03:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgDIDOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 23:14:54 -0400
Received: from icp-osb-irony-out3.external.iinet.net.au ([203.59.1.153]:21224
        "EHLO icp-osb-irony-out3.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgDIDOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 23:14:54 -0400
X-SMTP-MATCH: 0
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A4AADQko5e/zXSMGcNWR0BAQEJARE?=
 =?us-ascii?q?FBQGBaQYBCwGDFIExhByPUgEBBoEKCIojj1CBewoBAQEBAQEBAQEjFAQBAYR?=
 =?us-ascii?q?Egi02Bw4CEAEBAQUBAQEBAQUDAYV3TIV/JxVBKAUIAiYCSyEIAQGDIgGCV69?=
 =?us-ascii?q?0dYEyGoksgUCBDioBgWSKaHmBB4E4DIg2gkWCXgSODoolmQUIgkCHeI88I4J?=
 =?us-ascii?q?PiD6ETQOMM61zCoF/MxoIKAiDJAlHmk6FU2KPQQEB?=
X-IPAS-Result: =?us-ascii?q?A2A4AADQko5e/zXSMGcNWR0BAQEJAREFBQGBaQYBCwGDF?=
 =?us-ascii?q?IExhByPUgEBBoEKCIojj1CBewoBAQEBAQEBAQEjFAQBAYREgi02Bw4CEAEBA?=
 =?us-ascii?q?QUBAQEBAQUDAYV3TIV/JxVBKAUIAiYCSyEIAQGDIgGCV690dYEyGoksgUCBD?=
 =?us-ascii?q?ioBgWSKaHmBB4E4DIg2gkWCXgSODoolmQUIgkCHeI88I4JPiD6ETQOMM61zC?=
 =?us-ascii?q?oF/MxoIKAiDJAlHmk6FU2KPQQEB?=
X-IronPort-AV: E=Sophos;i="5.72,361,1580745600"; 
   d="scan'208";a="253499226"
Received: from unknown (HELO [10.44.0.192]) ([103.48.210.53])
  by icp-osb-irony-out3.iinet.net.au with ESMTP; 09 Apr 2020 11:14:11 +0800
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.7
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <ea2d2b5c-a164-7318-3dcf-3c30098364f2@linux-m68k.org>
Date:   Thu, 9 Apr 2020 13:14:08 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Can you please pull the m68knommu git tree, for-next branch.

Only a single commit, to remove all use of the obsolete setup_irq()
calls within the m68knommu architecture code.

Regards
Greg



The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

   Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

for you to fetch changes up to ba000760eb0f182e6ef04faca70bb9737a9674b4:

   m68k: Replace setup_irq() by request_irq() (2020-03-23 12:01:19 +1000)

----------------------------------------------------------------
afzal mohammed (1):
       m68k: Replace setup_irq() by request_irq()

  arch/m68k/68000/timers.c      | 16 +++++++---------
  arch/m68k/coldfire/pit.c      | 16 +++++++---------
  arch/m68k/coldfire/sltimers.c | 29 +++++++++++++++--------------
  arch/m68k/coldfire/timers.c   | 31 +++++++++++++++----------------
  4 files changed, 44 insertions(+), 48 deletions(-)
