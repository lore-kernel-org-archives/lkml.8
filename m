Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C114C3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB12217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608408;
	bh=f1s+YvCK7KWxdlT3jqyahDQ8NHLzxmyGOCafi62aq2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aiQ8n+4L/x5DG3nlOfCgi7ZFT1MI9gOJXg5uzRL1g0TAjeehJWegVBk2UrHVa1Yo9
	 FRe9pmum0iJrOvdsBIh88Hsj2nHrTPx5qcQR+LZwsWxldwDh7Zu5xkJtgI543eCGhP
	 /t3RV9i+q44H7a8YCSJvPrRkwRUtXB/qMLdYT1w0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgBMPkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:40:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387800AbgBMP2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:49 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 397E9222C2;
        Thu, 13 Feb 2020 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607729;
        bh=f1s+YvCK7KWxdlT3jqyahDQ8NHLzxmyGOCafi62aq2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w7VVvxXsCze9CO0K6WLlHrP9cAzv87prVwNjWP9+IWKr506B1xDwSDRrZVB4BzyYG
         P4oY38hiJGKsrhvpRYbjIRaHJfjpvIJn7goEmbpM1Cz73RBLxOEWbKwgxiP2/tmC5L
         dg0Sz9AYjePxG7ksGHCgNcnhzCeSN27BSqgRNBW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5.5 060/120] arm64: dts: renesas: r8a77990: ebisu: Remove clkout-lr-synchronous from sound
Date:   Thu, 13 Feb 2020 07:20:56 -0800
Message-Id: <20200213151921.899823700@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit bf2b74ce9b33a2edd6ba1930ce60a71830790910 upstream.

rcar_sound doesn't support clkout-lr-synchronous in upstream.
It was supported under out-of-tree rcar_sound.
upstream rcar_sound is supporting
	- clkout-lr-synchronous
	+ clkout-lr-asynchronous

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87mubt3tux.wl-kuninori.morimoto.gx@renesas.com
Fixes: 56629fcba94c698d ("arm64: dts: renesas: ebisu: Enable Audio")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -636,7 +636,6 @@
 	/* audio_clkout0/1/2/3 */
 	#clock-cells = <1>;
 	clock-frequency = <12288000 11289600>;
-	clkout-lr-synchronous;
 
 	status = "okay";
 


