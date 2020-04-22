Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE00EC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830AC2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDVUmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:42:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:10492 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgDVUmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:42:06 -0400
IronPort-SDR: kfSrRkHOnSjh6H53DTzMRtYkFQj/8pwM3bMbUb6nGjszav6unI/kh12MgpvQZ7gttDtUEJCelX
 vVB4KE1Nnjog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 13:42:05 -0700
IronPort-SDR: xBg8ru2THU27gYbXvzDcJOubD485D4k856TbNQPd/rTurIEctE94R/3lqD1MRTtmV+MJtEHwdg
 easCQ7x/UWJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="365793601"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2020 13:42:05 -0700
Date:   Wed, 22 Apr 2020 13:41:17 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 0/7] x86: tag application address space for devices
Message-ID: <20200422204117.GB229170@romley-ivt3.sc.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 12:33:01PM -0700, Fenghua Yu wrote:
> Typical hardware devices require a driver stack to translate application
> buffers to hardware addresses, and a kernel-user transition to notify the
> hardware of new work. What if both the translation and transition overhead
> could be eliminated? This is what Shared Virtual Address (SVA) and ENQCMD
> enabled hardware like Data Streaming Accelerator (DSA) aims to achieve.
> Applications map portals in their local-address-space and directly submit
> work to them using a new instruction.
> 
Hi, maintainers,

Any comment on this series?

Thanks.

-Fenghua
