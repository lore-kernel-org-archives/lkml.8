Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59B9C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702E3214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217511;
	bh=JoBAKm2P5KYRaZHWujHHUbJl6+7uf7Ch3XDLnH4jh+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qfWK4wSKtvL2mlWdi7y4D37l63e3dbIi/ScaC5w65WuRYwlw4TPLtT6RSbHUSA3MG
	 FhsmdaBxNHiDDR0OGIGf8ZAYBkrh4oo41spcl9XkD/UvTy7UeOmWj4LeBfKZnL/ONw
	 R+wAmGCEgbFYnavv7rB5S5jvpvUzAWYfV9/TP81s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391535AbgAPXbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:31:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403876AbgAPXb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:31:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 230572072B;
        Thu, 16 Jan 2020 23:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217485;
        bh=JoBAKm2P5KYRaZHWujHHUbJl6+7uf7Ch3XDLnH4jh+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xUGtjlV6z8k4+xQ+Hvo8aoqolYN7MZh1kUqjaVa1WdOJOOMhpIoHVQgu+Sb/5MnQj
         5yR3/AyID6sEcm0QgCR6zPgUkY+830PLSzjlh7gRwLT7Qi+nITqaX7qe187vF+khHg
         NwewvqypX4H2TM4vAKd2w4HdjEQ98J4R6r7WPp6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 18/71] dccp: Fix memleak in __feat_register_sp
Date:   Fri, 17 Jan 2020 00:18:16 +0100
Message-Id: <20200116231712.074223081@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

commit 1d3ff0950e2b40dc861b1739029649d03f591820 upstream.

If dccp_feat_push_change fails, we forget free the mem
which is alloced by kmemdup in dccp_feat_clone_sp_val.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e8ef967a54f4 ("dccp: Registration routines for changing feature values")
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dccp/feat.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/dccp/feat.c
+++ b/net/dccp/feat.c
@@ -738,7 +738,12 @@ static int __feat_register_sp(struct lis
 	if (dccp_feat_clone_sp_val(&fval, sp_val, sp_len))
 		return -ENOMEM;
 
-	return dccp_feat_push_change(fn, feat, is_local, mandatory, &fval);
+	if (dccp_feat_push_change(fn, feat, is_local, mandatory, &fval)) {
+		kfree(fval.sp.vec);
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 /**


