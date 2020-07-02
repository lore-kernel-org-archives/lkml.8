Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65905C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421EA206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UcmUV7ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgGBPWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:22:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53268 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgGBPWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:22:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062EuJSB132970;
        Thu, 2 Jul 2020 15:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=knq8FhKf2KET7qx7cbx90iJZQGAiu8Vf8BPOz/oCK2M=;
 b=UcmUV7ezZEhfOC/Q8ahQf+5Tw7g+dZQM0Iak1G18GkYQTQxCH/kY3SxCOd2+kVt/q6st
 /p4mtSZwyQ7iFp+UIuWSdUr9Qp4FKktw5zDyEou+gRE4aUvFyETeTNco0teQWYIglco1
 B1HwBgj7Xh+4XovneoO398tEJx2TskY/xKX7JOuJE/lkOJUPvd08dOIhNPuoi5+r1Csb
 1AyuRJ4LgifTLBMWCz6VfTTf3/hHD6mlmG6n6Whx7CYpjyRlr3d0JanWR4HcgoFoR8v7
 20MOZ3Qm7swfH1pQYQRujkfU4xAkwUmkCjwwZJxVlLjRpJgOgTAQRYNo8joqzgtfw0EH Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31xx1e5xc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Jul 2020 15:21:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062EvrQZ162727;
        Thu, 2 Jul 2020 15:21:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31xg2144d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jul 2020 15:21:43 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 062FLfE2000779;
        Thu, 2 Jul 2020 15:21:41 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jul 2020 15:20:47 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH RFC 0/7] CPU feature evaluation after microcode late loading
Date:   Thu,  2 Jul 2020 18:18:20 +0300
Message-Id: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=0 mlxlogscore=999 cotscore=-2147483648 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC patch set aims to provide the ability to re-evaluate all CPU
features and take proper bug mitigation in place after a microcode
late loading.

This was debated last year and this patch set implements a subset of
point #2 from Thomas Gleixner's idea:
https://lore.kernel.org/lkml/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/

Point #1 was sent as an RFC some time ago
(https://lkml.org/lkml/2020/4/27/214), but after a discussion with CPU
vendors (Intel), the metadata file is not easily buildable at this
moment so we could not advance with it more. Without #1, I know it is
unlikely to embrace the feature re-evaluation.

Patches from 1 to 4 bring in changes for functions/variables in order to be
able to use them at runtime.

Patch 5 re-evaluates CPU features, patch 6 is re-probing bugs and patch 7
deals with speculation blacklist CPUs/microcode versions.

Thank you,
Mihai Carabas

Mihai Carabas (7):
  x86: cpu: bugs.c: remove init attribute from functions and variables
  x86: cpu: modify boot_command_line to saved_command_line
  x86: kernel: cpu: bugs.c: modify static_cpu_has to boot_cpu_has
  x86: cpu: bugs.c: update cpu_smt_disable to be callable at runtime
  x86: microcode: late loading feature and bug evaluation
  x86: cpu: bugs.c: reprobe bugs at runtime
  x86: cpu: update blacklist spec features for late loading

 arch/x86/include/asm/microcode.h       |   3 +
 arch/x86/include/asm/microcode_intel.h |   1 +
 arch/x86/kernel/cpu/bugs.c             | 142 +++++++++++++++++++--------------
 arch/x86/kernel/cpu/common.c           |  32 +++++++-
 arch/x86/kernel/cpu/cpu.h              |   4 +-
 arch/x86/kernel/cpu/intel.c            |  28 +++++++
 arch/x86/kernel/cpu/microcode/core.c   |  28 +++++++
 arch/x86/kernel/cpu/microcode/intel.c  |   5 +-
 arch/x86/kernel/cpu/tsx.c              |   8 +-
 arch/x86/kernel/process.c              |   8 +-
 arch/x86/kvm/vmx/vmx.c                 |   2 +-
 kernel/cpu.c                           |  18 ++++-
 12 files changed, 201 insertions(+), 78 deletions(-)

-- 
1.8.3.1

