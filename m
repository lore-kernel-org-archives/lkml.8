Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57147C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CDE206EF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gAXJuJ+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgBRJ3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:29:43 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:43614 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgBRJ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:29:42 -0500
Received: by mail-wr1-f53.google.com with SMTP id r11so22961913wrq.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x2s9Vlm8Xs5SFKLJRgXyDkqsNds2RA2bN9hJWbCVdRM=;
        b=gAXJuJ+uw8vdRqvxDQ5IGA9/+4u2SieS59aen6xgMticqIjWF6jI7ZSQCy7l1P0Wir
         Fh+NSvhMTtYWt1S+7dyL7oZD1iPJlSfuPi2CDOGAm9SKQcTwWPh348RURitv4CZ/MWKL
         Mzeh3KZ2Rq1rGpk+N/RmL0IE0qFufOwsUo7qCLRLEN8zyB4kO0YcIC3LwH0VOkFaAGkT
         VrH1gf6Qp/I7uXsSJ6nmzsqJgdwxRsFw79p4FMYMU1FGZR7SmCf4NznFu75N/VUu5ESL
         UwGRsOrwH93wIaIxt60hygidHQPQO9cD+VflotRjpH/a4aLUeJyQwdhUY0qbv9tCYx0h
         m2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x2s9Vlm8Xs5SFKLJRgXyDkqsNds2RA2bN9hJWbCVdRM=;
        b=gOS0oL2lMtpwsgujYhbvC8+iGQvPOxOnBZgZ2Co5Wj51uXCZSBtJ6DdSPEK3U9aaYu
         w52bZY3UqyJ+643+aW8zrMKY96TLTHyk4MxAEEkqZ0aQzAJpAKx9/I6Q6TVqop+5Sj6p
         TU6wrwCeNp744Elza/6Jk+2D5ALuCR9kUNx7cUtuu0B2jSSnVpi18sOSJjXY90WLLDBh
         LtfyJxoV9/b733cxxQFFWD2Dxyq/ogx/hUlkk2kvwYEAAmhkfVxsshGRe6IAoU/DGgCo
         jSlu6/zYacw7FHciCOxBpgFcW3CK/QCN6mNN2Pr2ZLP54BIhoRAA+FTIvAK0FnsqIw3n
         EYGA==
X-Gm-Message-State: APjAAAWB74/E6Qzj44lRRWfrNIPKOBfvFcnDYd+p4fv/NFIllcQH/agf
        JGt1LWQ5ws6yVJABOBYteuZABQ==
X-Google-Smtp-Source: APXvYqwX8ALABKiS1olnPwGRlGKw9pwwpknEwezan/AqLzPy5qaxx2VpgxtDGmNTBTDySCzR9fZ9jQ==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr29361219wrt.229.1582018181035;
        Tue, 18 Feb 2020 01:29:41 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id w11sm5103479wrt.35.2020.02.18.01.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 01:29:40 -0800 (PST)
Subject: Re: NVMEM usage consult for device information
To:     =?UTF-8?B?TWFjIEx1ICjnm6flrZ/lvrcp?= <mac.lu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Cc:     =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>
References: <06d083206a4f4f5981be9d2e628162f8@mtkmbs01n1.mediatek.inc>
 <11b42d7b-ff96-d377-5225-6f9fcd5c57b8@linaro.org>
 <57c79cb8f45449d3ba49609cdd4a0767@mtkmbs01n1.mediatek.inc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6db967dc-7776-a10e-21cd-ba47ff6f02c3@linaro.org>
Date:   Tue, 18 Feb 2020 09:29:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <57c79cb8f45449d3ba49609cdd4a0767@mtkmbs01n1.mediatek.inc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/02/2020 09:26, Mac Lu (盧孟德) wrote:
> Hi Srini:
>>Is this data stored in a non volatile memory on the SoC?
>>if yes, then we should have a proper nvmem provider driver.
> 
> Yes. This data is stored in non volatile memory on the SoC.
It makes sense to have  nvmem driver in that case. which can then be 
used by Device Tree to retrieve the required configurations from NVMEM.

--srini
> It would be read at bootloader and delivered to kernel by DTB.

> 
> 
> Thanks
> Mac
> 
> -----Original Message-----
> From: Srinivas Kandagatla [mailto:srinivas.kandagatla@linaro.org]
> Sent: Tuesday, February 18, 2020 5:19 PM
> To: Mac Lu (盧孟德) <mac.lu@mediatek.com>; linux-kernel@vger.kernel.org; linux-mediatek@lists.infradead.org
> Cc: Andrew-CT Chen (陳智迪) <Andrew-CT.Chen@mediatek.com>
> Subject: Re: NVMEM usage consult for device information
> 
> 
> 
> On 18/02/2020 05:16, Mac Lu (盧孟德) wrote:
>> Hello,
>> 
>> Mediatek chip have some SOC configurations and specific data which 
>> would be delivered to kernel by DTB.
>> 
> Is this data stored in a non volatile memory on the SoC?
> if yes, then we should have a proper nvmem provider driver.
> 
> --srini
> 
>> So we want to implement a new NVMEM driver to retrieve these data for 
>> use by the NVMEM Framework.
>> 
>> Do you agree with the usage for our application?
>> 
>> Thanks
>> 
>> Mac
>> 
>> ************* MEDIATEK Confidentiality Notice ******************** The 
>> information contained in this e-mail message (including any
>> attachments) may be confidential, proprietary, privileged, or 
>> otherwise exempt from disclosure under applicable laws. It is intended 
>> to be conveyed only to the designated recipient(s). Any use, 
>> dissemination, distribution, printing, retaining or copying of this 
>> e-mail (including its
>> attachments) by unintended recipient(s) is strictly prohibited and may 
>> be unlawful. If you are not an intended recipient of this e-mail, or 
>> believe that you have received this e-mail in error, please notify the 
>> sender immediately (by replying to this e-mail), delete any and all 
>> copies of this e-mail (including any attachments) from your system, 
>> and do not disclose the content of this e-mail to any other person. Thank you!
>> 
> 
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including its
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or believe
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
> 
