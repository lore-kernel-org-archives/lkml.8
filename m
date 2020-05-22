Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6F8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B263E206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159438;
	bh=MbeZa4VffzmxWAR8MGy0BeRxIsWisBaIT8gBRIYAzuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W538QSLFkGPywgO3TC1DmLiccOsks29g1TCsSFj3nntz/TRcQgnFDApO84pYJcErA
	 SvWtOQPQF56eKSZlzzdhfX6Sqvp4UDQPI9C6yfoWelnAfAFNgcKi5/2D308fPNXT9P
	 xtRF67JpP0I7Ds/aXjd0p7hYnM6d4yQ0U8+ojLhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgEVO5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730786AbgEVOun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:50:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69ECF221FA;
        Fri, 22 May 2020 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159043;
        bh=MbeZa4VffzmxWAR8MGy0BeRxIsWisBaIT8gBRIYAzuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j00qSGyFz04Zek1HqulZRTPPWk3Pvlmpxgc6+IVM+HePTC9MWQKn/EPDtHNGemFqC
         4EFuBj/dbNRDyhd/yyEmIx2UedlBzHNyTEkfx1tahoYdEJiGC7i1akGULnM6sp0D8h
         CjeecjgCtWDOMuyJnl2+cPEUbDRD3B4RCzq4SZms=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matteo Croce <mcroce@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 40/41] samples: bpf: Fix build error
Date:   Fri, 22 May 2020 10:49:57 -0400
Message-Id: <20200522144959.434379-40-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522144959.434379-1-sashal@kernel.org>
References: <20200522144959.434379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

[ Upstream commit 23ad04669f81f958e9a4121b0266228d2eb3c357 ]

GCC 10 is very strict about symbol clash, and lwt_len_hist_user contains
a symbol which clashes with libbpf:

/usr/bin/ld: samples/bpf/lwt_len_hist_user.o:(.bss+0x0): multiple definition of `bpf_log_buf'; samples/bpf/bpf_load.o:(.bss+0x8c0): first defined here
collect2: error: ld returned 1 exit status

bpf_log_buf here seems to be a leftover, so removing it.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20200511113234.80722-1-mcroce@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/lwt_len_hist_user.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/samples/bpf/lwt_len_hist_user.c b/samples/bpf/lwt_len_hist_user.c
index 587b68b1f8dd..430a4b7e353e 100644
--- a/samples/bpf/lwt_len_hist_user.c
+++ b/samples/bpf/lwt_len_hist_user.c
@@ -15,8 +15,6 @@
 #define MAX_INDEX 64
 #define MAX_STARS 38
 
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
-
 static void stars(char *str, long val, long max, int width)
 {
 	int i;
-- 
2.25.1

