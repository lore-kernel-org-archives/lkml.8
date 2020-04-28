Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3924C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43032076A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgD1Vsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:48:54 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgD1Vsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:48:54 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MLi0U-1jlDUS435U-00HhCE; Tue, 28 Apr 2020 23:47:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Shreyas NC <shreyas.nc@intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: component: suppress uninitialized-variable warning
Date:   Tue, 28 Apr 2020 23:47:31 +0200
Message-Id: <20200428214754.3925368-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CwaJqqI8UP3UYQa9QLeTXBcxWgnAERLM8vCOxjOOEAo6dfRILDf
 LeO9h10wirIWDwv/JYCpujsz5ihmwXnxr5ZVnF6fjlXBTOrFpjkS7YaQllg/u4+ORwbI1DA
 kxCRbtdDyAV9QhcaU6Ziis4Gf2mVE3FsnWg1aXZZw9CUh5bIjY2/t57C93Zp4lBmTZ7TttH
 +ODOByIu1hjDFoMEOa2qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6OOAtvjEG8Y=:39ln5prj9KTgnldiZQ01UN
 4E3DgmxckBBa2DYf+ZhSgu5LP8rnoU4Hn209TkYgCfE1JcUIQUVKc/WxtcufErSo5Cc7wuQ0C
 HzlYNLD3iSHxe5f1tCMwO8ru5sj5J/nmxJyQgnRJBVi8lw1vkMQkGitCz+OLeOY+Xkm7LQHj+
 V91Wxldp5CR+OCHKLSESyA5Nj6Rzkrh4nqMngtnppNsj2qvsL9xrnD2Iga7qBJaHX/dL+PStU
 dtKwcK1elD3BzM2KXiqaHTMVVuFlCz1zUpsUv/cikpiuzJamzjci0ZWzeBdl6RiWJiHjH+lsM
 hx3dh4hwNbG2rLrazrEwtbyddf5jJ/nAkstwqCtI0eLABTQw2U3fFUd8uTvw6hkJXQJy1RsHp
 6hfMFZo5TnxcX6XNMqRQ0wyGPO0xDafn/aDE0+zEY0JnYszQKfE85vev6MjWpsKXu8Vff+iY/
 CU4S0ZY0Dqo0udPP37uRzHRDaPBBCezqthWPPmnYPOxpIKRoZpQeqOxjJVqshsVgo/eS/XOhz
 sVaaRy6A9tzG6A/Fr3p6EEbmQlKG7/Coa6/JJX2HNLK7iCBoiqtV1Krye5+yFtr5g/qx44Vjn
 JI0JvW5voZeBQ7Z3Wg6rkaQwb4KjEIq8PIcqU6rHlwMQcACLtK1cKXHsD4RtvxI1cbLwsNrem
 gjSO8tyhRV/HJgNb/CJDwwLG3BcVxxs3gNsQHaCBW2oxsagTe4FiE7kCNQ96DGWhLp0m/g6HK
 cPul8V6+pl7neS9mdT0KYU4hbbof7Giftobzl2I8G7gB/qL5AIBUhBfchAoLWZkBBgZyLdXyK
 7RbxwSNM9GBeW26VXpc/C6BmMmULaQ6gPa4JRNaynwd9MnuCKQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Old versions of gcc (tested on gcc-4.8) produce a warning for
correct code:

sound/soc/soc-compress.c: In function 'soc_compr_open':
sound/soc/soc-compress.c:75:28: error: 'component' is used uninitialized in this function [-Werror=uninitialized]
  struct snd_soc_component *component, *save = NULL;

Change the for_each_rtd_components() macro to ensure 'component'
gets initialized to a value the compiler does not complain about.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/soc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 907afbc652f2..69a82487fa9b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1179,7 +1179,7 @@ struct snd_soc_pcm_runtime {
 #define asoc_rtd_to_codec(rtd, n) (rtd)->dais[n + (rtd)->num_cpus]
 
 #define for_each_rtd_components(rtd, i, component)			\
-	for ((i) = 0;							\
+	for ((i) = 0, component = NULL;					\
 	     ((i) < rtd->num_components) && ((component) = rtd->components[i]);\
 	     (i)++)
 #define for_each_rtd_cpu_dais(rtd, i, dai)				\
-- 
2.26.0

