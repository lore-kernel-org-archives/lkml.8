Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D492C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557A72072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919382;
	bh=bauSevcKeg4mYS85bMxFfZEB+Fpsv6jNmDuyFK76HhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WMuZxy/3uwj+LYEl9/ogQEIWo6vSIfagXELQ7FJobEJ/jqk3QDTLa5ot26jS44bB3
	 bSgB2GZOvk+qmj2O5mCVsxb3FbuKSy+iZESvSSQ2pGCsKKftDjPnVCEp3yo/0c2xeh
	 2waRdJUNp+7AnMktm6gzQU9MwV2sfbyE8x1SRjOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgHTK3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731512AbgHTKVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:21:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E8520738;
        Thu, 20 Aug 2020 10:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918871;
        bh=bauSevcKeg4mYS85bMxFfZEB+Fpsv6jNmDuyFK76HhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLV5srljC54wQTzP0ZLO4syS1oqq3bmdc8KibMI0bGnOokG89115pPhfe+h2QSOss
         axac4Kou0+0yQ6NlBr/Z5NORa1DdUWQw0KgY1jxxwoR77K/r770W2Gsh9bpj4Vl/Hd
         WYALc29a3YSehQlJSpGfN18hSuZhJL2DKMobeJfI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a22c6092d003d6fe1122@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 096/149] Smack: fix another vsscanf out of bounds
Date:   Thu, 20 Aug 2020 11:22:53 +0200
Message-Id: <20200820092130.368312346@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit a6bd4f6d9b07452b0b19842044a6c3ea384b0b88 ]

This is similar to commit 84e99e58e8d1 ("Smack: slab-out-of-bounds in
vsscanf") where we added a bounds check on "rule".

Reported-by: syzbot+a22c6092d003d6fe1122@syzkaller.appspotmail.com
Fixes: f7112e6c9abf ("Smack: allow for significantly longer Smack labels v4")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smackfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index bd4d0f5a79aa3..2e2ef3a525ecb 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -939,6 +939,10 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 
 	for (i = 0; i < catlen; i++) {
 		rule += SMK_DIGITLEN;
+		if (rule > data + count) {
+			rc = -EOVERFLOW;
+			goto out;
+		}
 		ret = sscanf(rule, "%u", &cat);
 		if (ret != 1 || cat > SMACK_CIPSO_MAXCATNUM)
 			goto out;
-- 
2.25.1



