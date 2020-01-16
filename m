Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47527C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEE52072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216889;
	bh=CODGFaDMfu5utrqevmW4YohwWqC+gBcwGWeVRKV/k6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oinJVAdZwx5AELCINNP3ZxWUctjy7OfOElw98aK2Qq8WUti33oIqL9YVkpF5OjvIe
	 WO5YowLGF7i6SFLOejoPtP4TIleeOaMQpkw6PuGHFGoUPhXdFdNAY6dBo60qoJdb6p
	 47nRSU5mvyvQZqTezKdSUSnVhvY7zCifZ8xPIJKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390828AbgAPXV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:21:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390810AbgAPXVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:21:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CEAD20684;
        Thu, 16 Jan 2020 23:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216884;
        bh=CODGFaDMfu5utrqevmW4YohwWqC+gBcwGWeVRKV/k6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvqVsAzpTS9QylhXNWO34Pft9l5hoEq0/JWZnKqKeeAgVhZxBNrbx/9dGMJQdVb2L
         rv1bNT5iWQXLo6Mwwpr0ClRW62MXY6AXMSmndkyz9PEIWTXVQGJxe5hpaQ69svryOX
         H6fzMCqrQ9mN3lHmAZoEPZXrGWXU9/kP02ef7VYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 059/203] ASoC: core: Fix compile warning with CONFIG_DEBUG_FS=n
Date:   Fri, 17 Jan 2020 00:16:16 +0100
Message-Id: <20200116231749.178483016@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit bd0b609e0c3362cb167c51d4bd4330d79fc00987 upstream.

Paper over a compile warning:
  sound/soc/soc-pcm.c:1185:8: warning: unused variable ‘name’

Fixes: 0632fa042541 ("ASoC: core: Fix pcm code debugfs error")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20191107134833.1502-1-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-pcm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1148,7 +1148,9 @@ static int dpcm_be_connect(struct snd_so
 {
 	struct snd_soc_dpcm *dpcm;
 	unsigned long flags;
+#ifdef CONFIG_DEBUG_FS
 	char *name;
+#endif
 
 	/* only add new dpcms */
 	for_each_dpcm_be(fe, stream, dpcm) {


