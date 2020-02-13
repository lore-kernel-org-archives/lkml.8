Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60872C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CE4206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609998;
	bh=lbxSGU59kmdmmuKS911zLdpcn6ZObIXNyQT2hHgEQDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CeqQgmWxlYcuCuYgSTncI2Baxg0STMAFyJQqQLUaSWAK2ekzqZvzZYdZ17461KU8P
	 QmwUXeP2cZrd/Ih3Q9EOzDHRKGBR2MZvNMYhsSvuD/tkEGDfLcg0DmW6PtqFB8Q0rk
	 7fhcf4PvQH8daAQsy4eC2hQTsGyGIsJDq5jr0XKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgBMQGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:06:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728420AbgBMPXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:35 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18BE8246B1;
        Thu, 13 Feb 2020 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607415;
        bh=lbxSGU59kmdmmuKS911zLdpcn6ZObIXNyQT2hHgEQDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=du58Y1/TTa5iiEAibexsqWsSFZSqgNxxHZr7+RW91exslW5dMnkriwZdTScP0xtkV
         3L9TQfSMHQcwfU4m21vLDzPcbov13CWRSVjNtOkGV/APU7I2Mow5ubuyVkBVCkeMCT
         Jc8tnIbcm215mP3r2DdaA4IJPd7tIBi69W72qat4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 021/116] ALSA: dummy: Fix PCM format loop in proc output
Date:   Thu, 13 Feb 2020 07:19:25 -0800
Message-Id: <20200213151851.123743279@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 2acf25f13ebe8beb40e97a1bbe76f36277c64f1e upstream.

The loop termination for iterating over all formats should contain
SNDRV_PCM_FORMAT_LAST, not less than it.

Fixes: 9b151fec139d ("ALSA: dummy - Add debug proc file")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200201080530.22390-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/drivers/dummy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -925,7 +925,7 @@ static void print_formats(struct snd_dum
 {
 	int i;
 
-	for (i = 0; i < SNDRV_PCM_FORMAT_LAST; i++) {
+	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
 		if (dummy->pcm_hw.formats & (1ULL << i))
 			snd_iprintf(buffer, " %s", snd_pcm_format_name(i));
 	}


