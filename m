Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75680C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4299F206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948371;
	bh=QP6tJUUtGHfRPksj92wCUrbYb57oWUe1ma4dltobteE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HnZBBdEgH/0rAy1ud6u1+5rU64Jo2Nu3qgtZ0btu2MXIOcW6c7Z5n6JRdgeW9t1do
	 QAsfffmEcijYreZPBE5zz6g9SQjBGlqe9MwcZEVVjudsqDaEvb6ykycs4GuAhLx6GA
	 TfQEcMXMqFmAh8OuWmY4ie5w6ZluGN6y/wF2Pwac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393862AbgFWVj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388573AbgFWUHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:07:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9FF12064B;
        Tue, 23 Jun 2020 20:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942829;
        bh=QP6tJUUtGHfRPksj92wCUrbYb57oWUe1ma4dltobteE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E13t2jkpKUJQ1W2wiMbtrRBzuCzqJwACtlJp3h4sG98KWwvc3Q4PEkdVedbUqVriL
         tDHoRatthQYyq1+pfa6VSWM0WaNx8QKBV8nL1zYXMMAzsU+UwoZtnKatfF5nhO5W4c
         s+Awh+4nYt5Ph4lfNtK7XMeLhS1WMRsbiY2/3C2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 152/477] ASoC: component: suppress uninitialized-variable warning
Date:   Tue, 23 Jun 2020 21:52:29 +0200
Message-Id: <20200623195414.778521596@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 946f88a6c63d1..e0371e70242d5 100644
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



