Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D363C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3F4214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865009;
	bh=NZdbmBMxMZkx8EYKeJ9/ZZ4AFshWIv+yA55Cw9MGyXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zJE22z+SyzSmqA0W/xdS95p2PGKYX8k1boAvA/01sHEZWLPqD+XpuLrcXbzDSZv2a
	 YP9M5dqGmcU6uSvH9Ljn67n6/UbCK5CMfiEwp4oT+u7KNWayhsd1DJZDLFn/kpQrkh
	 Z8Sd0Y8gynaaAm7QzJVzMf91x73dCgOE/c0vU+Kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391332AbgAXLX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391326AbgAXLXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:23:25 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60581214AF;
        Fri, 24 Jan 2020 11:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865005;
        bh=NZdbmBMxMZkx8EYKeJ9/ZZ4AFshWIv+yA55Cw9MGyXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gAHFqEPqizGhvgXjwdnRwuqc04dw2Y8VugpjrBA7NB8H5dboiqIu7A+0yIXTMtFmO
         z9HfnGHRkmkkJl/7B8hLjb1KFH2MN/wJnxpDLF3ItPM7YpyH+fH8E5uZiYqZ+MrskJ
         8nHE54exMb53aP4sUTyrYO9WlSPgmtQ5iIoxB58M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 426/639] ASoC: meson: axg-tdmout: right_j is not supported
Date:   Fri, 24 Jan 2020 10:29:56 +0100
Message-Id: <20200124093140.371988332@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 7e0d7d0fbd06af0507611f85dba8daf24832abd9 ]

Right justified format is actually not supported by the amlogic tdm output
encoder.

Fixes: c41c2a355b86 ("ASoC: meson: add tdm output driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/axg-tdmout.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/meson/axg-tdmout.c b/sound/soc/meson/axg-tdmout.c
index f73368ee1088f..d11acb3cc696f 100644
--- a/sound/soc/meson/axg-tdmout.c
+++ b/sound/soc/meson/axg-tdmout.c
@@ -136,7 +136,6 @@ static int axg_tdmout_prepare(struct regmap *map, struct axg_tdm_stream *ts)
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
-	case SND_SOC_DAIFMT_RIGHT_J:
 	case SND_SOC_DAIFMT_DSP_B:
 		val |= TDMOUT_CTRL0_INIT_BITNUM(2);
 		break;
-- 
2.20.1



