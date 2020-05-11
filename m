Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E260EC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBCC220722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589218937;
	bh=a3Iyd0AtJyoc/jnDu0wU+xUacgHz++uvOIDW/S793sI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mmX328SU2zjHXHz1AK+fCVjxSDux0vWz27zOPUi6e2UqfgLpaNEE9zDCIoEhlQvHn
	 qCfK/mN4K1KQZTknlTzfwKjnSN+TcLqcpR8T6vUPCIKNPCQ7YTfyYQJVP+pMZnfx8g
	 xEscfsBoawQx0Ti98Z2EMXrTFoAQo8WF+ohvD9uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgEKRmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgEKRmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:42:16 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97DD52070B;
        Mon, 11 May 2020 17:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589218935;
        bh=a3Iyd0AtJyoc/jnDu0wU+xUacgHz++uvOIDW/S793sI=;
        h=Date:From:To:Cc:Subject:From;
        b=qeIHokrg81Z1PpYZkgeLSu43ScttAjHimGyFySHs1JaZipMJOdDVuxsk37D1z6OxC
         tYAXdXDKrjgLv/54g3h+wFPvjPlsmwMX0TtiIKxKyX8Tij3eU5FdehSvD83aHJNf8F
         2H13GhEvNX4lBB+icp38E9m7TN/zUo1KJzbLtBbY=
Date:   Mon, 11 May 2020 12:46:47 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] ASoC: Intel: Skylake: Replace zero-length array with
 flexible-array
Message-ID: <20200511174647.GA17318@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/soc/intel/atom/sst-atom-controls.h |    2 +-
 sound/soc/intel/skylake/skl-i2s.h        |    2 +-
 sound/soc/intel/skylake/skl-topology.h   |    4 ++--
 sound/soc/intel/skylake/skl.h            |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.h b/sound/soc/intel/atom/sst-atom-controls.h
index 5356e954a732..620b48d2a064 100644
--- a/sound/soc/intel/atom/sst-atom-controls.h
+++ b/sound/soc/intel/atom/sst-atom-controls.h
@@ -410,7 +410,7 @@ struct sst_cmd_set_gain_dual {
 struct sst_cmd_set_params {
 	struct sst_destination_id dst;
 	u16 command_id;
-	char params[0];
+	char params[];
 } __packed;
 
 
diff --git a/sound/soc/intel/skylake/skl-i2s.h b/sound/soc/intel/skylake/skl-i2s.h
index d7c15873c0d4..dfce91e11be1 100644
--- a/sound/soc/intel/skylake/skl-i2s.h
+++ b/sound/soc/intel/skylake/skl-i2s.h
@@ -46,7 +46,7 @@ struct skl_i2s_config_mclk {
 struct skl_i2s_config_mclk_ext {
 	u32 mdivctrl;
 	u32 mdivr_count;
-	u32 mdivr[0];
+	u32 mdivr[];
 } __packed;
 
 struct skl_i2s_config_blob_signature {
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index e967800dbb62..d2cd8ef8e97f 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -119,7 +119,7 @@ struct skl_cpr_gtw_cfg {
 struct skl_dma_control {
 	u32 node_id;
 	u32 config_length;
-	u32 config_data[0];
+	u32 config_data[];
 } __packed;
 
 struct skl_cpr_cfg {
@@ -152,7 +152,7 @@ struct skl_up_down_mixer_cfg {
 
 struct skl_algo_cfg {
 	struct skl_base_cfg  base_cfg;
-	char params[0];
+	char params[];
 } __packed;
 
 struct skl_base_outfmt_cfg {
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 2bfbf59277c4..26057f38a014 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -49,7 +49,7 @@ struct skl_astate_param {
 
 struct skl_astate_config {
 	u32 count;
-	struct skl_astate_param astate_table[0];
+	struct skl_astate_param astate_table[];
 };
 
 struct skl_fw_config {

