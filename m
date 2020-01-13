Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3322BC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A62207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgAMLeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:34:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728769AbgAMLeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:34:06 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DBXqKN134190
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 06:34:05 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xfve898mu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 06:34:05 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Mon, 13 Jan 2020 11:33:27 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Jan 2020 11:33:24 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00DBXNHF50855982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 11:33:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B2A45204F;
        Mon, 13 Jan 2020 11:33:23 +0000 (GMT)
Received: from pratiks-thinkpad.in.ibm.com (unknown [9.124.31.88])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 72F355204E;
        Mon, 13 Jan 2020 11:33:21 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, svaidy@linux.ibm.com, ego@linux.vnet.ibm.com,
        linuxram@us.ibm.com, psampat@linux.ibm.com,
        pratik.sampat@in.ibm.com, pratik.r.sampat@gmail.com
Subject: [PATCH v3 0/3] Introduce Self-Save API for deep stop states
Date:   Mon, 13 Jan 2020 17:03:17 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011311-0028-0000-0000-000003D0A08C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011311-0029-0000-0000-00002494BE3A
Message-Id: <cover.1578914462.git.psampat@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_03:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=792 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001130097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skiboot patches: https://patchwork.ozlabs.org/patch/1221011/
v2 patches: https://lkml.org/lkml/2020/1/12/253
Changelog
Patch v2 --> v3
1. Addressed minor comments from Ram Pai

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

 arch/powerpc/include/asm/opal-api.h        |   3 +-
 arch/powerpc/include/asm/opal.h            |   1 +
 arch/powerpc/platforms/powernv/idle.c      | 442 ++++++++++++++++++---
 arch/powerpc/platforms/powernv/opal-call.c |   1 +
 4 files changed, 389 insertions(+), 58 deletions(-)

-- 
2.24.1

