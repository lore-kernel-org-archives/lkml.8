Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C02AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A155204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690313;
	bh=N8Em1HI5CHy+i59UwXfiCvdXnRiojqqoK0W2KciPvSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GQ7SbGGLkvwX+aFfcpJUb/NLgiFtogIKCFSXEyAosnbm+EaWwwIAxBzVfYxPdCNhZ
	 QFCZRhkjlhBq9vpDHxoduZftdVZU8s0KH/QcWh+D6xe8UUkkoh50W/+OJx/tGuDPVH
	 +tFDLbfuTT/HW8ybBilR6PJUpHXPh/Ga+2MtlTh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391755AbgHQSvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387874AbgHQPwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:52:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D942063A;
        Mon, 17 Aug 2020 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679572;
        bh=N8Em1HI5CHy+i59UwXfiCvdXnRiojqqoK0W2KciPvSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wHG/s6HZebvfqGhNeCdyfvX9CN17HJrmcy1Dou7T05QCAcRiSrnjYB/ssBLOp+ivH
         2Ykr4RewIUZrdrx4yROfuQF5xQHJL9hXF1203G8P6VxnZFfFIW4/x8ev1wTBL3Y+jK
         6peTSugCxelZ3KwEtLSayOFZdpjQjfbNK+6Tswm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a22c6092d003d6fe1122@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 253/393] Smack: fix another vsscanf out of bounds
Date:   Mon, 17 Aug 2020 17:15:03 +0200
Message-Id: <20200817143831.894329438@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
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
index 840a192e93370..2bae1fc493d16 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -905,6 +905,10 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 
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



