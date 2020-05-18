Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12251C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A65207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFWTSL+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgERP5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgERP5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:57:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701D1C061A0C;
        Mon, 18 May 2020 08:57:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z72so50676wmc.2;
        Mon, 18 May 2020 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gh+W4KrBfrTWIjHTbRc07vJVQnhS7W3gVWqnNaNXtV8=;
        b=OFWTSL+bQqslrj47jSH0x9+iGBwndVSxp5+ECtCqHMh/o0Z6n2AkUU0rMO0VGla6Z1
         Ip0eePJ9i5A+36scgXyb2MoFjSx4jRKapgjclom/oMoEz8uCz+EJ2Rr9aopy7NnoNwVe
         MlAJmJYiGxa6QDxftsQqUsBW3nbQ+/vHkaLyxMyz9R7C6KRJrEfVqXgyPGTVPPWNsjlM
         g8kxY7qdrFXnlATNe2BuoIi6KIgz20oVNfyRsnqnf3b76uBpvAVsRK1xPQBpzqBTg/5W
         jYhooJES8DQj4vuJqFcbicIx6hLOEmmE1TYBOVtFMngoMx87w8LMkbRhXkv5WwL00MOS
         VkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gh+W4KrBfrTWIjHTbRc07vJVQnhS7W3gVWqnNaNXtV8=;
        b=MAz7/dNzUEmvuv/iBCG14Lw8OW3V4rcUBoPdBxEIbyQUN7wzDOpHpWoYlVxwOuwuLr
         WQExiw8oXSOID9x/dIQBu5nHqNQekWdGy4hg7J6xnjfcel/8zU/HfCKjGYwjDcp83q1a
         w1mpLDCgf50g5R2KnX1IdCVWbp/Dih4bqX3MizbM+0RhfNk23eDYh7fE4S2K7LtbJjV6
         fjbDGqFCa6wmML/8FZFr9+ny+35tOKxVkjhyKDv7RppvOwtQa4GM7khLv6Y+CKT5c/WE
         5sPq4B3aK/nsnoz18ENoRp+9b0GIobQzavZdbPK1TgPvbN7KqDhdYcRH5s7v6ZPiVPUG
         Gv7Q==
X-Gm-Message-State: AOAM532UpseDOUsCPoa01rRgm5By+5/Mo/CwAmv+SYt2P31UwoSLIPcy
        PdrJ5pwjzEVEhoPe1h9GOX0=
X-Google-Smtp-Source: ABdhPJy7fLeUKEGfrbDcTHMLEyRn6Q6jMdSZaK1jBJiOWdyUHiE/jIE+Ud0PC5K/aipfdBIfiZ7G7w==
X-Received: by 2002:a1c:6344:: with SMTP id x65mr37795wmb.51.1589817448125;
        Mon, 18 May 2020 08:57:28 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id v131sm17999920wmb.27.2020.05.18.08.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 08:57:27 -0700 (PDT)
Subject: Re: [PATCH 1/4] clk/soc: mediatek: mt8183: Bind clock driver from
 platform device
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>, matthias.bgg@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk@vger.kernel.org, Allison Randal <allison@lohutok.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20200518113156.25009-1-matthias.bgg@kernel.org>
 <CAAOTY_9-_fy4oGTBLPsXkWJ2ihL7k2hzfwiTorit+YkNi_SeMw@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d95bf802-4a9d-9791-cb0b-ba804d649045@gmail.com>
Date:   Mon, 18 May 2020 17:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY_9-_fy4oGTBLPsXkWJ2ihL7k2hzfwiTorit+YkNi_SeMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/05/2020 17:30, Chun-Kuang Hu wrote:
> Hi, Matthias:
> 
> <matthias.bgg@kernel.org> 於 2020年5月18日 週一 下午7:32寫道：
>>
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> The mmsys driver is now the top level entry point for the multimedia
>> system (mmsys), we bind the clock driver by creating a platform device.
>> We also bind the MediaTek DRM driver which is not yet implement and
>> therefor will errror out for now.
> 
> You may need to let CONFIG_MTK_MMSYS depends on
> CONFIG_COMMON_CLK_MT8173_MMSYS || CONFIG_COMMON_CLK_MT8183_MMSYS
> 

That will be fixed by:
https://patchwork.kernel.org/patch/11469521/

Otherwise this won't scale as we would need to add the SoCs using the mtk-mmsys
driver and this will be a lot if not all.

Regards,
Matthias

> Regards,
> Chun-Kuang.
> 
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>
>>  drivers/clk/mediatek/clk-mt8183-mm.c | 9 ++-------
>>  drivers/soc/mediatek/mtk-mmsys.c     | 8 ++++++++
>>  2 files changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
>> index 720c696b506d..9d60e09619c1 100644
>> --- a/drivers/clk/mediatek/clk-mt8183-mm.c
>> +++ b/drivers/clk/mediatek/clk-mt8183-mm.c
>> @@ -84,8 +84,9 @@ static const struct mtk_gate mm_clks[] = {
>>
>>  static int clk_mt8183_mm_probe(struct platform_device *pdev)
>>  {
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *node = dev->parent->of_node;
>>         struct clk_onecell_data *clk_data;
>> -       struct device_node *node = pdev->dev.of_node;
>>
>>         clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
>>
>> @@ -95,16 +96,10 @@ static int clk_mt8183_mm_probe(struct platform_device *pdev)
>>         return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>>  }
>>
>> -static const struct of_device_id of_match_clk_mt8183_mm[] = {
>> -       { .compatible = "mediatek,mt8183-mmsys", },
>> -       {}
>> -};
>> -
>>  static struct platform_driver clk_mt8183_mm_drv = {
>>         .probe = clk_mt8183_mm_probe,
>>         .driver = {
>>                 .name = "clk-mt8183-mm",
>> -               .of_match_table = of_match_clk_mt8183_mm,
>>         },
>>  };
>>
>> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
>> index cacafe23c823..783c3dd008b2 100644
>> --- a/drivers/soc/mediatek/mtk-mmsys.c
>> +++ b/drivers/soc/mediatek/mtk-mmsys.c
>> @@ -92,6 +92,10 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>>         .clk_driver = "clk-mt8173-mm",
>>  };
>>
>> +static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
>> +       .clk_driver = "clk-mt8183-mm",
>> +};
>> +
>>  static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
>>                                           enum mtk_ddp_comp_id next,
>>                                           unsigned int *addr)
>> @@ -339,6 +343,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
>>                 .compatible = "mediatek,mt8173-mmsys",
>>                 .data = &mt8173_mmsys_driver_data,
>>         },
>> +       {
>> +               .compatible = "mediatek,mt8183-mmsys",
>> +               .data = &mt8183_mmsys_driver_data,
>> +       },
>>         { }
>>  };
>>
>> --
>> 2.26.2
>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
