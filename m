Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2903C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782BC20870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1x4s/d/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388920AbgEYIiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387973AbgEYIiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:38:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD965C061A0E;
        Mon, 25 May 2020 01:38:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y17so7915868wrn.11;
        Mon, 25 May 2020 01:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UZc2CH7pYyilAZluOYrqPrd3fThr3CQF2GU6qOuf958=;
        b=j1x4s/d/vYUHXNDISjfenVtcRXyslFeM/mHGEeqNdM6uFniX82gFWwzpGlLV+trQ+D
         l9rtwW5h2Ocytd3xMPpKZikPdbU0qu+6rb4G8mxtx9r4uz3S4S6l2VNnw6e43ESSucxl
         seBdHzwqUdihswjhFFdag3R07LkpjoiRcYe30XUrL4ez/BkPXINC/om7pTikw/Ar+tEs
         VBU84Gn6ptax/TiJNbuT+kBIrjUHM3fOZg3q6QKIj1hW0taszwIv+j8L22tiTU9rpofv
         a3GOQ8d1x8DOd2JIn2+moc5ePLWsHCyab7XTji4ZZSnnOesoZ58mgRVrfLmMWqJuKcBH
         chLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UZc2CH7pYyilAZluOYrqPrd3fThr3CQF2GU6qOuf958=;
        b=TnTb8Ec81fvIvrm4oM9O/qiqip91T4pI9KsOX7zGPTUrk6iA8UM5RHFexPRnRi9nXA
         6Z4iol7Ze9P9JDakpjMm9ie26nAPVHKgccy8qts6Qykcpc7eYpnbha7BOPKbChdYA4Yg
         2afUXv0FT/5aTpz0oVvPFFCrPAmktVR03PeaHQh7c4HpTr8MALqcG9ocYAEkeKjEQstU
         RfIK+YaajfCaJGSN9di7ieZHvrE2yAGaPkikcBbAq+rRoCLHGyeP6CYUXt6JQtapjB3y
         +DRfAqmteNRpIqw0GiVnPNlkiF7a25XOgIrUbVHuIvfV/BusIeOP/p/XVn1Cchm8+BXm
         uCOA==
X-Gm-Message-State: AOAM5316ueA40Z2urwwX1KUTL9AOPMEiVffeheu6S3K7CDYH7+IEb/q3
        DVc/3erLHJUn/YZHnpeC/iOdyotP
X-Google-Smtp-Source: ABdhPJyOwGjWDbZt0YJ3qKFaSDOEfMwhQWk2pD5R3+EVszk8SMSf8yYMdX6wwjpCZZNEgNLd9AGxaA==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr14340946wrt.341.1590395893420;
        Mon, 25 May 2020 01:38:13 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id f2sm8898785wrg.17.2020.05.25.01.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 01:38:12 -0700 (PDT)
Subject: Re: [PATCH v5 10/13] soc: mediatek: cmdq: export finalize function
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        HS Liao <hs.liao@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
 <1583664775-19382-11-git-send-email-dennis-yc.hsieh@mediatek.com>
 <5d6b61b2-23c9-647f-fa22-73e779010bd8@gmail.com>
 <CAAOTY___HNcRPr8Jq-wNPO_G9pLVjf2D7ezbpPcGbXVNYy1_nA@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e487573a-2252-cd52-3a3d-c271f67fcb9a@gmail.com>
Date:   Mon, 25 May 2020 10:38:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY___HNcRPr8Jq-wNPO_G9pLVjf2D7ezbpPcGbXVNYy1_nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/05/2020 02:23, Chun-Kuang Hu wrote:
> Hi, Matthias:
> 
> Matthias Brugger <matthias.bgg@gmail.com> 於 2020年5月17日 週日 上午2:22寫道：
>>
>>
>>
>> On 08/03/2020 11:52, Dennis YC Hsieh wrote:
>>> Export finalize function to client which helps append eoc and jump
>>> command to pkt. Let client decide call finalize or not.
>>>
>>> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
>>> Reviewed-by: CK Hu <ck.hu@mediatek.com>
>>> ---
>>>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 1 +
>>>  drivers/soc/mediatek/mtk-cmdq-helper.c  | 7 ++-----
>>>  include/linux/soc/mediatek/mtk-cmdq.h   | 8 ++++++++
>>>  3 files changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>>> index 0dfcd1787e65..7daaabc26eb1 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>>> @@ -490,6 +490,7 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_crtc *mtk_crtc)
>>>               cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
>>>               cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event);
>>>               mtk_crtc_ddp_config(crtc, cmdq_handle);
>>> +             cmdq_pkt_finalize(cmdq_handle);
>>>               cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cmdq_handle);
>>>       }
>>>  #endif
>>
>> This should be a independent patch.
>> Other then that patch looks good.
> 
> Apply only drm part or only cmdq helpr part, it would be abnormal.

Right it would break DRM driver (if only applied to cmdq) or compilation if only
applied to DRM.

> Shall we seperate this patch?

After thinking twice, I think we can leave it as it is. If you provide your
Acked-by I can take it thorugh my tree, if that's OK for you.

Regards,
Matthias

> Or seperate it but make sure these two patches be in the same tree?
> 
> Regards,
> Chun-Kuang.
> 
>>
>>> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
>>> index a9ebbabb7439..59bc1164b411 100644
>>> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
>>> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
>>> @@ -372,7 +372,7 @@ int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
>>>  }
>>>  EXPORT_SYMBOL(cmdq_pkt_assign);
>>>
>>> -static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>>> +int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>>>  {
>>>       struct cmdq_instruction inst = { {0} };
>>>       int err;
>>> @@ -392,6 +392,7 @@ static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>>>
>>>       return err;
>>>  }
>>> +EXPORT_SYMBOL(cmdq_pkt_finalize);
>>>
>>>  static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
>>>  {
>>> @@ -426,10 +427,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>>>       unsigned long flags = 0;
>>>       struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
>>>
>>> -     err = cmdq_pkt_finalize(pkt);
>>> -     if (err < 0)
>>> -             return err;
>>> -
>>>       pkt->cb.cb = cb;
>>>       pkt->cb.data = data;
>>>       pkt->async_cb.cb = cmdq_pkt_flush_async_cb;
>>> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
>>> index fec292aac83c..99e77155f967 100644
>>> --- a/include/linux/soc/mediatek/mtk-cmdq.h
>>> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
>>> @@ -213,6 +213,14 @@ int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
>>>   */
>>>  int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value);
>>>
>>> +/**
>>> + * cmdq_pkt_finalize() - Append EOC and jump command to pkt.
>>> + * @pkt:     the CMDQ packet
>>> + *
>>> + * Return: 0 for success; else the error code is returned
>>> + */
>>> +int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
>>> +
>>>  /**
>>>   * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
>>>   *                          packet and call back at the end of done packet
>>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
