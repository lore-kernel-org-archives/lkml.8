Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D725C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBECB20829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="Ik/dePyz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovfYQGFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgIBOuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:50:15 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57659 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbgIBOK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:10:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A92C95804E0;
        Wed,  2 Sep 2020 10:10:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 10:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=7PqQE5cZt4VblhYOFjuBF76nPi
        qQ+OY9NWSl6QlW+yY=; b=Ik/dePyzFb9DjEnkX6mBpWhIC5q8lnvR7KVTQIhzNG
        ZX2MHIsErogNQbToOA0wgSzuT7MzW5m7VEFc8abaQZJbuKAqAMjb8Kche59WgD11
        nJZR+XvWL5Fmn5XoOF8Tsfr2MbFOtNYvnieUMhu0KwODBMLA5/gH8UhNphCiB3CN
        POs3ngjUw1sbJpVWCj6gPaFsh6mrHwN6yIHCPp6KJ2N7a+4oeBS6yIX7ZK1WnT40
        zsJRUC7XtoQ+//WLplFUPUHhHn8qfDdwHRWR7HqQ/OOk1WUuLdC1+Zh95kty4Ia5
        kc62Q2Ayj3aK+ampuMg8ukY9Ykl6C4nYUmtg6e2ULeMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7PqQE5cZt4VblhYOF
        juBF76nPiqQ+OY9NWSl6QlW+yY=; b=ovfYQGFGto3wTFfVtbTt5ITF4AHVGlqi3
        etwi4cd9+FDTy+yPbYqDlyKu0G9CTQ9czZmUlN05KMAXuSN6F5OtPd04GTp73jcc
        RngsOPJzWvkd9X9H1EQINNwuBHIzyyQNXtrxpkMIK6vufY+afa99C26VSGNu3fCT
        FdQhXwSUj/wzdluhVJSvQ7iZ6eVbYe6v0pwDKzgznk2uD4HLT9tH1wtUbTni3ukY
        qZiAGmBflvuKJ7SL2E5cre65xzTBCdhkrsMxAMQaocsCvejMVV5xUlDverK0Ip/B
        BBIE9k+TUu1gqyhApyD1e5mHlITPsdavqIRMIfMboMw2UOqCHCFhw==
X-ME-Sender: <xms:uadPX3BX95NtbpswHaB2B4hL4ifHjT1JZc8bcbYRzdeTIR1NpVVe_Q>
    <xme:uadPX9j2FDxgwoeFWSupTqGDFyNcHdTqKttGMbPh4K80C9xfAoFE3c6UpgBX6pPgp
    Lt71AmXIuj3R7RZc08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhigthhhoucet
    nhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrghtth
    gvrhhnpeelveehveejgefgkedttedvteffgfelfeeuveduteelvdduhefhjeetjeehheel
    keenucfkphepuddvkedruddtjedrvdeguddrudejkeenucfuphgrmhfkphfpvghtfihorh
    hkpeduvdekrddutdejrddvgedurddujeeknecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:uadPXymCM0E46r2hSP4V-HbjLZ7mZcA1egQTM-cG1o1YmFY9Njin3A>
    <xmx:uadPX5ytjtpYMW5jPtc_bH_MCmWlGBZj4YEtzhOvSZ1t2znzTzzzew>
    <xmx:uadPX8TXzc5xYLhPNy09UZAJ5dkuTDnOJ8bj2oW53Mz-IfZXdNhKbg>
    <xmx:uqdPX3eZqinJZMiY8ir1iuPTMbNQdCgXaMWK4gpHmazZlfDxiiXhp8FbYnw>
Received: from cisco.hsd1.co.comcast.net (unknown [128.107.241.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0A334306005F;
        Wed,  2 Sep 2020 10:09:59 -0400 (EDT)
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] seccomp: don't leave dangling ->notif if file allocation fails
Date:   Wed,  2 Sep 2020 08:09:53 -0600
Message-Id: <20200902140953.1201956-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian and Kees both pointed out that this is a bit sloppy to open-code
both places, and Christian points out that we leave a dangling pointer to
->notif if file allocation fails. Since we check ->notif for null in order
to determine if it's ok to install a filter, this means people won't be
able to install a filter if the file allocation fails for some reason, even
if they subsequently should be able to.

To fix this, let's hoist this free+null into its own little helper and use
it.

Reported-by: Kees Cook <keescook@chromium.org>
Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
---
 kernel/seccomp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index bb0dd9ae699a..676d4af62103 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1109,6 +1109,12 @@ static long seccomp_set_mode_strict(void)
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
+static void seccomp_notify_free(struct seccomp_filter *filter)
+{
+	kfree(filter->notif);
+	filter->notif = NULL;
+}
+
 static void seccomp_notify_detach(struct seccomp_filter *filter)
 {
 	struct seccomp_knotif *knotif;
@@ -1138,8 +1144,7 @@ static void seccomp_notify_detach(struct seccomp_filter *filter)
 		complete(&knotif->ready);
 	}
 
-	kfree(filter->notif);
-	filter->notif = NULL;
+	seccomp_notify_free(filter);
 	mutex_unlock(&filter->notify_lock);
 }
 
@@ -1494,7 +1499,7 @@ static struct file *init_listener(struct seccomp_filter *filter)
 
 out_notif:
 	if (IS_ERR(ret))
-		kfree(filter->notif);
+		seccomp_notify_free(filter);
 out:
 	return ret;
 }

base-commit: 7b6aa0bb62fd6fd50f2d14136136262d28fb2dfe
-- 
2.25.1

