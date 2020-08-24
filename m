Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26A7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0F6206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258172;
	bh=riN4z/mrdo2qC42KeSPF/qU3Hm3H0TkNahjQu/VUgaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EdAuorRrVEuYLugNye2h7rJngQ5X8jmSwtcsaaibb5Lz5RqVvxT7mjVHXSJTgJfLx
	 tYOXSXTkaJWwT2LFHt0qSFaE+3MbbpusWY78XuUdPx+N5Hl2yo5KAHFryzhfoIJJuA
	 aQZwKQQ45RtLKfFBK78ajB16ZwD/10ISnfAPjyIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgHXIgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgHXIgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:36:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B47A204FD;
        Mon, 24 Aug 2020 08:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258162;
        bh=riN4z/mrdo2qC42KeSPF/qU3Hm3H0TkNahjQu/VUgaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrQ18nInGCsTcfIa7/dBmIeWW4m5tJ8K0t9THCa96VA/Upm4HUvMni4AiPHlvqqUh
         9lFQcrkTbZdrinEBX80GzdMn9mh9cduFejuNgCONXijdKf5wMaQBw0B0gVW2UOzrJb
         JZ1RT1FVkdT23tS3LYkF8nrMQukMGuB50yPyMrrY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 098/148] s390/runtime_instrumentation: fix storage key handling
Date:   Mon, 24 Aug 2020 10:29:56 +0200
Message-Id: <20200824082418.734685366@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
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



