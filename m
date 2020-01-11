Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FFFC33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8555E2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737143;
	bh=CML4ynmYXN0xB1zt3WrGElGGQONxilXaUfFuXX/uags=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QL72/ZTMKOXlNdzRtd3n/jJ2vMiohPoaRmccB3gCXyjcrUhWG3TXzezzqkEi3XTfa
	 VahShXv22oDXum1o9FKFZl5U3TRcjoqiS8fNZOb1+Pw4pWAWbWcOV+fuT+IlCHvgg7
	 jjvhSp4VoqscauCM4CZpbdg7ht+iI9EkMxngbEaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgAKKFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:05:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbgAKKFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:05:42 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07FBB2082E;
        Sat, 11 Jan 2020 10:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737141;
        bh=CML4ynmYXN0xB1zt3WrGElGGQONxilXaUfFuXX/uags=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMOz6+B2hAcrS88BRiIfUBT9n6p6My3PiPtdDZwvMYtTkrRTD0W+YSm0hAb81XOz9
         Ar/UHzXUZnHAYo3BEs1FYDBhydKhfZfGKq6eZBGriRaAlr42KhwdYb8Crr/4+ojIhd
         xsJcH6NqzhZnpu53RwHp01VLMaMWUP0H0FePjOuk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hebb <tommyhebb@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 74/91] kconfig: dont crash on NULL expressions in expr_eq()
Date:   Sat, 11 Jan 2020 10:50:07 +0100
Message-Id: <20200111094911.443916963@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hebb <tommyhebb@gmail.com>

[ Upstream commit 272a72103012862e3a24ea06635253ead0b6e808 ]

NULL expressions are taken to always be true, as implemented by the
expr_is_yes() macro and by several other functions in expr.c. As such,
they ought to be valid inputs to expr_eq(), which compares two
expressions.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/expr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index ed29bad1f03a..96420b620963 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -201,6 +201,13 @@ static int expr_eq(struct expr *e1, struct expr *e2)
 {
 	int res, old_count;
 
+	/*
+	 * A NULL expr is taken to be yes, but there's also a different way to
+	 * represent yes. expr_is_yes() checks for either representation.
+	 */
+	if (!e1 || !e2)
+		return expr_is_yes(e1) && expr_is_yes(e2);
+
 	if (e1->type != e2->type)
 		return 0;
 	switch (e1->type) {
-- 
2.20.1



