Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE8FC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D08920714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeqhwkoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgGYStW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGYStW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 14:49:22 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB208C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 11:49:21 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id o72so3902389ota.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rMyb1gO3q+v65MaIVuTcYIle7Wdt4tjlApNFSHQMhoA=;
        b=IeqhwkoAGMsuiqAFwxeyeJD1ArMD7DDh1kvr35hYkSEa7vAAo9Mkerlw9DBz548GNr
         bVbommZ44uBja6vI548WYNUw1Ej1QYdSa/P22PLFeltPACVePYpkYiMcMUrlQn32RRRs
         7oyi42ibOJgz47MrzafTjWmy3YTDCYMI/TED6GK8T0VrN/JVM8Su+ZykPwimtuJTJkbA
         gMUKoEZBaAHPOkAe9lxda/858rkzDQFC4XgTs5+YPxkmpwpbnd/GCARSVHHnn1DLuVSz
         AqDR6uMAN4YzLkWREmRtyyg8LJ5JUXkVkrIoRDajGE0utbEbvT5OH8fIvERBgBc7Xme4
         veDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rMyb1gO3q+v65MaIVuTcYIle7Wdt4tjlApNFSHQMhoA=;
        b=U+ZWZsTZ8aI8PRg4fFU/NYy03cOnvVYyjGi8/PuBIU+b4lWSqZIMIhXownJQmhnMDX
         m1nCi7qQkdSDipg37jtlPlMx5rJ7KeZQ32Glla+yW+PkiRl9SA6uH/PNLWCyzmHggs5x
         JCRH5dhQiMnITTFV6vET1HXbKvRmP2OIiGw7iEVHuWpeS5QYZc4TGxdITPBW+7N71pwq
         YMySv0WLnpEJCLQx/2CbVlFpELa8lRfHyQbZdHqlxzGUZoy3Nim1UyudhHzTjzn6JLmW
         UlLqP3PZC6fPAF4KTiFfK9EbIaqql0tb4yp0/hDVM7gpq+fKKhpzK7vOSjqbCYrxu9Ja
         jDsg==
X-Gm-Message-State: AOAM531zbsbQoomZt0KHba8moW0IF+BFIN+S3lKGY2nNBp8Xslqu1CYL
        iGNOiTjfD8lK/fUkN+QjuKYzb2IJ
X-Google-Smtp-Source: ABdhPJwRtHGA53qzVQAfRO5i9xkHDMSRTJmtpjENMgOwLX7nr8G//q1IyCJFe1LB13PCVTz3X73oOw==
X-Received: by 2002:a9d:5d2:: with SMTP id 76mr14224874otd.55.1595702961035;
        Sat, 25 Jul 2020 11:49:21 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id m24sm1646438oof.5.2020.07.25.11.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 11:49:20 -0700 (PDT)
Subject: Re: [PATCH 1/1] STAGING - REALTEK RTL8188EU DRIVERS: Fix Coding Style
 Error
To:     Joe Perches <joe@perches.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anoop S <anoop.skumar1507@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Merwin Trever Ferrao <merwintf@gmail.com>,
        Rahul Gottipati <rahul.blr97@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200725122041.5663-1-anant.thazhemadam@gmail.com>
 <aab59eb1-baff-5de1-4e14-88ffc42db1fe@lwfinger.net>
 <d4427fb12f9d4735ec82355bbe99f7b3098fc1a4.camel@perches.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <18de15c4-1737-ae8b-b213-6f44792774be@lwfinger.net>
Date:   Sat, 25 Jul 2020 13:49:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d4427fb12f9d4735ec82355bbe99f7b3098fc1a4.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/20 1:39 PM, Joe Perches wrote:
> On Sat, 2020-07-25 at 12:47 -0500, Larry Finger wrote:
>> On 7/25/20 7:20 AM, Anant Thazhemadam wrote:
>>> Running the checkpatch.pl script on the file for which patch was created, the
>>> following error was found to exist.
>>> ERROR: space required after that ',' (ctx:VxV)
>>>
>>> Fixed the above error which was found on line #721 by inserting a blank
>>> space at the appropriate position.
> []
>>> diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
> []
>>> @@ -718,7 +718,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>>>    				res = _FAIL;
>>>    			}
>>>    		} else {
>>> -			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n",__func__));
>>> +			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n", __func__));
>>>    			res = _FAIL;
>>>    		}
>>>    	}
>>
>> In fixing one checkpatch.pl condition, you introduced another - the resulting
>> line is too long. You should fix only one such condition, but you should fix any
>> others that are introduced. You do need to document it.
> 
> I think that doesn't matter as it was also too long
> before this change.
> 
>> Patch subjects for this driver should be written as "staging: rtl8188eu: .....".
> 
> How likely is it that this driver would ever be
> moved to drivers/net/wireless/realtek/rtlwifi?

Very unlikely. It I wanted to undertake that kind of effort, I would switch to 
one of the later versions from Realtek that uses nl80211/cfg80211. Despite that, 
it is likely that only the USB driver from rtlwifi could be used.

Larry



