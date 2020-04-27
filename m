Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736F5C5519B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCAF2098B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IVeRpo0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgD0IKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:10:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58904 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0IKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:10:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03R896uw078562;
        Mon, 27 Apr 2020 08:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=V3dV4HI5/iBpkFy0uWsc3l23+oYkKV87jXoYnULnNi8=;
 b=IVeRpo0myI/VzgHl/s1tcU8crZNOCsO3OPPm0GXeGOggql2mDJKyACe/6nSoewt9mKoa
 3zSSX3PghqlC3dCi018qHus8qkrXH7zuPuY1ADaqJFoAYx10c+LRsEQCf/aSDEQbaE8e
 CVW29U3bmDPH6Jpid0z5Bvxk1l+aLaeAA8xBrNYlZr+7pVjcWijEYSi42eFiodWGn4tR
 oZ3EW+b5EAMzBt86YxtAn+E5Oc4i9qst9366IXipYC2MJZMksvYc6mhxLqUQVxX1970U
 xVzOerfo7hVE1+U7OtYVUUKf+mMJR8qKU0rIX0j5uyUtnrBWTpn3CVwd5fb7A/3o7aTD Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30mcmqw2eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 08:10:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03R871Lu172217;
        Mon, 27 Apr 2020 08:08:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30my08nbq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 08:08:28 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03R88Ie3018689;
        Mon, 27 Apr 2020 08:08:18 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Apr 2020 01:08:18 -0700
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH RFC] Microcode late loading feature identification
Date:   Mon, 27 Apr 2020 10:27:56 +0300
Message-Id: <1587972479-10971-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9603 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9603 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC patch set aims to provide a way to identify the modifications
brought in by the new microcode updated at runtime (aka microcode late
loading). This was debated last year and this patch set implements
point #1 from Thomas Gleixner's idea:
https://lore.kernel.org/lkml/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/

This patch set has the following patches:

- patch 1 is introducing a new metadata file that comes with the microcode
(provided by the CPU manufacture) that describes what modifications are
done by loading the new microcode

- patch 2 parses the metadata file and is verifying it against kernel
policy. In this patch, as an RFC, as a kernel policy, it was imposed
the rule of not allowing to remove any feature. If so, it won't be
loaded a new microcode. The policy can be further extended and describe
in different ways

- patch 3 adds the documentation of the metadata file format


How to test:

- place metadata file in /lib/firmware/intel-ucode/ together with the
microcode blob:

[root@ovs108 ~]# ls -l /lib/firmware/intel-ucode
total 96
-rw-r--r--.   1 root root 34816 Mar 11 00:27 06-55-04
-rw-r--r--.   1 root root    84 Mar 25 03:13 06-55-04.metadata

The microcode blob can be taken from the microcode_ctl package.

- after installing the kernel and rebooting the machine run "dracut -f
--no-early-microcode" to create an initramfs without the microcode (and
avoid early loading)

- reboot

- after rebooting issue: echo 1 > /sys/devices/system/cpu/microcode/reload

[root@ovs108 ~]# cat /lib/firmware/intel-ucode/06-55-04.metadata
m - 0x00000122
c + 0x00000007 0x00 0x00000000 0x021cbfbb 0x00000000 0x00000000

[root@ovs108 ~]# echo 1 > /sys/devices/system/cpu/microcode/reload
[root@ovs108 ~]# dmesg | tail -2
[ 1285.729841] microcode: Kernel policy does not allow to remove MSR: 122
[ 1285.737144] microcode: kernel does not support the new microcode: intel-ucode/06-55-04

[root@ovs108 ~]# cat /lib/firmware/intel-ucode/06-55-04.metadata
m + 0x00000122
c + 0x00000007 0x00 0x00000000 0x021cbfbb 0x00000000 0x00000000
[root@ovs108 ~]# echo 1 > /sys/devices/system/cpu/microcode/reload
[root@ovs108 ~]# dmesg | tail -10
[ 1220.212415] microcode: updated to revision 0x2000065, date = 2019-09-05
[ 1220.212645] microcode: Reload completed, microcode revision: 0x2000065

Mihai Carabas (3):
  x86: microcode: intel: read microcode metadata file
  x86: microcode: intel: process microcode metadata
  Documentation: x86: microcode: add description for metadata file

 Documentation/x86/microcode.rst       | 36 +++++++++++++
 arch/x86/kernel/cpu/microcode/intel.c | 97 +++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

-- 
1.8.3.1

