Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76DCC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1ECF20776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUV0KW2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgH1RqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1RqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:46:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099B1C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 10:46:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a65so3462wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wt5rjtBjiQXgsiZyccrqBuCchJi/28V2VtauT80eDG0=;
        b=WUV0KW2evFF4RrkIwdzw/atzBtpCx0Bb/Fq48JIv2No29U8b+B8ccBfp7w6DgBRFcW
         R0kj0dc51Ov33t56Z0lM55A5yekGZfTASbVHE5yJzr0QVQ5l2qAZtYlaEfJiuQuFHTQa
         ZPdEVxkHyfz06FKxIS00G1nbTIVP6zTO/i7vu84+X007oGv2upzyt9bqrokOTNq2ppN0
         FXrPuKy4dAjZ9o4ESEF0Dx+oNTHQFNEFR2TPNt86iv/dT3cHhXD4Obew2zGKX2aAz28Y
         G1HCcV9cVAW4H9mxlJydkrRMlFNCI/+9wUxj5h9KSX4xfRuIsLHtLLai7V9dD2XakUvj
         DPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wt5rjtBjiQXgsiZyccrqBuCchJi/28V2VtauT80eDG0=;
        b=pNQ9MjuPVzHdkYhFc5IJvWwhgyIgX82+dsJqUHS9Vl1+leDHmeJbv05JCkvurZX5S8
         4s98Ahk/VjmyFHdYezBUlM1CT8wDNYZGtDomYi+6IrIlx1aM6A7l7KKZwQHEzw2PLhFi
         FPvDEVkuy/tsR8i77UzxY+x7AM8P3Dj72H6RIZatDx9u/+7EfVf3jOrVmr31psRVDCpu
         dvH4p6AWCGMSA9HACZVSDlx1fKz4UKwpy6Rq0TPAFbp3QfUGsH8eDlqGLmD58vRUFD9u
         Bm4qaEBJlrLpAu0L5M8vIoGuVSpWAz7FVS9boP79Zfu9pu9FdSXmkVowbc1vsWsH/5tU
         R7ZA==
X-Gm-Message-State: AOAM530XFle7k+t/ddHQoUpHtN054zgx4JPgtSQiewNGZ9PWhX1MJTq9
        6tcDo3SHTuh4G26xGAiVphp91B+XT0MnmA==
X-Google-Smtp-Source: ABdhPJxw6H5OJA+8lnePhRZO+ExFbEMYE/vZGK7hd2gMbDXj2PKzlQ4ucdnQp3HFtU69OXUrx/mNxg==
X-Received: by 2002:a1c:3285:: with SMTP id y127mr240362wmy.104.1598636760666;
        Fri, 28 Aug 2020 10:46:00 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.187])
        by smtp.gmail.com with ESMTPSA id f17sm309312wru.13.2020.08.28.10.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 10:45:59 -0700 (PDT)
Subject: Re: Aw: Re: [PATCH v5 3/7] drm/mediatek: disable tmds on mt2701
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Frank Wunderlich <linux@fw-web.de>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        chunhui dai <chunhui.dai@mediatek.com>
References: <20200819081752.4805-1-linux@fw-web.de>
 <20200819081752.4805-4-linux@fw-web.de>
 <trinity-14a1b182-38ab-4f84-bb72-94d448b05fd5-1597994235320@3c-app-gmx-bs37>
 <81276d4c-8883-8bfd-d7d0-9b9ac025ed97@gmail.com>
 <trinity-ddd51146-41eb-49ae-9456-4588450d31aa-1598535710011@3c-app-gmx-bap26>
 <e0edfd9f-5916-80ee-3bef-92d7050f97db@gmail.com>
 <CAAOTY_9R24-tcAMSfDhxLEXDFPAbMd5fYm8EwGODDMpULq-UZA@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <4c929eb9-23da-3797-12e7-ffd2a9a14048@gmail.com>
Date:   Fri, 28 Aug 2020 19:45:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY_9R24-tcAMSfDhxLEXDFPAbMd5fYm8EwGODDMpULq-UZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/08/2020 01:46, Chun-Kuang Hu wrote:
> Hi, Frank:
> 
> Matthias Brugger <matthias.bgg@gmail.com> 於 2020年8月27日 週四 下午10:28寫道：
>>
>>
>>
>> On 27/08/2020 15:41, Frank Wunderlich wrote:
>>> Hi Matthias,
>>>
>>> any opinions about the dts-changes?
>>>
>>
>> they look good to me.
>>
>>> maybe series except the tmds-Patch get merged...so i add it only to my own repo till we find a better way?
>>> currently mainline does not support hdmi at all for the board. the tmds-patch is only a fix for specific resolutions which have a "flickering" without this Patch.
>>>
>>
>> Well let's see what CK's opinion.
>>
> 
> Because no one has comment on this patch, I could apply this patch but
> I need you to add more experiment information so if someone meets
> another bug, he could fix his bug and consider your problem.
> 

I'm adding Chunhui Dai as he got dropped in the discussion.

Chunhui can you as the first patch author provide some more technical background 
why the distortion happens and why this patch fixes it?

Thanks a lot,
Matthias
