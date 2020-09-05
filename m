Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3E3C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C53D20760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A71gB59m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgIERzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgIERzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 13:55:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF932C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=jUZ7wVkTOQQmJc8x+4KhnWzCxul2cSsRNxbx56SPfxo=; b=A71gB59mhOADuO2PBRZ+b0N9W3
        gbr1xRbj0gHTU0+Kf1tucuyOehTVwO3UKP8z9tG+rOjoNFAfYYvoZA/RwE4VHKpGFu6ukgjk6SpkJ
        ksVeRt79gOp9LvCMXa6XAmjSPiZ1RJJEHYNeeqtQDOAnNKWCHPsYIDNv4ivXY97uXBSeERqFAJAoL
        qFcLWtRAJux0E8aX0oJzSes/PyyK1ASQuHKnD68zCj0aNHuD2h/9dpdnmKTAM60JZ/IaPe3BBBhP9
        lI71qOXqTCzrn6IWOLi+5j2gLuI2Zc8wi2L+jHiGgcqaq+i7r+TpLNW2F8M7/F02sfqadFXncqGFo
        W+eow98g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEcP4-0001qg-LN; Sat, 05 Sep 2020 17:55:06 +0000
Subject: Re: [PATCH v7 3/9] docs: x86: Add documentation for SVA (Shared
 Virtual Addressing)
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-4-git-send-email-fenghua.yu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <626fe21c-1f82-f4f8-e37b-32d91e7d557a@infradead.org>
Date:   Sat, 5 Sep 2020 10:54:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598540794-132666-4-git-send-email-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'll add a few edits other than those that Borislav made.
(nice review job, BP)


On 8/27/20 8:06 AM, Fenghua Yu wrote:
> From: Ashok Raj <ashok.raj@intel.com>
> 
> ENQCMD and Data Streaming Accelerator (DSA) and all of their associated
> features are a complicated stack with lots of interconnected pieces.
> This documentation provides a big picture overview for all of the
> features.
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v7:
> - Change the doc for updating PASID by IPI and context switch (Andy).
> 
> v3:
> - Replace deprecated intel_svm_bind_mm() by iommu_sva_bind_mm() (Baolu)
> - Fix a couple of typos (Baolu)
> 
> v2:
> - Fix the doc format and add the doc in toctree (Thomas)
> - Modify the doc for better description (Thomas, Tony, Dave)
> 
>  Documentation/x86/index.rst |   1 +
>  Documentation/x86/sva.rst   | 254 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 255 insertions(+)
>  create mode 100644 Documentation/x86/sva.rst


> diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
> new file mode 100644
> index 000000000000..6e7ac565e127
> --- /dev/null
> +++ b/Documentation/x86/sva.rst
> @@ -0,0 +1,254 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================================
> +Shared Virtual Addressing (SVA) with ENQCMD
> +===========================================
> +
> +Background
> +==========
> +

...

> +
> +Shared Hardware Workqueues
> +==========================
> +
> +Unlike Single Root I/O Virtualization (SRIOV), Scalable IOV (SIOV) permits
> +the use of Shared Work Queues (SWQ) by both applications and Virtual
> +Machines (VM's). This allows better hardware utilization vs. hard
> +partitioning resources that could result in under utilization. In order to
> +allow the hardware to distinguish the context for which work is being
> +executed in the hardware by SWQ interface, SIOV uses Process Address Space
> +ID (PASID), which is a 20bit number defined by the PCIe SIG.

                          20-bit

> +
> +PASID value is encoded in all transactions from the device. This allows the
> +IOMMU to track I/O on a per-PASID granularity in addition to using the PCIe
> +Resource Identifier (RID) which is the Bus/Device/Function.
> +
> +
> +ENQCMD
> +======
> +

...

> +
> +Process Address Space Tagging
> +=============================
> +

...

> +
> +PASID Management
> +================
> +

...

> +
> +Relationships
> +=============
> +
> + * Each process has many threads, but only one PASID

                           (end with)             PASID.

> + * Devices have a limited number (~10's to 1000's) of hardware
> +   workqueues and each portal maps down to a single workqueue.
> +   The device driver manages allocating hardware workqueues.
> + * A single mmap() maps a single hardware workqueue as a "portal"

                         (end with)                                  .

> + * For each device with which a process interacts, there must be
> +   one or more mmap()'d portals.
> + * Many threads within a process can share a single portal to access
> +   a single device.
> + * Multiple processes can separately mmap() the same portal, in
> +   which case they still share one device hardware workqueue.
> + * The single process-wide PASID is used by all threads to interact
> +   with all devices.  There is not, for instance, a PASID for each
> +   thread or each thread<->device pair.
> +
> +FAQ
> +===
> +
> +* What is SVA/SVM?
> +
> +Shared Virtual Addressing (SVA) permits I/O hardware and the processor to
> +work in the same address space. In short, sharing the address space. Some
> +call it Shared Virtual Memory (SVM), but Linux community wanted to avoid

                                                            waned to avoid confusing

> +it with Posix Shared Memory and Secure Virtual Machines which were terms

           POSIX

> +already in circulation.
> +
> +* What is a PASID?
> +
> +A Process Address Space ID (PASID) is a PCIe-defined TLP Prefix. A PASID is

ah, BP already commented about using acronyms to define acronyms.  :)

