Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919D4C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61309206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgDWFed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 01:34:33 -0400
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:52231 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbgDWFed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 01:34:33 -0400
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.147) BY m4a0073g.houston.softwaregrp.com WITH ESMTP;
 Thu, 23 Apr 2020 05:32:15 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 23 Apr 2020 05:33:32 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 23 Apr 2020 05:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9I6cvTzDKnhipYQwOUSjCh2qeRsyTjBSpnDFNEv8vGYiiks+6Z2o80FEZN+jC9gvlXdk3qCq9/GgDJUSrlB7kRVHk5JGRha/uCLosZ3IB34FGbE0FujWK43WjEY9IxqTq/AsDEs17w73yHxylKkLJJs2W64OoJWOsOaOlM+MYN5JTwzz1eMlZ29XrWyQzZdWFk9iE2NdAcZgk4ru62dRpRszc77Du9EY0YzU2h1JBbEpmtcG32LK9EJ81X4eetIwvLxLowcu265DR/zFfGpweT1npK/A54WN8P/Wz1ibp78unExMPJEb2qEfi3q/Yfj7GbNvE2GO1V/Cpa6oTAnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tKcdUviP8aVMryiBqRSB4Z9Qp88tu5+LbcqI834jrY=;
 b=Jn2bmjHP5MnNGEfzxHwUQox7CIrUgOhjZ0hlmQaE0RL27cAI717eW9ryb7E3q4Z6TDKW53Ewa2CggFqGVDi9qoBZO503b3Hklldmy96zl7Djw/aa0a8nhA+BOE1/De0AcBlRGy9RVXfjFlcD8PeFGVK+A9s2VNCcJ+ROx6vXdShwlyupTKRq7gCmaXkZ09ojpaap3JGkFgbZGBmKja6hbfEW8ltlpGzYt245OFZYCpwe1ZdPVcnFOvqUQmK3KBlsL1s0QTEF26YobvkXHIYGHaZNb+as+8gPrXOd+GuKCSlE7I9eIQzBUEUT1g5tVtD/UIwXSgnfy0gYRXveKzJ6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=GHe@suse.com; 
Received: from CH2PR18MB3206.namprd18.prod.outlook.com (2603:10b6:610:14::15)
 by CH2PR18MB3430.namprd18.prod.outlook.com (2603:10b6:610:2e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 05:33:30 +0000
Received: from CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::f0d5:5de3:82c0:6b8a]) by CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::f0d5:5de3:82c0:6b8a%4]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 05:33:30 +0000
From:   Gang He <ghe@suse.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>,
        <joseph.qi@linux.alibaba.com>
CC:     Gang He <ghe@suse.com>, <linux-kernel@vger.kernel.org>,
        <ocfs2-devel@oss.oracle.com>, <akpm@linux-foundation.org>
