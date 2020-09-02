Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FAFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA262068F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="HL4tuH9+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FEwcU1tY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgIBBmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:42:50 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:34919 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726131AbgIBBlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:41:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4C737580484;
        Tue,  1 Sep 2020 21:40:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Sep 2020 21:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=vG7EGPCMURsU6YIqYApkqDbWEJ
        OYbtmOBmlzGtk2y0E=; b=HL4tuH9+RNv7SeEMAxQSrMfTxLgnNdqAEc2LEmNq6b
        natCdi47sIirh5yTc8NJ1rb7YDMT+qwGYbiCHOJVAl9uYFthyaeU4KmmKTm5BpWo
        S7aEbyyUkaMRTAdAqNRSTtIrK7U4jlf09xIbaiGjF1UiuHZOLayadnui3K3q8KKQ
        HVu+p867SVr2shZFlm3tkXTmiFWtrbe2waqPiCnc37NIjMRk+sm4lKL7hdqGJBkK
        N42vFVj5h4PLmU/1zVUthB2vnzGUE3loBLgBwXVgc/Fa+ZOcc/GdrPBTEV15MoZs
        GQ1Y7A4z2ObNNnBXbIe3HrOKNbcXreT1J9GhV6QciFKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=vG7EGPCMURsU6YIqY
        ApkqDbWEJOYbtmOBmlzGtk2y0E=; b=FEwcU1tYOQay6qYjyqiJ6mOJI/oK58p9d
        jMkCFTZ1RrFsZ4J4N890iQxOOy2YCPeMT0Piyk+xc0QY9mGdpPXosJsHHTKQil92
        xSglExQYEXmsCBelaJNtqQ/+5M+r06njBdaNZdWxZylbC92f2uaflJldXG/tusjW
        9kNlIKTBKC2595gKop0PK4ktwMHidOSoliELr585I6QlSfxYSvZW2V4AX3WH2D6K
        lxCKweA9rDNf4YeuFOgtz23a6aw76DRgYJ9VFK1P6DtAhcyp6IcvG38z+0ENi1p+
        V38UIAY/8sJpyU3n5mDWTyS3k8ZelBxKUWNZljOji2Psiai+wrs5g==
X-ME-Sender: <xms:CvhOX8VqWgozBV58uK2MpTHl9e84pnwmZsiv7er8aUqEsyBN_jkWMA>
    <xme:CvhOXwmQ_i9Eojm9kgqwiU5OME_MQMHrjZs498gLu6PdaooI7KoQaDRYOiehFSo04
    _t6dAOTbXaHUyqPe0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefkedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhigthhhoucet
    nhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrghtth
    gvrhhnpeelveehveejgefgkedttedvteffgfelfeeuveduteelvdduhefhjeetjeehheel
    keenucfkphepjeefrddvudejrddutddriedtnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:CvhOXwbCd7LmSodjAcqGE0cqPrwlWEhvFiG0L-DHkOSlFWnAOCUiKQ>
    <xmx:CvhOX7VsuuuX4wy6lGLpYllUgu4GTdcXbWqk7I7OUayiyniZhy-jMA>
    <xmx:CvhOX2mrKkWKOd8WXfZBkbY7284fp0sHQV3BDOpYhe-eZDZtL77h9w>
    <xmx:C_hOX4htHXUPZzNmSV4PYy9uE-cbt8f8zIvK4wfKMlIQ_lM_WiVbmtDFAh8>
Received: from cisco.hsd1.co.comcast.net (c-73-217-10-60.hsd1.co.comcast.net [73.217.10.60])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7886F328005E;
        Tue,  1 Sep 2020 21:40:25 -0400 (EDT)
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, "Tobin C . Harding" <me@tobin.cc>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
Subject: [PATCH 1/2] seccomp: don't leak memory when filter install races
Date:   Tue,  1 Sep 2020 19:40:16 -0600
Message-Id: <20200902014017.934315-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In seccomp_set_mode_filter() with TSYNC | NEW_LISTENER, we first initialize
the listener fd, then check to see if we can actually use it later in
seccomp_may_assign_mode(), which can fail if anyone else in our thread
group has installed a filter and caused some divergence. If we can't, we
partially clean up the newly allocated file: we put the fd, put the file,
but don't actually clean up the *memory* that was allocated at
filter->notif. Let's clean that up too.

To accomplish this, let's hoist the actual "detach a notifier from a
filter" code to its own helper out of seccomp_notify_release(), so that in
case anyone adds stuff to init_listener(), they only have to add the
cleanup code in one spot. This does a bit of extra locking and such on the
failure path when the filter is not attached, but it's a slow failure path
anyway.

Fixes: 51891498f2da ("seccomp: allow TSYNC and USER_NOTIF together")
Reported-by: syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
---
 kernel/seccomp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 3ee59ce0a323..bb0dd9ae699a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1109,13 +1109,12 @@ static long seccomp_set_mode_strict(void)
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
-static int seccomp_notify_release(struct inode *inode, struct file *file)
+static void seccomp_notify_detach(struct seccomp_filter *filter)
 {
-	struct seccomp_filter *filter = file->private_data;
 	struct seccomp_knotif *knotif;
 
 	if (!filter)
-		return 0;
+		return;
 
 	mutex_lock(&filter->notify_lock);
 
@@ -1142,6 +1141,13 @@ static int seccomp_notify_release(struct inode *inode, struct file *file)
 	kfree(filter->notif);
 	filter->notif = NULL;
 	mutex_unlock(&filter->notify_lock);
+}
+
+static int seccomp_notify_release(struct inode *inode, struct file *file)
+{
+	struct seccomp_filter *filter = file->private_data;
+
+	seccomp_notify_detach(filter);
 	__put_seccomp_filter(filter);
 	return 0;
 }
@@ -1581,6 +1587,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 			listener_f->private_data = NULL;
 			fput(listener_f);
 			put_unused_fd(listener);
+			seccomp_notify_detach(prepared);
 		} else {
 			fd_install(listener, listener_f);
 			ret = listener;

base-commit: f75aef392f869018f78cfedf3c320a6b3fcfda6b
-- 
2.25.1

