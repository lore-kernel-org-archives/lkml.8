Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E860EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0374207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323591;
	bh=L+ZIDbk7gGh2d8y06TrWjfNNB4BOtBVD11yTKaLw7C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fk1wvkQ6KTzzeP6mfp3SRxBp46UizK+JwOYk1GYxyYtKeNiXnUAA96zP+/GTVEjMC
	 Mj8465i4XHW+nGKo6nk13jDJTwHF0PzPVdhi63vLQ4KsRc0+RreQ3PReryhM7FN316
	 zti1cuyosvh6+C01OuaiLDeB7OZuvifecD4AnRkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbgFPPr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731431AbgFPPrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:47:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E60E420776;
        Tue, 16 Jun 2020 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322471;
        bh=L+ZIDbk7gGh2d8y06TrWjfNNB4BOtBVD11yTKaLw7C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzhrmCqQ/uwHEuf4aGg/0xDQo+o4aJQbeGlHY0whYy4zIVTSzmQTVPDimgsq0anGx
         LFlpOYYZjyyrB7WAZ+XENj/RJTgUn1k6uCkcFabC8swt+25efAaGx/NME7nxfOhVdm
         wbGzTzj656TOEiolIWCJIHKAmKIV6uKeftJ8cGfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        syzbot+bfdd4a2f07be52351350@syzkaller.appspotmail.com,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH 5.7 144/163] Smack: slab-out-of-bounds in vsscanf
Date:   Tue, 16 Jun 2020 17:35:18 +0200
Message-Id: <20200616153113.702093609@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>

commit 84e99e58e8d1e26f04c097f4266e431a33987f36 upstream.

Add barrier to soob. Return -EOVERFLOW if the buffer
is exceeded.

Suggested-by: Hillf Danton <hdanton@sina.com>
Reported-by: syzbot+bfdd4a2f07be52351350@syzkaller.appspotmail.com
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/smack/smackfs.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -878,11 +878,21 @@ static ssize_t smk_set_cipso(struct file
 	else
 		rule += strlen(skp->smk_known) + 1;
 
+	if (rule > data + count) {
+		rc = -EOVERFLOW;
+		goto out;
+	}
+
 	ret = sscanf(rule, "%d", &maplevel);
 	if (ret != 1 || maplevel > SMACK_CIPSO_MAXLEVEL)
 		goto out;
 
 	rule += SMK_DIGITLEN;
+	if (rule > data + count) {
+		rc = -EOVERFLOW;
+		goto out;
+	}
+
 	ret = sscanf(rule, "%d", &catlen);
 	if (ret != 1 || catlen > SMACK_CIPSO_MAXCATNUM)
 		goto out;


