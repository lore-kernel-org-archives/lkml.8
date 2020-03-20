Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209F1C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65C220709
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryUfaQrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCTU4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:56:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35311 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgCTU4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:56:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id m15so5660577lfp.2;
        Fri, 20 Mar 2020 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9bVlt9J+drXkckOzEfmQ7Nr2T5UaZ8eTOrZjkCCIRI=;
        b=ryUfaQrL0Q5vr3B5n7MyuIZSXWMM0WtOIYrcnmF7prGWtEqhrXWMoXEvVHIJ7CeTin
         SZqVToNvK9DElziI+cDv9Kwse5rzlO5PKeO9sqxvrY6aSgUS0cGfRj82oi6Gh+bUgW3p
         FGEIMvKzfLG5beSjDhb51mKVIiNA83nQWzNF9QO4W0/KhXYnfHxyd+rIncHhWc4ROYL6
         gdgD8bFTEMDTW10/5m4UtBBxWKMScKvlRQebVXgEsw8P0caHFL1iAig/2LgVBXHKyVpA
         qNWB9n1GNaFI/i4fdhZ7AYI43E3lkpGnSKiXpr1TFCKUlqZwISKAIhIvCTi32fvy2/kK
         mpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9bVlt9J+drXkckOzEfmQ7Nr2T5UaZ8eTOrZjkCCIRI=;
        b=dZHXUs4uu6eUaRNTiubLxhCpYo8E6wgghgJpI4UHEwcI9AkQCJE1JDa6gCAt7ayuFe
         aXH62LKvpKhqHECGTHj59LlY1HTV7Ozvo2xyfdPtkNoKYdaRmDl7dY/4I17B2my72Roq
         9J0h0tBAOJqz503fHVlvRUVRmcx5RbzJkTXii12OlN0Hc4zqi50IPjBgDFz9HeggsVm/
         6+8tKUlW+mA+MvbOF76oXt8vL+TdhVb6Omw0RLptaI5HFEb9aSIP/DWQuW9L85Bc0ibP
         DqmZ0nk25eN/Wu2bY+jdecEITR8LN+FKVyJH6gyy4xlhUVWI4xSGmVzODRytg5nWdOtK
         AoAg==
X-Gm-Message-State: ANhLgQ3BRHar7v6n+FCKrDWCALC6Y64KxCj952PYGXvAJgTfhH/4fG/x
        CaXyZ15hx80ggpCeH7P9TrU=
X-Google-Smtp-Source: ADFU+vughOvcS0nxYLm8TI0hZE316VSnBaspUKHj3rqn6C2EVcQR2cAQHbYoZ7Zu4ztnWJt/mEHu9w==
X-Received: by 2002:ac2:54af:: with SMTP id w15mr6443768lfk.17.1584737775436;
        Fri, 20 Mar 2020 13:56:15 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id 1sm3873356lft.47.2020.03.20.13.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:56:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: sound: tegra-wm8903: Document built-in microphone audio source
Date:   Fri, 20 Mar 2020 23:55:03 +0300
Message-Id: <20200320205504.30466-2-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320205504.30466-1-digetx@gmail.com>
References: <20200320205504.30466-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal microphone source is needed in order to be able to describe
the hardware audio routing for devices that have the built-in microphone
in addition to the external Mic Jack.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
index b795d282818d..a8f2b0c56c79 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
@@ -18,6 +18,7 @@ Required properties:
   * Headphone Jack
   * Int Spk
   * Mic Jack
+  * Int Mic
 
 - nvidia,i2s-controller : The phandle of the Tegra I2S1 controller
 - nvidia,audio-codec : The phandle of the WM8903 audio codec
-- 
2.25.1

