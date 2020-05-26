Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F37C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE36820721
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521248;
	bh=eUVjV3AP6pVxx9BUy2BWXmtarhggMcNmDp9jlExEm9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d7WRO3E4+CZH/c4RPbIZIym+q58r008fHgSVlGujuu/lI4INUDnYDIkXDa9j7NGgd
	 k1TsgQVos8tS+RO0r5HQP6c+4qbeGEq+sKIrELUVrFHhIcx7eM+26qsLOJQHbNV2Wd
	 wqULI5AjL7l+tPY9Fm5hmIrlMlYe4V8X9t6HyRsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392472AbgEZT12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391342AbgEZTEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:04:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A9C20849;
        Tue, 26 May 2020 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519860;
        bh=eUVjV3AP6pVxx9BUy2BWXmtarhggMcNmDp9jlExEm9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBLvqerzmeDSSJvdJyYUOf98KYmqS91U1PfOftr/VUWytMo2fHlh8HjxLms7oEYw5
         2LrrDfeblR0V5QRkZ+5uTe+15CWvZIdyBXxIBFJtXSAQ9A7r9gKI7Wq6Y/gp1PGd0y
         tQ19mtAxsEInNmx1SkeXo3v0SWKubNW5pgkQMGcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.19 44/81] apparmor: fix potential label refcnt leak in aa_change_profile
Date:   Tue, 26 May 2020 20:53:19 +0200
Message-Id: <20200526183931.948240214@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

commit a0b845ffa0d91855532b50fc040aeb2d8338dca4 upstream.

aa_change_profile() invokes aa_get_current_label(), which returns
a reference of the current task's label.

According to the comment of aa_get_current_label(), the returned
reference must be put with aa_put_label().
However, when the original object pointed by "label" becomes
unreachable because aa_change_profile() returns or a new object
is assigned to "label", reference count increased by
aa_get_current_label() is not decreased, causing a refcnt leak.

Fix this by calling aa_put_label() before aa_change_profile() return
and dropping unnecessary aa_get_current_label().

Fixes: 9fcf78cca198 ("apparmor: update domain transitions that are subsets of confinement at nnp")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/apparmor/domain.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1338,6 +1338,7 @@ int aa_change_profile(const char *fqname
 		ctx->nnp = aa_get_label(label);
 
 	if (!fqname || !*fqname) {
+		aa_put_label(label);
 		AA_DEBUG("no profile name");
 		return -EINVAL;
 	}
@@ -1356,8 +1357,6 @@ int aa_change_profile(const char *fqname
 			op = OP_CHANGE_PROFILE;
 	}
 
-	label = aa_get_current_label();
-
 	if (*fqname == '&') {
 		stack = true;
 		/* don't have label_parse() do stacking */


