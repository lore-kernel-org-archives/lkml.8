Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2A0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F334206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NslUa6CQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgFAJdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:33:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEEEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 02:33:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y17so10725081wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kQ+7ItpJV494cqEQSRX9aBEpOfptshaMMMYe5L0226k=;
        b=NslUa6CQwZutRKaBW8LM32JDBJ+2uySdpwlwPJ8urLWxFXMCRZPWUyvjcb6lSqpdMt
         xmRJemf3K3L1kna9AivFPg/LOwy/fKfMfWJEzquu7vSfqZ+eF9KxT918GyZ5Tlf4IZJl
         0r5gy+QuYg6mnhIRfutYzuVzh7ED+xyoPDKiA2erkWYbQJJfvqpeKkHogh7I6UPLVKsp
         93cqtF7kF0jjEYZLVBXEYNijuLj8YfbrVm6q6gT+nBpoP3qjm8H7QtQyGdbwmNVIio+/
         TZdPHp7w2NH33Gv/Z+3UbPC952Gb2X+8q4I9jEzB5VIAe2bTicPFS4FuCnLHPV/BPOzF
         3/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kQ+7ItpJV494cqEQSRX9aBEpOfptshaMMMYe5L0226k=;
        b=YV9kg09M6zRNu8YvwnTp1+9c/vtmthxQJm7FDJgitgKBN9KdoqE3zOdpxfb0oyVkFp
         O8aAz2ZtyqFFUUtsSvVBo7ntrv3xYWQJD00VaMIVyIGHQUvg2u4n6PgzyD0g1ckLN9t8
         czmcTwi2NtEgf6ekJMR+8fTdUaoC6cJFlYhKO2BnJFrAD70mT7hb1IMvkNMo/mZO689Z
         T+gvPD0U1fMac+e1fYng0GeOog//hb/6H5SGPGkeYsanCWjiBoXTYAI/ZPXyGaxK8cjJ
         jXJz6mkAzpHw9m/URuHLlERdXRPLMyVFvWaZwTSQpo20JnZ/PhgcTUQsgcvSjyLwNhMJ
         e5/w==
X-Gm-Message-State: AOAM533LIv9UDoCo891HZ+7mgEpte85Jo1zmOdK2mRI5W1DlK1gyvdQh
        lY+YTyfL4sK/SNef4OMhjidVig==
X-Google-Smtp-Source: ABdhPJzjWmsWrS9tVmYGtcsVTakxheDEkKI7KB6vntfqQNEbhQn+Q2iqPQB1rL1ki7ECA+mHkgZsUg==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr20868008wru.102.1591003988097;
        Mon, 01 Jun 2020 02:33:08 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id e10sm20083248wrn.11.2020.06.01.02.33.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 02:33:07 -0700 (PDT)
