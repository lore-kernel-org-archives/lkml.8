Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130A9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14D22078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948537;
	bh=J6BtOatp0H0xxIehNq/YeWWaCUMLlsM3bkSFCVQqYCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gv09cVBtMt/nRWQUeIbdFTFY9WQ5QPV5aS81PBRI3lODtfFiyb0wHS6m0aWVGTtPD
	 ROL10FcoK1OgGLuoJsVAzQ9eASGlp1uqnK59Nup3PNdfNoOJwnrKYqshx2MZ0yQWFj
	 Cw6TAvgXz7lbbwCwcUyjnVOZTDWNsS0u9vdQboZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbgFWUFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388256AbgFWUEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:04:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23A21206C3;
        Tue, 23 Jun 2020 20:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942693;
        bh=J6BtOatp0H0xxIehNq/YeWWaCUMLlsM3bkSFCVQqYCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+wLJivNlnTPArmDEoGPtNIfG4kh7MVCV0rNuxe8Sm0n2BsOjfCS+fpcv3SJkriO7
         BtwN1l0EbmMxYuKELZLyYjdh7vaeOr5g3rWM5XlFcLVGoVgUYycmHWIGgWMk7K+wU8
         amOgqWoBZ82+91AEcwRyGcQ63Q1yfqgYqiW/1kFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 097/477] apparmor: fix introspection of of task mode for unconfined tasks
Date:   Tue, 23 Jun 2020 21:51:34 +0200
Message-Id: <20200623195412.187606278@linuxfoundation.org>
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

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit dd2569fbb053719f7df7ef8fdbb45cf47156a701 ]

Fix two issues with introspecting the task mode.

1. If a task is attached to a unconfined profile that is not the
   ns->unconfined profile then. Mode the mode is always reported
   as -

      $ ps -Z
      LABEL                               PID TTY          TIME CMD
      unconfined                         1287 pts/0    00:00:01 bash
      test (-)                           1892 pts/0    00:00:00 ps

   instead of the correct value of (unconfined) as shown below

      $ ps -Z
      LABEL                               PID TTY          TIME CMD
      unconfined                         2483 pts/0    00:00:01 bash
      test (unconfined)                  3591 pts/0    00:00:00 ps

2. if a task is confined by a stack of profiles that are unconfined
   the output of label mode is again the incorrect value of (-) like
   above, instead of (unconfined). This is because the visibile
   profile count increment is skipped by the special casing of
   unconfined.

Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/label.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 470693239e64f..6c3acae701efd 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -1531,13 +1531,13 @@ static const char *label_modename(struct aa_ns *ns, struct aa_label *label,
 
 	label_for_each(i, label, profile) {
 		if (aa_ns_visible(ns, profile->ns, flags & FLAG_VIEW_SUBNS)) {
-			if (profile->mode == APPARMOR_UNCONFINED)
+			count++;
+			if (profile == profile->ns->unconfined)
 				/* special case unconfined so stacks with
 				 * unconfined don't report as mixed. ie.
 				 * profile_foo//&:ns1:unconfined (mixed)
 				 */
 				continue;
-			count++;
 			if (mode == -1)
 				mode = profile->mode;
 			else if (mode != profile->mode)
-- 
2.25.1



