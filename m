Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC92DC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C6A20708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339247;
	bh=8cs4vnXlsHK6BO/SsjAWbXAI1jheAttXscHTh9YVgcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fu8kWP7jRHxNdxzcIPYzPFCLxOpuWYW7DluAth5GDuO6oCQ6tzQsX9OpoFMNHzmok
	 1Xjwz0EiY+ByoKOHJt+DD8g5DCp/Ay9CCHepMee3nzlBTo4oOQJ5jrMbK+JEIwBO+/
	 GIQeDVY9Zn/ZWoK24Syjvto7TYBuHR4bODegeOyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgBJMyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:54:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730140AbgBJMmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:42:03 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6624A2085B;
        Mon, 10 Feb 2020 12:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338523;
        bh=8cs4vnXlsHK6BO/SsjAWbXAI1jheAttXscHTh9YVgcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUz7dkzZ4dmAX9ow/eeBOqTp0Brrrni4lZx5fx7VbdCMEmg6a5eusAit359iCPicW
         J76CosQDL5IzAR6UcoEHhF8UGlA63aAzCn8tl1LPsk5W1Om6nllUgRAKVxHPJksd6T
         WswOCk4IznrhQLpMWlQGSiwoVc4uIQm68jaIlfNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rob Clark <robdclark@chromium.org>
Subject: [PATCH 5.5 289/367] drm: msm: mdp4: Adjust indentation in mdp4_dsi_encoder_enable
Date:   Mon, 10 Feb 2020 04:33:22 -0800
Message-Id: <20200210122450.516773342@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 251e3cb1418ff3f5061ee31335e346e852b16573 upstream.

Clang warns:

../drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c:124:3: warning:
misleading indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
         mdp4_crtc_set_config(encoder->crtc,
         ^
../drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c:121:2: note:
previous statement is here
        if (mdp4_dsi_encoder->enabled)
        ^

This warning occurs because there is a space after the tab on this line.
Remove it so that the indentation is consistent with the Linux kernel
coding style and clang no longer warns.

Fixes: 776638e73a19 ("drm/msm/dsi: Add a mdp4 encoder for DSI")
Link: https://github.com/ClangBuiltLinux/linux/issues/792
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
@@ -121,7 +121,7 @@ static void mdp4_dsi_encoder_enable(stru
 	if (mdp4_dsi_encoder->enabled)
 		return;
 
-	 mdp4_crtc_set_config(encoder->crtc,
+	mdp4_crtc_set_config(encoder->crtc,
 			MDP4_DMA_CONFIG_PACK_ALIGN_MSB |
 			MDP4_DMA_CONFIG_DEFLKR_EN |
 			MDP4_DMA_CONFIG_DITHER_EN |


