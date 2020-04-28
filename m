Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18851C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025A8206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgD1WNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:13:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:57310 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgD1WNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:13:07 -0400
IronPort-SDR: yQx3MJGE+sc0dAYIurwEQ3iq+T/Szvy7Hf2HFY/bIS9Xj0ebglngYztSHuhT0hMcTOaKXWT8Y6
 P70wHdtevGTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 15:13:05 -0700
IronPort-SDR: UrO7djlVD746mQgSPR9NNFNfA6Q93RtblZyn3IyDb/eLZWJ1jt5uCnmYQLA0JuXb00jYhZNGYP
 TE87jCla70kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="282293855"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.240.17])
  by fmsmga004.fm.intel.com with SMTP; 28 Apr 2020 15:13:04 -0700
Date:   Tue, 28 Apr 2020 15:13:03 -0700
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
Message-ID: <20200428151303.00004fa2@intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F608EE2@ORSMSX115.amr.corp.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
        <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
        <87pnbus3du.fsf@nanos.tec.linutronix.de>
        <20200428112113.000033bd@intel.com>
        <87tv13o306.fsf@nanos.tec.linutronix.de>
        <3908561D78D1C84285E8C5FCA982C28F7F608BE9@ORSMSX115.amr.corp.intel.com>
        <20200428134200.000010f7@intel.com>
        <3908561D78D1C84285E8C5FCA982C28F7F608EE2@ORSMSX115.amr.corp.intel.com>
Organization: intel
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 13:59:43 -0700
"Luck, Tony" <tony.luck@intel.com> wrote:

> >> So the driver needs to use flush/drain operations to make sure all
> >> the in-flight work has completed before releasing/re-using the
> >> PASID. 
> > Are you suggesting we should let driver also hold a reference of the
> > PASID?  
> 
> The sequence for bare metal is:
> 
> 	process is queuing requests to DSA
> 	process exits (either deliberately, or crashes, or is killed)
> 	kernel does exit processing
> 	DSA driver is called as part of tear down of "mm"
> 		issues drain/flush commands to ensure that all
> 		queued operations on the PASID for this mm have
> 		completed
> 	PASID can be freed
> 
> There's a 1:1 map from "mm" to PASID ... so reference counting seems
> like overkill. Once the kernel is in the "exit" path, we know that no
> more work can be queued using this PASID.
> 
There are two users of a PASID, mm and device driver(FD). If
either one is not done with the PASID, it cannot be reclaimed. As you
mentioned, it could take a long time for the driver to abort. If the
abort ends *after* mmdrop, we are in trouble.
If driver drops reference after abort/drain PASID is done, then we are
safe.


> -Tony

