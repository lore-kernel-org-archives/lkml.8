Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CEFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B11D208A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658741;
	bh=mJrXbTTQE/TU8fIHQr6LBtPOS7pr8EpfcxM26Vd55II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=METKiTYdkrNxA82SnTR33bj9vqXECdcPVMZsaQDXEPSMdnZHFCSXnHTV4d28OFSiV
	 gEQpT+NL4255gQaVcCulrP3+bb519zhl0IQSKLMt/8BdrFWWfPf24PwPqMagQAhduh
	 yEQPLbFIvaqLvSUwnuK81/Z3zds4iCdbHV2k5cpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbgFHXZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731009AbgFHXUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:20:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8CEF20872;
        Mon,  8 Jun 2020 23:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658440;
        bh=mJrXbTTQE/TU8fIHQr6LBtPOS7pr8EpfcxM26Vd55II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/FnaTeHbrpsnlyJDNogPZnoXDW7WTyikCehhoBkWtwLJkggGwiJy1Ir7dyR/aHQC
         L4Ba9A15EsYp89ZL3C9oC1cnVjuMSXap7I7a+oL7Aya7QQOHc6eqx9K2CFQUWlD1eC
         Vy8ETduESxOgHtFsm8qIfcjR5czckFDCIZ7yQQLw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 083/175] selftests/bpf: Fix memory leak in extract_build_id()
Date:   Mon,  8 Jun 2020 19:17:16 -0400
Message-Id: <20200608231848.3366970-83-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

[ Upstream commit 9f56bb531a809ecaa7f0ddca61d2cf3adc1cb81a ]

getline() allocates string, which has to be freed.

Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_BUILD_ID")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/20200429012111.277390-7-andriin@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 3bf18364c67c..8cb3469dd11f 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -293,6 +293,7 @@ int extract_build_id(char *build_id, size_t size)
 		len = size;
 	memcpy(build_id, line, len);
 	build_id[len] = '\0';
+	free(line);
 	return 0;
 err:
 	fclose(fp);
-- 
2.25.1

