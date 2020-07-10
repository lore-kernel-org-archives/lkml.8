Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25FBC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFDF920748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q53oHFKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgGJNed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgGJNec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:34:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7036DC08C5CE;
        Fri, 10 Jul 2020 06:34:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so5948889wmf.0;
        Fri, 10 Jul 2020 06:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RNU/6302rcOODFLCEwANfmyQpoUQ2vOd8B0eKLChpSE=;
        b=Q53oHFKsaw4OCYx49+iBVCsst7Y23PSx8gEhnEI2UKg0iwX6IkQ0CBC6B0RDNn5s4d
         DK2QjnkLusfxi72FE6JTvMdjJ87VRBrt/0YbjVaWHPPx8YuwhYTkdQbYSP71h6RbKf6a
         4lGKKX+4tqrHetgXHFWXML1Oub7m6pxY/GYXBIM6HBsbZsOlcQ71S+GucXslavCvZpvM
         RE750aTeLEev9RNXORjzl6/cRUCbh0g3Un2CFnxBLPcu8ez3dEp9IRDXRvRVEsi9YwgK
         E8+2ZZph3FZs0VJgREz+venk9okouoeUCh1cEh67QCjs5Fru0XTjiyJPZtkOub9rTFUY
         ELCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RNU/6302rcOODFLCEwANfmyQpoUQ2vOd8B0eKLChpSE=;
        b=hCfAOdaTfhuTuZUxMRWN31e9miNnuLTRi+3j0Atge85m4kxh1bEB5ckIfpUcDZ3VUH
         EVdBrIVgiVx1CKHAhZ3DK8bcd9+Sg4l8K+wutdJ77IOW0gsQR3jwDqFPSWs0hneqipe2
         VQCFtVjW3aHM30l6S7Dc9fo5Zf3fqBwn8TSh3r7o0nvMd3PC0AYxRJ7bnvT0vUfAk1oQ
         cxuPtoGq3AsvJtNxiY1DqY+FtuJBkOeDtiCAN49Fmi5Dhyw3WiHz/96Skz3sx+yUp9Qa
         T07emHwSNFiMwBRnqpTo4rwGNyXVSZm5oogIvdFQwq3UPjWVK5EBQSIEpWQ3FzJBt//k
         mPWA==
X-Gm-Message-State: AOAM532pv/sf5pouT9LGTbPkVwivgZ+J/PFPjiVE6q4TyXKaq4bZ58DO
        dJWArZengAWsntC6PuCQBMw=
X-Google-Smtp-Source: ABdhPJxwuzAwkiVu4PKL02+ytwiGtWwViRpoEp4epFrba7W8NasX5QwhcrD97o5Wahrp3YlAFpJopQ==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr5118147wmd.86.1594388071128;
        Fri, 10 Jul 2020 06:34:31 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id l3sm9911568wrx.22.2020.07.10.06.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 06:34:30 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mt8173: Re-measure capacity-dmips-mhz
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ikjoon Jang <ikjn@chromium.org>
References: <20200706083705.2343150-1-hsinyi@chromium.org>
 <71bc5fa2-0869-5d91-6bb8-e8d59176e19c@gmail.com>
 <CAJMQK-iGwXFwkvY_1nYiVQ6D-N5yU8YNqxeaSy-1XNMJHj1H0A@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <fe75ae59-99a7-3eec-b481-f1ec3264a86f@gmail.com>
Date:   Fri, 10 Jul 2020 15:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJMQK-iGwXFwkvY_1nYiVQ6D-N5yU8YNqxeaSy-1XNMJHj1H0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2020 20:55, Hsin-Yi Wang wrote:
> On Thu, Jul 9, 2020 at 1:01 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>>
>>
>>
>> On 06/07/2020 10:37, Hsin-Yi Wang wrote:
>>> Re measure capacity-dmips-mhz on elm and hana:
>>>
>>> cpu 1:  9502 DMIPS @ 1703 Mhz
>>> cpu 3: 16250 DMIPS @ 2106 Mhz
>>>
>>> ==> 740 : 1024
>>
>> I have some trouble to match the commit message to the actual patch. Commit
>> message talks about cpu 1 but patch changes cpu0. Where are the values of the
>> other CPUs?
> 
> Small cpu on 8173 is cpu0 & cpu1, while big cpu is cpu2 & cpu3.
> Small cpu: 9502 DMIPS @ 1703 Mhz
> Big cpu:   16250 DMIPS @ 2106 Mhz
> 
> 9502/1703 : 16250/2106 = 740 : 1024 (scale big cpu to 1024), and this patch
> changes the small cpu value to 740.
> 
> 

applied to v5.8-next/dts64

Thanks!



> 
>>
>> Regards,
>> Matthias
>>
>>>
>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> index 70b1ffcab7f0..5e046f9d48ce 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> @@ -167,7 +167,7 @@ cpu0: cpu@0 {
>>>                                 <&apmixedsys CLK_APMIXED_MAINPLL>;
>>>                        clock-names = "cpu", "intermediate";
>>>                        operating-points-v2 = <&cluster0_opp>;
>>> -                     capacity-dmips-mhz = <526>;
>>> +                     capacity-dmips-mhz = <740>;
>>>                };
>>>
>>>                cpu1: cpu@1 {
>>> @@ -182,7 +182,7 @@ cpu1: cpu@1 {
>>>                                 <&apmixedsys CLK_APMIXED_MAINPLL>;
>>>                        clock-names = "cpu", "intermediate";
>>>                        operating-points-v2 = <&cluster0_opp>;
>>> -                     capacity-dmips-mhz = <526>;
>>> +                     capacity-dmips-mhz = <740>;
>>>                };
>>>
>>>                cpu2: cpu@100 {
>>>
