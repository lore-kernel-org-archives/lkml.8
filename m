Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39178C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDBD20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgD1V3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:29:36 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:49389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgD1V3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:29:35 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MowOm-1ipG1f4B2s-00qQ8m; Tue, 28 Apr 2020 23:28:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_easrc: mark PM functions __maybe_unused
Date:   Tue, 28 Apr 2020 23:28:08 +0200
Message-Id: <20200428212847.2926376-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:g/lhTMinUlzKjoBIslu8GiMzNGRtNXY/jrd3tcEcByZM7OBbtB4
 ni0GNMk8eCslNsbQoe99tiGfiOdXiREgzjYzJbkoU6Gk+JZ4JeO5sI2qj8P4KGpZT9P+Qpv
 OP3lNJVvxL9erFHGc981EEpzkjD0ZH4y9R0sxGfaYsFoMgqhsVLURA0ObNL/JoA4VJawBEQ
 5h4lwzodX+tMpvTYcnD/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oBdNdq+NZP4=:b+wToa9B5rVpLOXSchgxRB
 6JY0FVY34Rhc/GAf+tjSYKy4MXV4qaTgTG6dYN5wSPegJebeSwS27m7aZuVQ2p0V0JvHtZlM2
 CZAdNivvwKyM8DqbHTmeOP8Ws3J6nV9hEySSUhGRlXBzi58wIqlk6I7aKeV++u1eXpQXarLWP
 Y4WeHJ5mJJpfoSBgECD62/Zw40cdE8e4wSNjxd7gqdjHEqP836JTXitS+jN7wYNRGORmEF900
 wiqiRd+7+LlP6OzSZzmAMWJ1AVFeRys93KH7Zr443pSex6o5J7I2MP3+DOOQDUH2JNq2oNJsK
 2PRFyvv0TxXvwbbxCxNLyYd+BE9QIp2qp2drXnC0Zo6k38X0hyIwYBOLGtnmMf2OQh3Ej2UR/
 BCCkSgysFjYNvrcPfRa7nmL3iz6KznihwJRTK+xLt2O6260HCIaDPAMQZQ6yAJwtaQaGltI5G
 gU7rRMRvOZ4jbBsj9TJpYh1EhjBuOy4kfHaf/X7++BoQmxYGNcO1/pukW8WHEbtprO/aFGwFz
 q5CWlPa6aRn7YY/S58jjmBQQBlPJJ6jXSKK2/mixiYwJujqPAc2q5JrMk6rFUdwTot1xfe58e
 pfG+CFfKV8UF/KDG1ONndrFM48axdxESV5ixK3Q+0mQaXFsHjZBglGRHxmsPuJ1fcuQUaxI+C
 eDJ2InmaQ4R26ibq7h3Bciv8hZurL2Hu/GvN74+utBermv8ICEKLI5EKwkadkfIfMx2pajs0d
 /BnMA4iVnSHHe4tP+6d7IMw65Yywf9QYytTzzNb/FMoaD+VnesyzDykKjEdRSat74JWPLxLOx
 jvcfhBtX3IIJoZYEHghRrBDMSt0Vbn+431jQTOXs6VwECwR+FQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ifdefs are hard, and in this driver the suspend/resume functions are
the only callers of some other helpers that trigger a harmless warning
when CONFIG_PM is disabled:

sound/soc/fsl/fsl_easrc.c:1807:12: warning: 'fsl_easrc_get_firmware' defined but not used [-Wunused-function]
 1807 | static int fsl_easrc_get_firmware(struct fsl_asrc *easrc)
      |            ^~~~~~~~~~~~~~~~~~~~~~
sound/soc/fsl/fsl_easrc.c:303:12: warning: 'fsl_easrc_resampler_config' defined but not used [-Wunused-function]
  303 | static int fsl_easrc_resampler_config(struct fsl_asrc *easrc)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~

Remove the #ifdef and just mark the callers as __maybe_unused to
suppress the warnings altogether.

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/fsl/fsl_easrc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 20326bffab64..c6b5eb2d2af7 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1997,8 +1997,7 @@ static int fsl_easrc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int fsl_easrc_runtime_suspend(struct device *dev)
+static __maybe_unused int fsl_easrc_runtime_suspend(struct device *dev)
 {
 	struct fsl_asrc *easrc = dev_get_drvdata(dev);
 	struct fsl_easrc_priv *easrc_priv = easrc->private;
@@ -2015,7 +2014,7 @@ static int fsl_easrc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int fsl_easrc_runtime_resume(struct device *dev)
+static __maybe_unused int fsl_easrc_runtime_resume(struct device *dev)
 {
 	struct fsl_asrc *easrc = dev_get_drvdata(dev);
 	struct fsl_easrc_priv *easrc_priv = easrc->private;
@@ -2094,7 +2093,6 @@ static int fsl_easrc_runtime_resume(struct device *dev)
 	clk_disable_unprepare(easrc->mem_clk);
 	return ret;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops fsl_easrc_pm_ops = {
 	SET_RUNTIME_PM_OPS(fsl_easrc_runtime_suspend,
-- 
2.26.0

