Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35E5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D513420720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgFVOVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:21:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:17383 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgFVOVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:21:06 -0400
IronPort-SDR: M1QOWFk8H9xWL+wGVKmKLnrpxkPVwMRLCtD3ySLsAdKlY87mwGiRuMwnI2Xn+DXm0sgW8geCIM
 rN55YXQGgZeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="124043591"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="124043591"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 07:21:05 -0700
IronPort-SDR: VPZVZdo91oqUn3223c7HO4fiswgP6WBbhibM2xzYlVAcGE0AmY8xI+XXEXdaWdoVzh2OY6QfGS
 yzRR86q/zA7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="300853515"
Received: from linux-01.iind.intel.com ([10.106.147.3])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2020 07:19:20 -0700
From:   Gyan Gupta <gyan.gupta@intel.com>
To:     gyan.gupta@intel.com, x86-ml <x86@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -v2] x86/msr: Filter MSR writes
Date:   Mon, 22 Jun 2020 19:52:28 +0530
Message-Id: <1592835748-4589-1-git-send-email-gyan.gupta@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@alien8.de>

> The whitelist is still TBD, I might be able to remove it competely and defer the
> whole whitelisting to the future. when people start reporting MSRs (see
> pr_err_ratelimited() call below).

I am also working on a similar functionality where we allow specific MSRs(whitelisted MSRs) to be allowed to read & write.
Additionally, writes are subjected to checks where only certain bits can be allowed to be modified. This is to increase security & safety of system.
For example, MCi_CTL can be used to enable/disable error reporting of hw unit. So in our use case once error reporting is enabled, it must 
not be disabled. Also we want to have restrictions on rdmsr for security purposes.

- Gyan

