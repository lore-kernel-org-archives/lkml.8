Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9981DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7765220855
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imy9tfNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHROlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:41:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59804 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726585AbgHROk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597761654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Me2nEXfs6+MwbcBz8kcYDmmfJIuN9KRoRNQt94lDVkY=;
        b=imy9tfNqqtqkAghpFXQLCCAkXzZiG2efKJpUxSceYyp/B7wr58PNkvk20G//zeqGqKDqNc
        nZc7tI3ynx0WBZpfZ9pVtyWbWbLdf/pHyT/+yosczOiSfnT1wrE0l0O07CnR7nCE2EvyWx
        QC2sjRliN14bLhauV6W7Ti8AmhhAH04=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-jdMofpa5N9-WaijYMi1w3A-1; Tue, 18 Aug 2020 10:40:49 -0400
X-MC-Unique: jdMofpa5N9-WaijYMi1w3A-1
Received: by mail-qv1-f72.google.com with SMTP id c4so13436594qvq.15
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Me2nEXfs6+MwbcBz8kcYDmmfJIuN9KRoRNQt94lDVkY=;
        b=ed0jm6ku0bphxMHXTZe1qSWAjGwNdfBQR+IvUMj+/ld36JAKXKGJdtRUjGZD3iqMiZ
         oybAk5kQmC+mkTXlrnddTW57a5t6IqfAd3N5tH2GkFdTSzZ0sdCLKtM4gA5u8RgMVkPW
         ery3/kFRFB0UsbSO/Cq/PZ/NeoQc3s5cMvdugzB/1kZeiKbJX4VUwUlLcw+cv2LEcq4z
         hEa4nn2gfWcQtQ4aVD3ZMrUnsN7H3tejNOMn/crGc7+8nFcIr49l3xGAPOivlmNfcw1I
         4m7A8Vo5x4oWAZz9eG0/iPNwm76xMSN9Y8ALBpKpdl37lpJvFtPpwGA9xveEDj2HlxPo
         MDVQ==
X-Gm-Message-State: AOAM5319ogTJJyluoAstyIhewgMjUQ84vI17TZEOi3LdJ/WuJFB5mPeo
        SgG6DshfxOTPt37z5LZaaA7/oN9IYmlD9Z6knExMWI/xfU77fVqp+TKBxnQbrNRLW2603CVNEav
        FdK/Hn7RLY70KNe8n/FM9tuD/
X-Received: by 2002:a37:6c7:: with SMTP id 190mr17070313qkg.163.1597761648320;
        Tue, 18 Aug 2020 07:40:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwh1KKi6sSONuAEpAIlQtNdijIzVhZZdqE4JyuGdZ58OaFIj7ZreUze9rrye83+q0H1uLBA/w==
X-Received: by 2002:a37:6c7:: with SMTP id 190mr17070298qkg.163.1597761648107;
        Tue, 18 Aug 2020 07:40:48 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 84sm20296994qkl.11.2020.08.18.07.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 07:40:47 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] add regmap-spi-avmm & Intel Max10 BMC chip support
To:     Xu Yilun <yilun.xu@intel.com>, Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1596614456-20182-1-git-send-email-yilun.xu@intel.com>
 <20200817082410.GB19661@yilunxu-OptiPlex-7050> <20200817091252.GV4354@dell>
 <20200818083647.GE22873@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <5a2d4761-e800-bfb6-d67b-8740b8039ecc@redhat.com>
Date:   Tue, 18 Aug 2020 07:40:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200818083647.GE22873@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yilun,

I was looking at the tx side a bit and think the padding function could be moved into the pkt/phy function.  The pky/phy function already is looking for the eop's so reuse it and remove the search for eop and exchange the loops that do char moving and padding to mem* functions.  The logic is something like.                                                          
if (tb == tb_end - 1 && !eop_inserted) {
        *pb = PKT_EOP;

        p_eop = pb;

...

    dst_pb = &br->phy_buf[aligned_len];
    size_t s = pb - p_eop + 1;
    /* move EOP and bytes after EOP to the end of aligned size */
    memmove(dst_pb - s, p_eop, s);
    /* fill the hole with PHY_IDLEs */
    memset(p_eop, PHY_IDLE, aligned_len - br->phy_len);
    /* update the phy data length */

Tom

 

On 8/18/20 1:36 AM, Xu Yilun wrote:
> On Mon, Aug 17, 2020 at 10:12:52AM +0100, Lee Jones wrote:
>> On Mon, 17 Aug 2020, Xu Yilun wrote:
>>
>>> Hi Brown & jones:
>>>
>>> I tried to refacor the regmap code and add comments in this patchset. I
>>> made big changes to the rx flow and remove some tricky parts in it.
>>>
>>> Would it be more understandable than last version? I'm expecting your
>>> comments on it when you have time, thanks in advance.
>> Just resubmit please.  We can review the code itself.
> Ok. I'll rebase it to 5.9-rc1 and resubmit it.
>
> Thanks,
> Yilun
>
>> -- 
>> Lee Jones [李琼斯]
>> Senior Technical Lead - Developer Services
>> Linaro.org │ Open source software for Arm SoCs
>> Follow Linaro: Facebook | Twitter | Blog

