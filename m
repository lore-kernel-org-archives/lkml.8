Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D5AC3F345
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D115D20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812776;
	bh=DSFBM7BNuOdb259OtWqXqz7MxqSG3Bzku8QvVO0rB9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jyju5kZQdpfTPgLRtwlOOKktTAUv9qcENiLSz5KtzNVdlxsJgH+ReTweziv6PTagO
	 eomYZTNZwXcIBxz77fD4rRUtpNUHpjGE4LOAFb+BXv2jS0B+666Q+fsomMCn//HKMM
	 iTx/JEXwQOCJbPDKDVWfAK9Sug6uwO9EPlBT+APg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388923AbgB0OMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:12:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388904AbgB0OMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:12:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D357524691;
        Thu, 27 Feb 2020 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812770;
        bh=DSFBM7BNuOdb259OtWqXqz7MxqSG3Bzku8QvVO0rB9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1BnQeGsi5htjETFa1XC3Hwnd+fb7R0HbLvy8K8j/AnKyRkw6NEoM6d3YTLp8o+FWq
         9WVHaFn0sbOCoe6vfcTxxi6U+0a3japMtXBEb68rxsNQtiFsLCxY8oaU+U4RQ/s/l7
         K46ke6wqw/3bcXxcKEGXyu+K4Ty5eZF6wqf4h7qU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.5 010/150] ASoC: codec2codec: avoid invalid/double-free of pcm runtime
Date:   Thu, 27 Feb 2020 14:35:47 +0100
Message-Id: <20200227132234.226756912@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Holland <samuel@sholland.org>

commit b6570fdb96edf45bcf71884bd2644bd73d348d1a upstream.

The PCM runtime was freed during PMU in the case that the event hook
encountered an error. However, it is also unconditionally freed during
PMD. Avoid a double-free by dropping the call to kfree in the PMU hook.

Fixes: a72706ed8208 ("ASoC: codec2codec: remove ephemeral variables")
Cc: stable@vger.kernel.org
Signed-off-by: Samuel Holland <samuel@sholland.org>
Link: https://lore.kernel.org/r/20200213061147.29386-2-samuel@sholland.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-dapm.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3888,9 +3888,6 @@ snd_soc_dai_link_event_pre_pmu(struct sn
 	runtime->rate = params_rate(params);
 
 out:
-	if (ret < 0)
-		kfree(runtime);
-
 	kfree(params);
 	return ret;
 }


