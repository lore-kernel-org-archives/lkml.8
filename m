Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F57C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678F12158C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578621;
	bh=WzdKLcxsUo5ZGyDCjZY1UzGGrwyvJ95PTwBkTb205bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WLzvwQpG8njXWn6iyQzYFLZjC5FIlpaObMPRvOf40nir6iashyk3zse3CJqzrxY3F
	 OH3uXBdy3vWOo/SOmZqywgL8RrCSV8RPHVfnd6AG8suUfu3bHuzdpUyb593C3ccNB3
	 Dto4fQZzZKyJ960qqmVNecmc01c/1p5ukaB1pSzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbgFSO47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390058AbgFSO4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:56:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3EF8217D9;
        Fri, 19 Jun 2020 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578599;
        bh=WzdKLcxsUo5ZGyDCjZY1UzGGrwyvJ95PTwBkTb205bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJW0lGctNLaXD+h6iK542SleAVGfZsE/QDpUoMnpvodG5FSENBAlYJGQ0BbZp5Y+z
         aNlwbpv1EelGGWMcF5hu165BF4htj1jmt7AzFTKq30gtD/dFIFouZb9GOZYjtaTVGe
         Do6bnJE4GxaxX/cP2UurVAG5rTQ4Yj4xd461p8YQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        syzbot+bfdd4a2f07be52351350@syzkaller.appspotmail.com,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH 4.19 082/267] Smack: slab-out-of-bounds in vsscanf
Date:   Fri, 19 Jun 2020 16:31:07 +0200
Message-Id: <20200619141652.833796545@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
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
@@ -906,11 +906,21 @@ static ssize_t smk_set_cipso(struct file
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


