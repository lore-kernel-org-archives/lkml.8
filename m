Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67764C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FF12082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBDOte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:49:34 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:37254 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbgBDOtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:49:33 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 014EnUwV004584
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Feb 2020 15:49:30 +0100
Received: from [139.25.68.37] ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 014EnUoG029882;
        Tue, 4 Feb 2020 15:49:30 +0100
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Jailhouse 0.12 released
To:     Jailhouse <jailhouse-dev@googlegroups.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mozilla-News-Host: news://news://news://news://news://blaine.gmane.org
Message-ID: <dd4344b9-ca04-0ef2-0810-6b98e30f68b4@siemens.com>
Date:   Tue, 4 Feb 2020 15:49:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This release is an important milestone for Jailhouse because it comes 
with a reworked inter-cell communication device with better driver 
support and even an experimental virtio transport model for this.

While this shared memory device model is still in discussion with virtio 
and QEMU communities, thus may undergo some further smaller changes, it 
was important to move forward with it because there is an increasing 
demand for it on the Jailhouse side. We now support multi-peer 
connection, have a secure (unprivileged) and efficient UIO driver and 
can even start working on virtio integration - without having to touch 
the hypervisor any further. More information also in [1].

The release has another important new, and that is SMMUv3 for ARM64 
target, as well as the TI-specific MPU-like Peripheral Virtualization 
Unit (PVU). SMMUv2 support is unfortunately still waiting in some NXP 
downstream branch for being pushed upstream.

Note that there are several changes to the configuration format that 
require adjustments of own configs. Please study related changes in our 
reference configurations or, on x86, re-generate the system configuration.

Due to all these significant changes, statistics for this release look 
about more heavyweight than usual:
195 files changed, 7185 insertions(+), 2612 deletions(-)

- New targets:
    - Texas Instruments J721E-EVM
    - Raspberry Pi 4 Model B
- Cross-arch changes:
    - rework of ivshmem inter-cell communication device
    - fix hugepage splitting in paging_destroy
    - allow to disable hugepage creation
      (to statically mitigate CVE-2018-12207)
- ARM / ARM64:
    - SMMUv3 support
    - TI PVU support
    - fix race several conditions in IRQ injection
    - add support for PCI in bare-metal inmates
- x86:
    - model PIO access via whitelist regions, rather than bitmaps
    - vtd: Protect against invalid IQT register values
    - fix 1024x768 mode of EFI framebuffer
    - permit root cell to enable CR4.UMIP

You can download the new release from

     https://github.com/siemens/jailhouse/archive/v0.12.tar.gz

then follow the README.md for first steps on recommended evaluation
platforms and check the tutorial session from ELC-E 2016 [2][3]. To try
out Jailhouse in a virtual environment or on a few reference boards,
there is an image generator available [4]. It will soon be updated to
the new release as well. Drop us a note on the mailing list if you run
into trouble.

A quick forecast of what is being worked on: One of the next major 
changes will be a rework of the CPU selection in configs (selection by 
stable physical IDs), along with support for L2 CAT on Intel processors. 
There is also ongoing discussion to extend sub-page memory regions with 
access bitmaps, on byte or even register bit-level. That will make 
access control more scalable, e.g. to pass pinmux registers to different 
cells.

Last but not least: We are starting a port of Jailhouse to RISC-V, first 
against QEMU, then against an FPGA model that will be developed within 
the EU-funded SELENE project. Stay tuned, there will be more behind it!

Thanks to all the contributors and supporters!

Jan

[1] 
https://static.sched.com/hosted_files/kvmforum2019/4b/KVM-Forum19_ivshmem2.pdf
[2] 
https://events.static.linuxfound.org/sites/events/files/slides/ELCE2016-Jailhouse-Tutorial.pdf
[3] https://youtu.be/7fiJbwmhnRw?list=PLbzoR-pLrL6pRFP6SOywVJWdEHlmQE51q
[4] https://github.com/siemens/jailhouse-images

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
