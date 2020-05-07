Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C43AC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120B321835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879079;
	bh=b1/YLFC+l6epGRK0csxeBGfOSfYmlenINjpg49VDwYs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ecX0eeH6A/EOogVYrm6vbn1KMzIw8ReGsdivhCNnPUBs6O4ttgysl4qEOC8fKQ0rY
	 Fr6nySvx765uuY9JeH5MdHcUwjlXk069Ia0gP0nxpRKlVcI0x47eO6Zhe+UiTvjd9p
	 2O0jML9g0DCRmh7BrpEQZd0w7c5YgYneQim+X8XE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgEGTR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgEGTR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:17:57 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94100208D6;
        Thu,  7 May 2020 19:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879077;
        bh=b1/YLFC+l6epGRK0csxeBGfOSfYmlenINjpg49VDwYs=;
        h=Date:From:To:Cc:Subject:From;
        b=F4e/oI0NaaKvrBApNt24/dZC1saXWd8uYNKxsmU5yUG+byaspmcBnOEtx5MGTrRTT
         D+SWYBU9d7o55LtwkRevIdSjZlA3cqxe9Yn3Jhph1oHpckG7n8ViaUUFsKnsYQ48TJ
         0cGOJmJEepFSp37TN2BJZaM0vAUxKx2e+gdet7rs=
Date:   Thu, 7 May 2020 14:22:23 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: Replace zero-length array with flexible-array
Message-ID: <20200507192223.GA16335@embeddedor>
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
 include/sound/control.h     |    2 +-
 include/sound/intel-nhlt.h  |    6 +++---
 sound/core/oss/pcm_plugin.h |    2 +-
 sound/usb/usx2y/usbusx2y.h  |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index 11feeee31e35..aeaed2a05bae 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -75,7 +75,7 @@ struct snd_kcontrol {
 	unsigned long private_value;
 	void *private_data;
 	void (*private_free)(struct snd_kcontrol *kcontrol);
-	struct snd_kcontrol_volatile vd[0];	/* volatile data */
+	struct snd_kcontrol_volatile vd[];	/* volatile data */
 };
 
 #define snd_kcontrol(n) list_entry(n, struct snd_kcontrol, list)
diff --git a/include/sound/intel-nhlt.h b/include/sound/intel-nhlt.h
index f657fd8fc0ad..743c2f442280 100644
--- a/include/sound/intel-nhlt.h
+++ b/include/sound/intel-nhlt.h
@@ -50,7 +50,7 @@ enum nhlt_device_type {
 
 struct nhlt_specific_cfg {
 	u32 size;
-	u8 caps[0];
+	u8 caps[];
 } __packed;
 
 struct nhlt_fmt_cfg {
@@ -60,7 +60,7 @@ struct nhlt_fmt_cfg {
 
 struct nhlt_fmt {
 	u8 fmt_count;
-	struct nhlt_fmt_cfg fmt_config[0];
+	struct nhlt_fmt_cfg fmt_config[];
 } __packed;
 
 struct nhlt_endpoint {
@@ -80,7 +80,7 @@ struct nhlt_endpoint {
 struct nhlt_acpi_table {
 	struct acpi_table_header header;
 	u8 endpoint_count;
-	struct nhlt_endpoint desc[0];
+	struct nhlt_endpoint desc[];
 } __packed;
 
 struct nhlt_resource_desc  {
diff --git a/sound/core/oss/pcm_plugin.h b/sound/core/oss/pcm_plugin.h
index 8d2f7a4e3ab6..46e273bd4a78 100644
--- a/sound/core/oss/pcm_plugin.h
+++ b/sound/core/oss/pcm_plugin.h
@@ -64,7 +64,7 @@ struct snd_pcm_plugin {
 	char *buf;
 	snd_pcm_uframes_t buf_frames;
 	struct snd_pcm_plugin_channel *buf_channels;
-	char extra_data[0];
+	char extra_data[];
 };
 
 int snd_pcm_plugin_build(struct snd_pcm_substream *handle,
diff --git a/sound/usb/usx2y/usbusx2y.h b/sound/usb/usx2y/usbusx2y.h
index e0f77172ce8f..144b85f57bd2 100644
--- a/sound/usb/usx2y/usbusx2y.h
+++ b/sound/usb/usx2y/usbusx2y.h
@@ -18,7 +18,7 @@ struct snd_usX2Y_AsyncSeq {
 struct snd_usX2Y_urbSeq {
 	int	submitted;
 	int	len;
-	struct urb	*urb[0];
+	struct urb	*urb[];
 };
 
 #include "usx2yhwdeppcm.h"

