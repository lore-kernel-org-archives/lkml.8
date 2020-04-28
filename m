Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7D6C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306A0208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgD1UmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:42:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:56480 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD1UmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:42:02 -0400
IronPort-SDR: hS4L0avMnzi/CbwJb8gTD4tJER3pe08Dhr0lXaZ4WaeQfg/4Q8F+8ekoDI6EtMnf/LCIo+hQsY
 psN73Cm86GrQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 13:42:01 -0700
IronPort-SDR: xagcZJWK38zXxA6Ieuy00Ct62Fx2wWHz9vTb6SOF2J+n3Zp70Y7WRrXkYEqW+/S3sb23RIPidX
 V9CDHy8qkx/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="246625188"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.240.17])
  by orsmga007.jf.intel.com with SMTP; 28 Apr 2020 13:42:00 -0700
Date:   Tue, 28 Apr 2020 13:42:00 -0700
From:   "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH 5/7] x86/mmu: Allocate/free PASID
Message-ID: <20200428134200.000010f7@intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F608BE9@ORSMSX115.amr.corp.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
        <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
        <87pnbus3du.fsf@nanos.tec.linutronix.de>
        <20200428112113.000033bd@intel.com>
        <87tv13o306.fsf@nanos.tec.linutronix.de>
        <3908561D78D1C84285E8C5FCA982C28F7F608BE9@ORSMSX115.amr.corp.intel.com>
Organization: intel
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 12:07:25 -0700
"Luck, Tony" <tony.luck@intel.com> wrote:

> > If fd release cleans up then how should there be something in
> > flight at the final mmdrop?  
> 
> ENQCMD from the user is only synchronous in that it lets the user
> know their request has been added to a queue (or not).  Execution of
> the request may happen later (if the device is busy working on
> requests for other users).  The request will take some time to
> complete. Someone told me the theoretical worst case once, which I've
> since forgotten, but it can be a long time.
> 
> So the driver needs to use flush/drain operations to make sure all
> the in-flight work has completed before releasing/re-using the PASID.
> 
Are you suggesting we should let driver also hold a reference of the
PASID?

> -Tony

