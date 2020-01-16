Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CA7C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEC52082F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216922;
	bh=TK8UhmeaSYuBE2n/WDEOSS7O5CO8iTAHK/6H7NHM8Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GvJfEeBvEHjQXP5RIqogtfzV3KjJZmq3oM5TlGvF7pTJM13VmMaaO90hPC+mIlDtG
	 j6IMiFwIjMy0XQjOYUud1IS+wUBFPbgD6dZzMIYpDXBn9sqZ/kaGZl0dhPIBaRKnlw
	 jvADb0dHeHbmF3RAxY8/rXDgS3L1grKwtqIWNqoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390886AbgAPXWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:22:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388340AbgAPXVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:21:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A54D5206D9;
        Thu, 16 Jan 2020 23:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216913;
        bh=TK8UhmeaSYuBE2n/WDEOSS7O5CO8iTAHK/6H7NHM8Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dr0nS2fNPUMAkcqzSG5KjhJ4EN+q4q7cdY9v+AKw/3bsLdfw2vUDXi8JEiEAVL0ZB
         hd2qxv/TRtcoE8GqyjOfDpwXoM3e1y0h2HZuM+OcyJrFOR05NX9uiyqIL6jCMI13Se
         WnvdK6hOpTFaqCu69ltxp9CrAQwdW9uIpCVjY+Nc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 055/203] ASoC: dt-bindings: mt8183: add missing update
Date:   Fri, 17 Jan 2020 00:16:12 +0100
Message-Id: <20200116231748.781128530@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzung-Bi Shih <tzungbi@google.com>

commit 7cf2804775f8a388411624b3e768e55d08711e9d upstream.

Headset codec is optional.  Add missing update to DT binding document.

Fixes: a962a809e5e4 ("ASoC: mediatek: mt8183: make headset codec optional")
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20190920112320.166052-1-tzungbi@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt
+++ b/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt
@@ -2,9 +2,11 @@ MT8183 with MT6358, TS3A227 and MAX98357
 
 Required properties:
 - compatible : "mediatek,mt8183_mt6358_ts3a227_max98357"
-- mediatek,headset-codec: the phandles of ts3a227 codecs
 - mediatek,platform: the phandle of MT8183 ASoC platform
 
+Optional properties:
+- mediatek,headset-codec: the phandles of ts3a227 codecs
+
 Example:
 
 	sound {


