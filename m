Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3E8C35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6E820CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgEGVe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:34:58 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:45433 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGVe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:34:58 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M42Ss-1jWo9f1xCq-0004Xr; Thu, 07 May 2020 23:34:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tzung-Bi Shih <tzungbi@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: cros_ec_codec: allocate shash_desc dynamically
Date:   Thu,  7 May 2020 23:33:51 +0200
Message-Id: <20200507213405.1869430-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mP81ucRfJ0n2J5vksalKCXqnqjJ2Qyi7rUxUi+Qw5uBcwTowcbw
 i4m5Hv6OHNLto24ko3XxR5xHOB/S08y9gc/fl6B4hMFSideVdmA+s9jO6bt2XjI9ckPQVHW
 a0BuPYhrCl89Hl1V4BKX941bK0n9qyEWWdIbAjh3hqak4MlQciGt4WGj1qMnC4WuCem81/5
 q1TyibN00u3zbdg47U1lQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YlYAs++/TXg=:+/xJSWcjlOALQmASEKD+mM
 yE28stKlsO0l0oYH+yhPbxVPfRZki9ANaZmbRNEn0yVjhj16CnJSim2c857PjGt14hQYgPgkp
 k5APNe8omUP9RjBt7FuD8RnUvoCvnfFB6c9xFQWnymlWIjc29Ino8gqkY9Hxo7dIgxZ44pjVY
 Ierqf0RnUqWiPqlfb3qkMHqa9AM52UHzdjj+Wz7L2LzoDgVrON5iOf99LyVQ5h1wX82YvndCQ
 f/nWAUfncfUMg5TSoL69r87E7PzMf99DQ6e5MxTDZRgW+jT780zp1/ezpiHbiWYRYaYBRRuLK
 5r7+09VMTHG5vhPgizR+alHKZU+A/ZpVmhd9xhgDsE0WKV6ygg6FrlA87mjgj620TNb9NHDSc
 mByk1MtGAjpUVP75mbbUP4YJd3v3fVrXFhlNi6gvAX0h/JJLtGcrJOsLUabzJy/jH/Xw4mjgw
 wL1GMyikEC48LiEH/mR7kzXv651QWh2Yq7lKkZLX48X2dbukfkawGM/4SEMoeo9IlAhFwIb6e
 OMx3gzs9vyik72WDGU9WX8YX99gf7U2c5DdubkVP8ilLqK6z16NWgPFHQGFY82FwmJaDTxLR5
 ceOO4/wrmqg/L3IAJEv+BEX7a73dTDoULgQlIQdTuwfi+quO5940TK2xLMYXDDEyFJ10wnYBr
 oA9VmhZiTDFDkHmL1affrKaOyB6ZIxfVSNIq45GrNIQiCikuo9ZHI3DskR6ReMp5m1dXqcUb/
 u8DKMoa1c8zAHWJASwBF/MIYpH8XOIv64i15hjgjbQyVdSm3eVK3sQQYmcZ3ZmGhW6vaJGJju
 eWYfe+m33ifu3xeMhlQHaryqPW20krpS9URANAtmLjFORH1Dsk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wov_hotword_model_put() function has multiple large variables on
its stack, the largest of which is the result of SHASH_DESC_ON_STACK().
In total, this exceeds the warning limit for 32-bit architectures:

sound/soc/codecs/cros_ec_codec.c:776:12: error: stack frame size of 1152 bytes in function 'wov_hotword_model_put' [-Werror,-Wframe-larger-than=]

The function already has a dynamic crypto_alloc_shash() allocation, so
using kmalloc() for the descriptor is correct as well and does not
introduce any additional failure scenarios. With this, the stack usage
of wov_hotword_model_put() gets reduced to 480 bytes in my test
configuration.

Fixes: b6bc07d4360d ("ASoC: cros_ec_codec: support WoV")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/cros_ec_codec.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index d3dc42aa6825..1948bc6971f6 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -108,22 +108,23 @@ static int calculate_sha256(struct cros_ec_codec_priv *priv,
 			    uint8_t *buf, uint32_t size, uint8_t *digest)
 {
 	struct crypto_shash *tfm;
+	struct shash_desc *desc;
 
 	tfm = crypto_alloc_shash("sha256", CRYPTO_ALG_TYPE_SHASH, 0);
 	if (IS_ERR(tfm)) {
 		dev_err(priv->dev, "can't alloc shash\n");
 		return PTR_ERR(tfm);
 	}
-
-	{
-		SHASH_DESC_ON_STACK(desc, tfm);
-
-		desc->tfm = tfm;
-
-		crypto_shash_digest(desc, buf, size, digest);
-		shash_desc_zero(desc);
+	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(tfm), GFP_KERNEL);
+	if (!desc) {
+		crypto_free_shash(tfm);
+		return -ENOMEM;
 	}
+	desc->tfm = tfm;
+	crypto_shash_digest(desc, buf, size, digest);
+	shash_desc_zero(desc);
 
+	kfree(desc);
 	crypto_free_shash(tfm);
 
 #ifdef DEBUG
-- 
2.26.0

