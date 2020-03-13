Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4143C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9C120746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584094086;
	bh=eOHdzKsuiDRxoSeOKx1T/q3qpP4W3MG5l3YkkamaGsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=awJ8mBoas8fByHq1R0T3QBkoF4Q1I4t9Kqwrze/PWlUxaOW+RM9sWm0T1WrDlN3K/
	 8wsi96RIl9XO1qig7U16OtMVgcp3j6QVBlj0bAxf9hbsVZ32QxH8lxO6ZVETMNXTU8
	 y3Ul1wx9AhU6x6N0Y/0eozcxgXAmDhNLuKeonpt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgCMKIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgCMKIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:08:01 -0400
Received: from localhost.localdomain (unknown [171.76.107.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B4842074D;
        Fri, 13 Mar 2020 10:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584094081;
        bh=eOHdzKsuiDRxoSeOKx1T/q3qpP4W3MG5l3YkkamaGsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSsgxDNmXiZrw4DKDd+KmQgD7Mgpyg3FDetFtJO6IsqW34smLhVCZK3ICsd1Wdd9c
         fhb6Qqmvm5ZrRg3Urk8f2gr4LoQRruUovC/BWuvANCIKxMrkFbAwOCjUqWCtD+JmqW
         7EBwxmyIup0Qr/J7Ux64EwNssBQKtBnB2KH1Hu7o=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] ALSA: compress: bump the version
Date:   Fri, 13 Mar 2020 15:37:08 +0530
Message-Id: <20200313100708.1558658-10-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313095318.1555163-2-vkoul@kernel.org>
References: <20200313095318.1555163-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have added support for bunch of new decoders and parameters for
decoders. To help users find the support bump the version up to 0,2,0.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/uapi/sound/compress_offload.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index 56d95673ce0f..7184265c0b0d 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -31,7 +31,7 @@
 #include <sound/compress_params.h>
 
 
-#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 2)
+#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 2, 0)
 /**
  * struct snd_compressed_buffer - compressed buffer
  * @fragment_size: size of buffer fragment in bytes
-- 
2.24.1

