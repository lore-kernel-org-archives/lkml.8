Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B727AC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D55B20637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KX3p6IR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgCKDV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:21:59 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2076 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgCKDV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:21:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e6859290000>; Tue, 10 Mar 2020 20:21:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 10 Mar 2020 20:21:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 10 Mar 2020 20:21:58 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Mar
 2020 03:21:57 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Mar 2020 03:21:57 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e6859550000>; Tue, 10 Mar 2020 20:21:57 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <christian.brauner@ubuntu.com>
CC:     Linux Next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] pid: fix uninitialized retval in alloc_pid()
Date:   Tue, 10 Mar 2020 20:21:53 -0700
Message-ID: <20200311032153.431492-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583896873; bh=aNbMTHzEBed2jLOkpeGMmsEaPHwGzRfzqOjyErWK5uk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=KX3p6IR6m/cQXjuSydvF0pEZ0gTdkgVJTOLRSOdojHLdH5cQZk+I1nwGRl7Kg3Kcx
         +eHwLyP6kuBpa7FnsUx7RtImMfZi1udoigiyeUtkKskqhxifRO4MYg01M0jc0qFiOe
         Z5FQvDYPOfdRrMdvcbnPl94iuMROFDiRBShgbJNnsVaDn3IfhjEHulDKNfTpfOVJsr
         mizltKbR1xzsUzhDYx0ENA8xRQkz3zWcK4ZAaDkLNq2pfAGov0hIV0glXu6Y3o903p
         /wRm1fGcK/W0WgG32Hf3STT45EgDarQKBrCareLKlyLOCH5ZnFCqYdXcdwSkq6EBd2
         r0E2TKg4ssdYw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8deb24dcb89cb ("pid: make ENOMEM return value more obvious")
left the return value uninitialized in one error case. The justification
for the above commit included a statement that retval is "initialized on
ever[y] failure path in the loop". However, that is not quite good
enough because there is an earlier case that is before the loop. And
also, it's more maintenance and merge-safe to initialize it once at the
top, as evidenced by this build warning that we now have.

Therefore, restore the top-level initialization of retval.

Also move the descriptive comment up, and remove the now-redundant
later initialization of retval.

Fixes: 8deb24dcb89cb ("pid: make ENOMEM return value more obvious")
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 kernel/pid.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index ff6cd6786d10..49bf6dd32de4 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -162,7 +162,16 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t =
*set_tid,
 	int i, nr;
 	struct pid_namespace *tmp;
 	struct upid *upid;
-	int retval;
+
+	/*
+	 * ENOMEM is not the most obvious choice especially for the case
+	 * where the child subreaper has already exited and the pid
+	 * namespace denies the creation of any new processes. But ENOMEM
+	 * is what we have exposed to userspace for a long time and it is
+	 * documented behavior for pid namespaces. So we can't easily
+	 * change it even if there were an error code better suited.
+	 */
+	int retval =3D -ENOMEM;
=20
 	/*
 	 * set_tid_size contains the size of the set_tid array. Starting at
@@ -244,16 +253,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t =
*set_tid,
 		tmp =3D tmp->parent;
 	}
=20
-	/*
-	 * ENOMEM is not the most obvious choice especially for the case
-	 * where the child subreaper has already exited and the pid
-	 * namespace denies the creation of any new processes. But ENOMEM
-	 * is what we have exposed to userspace for a long time and it is
-	 * documented behavior for pid namespaces. So we can't easily
-	 * change it even if there were an error code better suited.
-	 */
-	retval =3D -ENOMEM;
-
 	get_pid_ns(ns);
 	refcount_set(&pid->count, 1);
 	for (type =3D 0; type < PIDTYPE_MAX; ++type)

base-commit: 134546626849cd6852d6d4bf8f207b5fbc54261b
--=20
2.25.1

