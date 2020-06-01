Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083AAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D910520734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgFAJpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:45:20 -0400
Received: from foss.arm.com ([217.140.110.172]:35640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFAJpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:45:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 630231FB;
        Mon,  1 Jun 2020 02:45:19 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 65E7B3F305;
        Mon,  1 Jun 2020 02:45:18 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 0/3] firmware: Add support for PSA FF-A interface
Date:   Mon,  1 Jun 2020 10:45:09 +0100
Message-Id: <20200601094512.50509-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Sorry for posting in the middle of merge window and I must have done
this last week itself. This is not the driver I had thought about posting
last week. After I started cleaning up and looking at Will's KVM prototype[1]
for PSA FF-A (previously known as SPCI), I got more doubts on alignment
and dropped huge chunk of interface APIs in the driver in order to keep
it simple, and get aligned more with that prototype and avoid scanning
lots of code unnecessary.

Here are few things to clarify:

1. DT bindings
---------------
	I was initially against adding bindings for Tx/Rx buffers for
	partitions. As per the spec, an endpoint could allocate the
	buffer pair and use the FFA_RXTX_MAP interface to map it with the
	Hypervisor(KVM here). However looking at the prototype and also
	I remember you mentioning that it is not possible to manage buffers
	in that way. Please confirm if you plan to add the buffer details
	fetcthing them through ioctls in KVM and adding them to VM DT nodes
	in KVM userspace. I will update the bindings accordingly.

2. Driver
---------
a. Support for multiple partitions in a VM
------------------------------------------
	I am not sure if there is need for supporting multiple partitions
	within a VM. It should be possible to do so as I expect to create
	device for each partition entry under arm-psa-ffa devicetree node.
	However, I don't want to assume something that will never be a
	usecase. However I don't think this will change must of the
	abstraction as we need to keep the interface API implementation
	separate to support different partitions on various platforms.

b. SMCCC interface
------------------
	This is something I messed up completely while trying to add
	support for SMCCC v1.2. It now supports x0-x17 as parameter
	registers(input) and return registers(output). I started simple
	with x0-x7 as both input and output as PSA FF-A needs that at
	most. But extending to x0-x17 then became with messy in my
	implementation. That's the reason I dropped it completely
	here and thought of checking it first.

	Do we need to extend the optimisations that were done to handle
	ARCH_WORKAROUND_{1,2}. Or should be just use a version with x0-x7
	as both input and ouput. Hyper-V guys need full x0-x17 support.

	I need some guidance as what is the approach preferred ?

3. Partitions
-------------
	I am not sure if we have a full define partition that we plan to
	push upstream. Without one, we can have a sample/example partition
	to test all the interface APIs, but is that fine with respect to
	what we want upstream ? Any other thoughts that helps to test the
	driver ?

Sorry for long email and too many questions, but I thought it is easier
this way to begin with than throwing huge code implementing loads of APIs
with no users(expect example partition) especially that I am posting this
during merge window.

Sudeep Holla (3):
  dt-bindings: Add ARM PSA FF binding for non-secure VM partitions
  firmware: Add support for PSA FF-A transport for VM partitions
  firmware: Add example PSA FF-A non-secure VM partition

 .../devicetree/bindings/arm/arm,psa-ffa.txt   |  47 ++++
 drivers/firmware/Kconfig                      |   1 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/arm_psa_ffa/Kconfig          |  22 ++
 drivers/firmware/arm_psa_ffa/Makefile         |   3 +
 drivers/firmware/arm_psa_ffa/driver.c         | 250 ++++++++++++++++++
 drivers/firmware/arm_psa_ffa/partition.c      |  71 +++++
 include/linux/arm_psa_ffa.h                   |  42 +++
 8 files changed, 437 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,psa-ffa.txt
 create mode 100644 drivers/firmware/arm_psa_ffa/Kconfig
 create mode 100644 drivers/firmware/arm_psa_ffa/Makefile
 create mode 100644 drivers/firmware/arm_psa_ffa/driver.c
 create mode 100644 drivers/firmware/arm_psa_ffa/partition.c
 create mode 100644 include/linux/arm_psa_ffa.h

-- 
2.17.1