> +a 20 bit number allocated and managed by the OS. PASID is included in all

     20-bit

> +transactions between the platform and the device.
> +
> +* How are shared work queues different?
> +
> +Traditionally to allow user space applications interact with hardware,
> +there is a separate instance required per process. For example, consider
> +doorbells as a mechanism of informing hardware about work to process. Each
> +doorbell is required to be spaced 4k (or page-size) apart for process
> +isolation. This requires hardware to provision that space and reserve in

                                                                 reserve it in

> +MMIO. This doesn't scale as the number of threads becomes quite large. The
> +hardware also manages the queue depth for Shared Work Queues (SWQ), and
> +consumers don't need to track queue depth. If there is no space to accept
> +a command, the device will return an error indicating retry. Also
> +submitting a command to an MMIO address that can't accept ENQCMD will
> +return retry in response. In the new DMWr PCIe terminology, devices need to

so how does a submitter know whether a return of "retry" means no_space or
invalid_for_this_device?

> +support DMWr completer capability. In addition it requires all switch ports
> +to support DMWr routing and must be enabled by the PCIe subsystem, much
> +like how PCIe Atomics() are managed for instance.
> +
> +SWQ allows hardware to provision just a single address in the device. When
> +used with ENQCMD to submit work, the device can distinguish the process
> +submitting the work since it will include the PASID assigned to that
> +process. This decreases the pressure of hardware requiring to support
> +hardware to scale to a large number of processes.
> +
> +* Is this the same as a user space device driver?
> +
> +Communicating with the device via the shared work queue is much simpler
> +than a full blown user space driver. The kernel driver does all the
> +initialization of the hardware. User space only needs to worry about
> +submitting work and processing completions.
> +
> +* Is this the same as SR-IOV?
> +
> +Single Root I/O Virtualization (SR-IOV) focuses on providing independent

In 2 other places, SR-IOV is just SRIOV. Please be consistent.

> +hardware interfaces for virtualizing hardware. Hence its required to be
> +almost fully functional interface to software supporting the traditional
> +BAR's, space for interrupts via MSI-x, its own register layout.

   BARs,                           MSI-X,

> +Virtual Functions (VFs) are assisted by the Physical Function (PF)
> +driver.
> +
> +Scalable I/O Virtualization builds on the PASID concept to create device
> +instances for virtualization. SIOV requires host software to assist in
> +creating virtual devices, each virtual device is represented by a PASID

                    devices; each

> +along with the BDF of the device.  This allows device hardware to optimize

what is BDF?  ah, bus/device/function.  still, not nice here.

> +device resource creation and can grow dynamically on demand. SR-IOV creation
> +and management is very static in nature. Consult references below for more
> +details.
> +
> +* Why not just create a virtual function for each app?
> +
> +Creating PCIe SRIOV type virtual functions (VF) are expensive. They create

                                                   is

> +duplicated hardware for PCI config space requirements, Interrupts such as

                                            requirements -- interrupts

> +MSIx for instance. Resources such as interrupts have to be hard partitioned

   MSI-X

> +between VF's at creation time, and cannot scale dynamically on demand. The

           VFs

> +VF's are not completely independent from the Physical function (PF). Most

   VFs

> +VF's require some communication and assistance from the PF driver. SIOV

   VFs

> +creates a software defined device. Where all the configuration and control
> +aspects are mediated via the slow path. The work submission and completion
> +happen without any mediation.

...


-- 
~Randy

