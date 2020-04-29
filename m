Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E52BC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FAD8208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgD2WRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:17:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:11796 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgD2WRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 18:17:05 -0400
IronPort-SDR: 6kWa0COaKlQbNhBypua1gUE1rYiIoPdLnBDOu7djbv79x+uhHe8Hrs8Wv+2NRJ/iYj0M2VIlor
 3sQRLqpyfCzg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 15:17:04 -0700
IronPort-SDR: EGYnLfCVgjRdNT/fYGTKRk+d6V0IiVC/1awiI7IG5cNJU7V0Ldg9SIIizGpH0tjvPk5Gx5q7SB
 nRX3CPWIkgIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="432720256"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 29 Apr 2020 15:17:04 -0700
Date:   Wed, 29 Apr 2020 15:23:06 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 3/4] iommu/vt-d: Add page request draining support
Message-ID: <20200429152306.5be6fcdc@jacob-builder>
In-Reply-To: <3dd69b64-fc2c-bcfe-dc5f-cbca2b8c351f@linux.intel.com>
References: <20200422080611.15689-1-baolu.lu@linux.intel.com>
        <20200422080611.15689-4-baolu.lu@linux.intel.com>
        <20200428203644.3dcf13f2@jacob-builder>
        <3dd69b64-fc2c-bcfe-dc5f-cbca2b8c351f@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 14:00:05 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Jacob,
> 
> On 2020/4/29 11:36, Jacob Pan wrote:
> > On Wed, 22 Apr 2020 16:06:10 +0800
> > Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> >   
> >> When a PASID is stopped or terminated, there can be pending PRQs
> >> (requests that haven't received responses) in remapping hardware.
> >> This adds the interface to drain page requests and call it when a
> >> PASID is terminated.
> >>
> >> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> >> Signed-off-by: Liu Yi L<yi.l.liu@intel.com>
> >> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> >> ---
> >>   drivers/iommu/intel-svm.c   | 103
> >> ++++++++++++++++++++++++++++++++++-- include/linux/intel-iommu.h |
> >> 4 ++ 2 files changed, 102 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> >> index 83dc4319f661..2534641ef707 100644
> >> --- a/drivers/iommu/intel-svm.c
> >> +++ b/drivers/iommu/intel-svm.c
> >> @@ -23,6 +23,7 @@
> >>   #include "intel-pasid.h"
> >>   
> >>   static irqreturn_t prq_event_thread(int irq, void *d);
> >> +static void intel_svm_drain_prq(struct device *dev, int pasid);
> >>   
> >>   #define PRQ_ORDER 0
> >>   
> >> @@ -66,6 +67,8 @@ int intel_svm_enable_prq(struct intel_iommu
> >> *iommu) dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
> >>   	dmar_writeq(iommu->reg + DMAR_PQA_REG,
> >> virt_to_phys(iommu->prq) | PRQ_ORDER);
> >> +	init_completion(&iommu->prq_complete);
> >> +
> >>   	return 0;
> >>   }
> >>   
> >> @@ -208,6 +211,7 @@ static void intel_mm_release(struct
> >> mmu_notifier *mn, struct mm_struct *mm) rcu_read_lock();
> >>   	list_for_each_entry_rcu(sdev, &svm->devs, list) {
> >>   		intel_pasid_tear_down_entry(svm->iommu,
> >> sdev->dev, svm->pasid);
> >> +		intel_svm_drain_prq(sdev->dev, svm->pasid);  
> > mmu_notifier release is called in atomic context, drain_prq needs to
> > wait for completion. I tested exit path when a process crashes. I
> > got
> > 
> > [  +0.696214] BUG: sleeping function called from invalid context at
> > kernel/sched/completion.c:101 [  +0.000068] in_atomic(): 1,
> > irqs_disabled(): 0, non_block: 0, pid: 3235, name: dsatest
> > [  +0.000046] INFO: lockdep is turned off. [  +0.000002] CPU: 1
> > PID: 3235 Comm: dsatest Not tainted 5.7.0-rc1-z-svmtest+ #1637
> > [  +0.000000] Hardware name: Intel Corporation Kabylake Client
> > platform/Skylake Halo DDR4 RVP11, BIOS 04.1709050855 09/05/2017
> > [  +0.000001] Call Trace: [  +0.000004]  dump_stack+0x68/0x9b
> > [  +0.000003]  ___might_sleep+0x229/0x250
> > [  +0.000003]  wait_for_completion_timeout+0x3c/0x110
> > [  +0.000003]  intel_svm_drain_prq+0x12f/0x210
> > [  +0.000003]  intel_mm_release+0x73/0x110
> > [  +0.000003]  __mmu_notifier_release+0x94/0x220
> > [  +0.000002]  ? do_munmap+0x10/0x10
> > [  +0.000002]  ? prepare_ftrace_return+0x5c/0x80
> > [  +0.000003]  exit_mmap+0x156/0x1a0
> > [  +0.000002]  ? mmput+0x44/0x120
> > [  +0.000003]  ? exit_mmap+0x5/0x1a0
> > [  +0.000002]  ? ftrace_graph_caller+0xa0/0xa0
> > [  +0.000001]  mmput+0x5e/0x120
> > 
> >   
> 
> Thanks a lot!
> 
> Actually, we can't drain page requests in this mm_notifier code path,
> right? The assumptions of page request draining are that 1) the device
> driver has drained DMA requests in the device end; 2) the pasid entry
> has been marked as non-present. So we could only drain page requests
> in the unbind path.
> 
> Thought?
> 
Right, we could save the drain here. unbind will come soon when mm
exits. So even the in flight PRs come through, we could just respond
with "Invalid Response" after mm exit starts. The current code already
checks if the mm is exiting by mmget_not_zero.

> Best regards,
> baolu

[Jacob Pan]
