Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14757C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC4AF20810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7X6k9UB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgE2Vic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgE2Vib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:38:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D964C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 14:38:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k2so2052260pjs.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=U/JCQHWiwK23f0xFBIe6II6wByU6wFtw8VXlLquuDwE=;
        b=T7X6k9UBCwiGjhA/q7YA+IYVp60Sl9Oq9FRGyG5tLFbtmsWN5VvFE26WaMbbeOovkv
         OF/ldU0YDz1oJRqaJ5L9jy/y573Gq44pRL+kuNN3g6aU2BJkhfAgzl9nU6s57E4t7vHU
         v+BDXk459rTRhpFcftbfPDOZCkhpLOfnONHb+TU7e3f3ancqtLpwjERiAFBsE5wMWgMC
         TCtg/oAHLHQvkD5suKBbFMRr4fjmiaKZ5lDzhzSAQQh1f7lNQ32dZWwFJ7LXXPu67plz
         XWZbTNuuVYizWXma5v6FMCxzJtAngM4epA87s071QgRJpcYiintDfvwMSt6SIK+TC/eY
         9hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U/JCQHWiwK23f0xFBIe6II6wByU6wFtw8VXlLquuDwE=;
        b=mp3HxeCaf/AxsTIxhKzzuLvQJ8XbV2XWJ2/tj9B+IkAS8MxQx1ZNA8H+o3x1Bz7wRe
         FtwpkpvdZSr3c1fOEAPPZyDN4OsN15p/4Lrbpa16zekhdBrT0EQDn7MkrNT0dW2nXQWA
         9+t2bQBb/GzU1amD36EDDoH7qoeDJ/K6sXPI7PAzetgx4/KetuFMnuEgKo77M+/q7mzy
         8RIl8/7NAkgF7YcrsWAAZ3ySVwt+C0HsdKTc63OiGGLz9J3+PxdbIqPpz3G4cYg7dsUR
         Gd22KQ73nPWdhih6rx3d2BDYVlyNjojnsyqftQk3C1apQcXm2qbC5vKDCQKHfBe0YAtJ
         xPHw==
X-Gm-Message-State: AOAM531V5GQZFMxszGqVdeFVhuiheo8aOeZgWNYypRv1fNlzOhtKRv7u
        oTx6c3Rng4ZZBKFpSOqlQlef4q65BOw=
X-Google-Smtp-Source: ABdhPJzkXew6827lBFOqhUNImfruIgLQKY4yL6SEaYsd4psiMfMw7eB14pTrasZI2VKBt37TklCBqw==
X-Received: by 2002:a17:90a:aa8f:: with SMTP id l15mr12104229pjq.156.1590788310361;
        Fri, 29 May 2020 14:38:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id c24sm313775pjs.51.2020.05.29.14.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:38:29 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        alsa-devel@alsa-project.org
Subject: [RFC][PATCH] ASoC: qcom: q6asm-dai: kCFI fix
Date:   Fri, 29 May 2020 21:38:23 +0000
Message-Id: <20200529213823.98812-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following kCFI crash seen on db845c, caused
by the function prototypes not matching the callback
function prototype.

