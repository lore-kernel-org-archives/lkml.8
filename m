Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195A3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8496233F6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597677814;
	bh=i8CA6/j1VbHk5HL5gl8INswoxQFjy/h3zO5JJS8sS7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K1HyzxYbLLLedxrsEdGtI/JroTvL4AFYxN/2b/swhAL3N536US3D/kS3qHC+MuJ7L
	 /KZo99wuKpHu+YVKJQzs0VmoxFpPuGGcRYVSG9cRhcJQsWzB+lKI1b6Bb4rn/TiOFY
	 leaQunHUuW6YKcmRapyDOU00qmBk1KpPr3c8T+kM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgHQPXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbgHQPWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:22:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F6720709;
        Mon, 17 Aug 2020 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677739;
        bh=i8CA6/j1VbHk5HL5gl8INswoxQFjy/h3zO5JJS8sS7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yBf8Ij2mDDZJZlt1SvOdAp53Ie0019JkJQcVgPH+b1zFoUPWr4//v8L5qL2MookaS
         0dBT7etaUPQfh1QFHC1xXdWqrpw4Ndlm7jA5R+H0DZUkXHAPG2C0+V6Zzw1OeMXUVJ
         eZoTJcka7bb/fLv1wCbVc1MXA+jVF7jSg4xhIiA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 059/464] scripts/selinux/mdp: fix initial SID handling
Date:   Mon, 17 Aug 2020 17:10:12 +0200
Message-Id: <20200817143836.591463966@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Smalley <stephen.smalley.work@gmail.com>

[ Upstream commit 382c2b5d23b4245f1818f69286db334355488dc4 ]

commit e3e0b582c321 ("selinux: remove unused initial SIDs and improve
handling") broke scripts/selinux/mdp since the unused initial SID names
were removed and the corresponding generation of policy initial SID
definitions by mdp was not updated accordingly.  Fix it.  With latest
upstream checkpolicy it is no longer necessary to include the SID context
definitions for the unused initial SIDs but retain them for compatibility
with older checkpolicy.

Fixes: e3e0b582c321 ("selinux: remove unused initial SIDs and improve handling")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/selinux/mdp/mdp.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
index 576d11a60417b..6ceb88eb9b590 100644
--- a/scripts/selinux/mdp/mdp.c
+++ b/scripts/selinux/mdp/mdp.c
@@ -67,8 +67,14 @@ int main(int argc, char *argv[])
 
 	initial_sid_to_string_len = sizeof(initial_sid_to_string) / sizeof (char *);
 	/* print out the sids */
-	for (i = 1; i < initial_sid_to_string_len; i++)
-		fprintf(fout, "sid %s\n", initial_sid_to_string[i]);
+	for (i = 1; i < initial_sid_to_string_len; i++) {
+		const char *name = initial_sid_to_string[i];
+
+		if (name)
+			fprintf(fout, "sid %s\n", name);
+		else
+			fprintf(fout, "sid unused%d\n", i);
+	}
 	fprintf(fout, "\n");
 
 	/* print out the class permissions */
@@ -126,9 +132,16 @@ int main(int argc, char *argv[])
 #define OBJUSERROLETYPE "user_u:object_r:base_t"
 
 	/* default sids */
-	for (i = 1; i < initial_sid_to_string_len; i++)
-		fprintf(fout, "sid %s " SUBJUSERROLETYPE "%s\n",
-			initial_sid_to_string[i], mls ? ":" SYSTEMLOW : "");
+	for (i = 1; i < initial_sid_to_string_len; i++) {
+		const char *name = initial_sid_to_string[i];
+
+		if (name)
+			fprintf(fout, "sid %s ", name);
+		else
+			fprintf(fout, "sid unused%d\n", i);
+		fprintf(fout, SUBJUSERROLETYPE "%s\n",
+			mls ? ":" SYSTEMLOW : "");
+	}
 	fprintf(fout, "\n");
 
 #define FS_USE(behavior, fstype)			    \
-- 
2.25.1



