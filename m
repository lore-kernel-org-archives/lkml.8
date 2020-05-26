Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAE5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0592053B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520534;
	bh=mjFcX86r91d1iZBtQKyPObyOrcy9aYox6OEArrqea7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OTISGIc4W+IJY7A8JxJejt26OpanQTVAXHqQB06HIizFRWASPLd6YQBdu0wmI47cK
	 iTM7WpCtSxED8Lze0uqCrsdMGtM076k/ckqx6tcu6UESVK9FodGG9JIgBx7KvrLId8
	 EztoJppJ+t2QA1C8zlJpUSPOYk7m0Ux+FTwTSeAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404434AbgEZTPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404265AbgEZTP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:15:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A333E20776;
        Tue, 26 May 2020 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520528;
        bh=mjFcX86r91d1iZBtQKyPObyOrcy9aYox6OEArrqea7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrLiEuUUtlar+zMA/5GKJhpisvi4KFtdE9fXpqPVuP4jPOLP3s2lpiTXkF4pFPT4l
         tZFlGkDndEzFVeHntyjRrMoh8cDeKusPv4oIISK8UKyubVHlho0JdgRr9PtgObAHVO
         Wzcprwxauo35qQdYwF9XztDwIB1RL9fw+UtDrAcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        John Johansen <john.johansen@canonical.com>
Subject: [PATCH 5.6 075/126] apparmor: fix potential label refcnt leak in aa_change_profile
Date:   Tue, 26 May 2020 20:53:32 +0200
Message-Id: <20200526183944.505936788@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
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
@@ -1328,6 +1328,7 @@ int aa_change_profile(const char *fqname
 		ctx->nnp = aa_get_label(label);
 
 	if (!fqname || !*fqname) {
+		aa_put_label(label);
 		AA_DEBUG("no profile name");
 		return -EINVAL;
 	}
@@ -1346,8 +1347,6 @@ int aa_change_profile(const char *fqname
 			op = OP_CHANGE_PROFILE;
 	}
 
-	label = aa_get_current_label();
-
 	if (*fqname == '&') {
 		stack = true;
 		/* don't have label_parse() do stacking */


