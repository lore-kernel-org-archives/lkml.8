Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5538EC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4EE218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879112;
	bh=7P91oAr2DUrWWPTylD+XYbTnS9ORls0mGBJzML58PV4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=cbXkWiLxlgz6T7W0FX+kwa/1y+gl8NsWyfXRej6wXK2ZgElckhrlAqBnRdBNJ4Dx7
	 P25uW8VN2NdWM1opNlWiBSABms5zONBtN10q+9pYdtXiCy128auOqi8wQW7HExc3GL
	 6owdb4+q191QhJoXKIpOTUGpqsi0fMKPq+frpqzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgEGTSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgEGTSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:18:31 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07EDE208E4;
        Thu,  7 May 2020 19:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879110;
        bh=7P91oAr2DUrWWPTylD+XYbTnS9ORls0mGBJzML58PV4=;
        h=Date:From:To:Cc:Subject:From;
        b=c04KiV21Vc4SC/41DebL9qH4wDdGit2GFHfK1vpNiwY/OzMO+6nmPbo4lG4hx2EBH
         9irmKFKonvNBXnd8b0YJaaNxcXMA67PjYTPEKMH1l/f83HIq4/sx1VNTWMB9ZS2Evi
         6oVpN0NWaQ+6DtOV0dtQNOcRE1p01eeC3O5QZD+Y=
Date:   Thu, 7 May 2020 14:22:56 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Replace zero-length array with flexible-array
Message-ID: <20200507192256.GA16375@embeddedor>
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
 sound/soc/sof/probe.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/probe.h b/sound/soc/sof/probe.h
index 45daa5552834..250c4817f637 100644
--- a/sound/soc/sof/probe.h
+++ b/sound/soc/sof/probe.h
@@ -36,7 +36,7 @@ struct sof_probe_point_desc {
 struct sof_ipc_probe_dma_add_params {
 	struct sof_ipc_cmd_hdr hdr;
 	unsigned int num_elems;
-	struct sof_probe_dma dma[0];
+	struct sof_probe_dma dma[];
 } __packed;
 
 struct sof_ipc_probe_info_params {
@@ -51,19 +51,19 @@ struct sof_ipc_probe_info_params {
 struct sof_ipc_probe_dma_remove_params {
 	struct sof_ipc_cmd_hdr hdr;
 	unsigned int num_elems;
-	unsigned int stream_tag[0];
+	unsigned int stream_tag[];
 } __packed;
 
 struct sof_ipc_probe_point_add_params {
 	struct sof_ipc_cmd_hdr hdr;
 	unsigned int num_elems;
-	struct sof_probe_point_desc desc[0];
+	struct sof_probe_point_desc desc[];
 } __packed;
 
 struct sof_ipc_probe_point_remove_params {
 	struct sof_ipc_cmd_hdr hdr;
 	unsigned int num_elems;
-	unsigned int buffer_id[0];
+	unsigned int buffer_id[];
 } __packed;
 
 int sof_ipc_probe_init(struct snd_sof_dev *sdev,