Subject: [PATCH] ocfs2: mount shared volume without ha stack
Date:   Thu, 23 Apr 2020 13:33:00 +0800
Message-ID: <20200423053300.22661-1-ghe@suse.com>
X-Mailer: git-send-email 2.12.3
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::27) To CH2PR18MB3206.namprd18.prod.outlook.com
 (2603:10b6:610:14::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ghe-pc.suse.asia (45.122.156.254) by MAXPR0101CA0017.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 05:33:26 +0000
X-Mailer: git-send-email 2.12.3
X-Originating-IP: [45.122.156.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03d2ef94-5bba-4379-b6cd-08d7e747daf9
X-MS-TrafficTypeDiagnostic: CH2PR18MB3430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR18MB3430AA180347601D213D0C14CFD30@CH2PR18MB3430.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR18MB3206.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(956004)(6512007)(5660300002)(8936002)(81156014)(316002)(26005)(478600001)(186003)(6506007)(36756003)(52116002)(6486002)(2906002)(2616005)(86362001)(16526019)(66476007)(4326008)(6666004)(66556008)(66946007)(1076003)(8676002)(16060500001);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLQsqIe9STndH7yh+zC5f17xwMMz9gSnmi2uFn4SrpNNyheHo5OGMj8f95W2Rq66Ov6MLJJIOR5WqOB5y99cGWpbFwMRg8fOych4ps/QKj4ffCF427ZHifG1Yy0kT+cj5SSga2g45HeXoMMMnNaXDRuUhf2D2u0Mf5Ur5rZDjEvrupB6wWGor23v1T1CwWFFKzyEQEM0Ch6ycAK2TuAX1mhWE8757m4RBCmF8VX0mu0phNTzcmr1w36msP2QWSVIKJzFFqMCBLe3hdYrRgQz+o7zCc6sovOH2SiE8B17Tt6aVBI7xeuQOVmpMjbVoVfU0u2/9oHxk3HUi8fOE98VbdpzmHwRgwMpjVkjCry1aeMjl6k+cFwOJc0CR0x3tQM5bMz+m48jK34lmMdCw1VieZe5Rqyp63oV52khbFrLSVXrepTiP954B9ufsTIf10Irm2uU517sMxhaRF78rK0YwIfZYUZ61g5OR7oAVVancVAkOkQimexUo0R0noTPe45O
X-MS-Exchange-AntiSpam-MessageData: nXtKyfBWcTIWXd7tG0GuADVx87Z2EkMZ5S5mVAPWKMzHpw/Em1CzoCKzMoWSNWmkNvWeIurTx++VidqLbN/dbInG49htdiuEJW6LAzGlWZ0VB6uNKXBNargt2jk3SL1FH0Nf9Ho5ceLG24RRWnnrog==
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d2ef94-5bba-4379-b6cd-08d7e747daf9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 05:33:30.2924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1s8ojJVPWt5CoMqWMpaRPmp1E7EjuWRsp9aoiILVPM6a0ufLz3rJcmTbIBbPkPaj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3430
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually we create and use a ocfs2 shared volume on the top of
ha stack. For pcmk based ha stack, which includes DLM, corosync
and pacemaker services.
The customers complained they could not mount existent ocfs2
volume in the single node without ha stack, e.g. single node
backup/restore scenario.
Like this case, the customers just want to access the data
from the existent ocfs2 volume quickly, but do not want to
restart or setup ha stack.
Then, I'd like to add a mount option "nocluster", if the users
use this option to mount a ocfs2 shared volume, the whole mount
will not depend on the ha related services. the command will mount
the existent ocfs2 volume directly (like local mount), for avoiding
setup the ha stack.

Signed-off-by: Gang He <ghe@suse.com>
---
 fs/ocfs2/ocfs2.h    |  4 +++-
 fs/ocfs2/slot_map.c | 46 ++++++++++++++++++++++++++-------------------
 fs/ocfs2/super.c    | 21 +++++++++++++++++++++
 3 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 9150cfa4df7d..ee5d98516212 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -279,6 +279,7 @@ enum ocfs2_mount_options
 	OCFS2_MOUNT_JOURNAL_ASYNC_COMMIT = 1 << 15,  /* Journal Async Commit */
 	OCFS2_MOUNT_ERRORS_CONT = 1 << 16, /* Return EIO to the calling process on error */
 	OCFS2_MOUNT_ERRORS_ROFS = 1 << 17, /* Change filesystem to read-only on error */
+	OCFS2_MOUNT_NOCLUSTER = 1 << 18, /* No cluster aware filesystem mount */
 };
 
 #define OCFS2_OSB_SOFT_RO	0x0001
@@ -673,7 +674,8 @@ static inline int ocfs2_cluster_o2cb_global_heartbeat(struct ocfs2_super *osb)
 
 static inline int ocfs2_mount_local(struct ocfs2_super *osb)
 {
-	return (osb->s_feature_incompat & OCFS2_FEATURE_INCOMPAT_LOCAL_MOUNT);
+	return ((osb->s_feature_incompat & OCFS2_FEATURE_INCOMPAT_LOCAL_MOUNT)
+		|| (osb->s_mount_opt & OCFS2_MOUNT_NOCLUSTER));
 }
 
 static inline int ocfs2_uses_extended_slot_map(struct ocfs2_super *osb)
diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
index 8caeceeaeda7..4da0e4b1e79b 100644
--- a/fs/ocfs2/slot_map.c
+++ b/fs/ocfs2/slot_map.c
@@ -254,14 +254,16 @@ static int __ocfs2_find_empty_slot(struct ocfs2_slot_info *si,
 	int i, ret = -ENOSPC;
 
 	if ((preferred >= 0) && (preferred < si->si_num_slots)) {
-		if (!si->si_slots[preferred].sl_valid) {
+		if (!si->si_slots[preferred].sl_valid ||
+		    !si->si_slots[preferred].sl_node_num) {
 			ret = preferred;
 			goto out;
 		}
 	}
 
 	for(i = 0; i < si->si_num_slots; i++) {
-		if (!si->si_slots[i].sl_valid) {
+		if (!si->si_slots[i].sl_valid ||
+		    !si->si_slots[i].sl_node_num) {
 			ret = i;
 			break;
 		}
@@ -456,24 +458,30 @@ int ocfs2_find_slot(struct ocfs2_super *osb)
 	spin_lock(&osb->osb_lock);
 	ocfs2_update_slot_info(si);
 
-	/* search for ourselves first and take the slot if it already
-	 * exists. Perhaps we need to mark this in a variable for our
-	 * own journal recovery? Possibly not, though we certainly
-	 * need to warn to the user */
-	slot = __ocfs2_node_num_to_slot(si, osb->node_num);
-	if (slot < 0) {
-		/* if no slot yet, then just take 1st available
-		 * one. */
-		slot = __ocfs2_find_empty_slot(si, osb->preferred_slot);
+	if (ocfs2_mount_local(osb))
+		/* use slot 0 directly in local mode */
+		slot = 0;
+	else {
+		/* search for ourselves first and take the slot if it already
+		 * exists. Perhaps we need to mark this in a variable for our
+		 * own journal recovery? Possibly not, though we certainly
+		 * need to warn to the user */
+		slot = __ocfs2_node_num_to_slot(si, osb->node_num);
 		if (slot < 0) {
-			spin_unlock(&osb->osb_lock);
-			mlog(ML_ERROR, "no free slots available!\n");
-			status = -EINVAL;
-			goto bail;
-		}
-	} else
-		printk(KERN_INFO "ocfs2: Slot %d on device (%s) was already "
-		       "allocated to this node!\n", slot, osb->dev_str);
+			/* if no slot yet, then just take 1st available
+			 * one. */
+			slot = __ocfs2_find_empty_slot(si, osb->preferred_slot);
+			if (slot < 0) {
+				spin_unlock(&osb->osb_lock);
+				mlog(ML_ERROR, "no free slots available!\n");
+				status = -EINVAL;
+				goto bail;
+			}
+		} else
+			printk(KERN_INFO "ocfs2: Slot %d on device (%s) was "
+			       "already allocated to this node!\n",
+			       slot, osb->dev_str);
+	}
 
 	ocfs2_set_slot(si, slot, osb->node_num);
 	osb->slot_num = slot;
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index ac61eeaf3837..71ea9ce71a6b 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -175,6 +175,7 @@ enum {
 	Opt_dir_resv_level,
 	Opt_journal_async_commit,
 	Opt_err_cont,
+	Opt_nocluster,
 	Opt_err,
 };
 
@@ -208,6 +209,7 @@ static const match_table_t tokens = {
 	{Opt_dir_resv_level, "dir_resv_level=%u"},
 	{Opt_journal_async_commit, "journal_async_commit"},
 	{Opt_err_cont, "errors=continue"},
+	{Opt_nocluster, "nocluster"},
 	{Opt_err, NULL}
 };
 
@@ -619,6 +621,13 @@ static int ocfs2_remount(struct super_block *sb, int *flags, char *data)
 		goto out;
 	}
 
+	tmp = OCFS2_MOUNT_NOCLUSTER;
+	if ((osb->s_mount_opt & tmp) != (parsed_options.mount_opt & tmp)) {
+		ret = -EINVAL;
+		mlog(ML_ERROR, "Cannot change nocluster option on remount\n");
+		goto out;
+	}
+
 	tmp = OCFS2_MOUNT_HB_LOCAL | OCFS2_MOUNT_HB_GLOBAL |
 		OCFS2_MOUNT_HB_NONE;
 	if ((osb->s_mount_opt & tmp) != (parsed_options.mount_opt & tmp)) {
@@ -859,6 +868,7 @@ static int ocfs2_verify_userspace_stack(struct ocfs2_super *osb,
 	}
 
 	if (ocfs2_userspace_stack(osb) &&
+	    !(osb->s_mount_opt & OCFS2_MOUNT_NOCLUSTER) &&
 	    strncmp(osb->osb_cluster_stack, mopt->cluster_stack,
 		    OCFS2_STACK_LABEL_LEN)) {
 		mlog(ML_ERROR,
@@ -1139,6 +1149,11 @@ static int ocfs2_fill_super(struct super_block *sb, void *data, int silent)
 	       osb->s_mount_opt & OCFS2_MOUNT_DATA_WRITEBACK ? "writeback" :
 	       "ordered");
 
+	if ((osb->s_mount_opt & OCFS2_MOUNT_NOCLUSTER) &&
+	   !(osb->s_feature_incompat & OCFS2_FEATURE_INCOMPAT_LOCAL_MOUNT))
+		printk(KERN_NOTICE "ocfs2: The shared device (%s) is mounted "
+		       "without cluster aware mode.\n", osb->dev_str);
+
 	atomic_set(&osb->vol_state, VOLUME_MOUNTED);
 	wake_up(&osb->osb_mount_event);
 
@@ -1445,6 +1460,9 @@ static int ocfs2_parse_options(struct super_block *sb,
 		case Opt_journal_async_commit:
 			mopt->mount_opt |= OCFS2_MOUNT_JOURNAL_ASYNC_COMMIT;
 			break;
+		case Opt_nocluster:
+			mopt->mount_opt |= OCFS2_MOUNT_NOCLUSTER;
+			break;
 		default:
 			mlog(ML_ERROR,
 			     "Unrecognized mount option \"%s\" "
@@ -1556,6 +1574,9 @@ static int ocfs2_show_options(struct seq_file *s, struct dentry *root)
 	if (opts & OCFS2_MOUNT_JOURNAL_ASYNC_COMMIT)
 		seq_printf(s, ",journal_async_commit");
 
+	if (opts & OCFS2_MOUNT_NOCLUSTER)
+		seq_printf(s, ",nocluster");
+
 	return 0;
 }
 
-- 
2.21.0