Subject: Re: [RFC][PATCH] ASoC: qcom: q6asm-dai: kCFI fix
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        alsa-devel@alsa-project.org
References: <20200529213823.98812-1-john.stultz@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7d93893f-da1f-1c49-1407-9d9a8fc4f71d@linaro.org>
Date:   Mon, 1 Jun 2020 10:33:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200529213823.98812-1-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/05/2020 22:38, John Stultz wrote:
> Fixes the following kCFI crash seen on db845c, caused
> by the function prototypes not matching the callback
> function prototype.
> 
> [   82.585661] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000001
> [   82.595387] Mem abort info:
> [   82.599463]   ESR = 0x96000005
> [   82.602658]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   82.608177]   SET = 0, FnV = 0
> [   82.611829]   EA = 0, S1PTW = 0
> [   82.615369] Data abort info:
> [   82.618751]   ISV = 0, ISS = 0x00000005
> [   82.622641]   CM = 0, WnR = 0
> [   82.625774] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000174259000
> [   82.632292] [0000000000000001] pgd=0000000000000000, pud=0000000000000000
> [   82.639167] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [   82.644795] Modules linked in: hci_uart btqca xhci_plat_hcd xhci_pci_renesas xhci_pci xhci_hcd wcn36xx wcnss_ctrl wcd934x vctrl_regulator ufs_qcom syscon_reboot_e
> [   82.644927]  qcom_apcs_ipc_mailbox q6asm_dai q6routing q6asm q6afe_dai q6adm q6afe q6core q6dsp_common pm8941_pwrkey pm8916_wdt platform_mhu pinctrl_spmi_mpp pine
> [   82.812982] CPU: 3 PID: 240 Comm: kworker/u16:4 Tainted: G        W         5.6.0-rc7-mainline-00960-g0c34353d11b9-dirty #1
> [   82.824201] Hardware name: Thundercomm Dragonboard 845c (DT)
> [   82.829937] Workqueue: qcom_apr_rx apr_rxwq [apr]
> [   82.834698] pstate: 80c00005 (Nzcv daif +PAN +UAO)
> [   82.839553] pc : __cfi_check_fail+0x4/0x1c [q6asm_dai]
> [   82.844754] lr : __cfi_check+0x3a8/0x3b0 [q6asm_dai]
> [   82.849767] sp : ffffffc0105f3c20
> [   82.853123] x29: ffffffc0105f3c30 x28: 0000000000000020
> [   82.858489] x27: ffffff80f4588400 x26: ffffff80f458ec94
> [   82.863854] x25: ffffff80f458ece8 x24: ffffffe3670c7000
> [   82.869220] x23: ffffff8094bb7b34 x22: ffffffe367137000
> [   82.874585] x21: bd07909b332eada6 x20: 0000000000000001
> [   82.879950] x19: ffffffe36713863c x18: ffffff80f8df4430
> [   82.885316] x17: 0000000000000001 x16: ffffffe39d15e660
> [   82.890681] x15: 0000000000000001 x14: 0000000000000027
> [   82.896047] x13: 0000000000000000 x12: ffffffe39e6465a0
> [   82.901413] x11: 0000000000000051 x10: 000000000000ffff
> [   82.906779] x9 : 000ffffffe366c19 x8 : c3c5f18762d1ceef
> [   82.912145] x7 : 0000000000000000 x6 : ffffffc010877698
> [   82.917511] x5 : ffffffc0105f3c00 x4 : 0000000000000000
> [   82.922877] x3 : 0000000000000000 x2 : 0000000000000001
> [   82.928243] x1 : ffffffe36713863c x0 : 0000000000000001
> [   82.933610] Call trace:
> [   82.936099]  __cfi_check_fail+0x4/0x1c [q6asm_dai]
> [   82.940955]  q6asm_srvc_callback+0x22c/0x618 [q6asm]
> [   82.945973]  apr_rxwq+0x1a8/0x27c [apr]
> [   82.949861]  process_one_work+0x2e8/0x54c
> [   82.953919]  worker_thread+0x27c/0x4d4
> [   82.957715]  kthread+0x144/0x154
> [   82.960985]  ret_from_fork+0x10/0x18
> [   82.964603] Code: a8c37bfd f85f8e5e d65f03c0 b40000a0 (39400008)
> [   82.970762] ---[ end trace 410accb839617143 ]---
> [   82.975429] Kernel panic - not syncing: Fatal exception
> 
> Cc: Patrick Lai <plai@codeaurora.org>
> Cc: Banajit Goswami <bgoswami@codeaurora.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Alistair Delva <adelva@google.com>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for the Patch!


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index 125af00bba53..4640804aab7f 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -176,7 +176,7 @@ static const struct snd_compr_codec_caps q6asm_compr_caps = {
>   };
>   
>   static void event_handler(uint32_t opcode, uint32_t token,
> -			  uint32_t *payload, void *priv)
> +			  void *payload, void *priv)
>   {
>   	struct q6asm_dai_rtd *prtd = priv;
>   	struct snd_pcm_substream *substream = prtd->substream;
> @@ -490,7 +490,7 @@ static int q6asm_dai_hw_params(struct snd_soc_component *component,
>   }
>   
>   static void compress_event_handler(uint32_t opcode, uint32_t token,
> -				   uint32_t *payload, void *priv)
> +				   void *payload, void *priv)
>   {
>   	struct q6asm_dai_rtd *prtd = priv;
>   	struct snd_compr_stream *substream = prtd->cstream;
> 
