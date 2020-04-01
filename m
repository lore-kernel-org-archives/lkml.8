Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE31CC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9036121582
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758599;
	bh=QR5fErFmCSao2uxp/azzrTggGMtrxBhZ4mWA0rc0frE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pGAqjQ5w44FZKK1oHxvfhweXpR6rWWTEusQ/BdWcQ2vEeUYFJfG4VMIcMtKAxNWUl
	 byTnCQUIFjalCH0cZrS9xbhTYE3+IZSW3vCzO4Jrxd+txakeDRslq6uby0iJxRHaZT
	 FRrIGe9UNUm+XzILPFrCKG6qThaoSTZ8+jt6oLJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbgDAQ36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388198AbgDAQ3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:29:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672B420658;
        Wed,  1 Apr 2020 16:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758589;
        bh=QR5fErFmCSao2uxp/azzrTggGMtrxBhZ4mWA0rc0frE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SjzdvSCfSM10n1BTg6ytHgunbZ2TJWUHndvVUHIhwKCEIMx/gBA7LlY3j2xP1u+QO
         V9q5ejW0w8mcgr49yYgyu5VCXYQUb3EsSGwW0W6pthcU+1ykeljFaeiLFDw1DI+T6k
         v5yuYpeuUYjwQ7lHD83kJ9XZZvjrSDJo6imUWn8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 02/91] powerpc: Include .BTF section
Date:   Wed,  1 Apr 2020 18:16:58 +0200
Message-Id: <20200401161513.621852883@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

[ Upstream commit cb0cc635c7a9fa8a3a0f75d4d896721819c63add ]

Selecting CONFIG_DEBUG_INFO_BTF results in the below warning from ld:
  ld: warning: orphan section `.BTF' from `.btf.vmlinux.bin.o' being placed in section `.BTF'

Include .BTF section in vmlinux explicitly to fix the same.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200220113132.857132-1-naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 876ac9d52afcb..9b1e297be6730 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -255,6 +255,12 @@ SECTIONS
 		*(.branch_lt)
 	}
 
+#ifdef CONFIG_DEBUG_INFO_BTF
+	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {
+		*(.BTF)
+	}
+#endif
+
 	.opd : AT(ADDR(.opd) - LOAD_OFFSET) {
 		*(.opd)
 	}
-- 
2.20.1



