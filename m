Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3947CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C20020738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947535;
	bh=P4Qm1p9vcTvayaP8/s/tFnINqDCTaJU907tNtIp1OSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=12U9n79x9rjALE8n7CgBjodbcjCYb07rO5PzgGK43jsF4A3Cxnl87aoLp4uHaTFe/
	 mRycUQwv8LrpzdhtDt/eBOg75MSc34CBn6WxOQ6oybovRxxXsOizV5c0cMqvvhkpsi
	 zywkwnCwtbswMgHYv83NZnjdl7BkVYYqfYqawodg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389730AbgFWUS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388831AbgFWUSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:18:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3E6D2073E;
        Tue, 23 Jun 2020 20:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943531;
        bh=P4Qm1p9vcTvayaP8/s/tFnINqDCTaJU907tNtIp1OSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYl8Hf5+z1WVEF0mh3qrgdtY7l97cw3EdOG3PnLr54VJtsbhHEN+bMVuJRwKkt7sQ
         B7H4v7R2ZbI7vJPdjMHF+DjXf+EO2rq/NkFgMoa9+slejF3g7K9RLsmk3ZJAOj01Y2
         rZULexdWOgOeUswgpYITktvK4HYBbeJcYLhNUUE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 5.7 428/477] selinux: fix undefined return of cond_evaluate_expr
Date:   Tue, 23 Jun 2020 21:57:05 +0200
Message-Id: <20200623195427.760325005@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

commit 8231b0b9c322c894594fb42eb0eb9f93544a6acc upstream.

clang static analysis reports an undefined return

security/selinux/ss/conditional.c:79:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
        return s[0];
        ^~~~~~~~~~~

static int cond_evaluate_expr( ...
{
	u32 i;
	int s[COND_EXPR_MAXDEPTH];

	for (i = 0; i < expr->len; i++)
	  ...

	return s[0];

When expr->len is 0, the loop which sets s[0] never runs.

So return -1 if the loop never runs.

Cc: stable@vger.kernel.org
Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/conditional.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -27,6 +27,9 @@ static int cond_evaluate_expr(struct pol
 	int s[COND_EXPR_MAXDEPTH];
 	int sp = -1;
 
+	if (expr->len == 0)
+		return -1;
+
 	for (i = 0; i < expr->len; i++) {
 		struct cond_expr_node *node = &expr->nodes[i];
 


