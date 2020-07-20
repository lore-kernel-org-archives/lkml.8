Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48C8C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 857AE2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261792;
	bh=VjMVfVMbfkUwYPRfFvQ/y8lTlLvLih9l3qIfd7dySXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L0w6eb+I6RNkd8BL0pU+8q1rjxCm9xueV5Ky8kyQwL3k0lqrxTk2+BG54QXJlN++a
	 lKFQnPihjDmmOQO/MLtOpxTkhqWVLs7USKil/QOg1Wk1XCR7BED35eDF9AcXcN7a1/
	 vq5bH4c7EnPZTWFn/WTIns/oqtErRoDktpcpdyNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388557AbgGTQQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388535AbgGTQQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:16:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 793CB2064B;
        Mon, 20 Jul 2020 16:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261789;
        bh=VjMVfVMbfkUwYPRfFvQ/y8lTlLvLih9l3qIfd7dySXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HiYrvzlIQjDCrM+2CqKTJIzWkQjsdXULw9bB3FCDhXGQr5Q7QzeRPi+DeR01cLe81
         Ss08TvYNTsEm3CTj77d32A0ztnQcTPIjMeBnESsHh6z5gfKkaS03n78Z5HuwtrAcYg
         uo28yU9a5Yt1YnHuxzVflxJzKhdvenI2iq2N5mNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.7 212/244] ARM: dts: imx6qdl-gw551x: fix audio SSI
Date:   Mon, 20 Jul 2020 17:38:03 +0200
Message-Id: <20200720152835.940079177@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Harvey <tharvey@gateworks.com>

commit 4237c625304b212a3f30adf787901082082511ec upstream.

The audio codec on the GW551x routes to ssi1.  It fixes audio capture on
the device.

Cc: stable@vger.kernel.org
Fixes: 3117e851cef1 ("ARM: dts: imx: Add TDA19971 HDMI Receiver to GW551x")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -110,7 +110,7 @@
 		simple-audio-card,frame-master = <&sound_codec>;
 
 		sound_cpu: simple-audio-card,cpu {
-			sound-dai = <&ssi2>;
+			sound-dai = <&ssi1>;
 		};
 
 		sound_codec: simple-audio-card,codec {


