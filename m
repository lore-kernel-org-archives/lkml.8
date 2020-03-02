Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE09C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40942146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgCBQER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:04:17 -0500
Received: from 8bytes.org ([81.169.241.247]:49578 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbgCBQER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:04:17 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6CE8E5BC; Mon,  2 Mar 2020 17:04:16 +0100 (CET)
Date:   Mon, 2 Mar 2020 17:04:13 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@lca.pw>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RESEND] iommu: dmar: Fix RCU list debugging warnings
Message-ID: <20200302160412.GA7829@8bytes.org>
References: <20200223165538.29870-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223165538.29870-1-frextrite@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 10:25:39PM +0530, Amol Grover wrote:
> dmar_drhd_units is traversed using list_for_each_entry_rcu()
> outside of an RCU read side critical section but under the
> protection of dmar_global_lock. Hence add corresponding lockdep
> expression to silence the following false-positive warnings:
> 
> [    1.603975] =============================
> [    1.603976] WARNING: suspicious RCU usage
> [    1.603977] 5.5.4-stable #17 Not tainted
> [    1.603978] -----------------------------
> [    1.603980] drivers/iommu/intel-iommu.c:4769 RCU-list traversed in non-reader section!!
> 
> [    1.603869] =============================
> [    1.603870] WARNING: suspicious RCU usage
> [    1.603872] 5.5.4-stable #17 Not tainted
> [    1.603874] -----------------------------
> [    1.603875] drivers/iommu/dmar.c:293 RCU-list traversed in non-reader section!!
> 
> Tested-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
>  include/linux/dmar.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied, thanks.
