Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2EFC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EC220740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AA3HtYz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgCYToL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:44:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38014 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgCYTn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:43:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJdJ3g019908;
        Wed, 25 Mar 2020 19:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=FX10Haw9tTd69iSu01amsm7am09LReXT58Vg4Wx0LSQ=;
 b=AA3HtYz7Hig9PEjnH+o1RlGyhB/J7wbHoR3EEshGc/mhJO19+3YU0rY/AUrDCpVy0Hw2
 hOBleCqZXtwQvI2kH5WhKsN6CG8HdMnEhjlR6jhOyFlWimMl+kwVuNw5zFq0B1+Y1nqK
 s/pHsXLtW0WzWf3T1N7w5ch1CoTJIXZXxnwgeI5N2ztXt8Qcp51mMl1iNzpIqSDfSsnO
 4Cx/e6PirEiSyYgxFteFXjPzM6+OLI0hKqqk0YR0V/dg+LoXffk5beWodeBc93pJJtrA
 OVm5aD+Hn61FKr+IaZqkzsWL8nk2HHukq3voxY1b/vMilm7W61fpcXOuQIsr2CmYFAoC Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ywabrbsq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJghVo072956;
        Wed, 25 Mar 2020 19:43:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30073b1tw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:28 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02PJhOYt008199;
        Wed, 25 Mar 2020 19:43:24 GMT
Received: from pneuma.us.oracle.com (/10.39.203.246)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 12:43:23 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel support
Date:   Wed, 25 Mar 2020 15:43:05 -0400
Message-Id: <20200325194317.526492-1-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Trenchboot project focus on boot security has led to the enabling of
the Linux kernel to be directly invocable by the x86 Dynamic Launch
instruction(s) for establishing a Dynamic Root of Trust for Measurement
(DRTM). The dynamic launch will be initiated by a boot loader with
associated support added to it, for example the first targeted boot
loader will be GRUB2. An integral part of establishing the DRTM involves
measuring everything that is intended to be run (kernel image, initrd,
etc) and everything that will configure that kernel to run (command
line, boot params, etc) into specific PCRs, the DRTM PCRs (17-22), in
the TPM. Another key aspect is the dynamic launch is rooted in hardware.
On Intel this is done using the GETSEC instruction set provided by
Intel's TXT and the SKINIT instruction provided by AMD's AMD-V.
Information on these technologies can be readily found online.

To enable the kernel to be launched by GETSEC or SKINIT, a stub must be
built into the setup section of the compressed kernel to handle the
specific state that the late launch process leaves the BSP. This is a
lot like the EFI stub that is found in the same area. Also this stub
must measure everything that is going to be used as early as possible.
This stub code and subsequent code must also deal with the specific
state that the late launch leaves the APs in.

A quick note on terminology. The larger open source project itself is
called Trenchboot, which is hosted on Github (links below). The kernel
feature enabling the use of the x86 technology is referred to as "Secure
Launch" within the kernel code. As such the prefixes sl_/SL_ or
slaunch/SLAUNCH will be seen in the code. The stub code discussed above
is referred to as the SL stub.

The basic flow is:

 - Entry from the late launch jumps to the SL stub
 - SL stub fixes up the world on the BSP
 - For TXT, SL stub wakes the APs, fixes up their worlds
 - For TXT, APs are left halted waiting for an NMI to wake them
 - SL stub jumps to startup_32
 - SL main runs to measure configuration and module information into the
   DRTM PCRs. It also locates the TPM event log.
 - Kernel boot proceeds normally from this point.
 - During early setup, slaunch_setup() runs to finish some validation
   and setup tasks.
 - The SMP bringup code is modified to wake the waiting APs. APs vector
   to rmpiggy and start up normally from that point.
 - Kernel boot finishes booting normally
 - SL securityfs module is present to allow reading and writing of the
   TPM event log.

Outstanding:

 - Currently Secure Launch only supports TXT, though there is an AMD
   version is in progress.
 - The compressed kernel TPM code includes a CRB interface
   implementation but is untested due to inability to locate a system
   with TXT and a TPM accessible with the CRB interface
 - There is a known crash that is difficult to reproduce and is unclear
   how the secure launch code is causing the crash. Thread on it here:
   https://groups.google.com/forum/#!topic/trenchboot-devel/EZN_4ymrCgs

Links:

The Trenchboot project including documentation:

https://github.com/trenchboot

Intel TXT is documented in its own specification and in the SDM Instruction Set volume:

https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
https://software.intel.com/en-us/articles/intel-sdm

AMD SKINIT is documented in the System Programming manual:

https://www.amd.com/system/files/TechDocs/24593.pdf

Thanks
Ross Philipson and Daniel P. Smith

