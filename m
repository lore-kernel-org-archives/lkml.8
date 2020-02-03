Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520C1C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2992920838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748259;
	bh=nQ07RDAiC3+NI9ia5iDD9qRPO/t8Hv9eu60i7KhDezE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RY/Ln1Q3QgRMspssYgVHrC+y5yQLfC45G41CiyCmBRZbf5Zxpzb1GOuA8/1G98SZY
	 AwbdCTJiuIdcutIl05Z3eTudBCuvsaI7VidIZGN0UqyjiTZ09dFlILkXgXiy7zHVJ7
	 XH56XXt9Mtj84mRF2y46H6TM/vJoKh3eM8WjzsaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgBCQbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:31:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730291AbgBCQbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:31:47 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E5B2051A;
        Mon,  3 Feb 2020 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747506;
        bh=nQ07RDAiC3+NI9ia5iDD9qRPO/t8Hv9eu60i7KhDezE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rSATkHWGXcjlg2tkpQ2XUfjBkHXlufj8B0lzC1MQub6HiC5KVHEq2BHuZrk19xytC
         ArEf2LxRcbm84Fc719gbqw8ppMtOWYeD+245ok6jn/YnygfNpV09NH2ACH0pAJh0tt
         /elh7kTkgugIV1NWZ4bLOhCRihOz2ouhN1qpNQ3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+5493b2a54d31d6aea629@syzkaller.appspotmail.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.19 23/70] cgroup: Prevent double killing of css when enabling threaded cgroup
Date:   Mon,  3 Feb 2020 16:19:35 +0000
Message-Id: <20200203161915.970688753@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Koutný <mkoutny@suse.com>

commit 3bc0bb36fa30e95ca829e9cf480e1ef7f7638333 upstream.

The test_cgcore_no_internal_process_constraint_on_threads selftest when
running with subsystem controlling noise triggers two warnings:

> [  597.443115] WARNING: CPU: 1 PID: 28167 at kernel/cgroup/cgroup.c:3131 cgroup_apply_control_enable+0xe0/0x3f0
> [  597.443413] WARNING: CPU: 1 PID: 28167 at kernel/cgroup/cgroup.c:3177 cgroup_apply_control_disable+0xa6/0x160

Both stem from a call to cgroup_type_write. The first warning was also
triggered by syzkaller.

When we're switching cgroup to threaded mode shortly after a subsystem
was disabled on it, we can see the respective subsystem css dying there.

The warning in cgroup_apply_control_enable is harmless in this case
since we're not adding new subsys anyway.
The warning in cgroup_apply_control_disable indicates an attempt to kill
css of recently disabled subsystem repeatedly.

The commit prevents these situations by making cgroup_type_write wait
for all dying csses to go away before re-applying subtree controls.
When at it, the locations of WARN_ON_ONCE calls are moved so that
warning is triggered only when we are about to misuse the dying css.

Reported-by: syzbot+5493b2a54d31d6aea629@syzkaller.appspotmail.com
Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/cgroup/cgroup.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2940,8 +2940,6 @@ static int cgroup_apply_control_enable(s
 		for_each_subsys(ss, ssid) {
 			struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
 
-			WARN_ON_ONCE(css && percpu_ref_is_dying(&css->refcnt));
-
 			if (!(cgroup_ss_mask(dsct) & (1 << ss->id)))
 				continue;
 
@@ -2951,6 +2949,8 @@ static int cgroup_apply_control_enable(s
 					return PTR_ERR(css);
 			}
 
+			WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
+
 			if (css_visible(css)) {
 				ret = css_populate_dir(css);
 				if (ret)
@@ -2986,11 +2986,11 @@ static void cgroup_apply_control_disable
 		for_each_subsys(ss, ssid) {
 			struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
 
-			WARN_ON_ONCE(css && percpu_ref_is_dying(&css->refcnt));
-
 			if (!css)
 				continue;
 
+			WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
+
 			if (css->parent &&
 			    !(cgroup_ss_mask(dsct) & (1 << ss->id))) {
 				kill_css(css);
@@ -3277,7 +3277,8 @@ static ssize_t cgroup_type_write(struct
 	if (strcmp(strstrip(buf), "threaded"))
 		return -EINVAL;
 
-	cgrp = cgroup_kn_lock_live(of->kn, false);
+	/* drain dying csses before we re-apply (threaded) subtree control */
+	cgrp = cgroup_kn_lock_live(of->kn, true);
 	if (!cgrp)
 		return -ENOENT;
 


