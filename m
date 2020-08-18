Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EBFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 04:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C4D2072A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 04:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b6JBC6ow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgHREEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 00:04:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbgHREEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 00:04:53 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07I42kRk047090;
        Tue, 18 Aug 2020 00:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FT33P4zUZlwDZpiU3UIEzMVhQe4g4tz9J+Lij2nb/rY=;
 b=b6JBC6owz/1qct96Dy1FzBYkjiMwlP669FTwAhuEOT7lOGxQz1mUKOV6TT0JUqF4xOOg
 t+35bLGp5fUjOGVllZX4ViTIQfm8Wl3ZTGSoOoydJ1h3FJ8luuEv7HtgCLpwboW5TMkG
 B/1rWaCHJ4Zuy3HTnfeUJpWt5BpWCICF5RmHJ58KrbL369o2xTllPKxEnJvFmZcy/4ge
 IQpiUIodqwjuih5d20Xo2eRLTeSj4e8+c0P23ZWFFt9HxBqBWPwEOIojvlbk8eWbn0vc
 Rx+hCOBjvc7SJ09eludWbnx1FWyiva0sk+KcLjwdva0hG6aOQ/oiozjIzMGN/vVRyihq tw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3304rsunkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 00:04:46 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07I40LHx030549;
        Tue, 18 Aug 2020 04:04:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3304bbr3aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 04:04:43 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07I43C5822020404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 04:03:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46BE6AE053;
        Tue, 18 Aug 2020 04:04:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64EEDAE045;
        Tue, 18 Aug 2020 04:04:40 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.217])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Aug 2020 04:04:40 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/2] proc: Add struct mount & struct super_block addr in lx-mounts command
Date:   Tue, 18 Aug 2020 09:34:30 +0530
Message-Id: <af4d266dd2d6b45403feca45395e3146a6f497cd.1597721575.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1597721575.git.riteshh@linux.ibm.com>
References: <cover.1597721575.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_01:2020-08-17,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=749 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is many times found useful while debugging some FS related issue.

<e.g. output>
      mount          super_block      fstype devname pathname options
0xffff888a0bfa4b40 0xffff888a0bfc1000 rootfs none / rw   0 0
0xffff888a02c065c0 0xffff8889fcf65000 ext4 /dev/root / rw  ,relatime 0 0
0xffff8889fc8cc040 0xffff888a0bb51000 devtmpfs devtmpfs /dev rw  ,relatime 0 0

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 scripts/gdb/linux/proc.py | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
index 6a56bba233a9..c16fab981bdd 100644
--- a/scripts/gdb/linux/proc.py
+++ b/scripts/gdb/linux/proc.py
@@ -167,6 +167,9 @@ values of that process namespace"""
         if not namespace:
             raise gdb.GdbError("No namespace for current process")
 
+        gdb.write("{:^18} {:^15} {:>9} {} {} options\n".format(
+                  "mount", "super_block", "fstype", "devname", "pathname"))
+
         for vfs in lists.list_for_each_entry(namespace['list'],
                                              mount_ptr_type, "mnt_list"):
             devname = vfs['mnt_devname'].string()
@@ -190,14 +193,10 @@ values of that process namespace"""
             m_flags = int(vfs['mnt']['mnt_flags'])
             rd = "ro" if (s_flags & constants.LX_SB_RDONLY) else "rw"
 
-            gdb.write(
-                "{} {} {} {}{}{} 0 0\n"
-                .format(devname,
-                        pathname,
-                        fstype,
-                        rd,
-                        info_opts(FS_INFO, s_flags),
-                        info_opts(MNT_INFO, m_flags)))
+            gdb.write("{} {} {} {} {} {} {} {} 0 0\n".format(
+                      vfs.format_string(), superblock.format_string(), fstype,
+                      devname, pathname, rd, info_opts(FS_INFO, s_flags),
+                      info_opts(MNT_INFO, m_flags)))
 
 
 LxMounts()
-- 
2.25.4

