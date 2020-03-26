Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0A3C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A4E2082D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2/UIb0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCZIrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:47:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37519 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZIrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 04:47:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id d1so6016916wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aHsFOW/hRqJNBE26Z5Tub2WJh8U/eUTrSdlnpK42LdU=;
        b=K2/UIb0SKVqYqh8r2H12voDOpO0H039juj10pbN91ol+gT5TlMsO16CcYLXW5nGseJ
         RjUw2ZVwtcpGz7ANIAb1H97nQmPvCo8HSDgLq/NnXnORWtAJkjOIiSoh6ABZLwtYh89v
         3eDGJar5Rr3Tp4MwKnxEVqN3tKmSx2W9eM8vPJRTp1t+mHDFTHJ/Y4dF4GmpV8f/Tq8W
         Y38RAZ768onB+G84eIZq6aqlARVB/DwRHPThxtlSoCYl7b6flYWsi2L1KwQFtdnidpQg
         qT4+uviao1LrO4aQl3lwIV7naNh3UI4h5KEK8e7SGsWqxFV8V57QyEaKtuFB0Y9pwbm6
         vIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aHsFOW/hRqJNBE26Z5Tub2WJh8U/eUTrSdlnpK42LdU=;
        b=Y24+anRNDVrkHDbM8hS7k7Mrgxy7/kSNfRwcivyAxU1CYU8UIKovuxSPn77phFkbCT
         PCb4kG5BSowa/YcBJjaDiuUuSHri9lo//4ZbJdihog9Lb7P0051Xu4wYOsuw5ceM68vx
         I1hW5aGZ7k3MHxXvwqbT/DlmQkdFmczvgjcgOxE3jhsblDPmaNnsSbtcsavYJ20enEYJ
         FntESc7oktzZfdJ+gi2OsHheaFAbWBIbYOq1DdhMw1EAvhYHMThfu6aWtBQvYRrASw7c
         MnEcrn3FT8bxtVTsRx1yl2ujyeq8U9WH2Iswp/Tl39FesvtVMRrUMoQ30TLz6QfDPTDB
         nmfA==
X-Gm-Message-State: ANhLgQ08g5kd0uNevw/992ZEuTkvHAE3j00dSEaMCr18pFGwcbVgbHMC
        /9xn41lQoX3pWQwcNnePdeVsKB0v
X-Google-Smtp-Source: ADFU+vtf+5fVBQiQHUFA4G1j/8ab61fwr3VH/WIprGNCGY1eVEd78rWMvs31OrRFnqCyzgrVsyRzDw==
X-Received: by 2002:a1c:9904:: with SMTP id b4mr1995516wme.34.1585212420392;
        Thu, 26 Mar 2020 01:47:00 -0700 (PDT)
Received: from [192.168.178.22] (dslb-002-204-140-180.002.204.pools.vodafone-ip.de. [2.204.140.180])
        by smtp.gmail.com with ESMTPSA id s131sm2527282wmf.35.2020.03.26.01.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 01:46:59 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8188eu: cleanup long line in odm.c
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20200325215940.9225-1-straube.linux@gmail.com>
 <9b369028adca4105c376094db569637cf8bb1fa2.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <147371c7-54f9-3d17-b497-24044aa5c654@gmail.com>
Date:   Thu, 26 Mar 2020 09:45:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9b369028adca4105c376094db569637cf8bb1fa2.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-03-26 01:08, Joe Perches wrote:
> On Wed, 2020-03-25 at 22:59 +0100, Michael Straube wrote:
>> Cleanup line over 80 characters by removing unnecessary parentheses.
> []
>> diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
> []
>> @@ -590,7 +590,7 @@ void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm)
>>   	if (pDM_Odm->bLinked) {
>>   		if (pDM_Odm->RSSI_Min > 25) {
>>   			CurCCK_CCAThres = 0xcd;
>> -		} else if ((pDM_Odm->RSSI_Min <= 25) && (pDM_Odm->RSSI_Min > 10)) {
>> +		} else if (pDM_Odm->RSSI_Min <= 25 && pDM_Odm->RSSI_Min > 10) {
> 
> The test above this already guarantees pDM_Odm->RSSI_Min <= 25
> so the block could be written just
> 
> 		} else if (pDM->RSSI_Min > 10) {
> 

Ah, yes. Thank you. :)
