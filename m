Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A676C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241DE20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608177;
	bh=IiXe6jCzo8BSAkTH7IipY/0w/iKdCxdpdW2+rrn8XmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qVnZUfUywc2IWk1KDh90upDfjSNowiYdKxrfsqOMtAhXr8XJKC1c1KLyeW1Fc8D2I
	 w603zrGFMPWgu0MyMs+WWqw2Vg2dAG4OspVSXmXTWZwfoaluCcuyX4WB+MxLKeyFF1
	 GM2YJDEK8t0rLyo/qQ5GOhFEg0dQ1lBN+9WZzgmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbgBMPah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729408AbgBMP12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:28 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ABAF206DB;
        Thu, 13 Feb 2020 15:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607648;
        bh=IiXe6jCzo8BSAkTH7IipY/0w/iKdCxdpdW2+rrn8XmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqNctNpwfhxXQySG9JiCNnyomEiI3mzNN2NCacRCK5NWNCqwZSeLTqr2G8O2DUq3u
         SLw3SlVHB6FhD19PtClIl8HYdPK8rtlxko88CzRzVLOqTfsS16hh2aN5+IAAgVJu/9
         wduqHl8GPWFUsq+zrJLc7ofYdxg8Oj2ZZZh+B7PI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.4 41/96] arm64: dts: qcom: msm8998: Fix tcsr syscon size
Date:   Thu, 13 Feb 2020 07:20:48 -0800
Message-Id: <20200213151855.123670622@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

commit 05caa5bf9cab9983dd7a50428c46b7e617ba20d6 upstream.

The tcsr syscon region is really 0x40000 in size.  We need access to the
full region so that we can access the axi resets when managing the
modem subsystem.

Fixes: c7833949564e ("arm64: dts: qcom: msm8998: Add smem related nodes")
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Link: https://lore.kernel.org/r/20191107045948.4341-1-jeffrey.l.hugo@gmail.com
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/qcom/msm8998.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -985,7 +985,7 @@
 
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
-			reg = <0x01f40000 0x20000>;
+			reg = <0x01f40000 0x40000>;
 		};
 
 		tlmm: pinctrl@3400000 {


