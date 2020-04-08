Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0121C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884772075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgDHTBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:01:38 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:50919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgDHTBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:01:38 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N8X9L-1jIM0137C5-014TcB; Wed, 08 Apr 2020 21:01:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org, Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: tegra: fix tegra_pmc_get_suspend_mode definition
Date:   Wed,  8 Apr 2020 21:01:15 +0200
Message-Id: <20200408190127.587768-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:c7ca8mfo9nBDy3uis9G8lBiFvvnO3RJdZ+1sYN7xqlmV0Rm4SBv
 nUBHlgomQPUV/NBDC2KRgdX2Hhv1GkZWe7bPz7wuVru9X8zfGRXTgKsGB9Zb2c/CQS3drz6
 ffJxiq++2Blydw/cUyqv8CY8iZmcMUpRSny6Md+kujKbqhyChNc8B9q9p8tqLMfcG/qkf1/
 e9iXPzuqi3GLdwSi7NhZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:baZr+iWEE8w=:ZdJeRWPXWWgsKuCrid7Ywv
 OUz5gLP8Pj9XC2LCUHWoWXG6KxaEKpFwNYw9lGQbwMyinb2GTx4GtYfCnLTVYuy2VheG25ZrC
 351lzkS+9uzilsnqAHXt/WeIJqfsuR8KIXKO8kJOMRewJAl1TOLBnhkCz5ruf75m/GWVskRur
 7og6GXw+v6axw7ZuMGwfhe/avOiGKuErdpUDtsup1VLKIdkDA8+BKukO/Pl2gqtVRbeZK5JG/
 pSZROtsb7CD1HWJDNJDGr8x+TJ2pH9d6EleopGHxJ2fMNX2OmdsQ8k98Dz/LXM+KhRfZMHI+l
 erpSbGvHcJmRfTkSyPUiVY+ixKwWSLWEo9n6UI6r4VSuURhQ1gca+dxpPsaKn617ZhJfVAy1Y
 Gg+lbKLlHA2PPMvwMKUu+N6j/8Cuz56O2SPz/UTvz5G/e5nKKNx0qcLXpbdPW0eNfwxpYuETv
 1SZtm0BgTHrJ/Kj+hisT4N6M4eiXSKb5YKrSybyvAf/njZL3ms85z+i+70wbhnXAisQOcsGNj
 hfY2DI3HlpTsrBNsKIxuf7JG/nOPT+6Wylzwul7XtKZWOsef7cwkUCwst4kjNifpt6OrJvrhe
 IgK40bgMZlUVY9NMwAY4O/vejsSb31wguceXftkMZ1+u4FXiCszJuV/g6XeGFTKrQo9c8NHHb
 NuDURoBN90MgRW/UMHQSgGfy7DIrXJJa9jhNLVC/x+opCSNRmJfCgw9HEimq31Ha4yehsKNB2
 gYNtBsPIFx7BYDvwvgEach8XLqMlXVQLMQrDiG5JqcLi6DFpUsYtWMvx8DuULFvyGDiupy6hv
 BL+D6A6dTWX01KDG0Zaiq4NpSznTq3iIGw37s70F7WImNWWeuE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PM_SLEEP is disabled, the function is not defined,
causing a link failure:

arm-linux-gnueabi-ld: drivers/cpuidle/cpuidle-tegra.o: in function `tegra_cpuidle_probe':
cpuidle-tegra.c:(.text+0x24): undefined reference to `tegra_pmc_get_suspend_mode'

Change the #ifdef check according to the definition.

Fixes: 382ac8e22b90 ("cpuidle: tegra: Disable CC6 state if LP2 unavailable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/soc/tegra/pmc.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index 0dd52b0a5c1b..361cb64246f7 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -168,7 +168,6 @@ int tegra_io_pad_power_disable(enum tegra_io_pad id);
 int tegra_io_rail_power_on(unsigned int id);
 int tegra_io_rail_power_off(unsigned int id);
 
-enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
 void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
 void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode);
 
@@ -220,11 +219,6 @@ static inline int tegra_io_rail_power_off(unsigned int id)
 	return -ENOSYS;
 }
 
-static inline enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void)
-{
-	return TEGRA_SUSPEND_NONE;
-}
-
 static inline void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
 {
 }
@@ -235,4 +229,13 @@ static inline void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 
 #endif /* CONFIG_SOC_TEGRA_PMC */
 
+#if defined(CONFIG_SOC_TEGRA_PMC) && defined(CONFIG_PM_SLEEP)
+enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
+#else
+static inline enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void)
+{
+	return TEGRA_SUSPEND_NONE;
+}
+#endif
+
 #endif /* __SOC_TEGRA_PMC_H__ */
-- 
2.26.0