[   82.585661] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000001
[   82.595387] Mem abort info:
[   82.599463]   ESR = 0x96000005
[   82.602658]   EC = 0x25: DABT (current EL), IL = 32 bits
[   82.608177]   SET = 0, FnV = 0
[   82.611829]   EA = 0, S1PTW = 0
[   82.615369] Data abort info:
[   82.618751]   ISV = 0, ISS = 0x00000005
[   82.622641]   CM = 0, WnR = 0
[   82.625774] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000174259000
[   82.632292] [0000000000000001] pgd=0000000000000000, pud=0000000000000000
[   82.639167] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[   82.644795] Modules linked in: hci_uart btqca xhci_plat_hcd xhci_pci_renesas xhci_pci xhci_hcd wcn36xx wcnss_ctrl wcd934x vctrl_regulator ufs_qcom syscon_reboot_e
[   82.644927]  qcom_apcs_ipc_mailbox q6asm_dai q6routing q6asm q6afe_dai q6adm q6afe q6core q6dsp_common pm8941_pwrkey pm8916_wdt platform_mhu pinctrl_spmi_mpp pine
[   82.812982] CPU: 3 PID: 240 Comm: kworker/u16:4 Tainted: G        W         5.6.0-rc7-mainline-00960-g0c34353d11b9-dirty #1
[   82.824201] Hardware name: Thundercomm Dragonboard 845c (DT)
[   82.829937] Workqueue: qcom_apr_rx apr_rxwq [apr]
[   82.834698] pstate: 80c00005 (Nzcv daif +PAN +UAO)
[   82.839553] pc : __cfi_check_fail+0x4/0x1c [q6asm_dai]
[   82.844754] lr : __cfi_check+0x3a8/0x3b0 [q6asm_dai]
[   82.849767] sp : ffffffc0105f3c20
[   82.853123] x29: ffffffc0105f3c30 x28: 0000000000000020
[   82.858489] x27: ffffff80f4588400 x26: ffffff80f458ec94
[   82.863854] x25: ffffff80f458ece8 x24: ffffffe3670c7000
[   82.869220] x23: ffffff8094bb7b34 x22: ffffffe367137000
[   82.874585] x21: bd07909b332eada6 x20: 0000000000000001
[   82.879950] x19: ffffffe36713863c x18: ffffff80f8df4430
[   82.885316] x17: 0000000000000001 x16: ffffffe39d15e660
[   82.890681] x15: 0000000000000001 x14: 0000000000000027
[   82.896047] x13: 0000000000000000 x12: ffffffe39e6465a0
[   82.901413] x11: 0000000000000051 x10: 000000000000ffff
[   82.906779] x9 : 000ffffffe366c19 x8 : c3c5f18762d1ceef
[   82.912145] x7 : 0000000000000000 x6 : ffffffc010877698
[   82.917511] x5 : ffffffc0105f3c00 x4 : 0000000000000000
[   82.922877] x3 : 0000000000000000 x2 : 0000000000000001
[   82.928243] x1 : ffffffe36713863c x0 : 0000000000000001
[   82.933610] Call trace:
[   82.936099]  __cfi_check_fail+0x4/0x1c [q6asm_dai]
[   82.940955]  q6asm_srvc_callback+0x22c/0x618 [q6asm]
[   82.945973]  apr_rxwq+0x1a8/0x27c [apr]
[   82.949861]  process_one_work+0x2e8/0x54c
[   82.953919]  worker_thread+0x27c/0x4d4
[   82.957715]  kthread+0x144/0x154
[   82.960985]  ret_from_fork+0x10/0x18
[   82.964603] Code: a8c37bfd f85f8e5e d65f03c0 b40000a0 (39400008)
[   82.970762] ---[ end trace 410accb839617143 ]---
[   82.975429] Kernel panic - not syncing: Fatal exception

Cc: Patrick Lai <plai@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Alistair Delva <adelva@google.com>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 125af00bba53..4640804aab7f 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -176,7 +176,7 @@ static const struct snd_compr_codec_caps q6asm_compr_caps = {
 };
 
 static void event_handler(uint32_t opcode, uint32_t token,
-			  uint32_t *payload, void *priv)
+			  void *payload, void *priv)
 {
 	struct q6asm_dai_rtd *prtd = priv;
 	struct snd_pcm_substream *substream = prtd->substream;
@@ -490,7 +490,7 @@ static int q6asm_dai_hw_params(struct snd_soc_component *component,
 }
 
 static void compress_event_handler(uint32_t opcode, uint32_t token,
-				   uint32_t *payload, void *priv)
+				   void *payload, void *priv)
 {
 	struct q6asm_dai_rtd *prtd = priv;
 	struct snd_compr_stream *substream = prtd->cstream;
-- 
2.17.1

