Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F5DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B0F20716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597688481;
	bh=rPICp0WoBucKCukQoih/+t/Stt8ibUqmWeMuQjHzkWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CViD1OSwCoS3MqaX84pULdU0IxJLyAR6vaW6nw2n4AbINlZfA2AQj1RKQH5REDYj+
	 CNDQsMUC1rVSWjRQO8KQzhRiR6QJGj9JAskjoKxg9Ivv9X3e1JFjWVcBu63YPU3CrD
	 4mzl8IVMizEIaEsEw5SAg2XzJ+aZ1dODxJwpleEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390874AbgHQSVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388288AbgHQQEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:04:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5019F20825;
        Mon, 17 Aug 2020 16:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680247;
        bh=rPICp0WoBucKCukQoih/+t/Stt8ibUqmWeMuQjHzkWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLorjC/LN8Q2jieHMfUHyUKxIoEajO+YjeYmon3lTX5d8KWbT1BdX2yLV4CajFpWf
         cp/Exun62vNSpy9to/B073pj0CMOhbezZ5dS4ScJSXIj4DmSnlFij0h90Sc0dcpRp3
         ZY9+Dtdbk68v9uAlxn4GiS8xwhA1XJRBpONMpPSo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 111/270] ASoC: SOF: nocodec: add missing .owner field
Date:   Mon, 17 Aug 2020 17:15:12 +0200
Message-Id: <20200817143801.312750987@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 8753889e2720c1ef7ebf03370e384f5bf5ff4fab ]

This field is required for ASoC cards. Not setting it will result in a
module->name pointer being NULL and generate problems such as

cat /proc/asound/modules
 0 (efault)

Fixes: 8017b8fd37bf ('ASoC: SOF: Add Nocodec machine driver support')
Reported-by: Jaroslav Kysela <perex@perex.cz>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20200625191308.3322-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/nocodec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/nocodec.c b/sound/soc/sof/nocodec.c
index ea0fe9a09f3f5..71410116add1a 100644
--- a/sound/soc/sof/nocodec.c
+++ b/sound/soc/sof/nocodec.c
@@ -14,6 +14,7 @@
 
 static struct snd_soc_card sof_nocodec_card = {
 	.name = "nocodec", /* the sof- prefix is added by the core */
+	.owner = THIS_MODULE
 };
 
 static int sof_nocodec_bes_setup(struct device *dev,
-- 
2.25.1



