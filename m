Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3A9C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6184E20880
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738074;
	bh=uLLu5oc63WwBf7g8R0jV29KoDqKSvLMACvTHHtGtZvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a4eD/uRVKBmAhF9+aDOyfSgtGvs7h89K55Qp90PmMQ8Jtd95tERnUQEN7/yCQmTu0
	 sBhNX3bvKqZrV/tom8d3h1OVi2wtHzM566ZkWDZWku20BzqC3gQzJpr7rTwOezqqME
	 hCf95ttBT41wUa4XEHDwrb3BSEWjA6kuTNdArNqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgAKKVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbgAKKVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:21:10 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E1D20880;
        Sat, 11 Jan 2020 10:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738069;
        bh=uLLu5oc63WwBf7g8R0jV29KoDqKSvLMACvTHHtGtZvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWKE7y5jVQ3Y3lUCdNsISPJNhbMTBocoIbEMhPQc7tS0gVHePQwDnzSTKodj6Zxp4
         hZA8eQ04IyW0PXwawrjS4COQQscKn5rwBadrxoVm7tOplFYJ7hXt2Yi4wtG3jU8dlb
         WzrdS+p+fU3TsDMl0XMIReo01eSyT7og7nGLoRPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 019/165] ASoC: Intel: bytcr_rt5640: Update quirk for Teclast X89
Date:   Sat, 11 Jan 2020 10:48:58 +0100
Message-Id: <20200111094922.525159357@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 7eccc05c7101f34cc36afe9405d15de6d4099fb4 ]

When the Teclast X89 quirk was added we did not have jack-detection
support yet.

Note the over-current detection limit is set to 2mA instead of the usual
1.5mA because this tablet tends to give false-positive button-presses
when it is set to 1.5mA.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191203221442.2657-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index dd2b5ad08659..243f683bc02a 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -707,13 +707,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_MCLK_EN),
 	},
 	{
+		/* Teclast X89 */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "TECLAST"),
 			DMI_MATCH(DMI_BOARD_NAME, "tPAD"),
 		},
 		.driver_data = (void *)(BYT_RT5640_IN3_MAP |
-					BYT_RT5640_MCLK_EN |
-					BYT_RT5640_SSP0_AIF1),
+					BYT_RT5640_JD_SRC_JD1_IN4P |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_1P0 |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
 	},
 	{	/* Toshiba Satellite Click Mini L9W-B */
 		.matches = {
-- 
2.20.1



