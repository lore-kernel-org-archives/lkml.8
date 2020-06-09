Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06DCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED8020814
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="KBLTK0dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgFILUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgFILUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:20:09 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557CBC03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 04:20:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w3so20340598qkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 04:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4vbbsEa1uHDWb6XV9nSWbJE6AZC1+QscXr2WsFVfdlg=;
        b=KBLTK0dtfIy71HT/+n78qaq5LuFpORynM8pRT77MsxRZ5O33t4z0oAYrLv2SrM0R29
         WpRFkWTy3qANgKFRoV+Ck6M+A6U2SI+r6BvGxIgGVXs5+1bfVQ8CH16CrW4Ql/+hqa1V
         bwBNHpGx2H6qmtqx9CZLLk2ETY0imojIN0z9xzcNgTjntduaCp+JVN7qXvTmAv+T3ws6
         X52XbZmcup7Eytg6ZdzBpqg5v+O7/BNQWlqqTNTuYITHoOD002EgFS0mXiMVx/ts5ivN
         cn4wYsSDaRTFkH6j4VtCP9uLcBI5ws6Q2L7xBe3dv/75UZqCD8hSR/yhjMPohMSXr4ym
         gWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4vbbsEa1uHDWb6XV9nSWbJE6AZC1+QscXr2WsFVfdlg=;
        b=ClJreMfC8yf8k/HBXg0mFi89C88snwi7gsYBMrYf3jPrDenERWZMrRG5iS+9XgJKt2
         XwC2XVwLZdv0IXmNdlBDqL3f+p9b3hnSmjl9ykpKU6CKhgJ9DNUTkb5hlmAjJdVwIgUx
         +aAPlHd2Btu4IWNDr0diX2R5xC08HClGj7ZjM3blc2THYqAm6pMUhmX1tYR1606sHWul
         UKAhI15Imge1pqAD3lunnAGBLkRnf67Sgx6vkvXIsIfoDQUeXfWKUvkd6OlnFBzMiy9G
         MoXtPOscSkEtnOpeMfUJc59OxcQhkXr7elj87LFijbLXc4QAwIY4iF47fxVb7lfn0wJt
         75Cw==
X-Gm-Message-State: AOAM5323v5SpfRew9Zcoc9DiULjMiHmp+cg82kypjS2jM0ucVgodytuO
        S7Qr+jQSwEz+qa4rdX7G8ZCbK5yc6ck=
X-Google-Smtp-Source: ABdhPJzGJWLUixIeMGp2s5w5M+K/KN66kGS5c/6596VKFiPwBd+ENjZROdgaFYOPukx7ceM6miyzNw==
X-Received: by 2002:a37:9e10:: with SMTP id h16mr27201817qke.381.1591701606051;
        Tue, 09 Jun 2020 04:20:06 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id r37sm10260096qtk.34.2020.06.09.04.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 04:20:05 -0700 (PDT)
Subject: Re: [PATCH 2/5] soundwire: qcom: add support for mmio soundwire
 devices
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200608204347.19685-1-jonathan@marek.ca>
 <20200608204347.19685-3-jonathan@marek.ca>
 <20200609043420.GA1084979@vkoul-mobl>
 <bbb552ce-4b13-0395-e1bc-0b6c5766f4ae@linaro.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <a1098c40-adba-7e49-6d82-d7c50a6d286a@marek.ca>
Date:   Tue, 9 Jun 2020 07:20:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bbb552ce-4b13-0395-e1bc-0b6c5766f4ae@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 5:18 AM, Srinivas Kandagatla wrote:
> 
> 
> On 09/06/2020 05:34, Vinod Koul wrote:
>> Hi Jonathan,
>>
>> On 08-06-20, 16:43, Jonathan Marek wrote:
>>> Adds support for qcom soundwire devices with memory mapped IO registers.
>>
>> Please use 'SoundWire Master devices' instead :)
>>
>>>
>>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>>> ---
>>>   drivers/soundwire/qcom.c | 25 +++++++++++++++++++++++--
>>>   1 file changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>>> index f38d1fd3679f..628747df1c75 100644
>>> --- a/drivers/soundwire/qcom.c
>>> +++ b/drivers/soundwire/qcom.c
>>> @@ -90,6 +90,7 @@ struct qcom_swrm_ctrl {
>>>       struct sdw_bus bus;
>>>       struct device *dev;
>>>       struct regmap *regmap;
>>> +    void __iomem *mmio;
>>>       struct completion *comp;
>>>       struct work_struct slave_work;
>>>       /* read/write lock */
>>> @@ -154,6 +155,20 @@ static int qcom_swrm_ahb_reg_write(struct 
>>> qcom_swrm_ctrl *ctrl,
>>>       return SDW_CMD_OK;
>>>   }
>>> +static int qcom_swrm_cpu_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
>>> +                  u32 *val)
>>> +{
>>> +    *val = readl(ctrl->mmio + reg);
>>> +    return SDW_CMD_OK;
>>> +}
>>> +
>>> +static int qcom_swrm_cpu_reg_write(struct qcom_swrm_ctrl *ctrl, int 
>>> reg,
>>> +                   int val)
>>> +{
>>> +    writel(val, ctrl->mmio + reg);
>>> +    return SDW_CMD_OK;
>>> +}
>>
>> this looks fine but regmap supports mmio also, so I am thinking we
>> should remove these and set regmap (mmio/slim)... Srini..?
> 
> That is doable, but not going to add great value in this case, unless we 
> are having another layer of abstraction. So keeping it as readl/writel 
> seems okay to me.
> 

Adding to this, the slim case doesn't use the regmap directly, it goes 
through AHB_BRIDGE registers. So using a single regmap path is not 
"doable" (at least not in a nice way IMO).

> --srini
> 
> 
>>
