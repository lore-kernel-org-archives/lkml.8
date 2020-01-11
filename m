Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CBAC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2399D205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738335;
	bh=pKlEvZStrRWwiobdGwZb/2fTuQEcO/9zO6CNnj/hiDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zugmrjYDu6aBuwvj50ScVYqGFudEddLvnmZ7EcmxIKiVPf/4jGKCpNQ1p69k04cXm
	 GqRdNcnQvm88Fpjxhdd8ebWN0LPH3xj1GHInb0g/0Vs3Kmj+YbuQD0mtXSBmtrn0yI
	 1jjX7yuu8Q2a/g0NPdQDBG43TLsc5StFCyrplXRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgAKKZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:25:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730665AbgAKKZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:25:29 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D56205F4;
        Sat, 11 Jan 2020 10:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738329;
        bh=pKlEvZStrRWwiobdGwZb/2fTuQEcO/9zO6CNnj/hiDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RavqkTzBo6aydm698/JdUXo8Xuab550o3+uBnaEO5oUgV450etGQMabVuPrHVE5il
         RKTEdsUEDpd7ebnihSElLiypQi72DWc83HuXml0Rqt0KBjtba2T5ydi3Dy6K52hUQe
         XLcRgRYB/NbDNyxWFSQfXc9jNCDZGeh+hJKGJgOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Curtis Malainey <cujomalainey@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 048/165] ASoC: SOF: Intel: split cht and byt debug window sizes
Date:   Sat, 11 Jan 2020 10:49:27 +0100
Message-Id: <20200111094925.414499004@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Curtis Malainey <cujomalainey@chromium.org>

[ Upstream commit f84337c3fb8ff4d533ccbed0d2db4e8587d0ff58 ]

Turns out SSP 3-5 are only available on cht, to avoid dumping on
undefined registers let's split the definition.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191210004854.16845-7-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/byt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index a1e514f71739..41008c974ac6 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -24,7 +24,8 @@
 #define DRAM_OFFSET		0x100000
 #define DRAM_SIZE		(160 * 1024)
 #define SHIM_OFFSET		0x140000
-#define SHIM_SIZE		0x100
+#define SHIM_SIZE_BYT		0x100
+#define SHIM_SIZE_CHT		0x118
 #define MBOX_OFFSET		0x144000
 #define MBOX_SIZE		0x1000
 #define EXCEPT_OFFSET		0x800
@@ -75,7 +76,7 @@ static const struct snd_sof_debugfs_map byt_debugfs[] = {
 	 SOF_DEBUGFS_ACCESS_D0_ONLY},
 	{"dram", BYT_DSP_BAR, DRAM_OFFSET, DRAM_SIZE,
 	 SOF_DEBUGFS_ACCESS_D0_ONLY},
-	{"shim", BYT_DSP_BAR, SHIM_OFFSET, SHIM_SIZE,
+	{"shim", BYT_DSP_BAR, SHIM_OFFSET, SHIM_SIZE_BYT,
 	 SOF_DEBUGFS_ACCESS_ALWAYS},
 };
 
@@ -102,7 +103,7 @@ static const struct snd_sof_debugfs_map cht_debugfs[] = {
 	 SOF_DEBUGFS_ACCESS_D0_ONLY},
 	{"dram", BYT_DSP_BAR, DRAM_OFFSET, DRAM_SIZE,
 	 SOF_DEBUGFS_ACCESS_D0_ONLY},
-	{"shim", BYT_DSP_BAR, SHIM_OFFSET, SHIM_SIZE,
+	{"shim", BYT_DSP_BAR, SHIM_OFFSET, SHIM_SIZE_CHT,
 	 SOF_DEBUGFS_ACCESS_ALWAYS},
 };
 
-- 
2.20.1



