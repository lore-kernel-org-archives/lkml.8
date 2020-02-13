Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08C2C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2F220661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608768;
	bh=AzyPehGb52ECJ+zdCScD6NmW/QG6jNq0X+C2XumulvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0N2P5YaaZQ4FqnlS0YtVq+ZW/2RL4khXUrfLE+I9vYAa9FZKMIZ4hFLLHnZalQFQh
	 Tfa4cpKDQZCduJg4zzY5zib0wOUHIfuSG5PkyofqeSvUIcdALA8WULorEH1jmO2Wcw
	 o569WH+jl3e142JZ9ugjcYKTHShLePy3u7H1rtLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgBMPqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:46:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbgBMP1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:21 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241042468D;
        Thu, 13 Feb 2020 15:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607641;
        bh=AzyPehGb52ECJ+zdCScD6NmW/QG6jNq0X+C2XumulvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UD9RkW9ZPiByenwQGM5HJNouJp1Kw4K5aUAfD9URzEiDlqb40CM6aEUaoYLqujZ7e
         sXI9klPcv34wAX3PmUxyBuwTUfSHP05LEObI9hLT0W2+IE8Pa9ruxvFjq1YLvDc97M
         uwGwz8/+NQEldGUcK8KcFvQXPt6tG5/RgZVJnZd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 5.4 47/96] ARM: dts: meson8: use the actual frequency for the GPUs 182.1MHz OPP
Date:   Thu, 13 Feb 2020 07:20:54 -0800
Message-Id: <20200213151857.588130768@linuxfoundation.org>
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

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

commit fe634a7a9a57fb736e39fb71aa9adc6448a90f94 upstream.

The clock setup on Meson8 cannot achieve a Mali frequency of exactly
182.15MHz. The vendor driver uses "FCLK_DIV7 / 2" for this frequency,
which translates to 2550MHz / 7 / 2 = 182142857Hz.
Update the GPU operating point to that specific frequency to not confuse
myself when comparing the frequency from the .dts with the actual clock
rate on the system.

Fixes: 7d3f6b536e72c9 ("ARM: dts: meson8: add the Mali-450 MP6 GPU")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/meson8.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -129,8 +129,8 @@
 	gpu_opp_table: gpu-opp-table {
 		compatible = "operating-points-v2";
 
-		opp-182150000 {
-			opp-hz = /bits/ 64 <182150000>;
+		opp-182142857 {
+			opp-hz = /bits/ 64 <182142857>;
 			opp-microvolt = <1150000>;
 		};
 		opp-318750000 {


