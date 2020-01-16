Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7D2C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337C620663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201204;
	bh=63y6luguthzjydgpuxrNuDfTMIivEt0uMmMzMVa7/rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LdDsPygY+53l5l82Cukk049EBnWTDD0zpBIpx1WJTPHsOBtlvBBPcRtUV2B6613FC
	 c4eRafYNSNcy1YpBVhJkZqrX4+OpIWa4dn5zioLE9amD/vZFCCXYXUuNOIYLkJksOn
	 UEIO54fv1Hf738UfMW6+pV1BZ9iyLq8uezE4KIJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437228AbgAPS77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388493AbgAPRGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E56A207FF;
        Thu, 16 Jan 2020 17:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194385;
        bh=63y6luguthzjydgpuxrNuDfTMIivEt0uMmMzMVa7/rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNHw5814U1TMfTLd0eLpOJLeW8SvipO0ieFNRbIhiOX+2yvlbuiPhpRB3IlX+mKWn
         9LdX/1MA8CRv0rl/tOUo+uV2P00ReVs2raVbZbgv+qPG7vkUxLmrDZck7f+PQ3Q+Ps
         TpyqiNsapsBMM4g0/J7V7ICSVtV2ywCCj06G7eGI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Rudo <prudo@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 314/671] s390/kexec_file: Fix potential segment overlap in ELF loader
Date:   Thu, 16 Jan 2020 11:59:12 -0500
Message-Id: <20200116170509.12787-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Rudo <prudo@linux.ibm.com>

[ Upstream commit 6339a3889ad4d0dd930ed7a1e873fb81d3e690f7 ]

When loading an ELF image via kexec_file the segment alignment is ignored
in the calculation for the load address of the next segment. When there are
multiple segments this can lead to segment overlap and thus load failure.

Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Fixes: 8be018827154 ("s390/kexec_file: Add ELF loader")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/kexec_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/kexec_elf.c b/arch/s390/kernel/kexec_elf.c
index 602e7cc26d11..5cf340b778f1 100644
--- a/arch/s390/kernel/kexec_elf.c
+++ b/arch/s390/kernel/kexec_elf.c
@@ -58,7 +58,7 @@ static int kexec_file_add_elf_kernel(struct kimage *image,
 		if (ret)
 			return ret;
 
-		data->memsz += buf.memsz;
+		data->memsz = ALIGN(data->memsz, phdr->p_align) + buf.memsz;
 	}
 
 	return 0;
-- 
2.20.1

