Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8241FC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A0E20754
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCQOK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:10:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726016AbgCQOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:10:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HE1KJX029491
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:10:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yrr6u7yw9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:10:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Tue, 17 Mar 2020 14:10:24 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Mar 2020 14:10:21 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02HEAKLb57147470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 14:10:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8ED211C052;
        Tue, 17 Mar 2020 14:10:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B82B11C058;
        Tue, 17 Mar 2020 14:10:19 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.199.61.203])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Mar 2020 14:10:19 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, ego@linux.vnet.ibm.com, linuxram@us.ibm.com,
        psampat@in.ibm.com, pratik.r.sampat@gmail.com
Subject: [PATCH v5 0/3] Introduce Self-Save API for deep stop states
Date:   Tue, 17 Mar 2020 19:40:15 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031714-4275-0000-0000-000003ADD591
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031714-4276-0000-0000-000038C2FEA0
Message-Id: <20200317141018.42380-1-psampat@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_05:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skiboot patches v4: https://lists.ozlabs.org/pipermail/skiboot/2020-February/016404.html
Linux patches v4: https://lkml.org/lkml/2020/2/12/446
Changelog
v4 --> v5
Based on Michael Ellerman's comments, in patch3:
1. Added documentation in power-mgt.txt for self-save and self-restore
2. Used bitmap abstractions while parsing device tree
3. Fixed scenario where zero or less SPRs were treated as a success
4. Removed redundant device_node pointer
5. Removed unnecessary pr_warn messages
6. Changed the old of_find_node_by_path calls to of_find_compatible_node
7. Fixed leaking reference of the parsed device_node pointer 

Currently the stop-API supports a mechanism called as self-restore
which allows us to restore the values of certain SPRs on wakeup from a
deep-stop state to a desired value. To use this, the Kernel makes an
OPAL call passing the PIR of the CPU, the SPR number and the value to
which the SPR should be restored when that CPU wakes up from a deep
stop state.

Recently, a new feature, named self-save has been enabled in the
stop-api, which is an alternative mechanism to do the same, except
that self-save will save the current content of the SPR before
entering a deep stop state and also restore the content back on
waking up from a deep stop state.

This patch series aims at introducing and leveraging the self-save feature in
the kernel.

Now, as the kernel has a choice to prefer one mode over the other and
there can be registers in both the save/restore SPR list which are sent
from the device tree, a new interface has been defined for the seamless
handing of the modes for each SPR.

A list of preferred SPRs are maintained in the kernel which contains two
properties:
1. supported_mode: Helps in identifying if it strictly supports self
                   save or restore or both.
                   Initialized using the information from device tree.
2. preferred_mode: Calls out what mode is preferred for each SPR. It
                   could be strictly self save or restore, or it can also
                   determine the preference of  mode over the other if both
                   are present by encapsulating the other in bitmask from
                   LSB to MSB.
                   Initialized statically.

Below is a table to show the Scenario::Consequence when the self save and
self restore modes are available or disabled in different combinations as
perceived from the device tree thus giving complete backwards compatibly
regardless of an older firmware running a newer kernel or vise-versa.
Support for self save or self-restore is embedded in the device tree,
along with the set of registers it supports.

SR = Self restore; SS = Self save

.-----------------------------------.----------------------------------------.
|             Scenario              |                Consequence             |
:-----------------------------------+----------------------------------------:
| Legacy Firmware. No SS or SR node | Self restore is called for all         |
|                                   | supported SPRs                         |
:-----------------------------------+----------------------------------------:
| SR: !active SS: !active           | Deep stop states disabled              |
:-----------------------------------+----------------------------------------:
| SR: active SS: !active            | Self restore is called for all         |
|                                   | supported SPRs                         |
:-----------------------------------+----------------------------------------:
| SR: active SS: active             | Goes through the preferences for each  |
|                                   | SPR and executes of the modes          |
|                                   | accordingly. Currently, Self restore is|
|                                   | called for all the SPRs except PSSCR   |
|                                   | which is self saved                    |
:-----------------------------------+----------------------------------------:
| SR: active(only HID0) SS: active  | Self save called for all supported     |
|                                   | registers expect HID0 (as HID0 cannot  |
|                                   | be self saved currently)               |
:-----------------------------------+----------------------------------------:
| SR: !active SS: active            | currently will disable deep states as  |
|                                   | HID0 is needed to be self restored and |
|                                   | cannot be self saved                   |
'-----------------------------------'----------------------------------------'

Pratik Rajesh Sampat (3):
  powerpc/powernv: Interface to define support and preference for a SPR
  powerpc/powernv: Introduce Self save support
  powerpc/powernv: Parse device tree, population of SPR support

 .../bindings/powerpc/opal/power-mgt.txt       |  10 +
 arch/powerpc/include/asm/opal-api.h           |   3 +-
 arch/powerpc/include/asm/opal.h               |   1 +
 arch/powerpc/platforms/powernv/idle.c         | 416 +++++++++++++++---
 arch/powerpc/platforms/powernv/opal-call.c    |   1 +
 5 files changed, 373 insertions(+), 58 deletions(-)

-- 
2.17.1

