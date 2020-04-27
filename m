Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7F5C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9760B2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gBntIUlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgD0IIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:08:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57136 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgD0IIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:08:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03R836vG062365;
        Mon, 27 Apr 2020 08:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=pmiQIvDNHy8LtZslPvKzGmpIjktW4EcjqDLMfhvz3as=;
 b=gBntIUlPfp7ZOc9PxbjRQ1cnNbeACiROBnqbFKhL6yIyg4sIYo83XoMExidBXksFWgCc
 rOQRCyufPAgSP7fHxyUa7UoS3OZLnoBjEZW1AzHfWUQGPEW7pd88LF3+YA5hXWr/4/38
 h400e3ihcD/SBlI1ZCo3Dg2TmR/6OvFKIyq2qFA2u8vJcrh5WYCsiJ/owKm+V6vFNSfO
 Oai8cSYzZrmWherLs/U7O7EhffwEx/yHPTQWgmu3C6yvqhckH9IeZsTmE/F/CrWaAQQb
 mzUOUFX4Rzf2m73sakz+iN2ph0FBMQBnk69ewn+30au5Zy55297f9STJkF/uSu2nfeKy RA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30mcmqw25h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 08:08:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03R882U7175098;
        Mon, 27 Apr 2020 08:08:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30mxrpuh6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 08:08:28 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03R88LAB018697;
        Mon, 27 Apr 2020 08:08:22 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Apr 2020 01:08:21 -0700
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH RFC 3/3] Documentation: x86: microcode: add description for metadata file
Date:   Mon, 27 Apr 2020 10:27:59 +0300
Message-Id: <1587972479-10971-4-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587972479-10971-1-git-send-email-mihai.carabas@oracle.com>
References: <1587972479-10971-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9603 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=1
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9603 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=1 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microcode nowadays may remove of modify certain CPU feature bits. Prior
to this patch the kernel was blindly loading any microcode blob which might
have caused an unrecoverable error (e.g. the kernel was executing an
instruction that was removed). The following patches will process the
metadata file and will know what features are being added/removed/modified
and can take a decision on loading or not the new microcode blob.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 Documentation/x86/microcode.rst | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index a320d37..45e3ae8 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -110,6 +110,42 @@ The loading mechanism looks for microcode blobs in
 /lib/firmware/{intel-ucode,amd-ucode}. The default distro installation
 packages already put them there.
 
+Late loading metadata file
+==========================
+
+New microcode blobs may remove or modify CPU feature bits. Prior to this
+metadata file, the microcode was blindly loaded and might have created an
+unrecoverable error (e.g. remove an instruction used currently in the kernel).
+
+In order to improve visibility on what features a new microcode that is being
+loaded at runtime (late loading) brings in, a new metadata file is created
+together with the microcode blob. The metadata file has the same name as the
+microcode blob with a suffix of ".metadata". The metadata file respects the
+following regular expression: "{m|c} {+|-} u32 [u32]*", where "m" means MSR
+feature and "c" means a CPUID exposed feature.
+
+Here is an example of content for the metadata file::
+   m + 0x00000122
+   m - 0x00000120
+   c + 0x00000007 0x00 0x00000000 0x021cbfbb 0x00000000 0x00000000
+   c - 0x00000007 0x00 0x00000000 0x021cbfbb 0x00000000 0x00000000
+
+The definition of the file format is as follows::
+   - each line contains an action on a CPU feature that the microcode will do
+   - the first letter specify the type of the feature
+   - the second letter specify the operation:
+   -- + - adds the feature
+   -- - - removes the feature
+   - the third letter specifies the index of the CPUID or the MSR
+   - for the CPUID case all the others parameters specifies the
+     leaf, eax, ebx, ecx and edx values
+
+Using this metadata file, the kernel, based on its internal policies, may
+deny a microcode update in order to ensure system stability (e.g. if an
+instruction is removed by the microcode and that instruction is still being
+used by the current code, we would drop the update as it would brake the
+system).
+
 Builtin microcode
 =================
 
-- 
1.8.3.1

