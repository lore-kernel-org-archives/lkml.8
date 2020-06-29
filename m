Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2019AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16D920760
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459959;
	bh=ioSyaGjCvfzZnI3fdQwKqO/uLgNluVhF9QS4HsmDDZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kU060+uOk3muXYG4nKubXFg9h27QKVeQP3HR5YMW3pspfidToXpeHjSxyPQmkA0Yf
	 qkVVzHXuQsDc0GXBcObJ0vyc2NKSwE25NhKZB1DeiWamteBZwX1EmSNowEL3OhOOqj
	 zuoiYdKyLBuj5wob+VUva2ibeiUfLgx7hXNcvPrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgF2Tp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:45:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387815AbgF2Tko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA3022488D;
        Mon, 29 Jun 2020 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444388;
        bh=ioSyaGjCvfzZnI3fdQwKqO/uLgNluVhF9QS4HsmDDZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tW99CFfkhLQ3TxNL0BfAdEzF98Vge19ogavxYoat4mivLoM0WSRZDPOZC4C3kkhZW
         sU0oum6lWW7QHPxFII1VG3JibF9TZL1JA7XdfnkoPYS/VwT7jHP0YKp/whU3+uNeF6
         jwWBzHRj+0pwu7apXMpkL3/Wiq4AczoYr5ZThCUg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/178] ASoC: q6asm: handle EOS correctly
Date:   Mon, 29 Jun 2020 11:23:30 -0400
Message-Id: <20200629152523.2494198-66-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 6476b60f32866be49d05e2e0163f337374c55b06 ]

Successful send of EOS command does not indicate that EOS is actually
finished, correct event to wait EOS is finished is EOS_RENDERED event.
EOS_RENDERED means that the DSP has finished processing all the buffers
for that particular session and stream.

This patch fixes EOS handling!

Fixes: 68fd8480bb7b ("ASoC: qdsp6: q6asm: Add support to audio stream apis")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200611124159.20742-3-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index e8141a33a55e5..835ac98a789cd 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -25,6 +25,7 @@
 #define ASM_STREAM_CMD_FLUSH			0x00010BCE
 #define ASM_SESSION_CMD_PAUSE			0x00010BD3
 #define ASM_DATA_CMD_EOS			0x00010BDB
+#define ASM_DATA_EVENT_RENDERED_EOS		0x00010C1C
 #define ASM_NULL_POPP_TOPOLOGY			0x00010C68
 #define ASM_STREAM_CMD_FLUSH_READBUFS		0x00010C09
 #define ASM_STREAM_CMD_SET_ENCDEC_PARAM		0x00010C10
@@ -546,9 +547,6 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 		case ASM_SESSION_CMD_SUSPEND:
 			client_event = ASM_CLIENT_EVENT_CMD_SUSPEND_DONE;
 			break;
-		case ASM_DATA_CMD_EOS:
-			client_event = ASM_CLIENT_EVENT_CMD_EOS_DONE;
-			break;
 		case ASM_STREAM_CMD_FLUSH:
 			client_event = ASM_CLIENT_EVENT_CMD_FLUSH_DONE;
 			break;
@@ -651,6 +649,9 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 			spin_unlock_irqrestore(&ac->lock, flags);
 		}
 
+		break;
+	case ASM_DATA_EVENT_RENDERED_EOS:
+		client_event = ASM_CLIENT_EVENT_CMD_EOS_DONE;
 		break;
 	}
 
-- 
2.25.1

