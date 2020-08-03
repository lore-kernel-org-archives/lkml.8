Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34303C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E6522B45
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgHCRTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:19:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:57963 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgHCRTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:19:47 -0400
IronPort-SDR: fY6V27xfypH9r6Az8EPEF+QSxbLloTxwTbDmr6/9g0Jttp3F3btsrWKd9KeYMZ0CNl4zW5kiZy
 ioJTHr8widvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="131727768"
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; 
   d="scan'208";a="131727768"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 10:19:47 -0700
IronPort-SDR: KtHv35ANwZ8f7TkVfEpIBacjRUfJCoFDiYIqTEtwVJn0JL3JUXRZ6F9eqNCZZWvhjuk8Saq7H4
 s4Ctke6jmV9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; 
   d="scan'208";a="275358327"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga008.fm.intel.com with ESMTP; 03 Aug 2020 10:19:47 -0700
Date:   Mon, 3 Aug 2020 17:19:47 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu <iommu@lists.linux-foundation.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v6 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200803171947.GA329474@otcwcpicx6.sc.intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
 <CALCETrV6yTjFzuTMEP8T9_QfjAXktHZcMXSqionZGJ=Lj0YdFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV6yTjFzuTMEP8T9_QfjAXktHZcMXSqionZGJ=Lj0YdFg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andy,

On Fri, Jul 31, 2020 at 06:28:37PM -0700, Andy Lutomirski wrote:
> On Mon, Jul 13, 2020 at 4:48 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> >
> > A #GP fault is generated when ENQCMD instruction is executed without
> > a valid PASID value programmed in the current thread's PASID MSR. The
> > #GP fault handler will initialize the MSR if a PASID has been allocated
> > for this process.
> 
> Let's take a step back here.  Why are we trying to avoid IPIs?  If you
> call munmap(), you IPI other CPUs running tasks in the current mm.  If
> you do perf_event_open() and thus acquire RDPMC permission, you IPI
> other CPUs running tasks in the current mm.  If you call modify_ldt(),
> you IPI other CPUs running tasks in the current mm.  These events can
> all happen more than once per process.
> 
> Now we have ENQCMD.  An mm can be assigned a PASID *once* in the model
> that these patches support.  Why not just send an IPI using
> essentially identical code to the LDT sync or the CR4.PCE sync?

ldt (or the other two cases) is different from ENQCMD: the PASID MSR
is per-task and is supported by xsaves.

The per-task PASID MSR needs to updated to ALL tasks. That means IPI,
which only updates running tasks' MSRs, is not enough. All tasks' MSRs
need to be updated when a PASID is allocated.

This difference increases the complexity of sending IPI to running tasks
and updating sleeping tasks's MSRs with locking etc.

Of course, it's doable not to update the MSRs in all task when a new PASID
is allocated to the mm. But that means we need to discard xsaves support
for the MSR and create our own switch function to load the MSR. That
increases complexity.

We tried similar IPI way to update the PASID in about 200 lines of code.
As Dave Hansen pointed, it's too complex. The current lazy updating the MSR
only takes essential 3 lines of code in #GP.

Does it make sense to still use the current fix up method to update the MSR?

Thanks.

-Fenghua
