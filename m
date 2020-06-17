Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D282C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D18C20DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQMjO7Nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFQMkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:40:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36051 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726833AbgFQMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592397636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=2RQrT3EjDVr3su/B3tRPDza7pUR3iLPl4siz1SBOLw8=;
        b=hQMjO7NfwdTU8N5p2O4d+ZWv+iGEw8Rra9MgUuiifMUNfb3sEzF/IAIu4i8/fGnj5qQ2Rx
        lj+dgLfEQwHtxS9zEQhy8I+PfJd1B/uuWql9X1yJCMPYmi+XNoojECjSj8Ri5JBfWZQ85V
        ZgCfydu9St2T7/6f0DipGZYYk3HUjyo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-2qfS0-V6NiaXCn3unQkguw-1; Wed, 17 Jun 2020 08:40:34 -0400
X-MC-Unique: 2qfS0-V6NiaXCn3unQkguw-1
Received: by mail-qv1-f72.google.com with SMTP id ba13so1485872qvb.15
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 05:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2RQrT3EjDVr3su/B3tRPDza7pUR3iLPl4siz1SBOLw8=;
        b=OELzNpxBqkD86CQO/dXWdU+Dwc8U372NHPM87MFP4uisnQBF4ZZLnyjkV+1gTHSxPO
         bnUvbXSgX2ZqQSMsXVDa/CG+CL8dTSmdvUWO6aEUiqt1UtI4eh+xKjVOQtEYumcFeJPK
         sc3vNrulMueMo+pMmLq6wW9e1w2EKBc3LRiMwnikkQ/UrvzA3Dr6XuqFmfs8lMDl0Lxy
         mNia9L0rot9ykCuvvZuFSTfwh+aUjtCpLNVnk4lpv+Khql4NlFGOAlQu2jrt/MHEqWsO
         JrbVpm85uQ7++7TC24d+IFe4GqS+PnluK6hB56mETdiCOuvg5EXU/JSSpm6wDHTtyqPM
         N8ZA==
X-Gm-Message-State: AOAM5326wiOIp5lgk1vSwEcHdZP+yA8UpyXKIvVHSkmZyZgW8VmfqTxi
        XbYABSoHXj30uxOBE5WQEtgtI0kb4EClIN1XFrdZq/0XfSNnnb0h0bW7MK/fl6grOEO1GKlSqBi
        6U3IVem7FjyNrzxjGSQOMbdh0
X-Received: by 2002:a37:2c85:: with SMTP id s127mr23808530qkh.35.1592397634145;
        Wed, 17 Jun 2020 05:40:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRdA5/LRmzm5WOE/vH5imSdM/e0uBC09qFzet2IijFSRmUYeFsucAw0atfWaZlDq4biKMDmQ==
X-Received: by 2002:a37:2c85:: with SMTP id s127mr23808515qkh.35.1592397633918;
        Wed, 17 Jun 2020 05:40:33 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 69sm17054463qkh.15.2020.06.17.05.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 05:40:33 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, weiyongjun1@huawei.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] selinux: fix undefined return of cond_evaluate_expr
Date:   Wed, 17 Jun 2020 05:40:28 -0700
Message-Id: <20200617124028.14130-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

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

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/selinux/ss/conditional.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 450bc02f4cd2..0cc7cdd58465 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -27,6 +27,9 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
 	int s[COND_EXPR_MAXDEPTH];
 	int sp = -1;
 
+	if (expr->len == 0)
+		return -1;
+
 	for (i = 0; i < expr->len; i++) {
 		struct cond_expr_node *node = &expr->nodes[i];
 
-- 
2.18.1

