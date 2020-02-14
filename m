Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B041C3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD1D2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701686;
	bh=lkT4t2JPsfUiREueM4DtSYmWVfxxScuuhymixnWu/xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=glsBJRFZvU28mAOcpuxSUJ/axLk/nGyyJhiwMmEI+B4RbJGQZIfmEtzSrtqfCEXM/
	 2sJMvB8Y5wkibEdXNgDj1B93xU7gCeZwH88uwFVRQaUQTnv2YKgSjJCF39fwxJfMEd
	 2tzH6R96CDdtFdx1i+lhu9UBZFzIXEzvQurl6YXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390320AbgBNQGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:06:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390161AbgBNQF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:05:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C952187F;
        Fri, 14 Feb 2020 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696326;
        bh=lkT4t2JPsfUiREueM4DtSYmWVfxxScuuhymixnWu/xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TF1soRcQa8IrahPQJNZWUyBcNp04RJIyFuP6sjMlFf8bjH8ZfA0j98AV1EQIzBauk
         uFe4b4kAO81tk2kG61IOTqXRXtCXpnP3gxOvQVlCc18cr8xnglDIjsx6kB4st9WC7d
         CupW8MBHCeZUfjcmQAAHL3YYRJzDC0A/kasuNtFA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 165/459] arm64: dts: qcom: msm8998: Fix tcsr syscon size
Date:   Fri, 14 Feb 2020 10:56:55 -0500
Message-Id: <20200214160149.11681-165-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

[ Upstream commit 05caa5bf9cab9983dd7a50428c46b7e617ba20d6 ]

The tcsr syscon region is really 0x40000 in size.  We need access to the
full region so that we can access the axi resets when managing the
modem subsystem.

Fixes: c7833949564e ("arm64: dts: qcom: msm8998: Add smem related nodes")
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Link: https://lore.kernel.org/r/20191107045948.4341-1-jeffrey.l.hugo@gmail.com
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index ffb64fc239ee5..ccd535edbf4e1 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -985,7 +985,7 @@
 
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
-			reg = <0x01f40000 0x20000>;
+			reg = <0x01f40000 0x40000>;
 		};
 
 		tlmm: pinctrl@3400000 {
-- 
2.20.1

