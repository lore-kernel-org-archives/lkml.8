Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3EAC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FCD204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgIGKVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:21:52 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:8125 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728421AbgIGKVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:21:43 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 7 Sep 2020 03:21:33 -0700
Received: from akaher-virtual-machine.eng.vmware.com (unknown [10.197.103.239])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 22D5540271;
        Mon,  7 Sep 2020 03:21:34 -0700 (PDT)
From:   Ajay Kaher <akaher@vmware.com>
To:     <gregkh@linuxfoundation.org>
CC:     <alex.williamson@redhat.com>, <cohuck@redhat.com>,
        <peterx@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <srivatsab@vmware.com>, <srivatsa@csail.mit.edu>,
        <vsirnapalli@vmware.com>, <akaher@vmware.com>
Subject: [PATCH v4.19.y 0/3] vfio: Fix for CVE-2020-12888
Date:   Mon, 7 Sep 2020 15:47:23 +0530
Message-ID: <1599473843-34234-4-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599473843-34234-1-git-send-email-akaher@vmware.com>
References: <1599473843-34234-1-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: akaher@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CVE-2020-12888 Kernel: vfio: access to disabled MMIO space of some
devices may lead to DoS scenario
    
The VFIO modules allow users (guest VMs) to enable or disable access to the
devices' MMIO memory address spaces. If a user attempts to access (read/write)
the devices' MMIO address space when it is disabled, some h/w devices issue an
interrupt to the CPU to indicate a fatal error condition, crashing the system.
This flaw allows a guest user or process to crash the host system resulting in
a denial of service.
    
Patch 1/ is to force the user fault if PFNMAP vma might be DMA mapped
before user access.
    
Patch 2/ setup a vm_ops handler to support dynamic faulting instead of calling
remap_pfn_range(). Also provides a list of vmas actively mapping the area which
can later use to invalidate those mappings.
    
Patch 3/ block the user from accessing memory spaces which is disabled by using
new vma list support to zap, or invalidate, those memory mappings in order to
force them to be faulted back in on access.
    
Upstreamed patches link:
https://lore.kernel.org/kvm/158871401328.15589.17598154478222071285.stgit@gimli.home
        
[PATCH v4.19.y 1/3]:
Backporting of upsream commit 41311242221e:
vfio/type1: Support faulting PFNMAP vmas
        
[PATCH v4.19.y 2/3]:
Backporting of upsream commit 11c4cd07ba11:
vfio-pci: Fault mmaps to enable vma tracking
        
[PATCH v4.19.y 3/3]:
Backporting of upsream commit abafbc551fdd:
vfio-pci: Invalidate mmaps and block MMIO access on disabled memory