Daniel P. Smith (5):
  x86: Add early SHA support for Secure Launch early measurements
  x86: Add early TPM TIS/CRB interface support for Secure Launch
  x86: Add early TPM1.2/TPM2.0 interface support for Secure Launch
  x86: Add early general TPM interface support for Secure Launch
  x86: Secure Launch adding event log securityfs

Ross Philipson (7):
  x86: Secure Launch Kconfig
  x86: Secure Launch main header file
  x86: Secure Launch kernel early boot stub
  x86: Secure Launch kernel late boot stub
  x86: Secure Launch SMP bringup support
  kexec: Secure Launch kexec SEXIT support
  tpm: Allow locality 2 to be set when initializing the TPM for Secure
    Launch

 Documentation/x86/boot.rst                    |   9 +
 arch/x86/Kconfig                              |  35 +
 arch/x86/boot/compressed/Makefile             |   8 +
 arch/x86/boot/compressed/early_sha1.c         | 104 +++
 arch/x86/boot/compressed/early_sha1.h         |  17 +
 arch/x86/boot/compressed/early_sha256.c       |   6 +
 arch/x86/boot/compressed/early_sha512.c       |   6 +
 arch/x86/boot/compressed/head_64.S            |  32 +
 arch/x86/boot/compressed/kernel_info.S        |   3 +
 arch/x86/boot/compressed/sl_main.c            | 378 ++++++++++
 arch/x86/boot/compressed/sl_stub.S            | 568 ++++++++++++++
 arch/x86/boot/compressed/tpm/crb.c            | 302 ++++++++
 arch/x86/boot/compressed/tpm/crb.h            |  25 +
 arch/x86/boot/compressed/tpm/tis.c            | 212 ++++++
 arch/x86/boot/compressed/tpm/tis.h            |  51 ++
 arch/x86/boot/compressed/tpm/tpm.c            | 190 +++++
 arch/x86/boot/compressed/tpm/tpm.h            |  42 ++
 arch/x86/boot/compressed/tpm/tpm1.h           | 112 +++
 arch/x86/boot/compressed/tpm/tpm1_cmds.c      | 133 ++++
 arch/x86/boot/compressed/tpm/tpm2.h           |  89 +++
 arch/x86/boot/compressed/tpm/tpm2_auth.c      |  31 +
 arch/x86/boot/compressed/tpm/tpm2_auth.h      |  21 +
 arch/x86/boot/compressed/tpm/tpm2_cmds.c      | 150 ++++
 arch/x86/boot/compressed/tpm/tpm2_constants.h |  66 ++
 arch/x86/boot/compressed/tpm/tpm_buff.c       | 135 ++++
 arch/x86/boot/compressed/tpm/tpm_common.h     | 127 ++++
 arch/x86/boot/compressed/tpm/tpmbuff.h        |  34 +
 arch/x86/boot/compressed/tpm/tpmio.c          |  51 ++
 arch/x86/boot/compressed/vmlinux.lds.S        |   4 +
 arch/x86/include/asm/realmode.h               |   3 +
 arch/x86/kernel/Makefile                      |   1 +
 arch/x86/kernel/asm-offsets.c                 |  15 +
 arch/x86/kernel/setup.c                       |   3 +
 arch/x86/kernel/slaunch.c                     | 700 ++++++++++++++++++
 arch/x86/kernel/smpboot.c                     |  86 +++
 arch/x86/realmode/rm/header.S                 |   3 +
 arch/x86/realmode/rm/trampoline_64.S          |  37 +
 drivers/char/tpm/tpm-chip.c                   |  13 +-
 drivers/iommu/dmar.c                          |   4 +
 include/linux/sha512.h                        |  21 +
 include/linux/slaunch.h                       | 513 +++++++++++++
 kernel/kexec_core.c                           |   3 +
 lib/sha1.c                                    |   4 +
 lib/sha512.c                                  | 209 ++++++
 44 files changed, 4554 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/boot/compressed/early_sha1.c
 create mode 100644 arch/x86/boot/compressed/early_sha1.h
 create mode 100644 arch/x86/boot/compressed/early_sha256.c
 create mode 100644 arch/x86/boot/compressed/early_sha512.c
 create mode 100644 arch/x86/boot/compressed/sl_main.c
 create mode 100644 arch/x86/boot/compressed/sl_stub.S
 create mode 100644 arch/x86/boot/compressed/tpm/crb.c
 create mode 100644 arch/x86/boot/compressed/tpm/crb.h
 create mode 100644 arch/x86/boot/compressed/tpm/tis.c
 create mode 100644 arch/x86/boot/compressed/tpm/tis.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm1.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm1_cmds.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2_auth.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2_auth.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2_cmds.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2_constants.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm_buff.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm_common.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpmbuff.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpmio.c
 create mode 100644 arch/x86/kernel/slaunch.c
 create mode 100644 include/linux/sha512.h
 create mode 100644 include/linux/slaunch.h
 create mode 100644 lib/sha512.c

-- 
2.25.1

