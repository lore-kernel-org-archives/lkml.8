Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DA3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 257DF2193E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448229;
	bh=r63CG3lRlNECeZaLITgREg5AuTfmTKB+Dc4lY/TJL8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L2mgHvSwD64DM9ZVpQeBAomlqKLnCyQMYBsc7uwNEj4EXZQCUQ9u6bbK8nvVhDo0u
	 W1Ii13alXm5oFZzHLgC7ZujUxJ2rHoR4Ni4jcaYvQZPehRnW++tMiwWzppVSbCi6GW
	 dISyRPdL7tnQSnye6u0SfJswIJ9XY40l81ITRiBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbgFRCnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbgFRBLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:11:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A7D02193E;
        Thu, 18 Jun 2020 01:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442689;
        bh=r63CG3lRlNECeZaLITgREg5AuTfmTKB+Dc4lY/TJL8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcJZmhJndLI06ksq0rZ4aFI1vqj6PF/uEUPBRML45u7TiKfw+9g0c/hyPg8HmqXld
         zhbh3z4/SBwT4NgLbDFx80LQHjIjtG3q5qRm5pbDglvihblbt9kNZHTWAOt4HA+Pgm
         iW5wrkUAd5inY1qE75ahHnK66+v/0OAS2VQYnJ2U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.7 155/388] ASoC: component: suppress uninitialized-variable warning
Date:   Wed, 17 Jun 2020 21:04:12 -0400
Message-Id: <20200618010805.600873-155-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit be16a0f0dc8fab8e25d9cdbeb4f8f28afc9186d2 ]

Old versions of gcc (tested on gcc-4.8) produce a warning for
correct code:

sound/soc/soc-compress.c: In function 'soc_compr_open':
sound/soc/soc-compress.c:75:28: error: 'component' is used uninitialized in this function [-Werror=uninitialized]
  struct snd_soc_component *component, *save = NULL;

Change the for_each_rtd_components() macro to ensure 'component'
gets initialized to a value the compiler does not complain about.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20200428214754.3925368-1-arnd@arndb.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 946f88a6c63d..e0371e70242d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1177,7 +1177,7 @@ struct snd_soc_pcm_runtime {
 #define asoc_rtd_to_codec(rtd, n) (rtd)->dais[n + (rtd)->num_cpus]
 
 #define for_each_rtd_components(rtd, i, component)			\
-	for ((i) = 0;							\
+	for ((i) = 0, component = NULL;					\
 	     ((i) < rtd->num_components) && ((component) = rtd->components[i]);\
 	     (i)++)
 #define for_each_rtd_cpu_dais(rtd, i, dai)				\
-- 
2.25.1

