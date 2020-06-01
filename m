Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC63BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D51320870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591036629;
	bh=aYhFCPraAuuhSNT615HvbyUmvG8NskDq5ppqHhOLMQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XxdM047cVQKXfRAVeNekiZLDvN6jYW7htrwx0H+wbx88+scoGfpnyy0K0zjL++qi1
	 lCXzgZCQQkMzHhJS6hcLIfggQZAxN7Fyw4jxF3pYtiiLds18fSLVI3Byuht8jA6vhv
	 f+DlryQtGQ2whe/Gt0jg+YHkcSJ9BmbH3wcaVv9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgFAShI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731030AbgFASPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:15:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D45C2065C;
        Mon,  1 Jun 2020 18:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035345;
        bh=aYhFCPraAuuhSNT615HvbyUmvG8NskDq5ppqHhOLMQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0GidEXhKmH8QgkrtO4pA88a+zDmgJQRMaHUfKN4NRqJexfqfkDUAVCDIhw5sfFP60
         kq1FGD5Vd+mA665uUIGhUCpbcIeoW/4gcKDV3yF6SPRhyMb3fmg24XaAQwYM2Wkqea
         njMmCFQ9mBa3lmHv0RJLjWDaD4HnSUnDC+lGcPWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 117/177] exec: Always set cap_ambient in cap_bprm_set_creds
Date:   Mon,  1 Jun 2020 19:54:15 +0200
Message-Id: <20200601174058.367455771@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com>

[ Upstream commit a4ae32c71fe90794127b32d26d7ad795813b502e ]

An invariant of cap_bprm_set_creds is that every field in the new cred
structure that cap_bprm_set_creds might set, needs to be set every
time to ensure the fields does not get a stale value.

The field cap_ambient is not set every time cap_bprm_set_creds is
called, which means that if there is a suid or sgid script with an
interpreter that has neither the suid nor the sgid bits set the
interpreter should be able to accept ambient credentials.
Unfortuantely because cap_ambient is not reset to it's original value
the interpreter can not accept ambient credentials.

Given that the ambient capability set is expected to be controlled by
the caller, I don't think this is particularly serious.  But it is
definitely worth fixing so the code works correctly.

I have tested to verify my reading of the code is correct and the
interpreter of a sgid can receive ambient capabilities with this
change and cannot receive ambient capabilities without this change.

Cc: stable@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Fixes: 58319057b784 ("capabilities: ambient capabilities")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/commoncap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/commoncap.c b/security/commoncap.c
index f4ee0ae106b2..0ca31c8bc0b1 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -812,6 +812,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	int ret;
 	kuid_t root_uid;
 
+	new->cap_ambient = old->cap_ambient;
 	if (WARN_ON(!cap_ambient_invariant_ok(old)))
 		return -EPERM;
 
-- 
2.25.1



