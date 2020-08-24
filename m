Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29347C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6E2206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258917;
	bh=riN4z/mrdo2qC42KeSPF/qU3Hm3H0TkNahjQu/VUgaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JHXL4PTCcjdejTWpzT5AlF0YNEoJcJgk6PjI3j+aSzNyn2YsR6TjzDIkASlyqW2xt
	 N1a+J3B0nXTxgEMgWKK89lOo/omKpVAPO87LWhRhK2ce96ajeTqZqJPGW4FPz86/B7
	 9sfe3d3sme5xX1MeK3uZEjHKSVRatlYWwMh+7jKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgHXIsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgHXIsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:48:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6382A206F0;
        Mon, 24 Aug 2020 08:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258891;
        bh=riN4z/mrdo2qC42KeSPF/qU3Hm3H0TkNahjQu/VUgaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYIOwxs7+suwmTbpilYtysyiGgE9R+qipgiW1p0tdoET8OdiAdGzzZI7M6eja692M
         N62T9a/WI7Fk1k9SsRB/DZNgw8sLJvW0+SQAGJJcX6yRzYTP4YCNpAaM+VTaSph8Us
         YpFV0ZEaOvqwl/t2xL0sa9pUamFdmKBb+YjZJqJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 082/107] s390/runtime_instrumentation: fix storage key handling
Date:   Mon, 24 Aug 2020 10:30:48 +0200
Message-Id: <20200824082409.180331733@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 9eaba29c7985236e16468f4e6a49cc18cf01443e ]

The key member of the runtime instrumentation control block contains
only the access key, not the complete storage key. Therefore the value
must be shifted by four bits.
Note: this is only relevant for debugging purposes in case somebody
compiles a kernel with a default storage access key set to a value not
equal to zero.

Fixes: e4b8b3f33fca ("s390: add support for runtime instrumentation")
Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/runtime_instr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/runtime_instr.c b/arch/s390/kernel/runtime_instr.c
index 125c7f6e87150..1788a5454b6fc 100644
--- a/arch/s390/kernel/runtime_instr.c
+++ b/arch/s390/kernel/runtime_instr.c
@@ -57,7 +57,7 @@ static void init_runtime_instr_cb(struct runtime_instr_cb *cb)
 	cb->k = 1;
 	cb->ps = 1;
 	cb->pc = 1;
-	cb->key = PAGE_DEFAULT_KEY;
+	cb->key = PAGE_DEFAULT_KEY >> 4;
 	cb->v = 1;
 }
 
-- 
2.25.1



