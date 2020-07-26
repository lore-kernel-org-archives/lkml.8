Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7309C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8FA2065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWipaAoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgGZSD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGZSD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:03:59 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40511C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:03:59 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id s144so2561175oie.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=njy1r7SA9A6fHsSkCI0GEnHbYoiGBmKDPik7qyN7YE0=;
        b=BWipaAoAlTbeuMXzOXwuLgqgKDf8t+9SCzJK02Q3RXx7RrUL/HLsFtXqQFgRyFVcGA
         IWvU67/VWyZz6bREp5DuyEMihnTE+oj5iIdUZVA/caUIJaSzwyxRmQZZIZYX2VkVd3qF
         H3JbeRoOCmfkHD+W2CD4FFatE7Hlw0g1MT5zQUvJq0YPFswoEpsR4hUcB8i2LvNFCN6W
         sL8eOVz+aEXt/5IQuPRGUw1/yM4YRabOUB3cRyI77FzKJ1izDzwPduzX+FfwEEP+7j3J
         TyQwiHtIURal8OuiBveHTEgfUUzkK0e/Gp9XA8sfLROPS3LhloNKaAnWMhk4G363mVu+
         iwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=njy1r7SA9A6fHsSkCI0GEnHbYoiGBmKDPik7qyN7YE0=;
        b=pU45rAfiFniUUmINirKKv+an/tifb9rbJIZMbHzQd8fEtNkysN/Kjgjg4TOKxo9wot
         71sIVqhKBDp/MpxyoiGd6qjgReHcFQ9/T5OLV8zoGzVVujqAV11NzxhdPz46hnbo73Us
         HREYmOAhJImXTSJFLOrwQXk2Ruw2tXkNzqcime0eMwGMTmnhmE1TmmB0ZGLhZSAW4Phe
         H++bbnnOUoY61rysJsuzwgm7y+aTQoowGIPPh4FMsouC+zQLdnlDyUjSh3fiBA1c6fHn
         /+e7wSRp81Uh6CVVbLQBSFgE88/tpJ5ZWPLuL/WZjezzjWc8cjSRrLH4wdexVxMSvtaw
         ZcyA==
X-Gm-Message-State: AOAM532EiC9bBS1dbnJclM3p6vfWZNWTpLa95tmqS3xsrzwQYZH2IPs1
        sxsmvMklBliuj33TxtoJfuXBNADM
X-Google-Smtp-Source: ABdhPJyxz7dndp/8Jap8/LjH8xV/Gz9dw4SFIhAgyYJtbOoN5iuJoOpiCHfRvrssXMFi1HQtdoTvSA==
X-Received: by 2002:aca:5ec6:: with SMTP id s189mr14769289oib.119.1595786638381;
        Sun, 26 Jul 2020 11:03:58 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id w25sm1751619otm.81.2020.07.26.11.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 11:03:57 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: include: Fix coding style errors
To:     Aditya Jain <aditya.jainadityajain.jain@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org
References: <20200726080215.41501-1-aditya.jainadityajain.jain@gmail.com>
 <20200726082636.GA447282@kroah.com>
 <CAJAoDUjVBon2iiztdER82mHgJtVS6s5XYSajbCTne0KWAzoLvg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <da3da8d5-7227-ad65-1449-de9fb46561c7@lwfinger.net>
Date:   Sun, 26 Jul 2020 13:03:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJAoDUjVBon2iiztdER82mHgJtVS6s5XYSajbCTne0KWAzoLvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/20 3:40 AM, Aditya Jain wrote:
> On Sun, Jul 26, 2020 at 1:56 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Sun, Jul 26, 2020 at 01:32:15PM +0530, Aditya Jain wrote:
>>> Fixing ERROR: "foo *  bar" should be "foo *bar" in hal_phy_cfg.h
>>> as reported by checkpatch.pl
>>>
>>> Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
>>> ---
>>>   .../staging/rtl8723bs/include/hal_phy_cfg.h    | 18 +++++++++---------
>>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
>>> index 419ddb0733aa..fd5f377bad4f 100644
>>> --- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
>>> +++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
>>> @@ -42,7 +42,7 @@ u32         Data
>>>
>>>   u32
>>>   PHY_QueryRFReg_8723B(
>>> -struct adapter *             Adapter,
>>> +struct adapter               *Adapter,
>>>   u8           eRFPath,
>>>   u32                  RegAddr,
>>>   u32                  BitMask
>>
>> Ick, these are all horrid.  How about just making these all on a single
>> line like most functions have them instead of this one cleanup?
>>
>> Same for the other changes you made in this file.
>>
>> thanks,
>>
>> greg k-h
> 
> Agreed. I'll clean it up.

While you are at it, drop the "include;" from the subject. For staging, the 
usual subject is of the form "staging: driver: thing being done". In your case 
"staging: rtl8723bs: Fix coding style errors". The directory of the files are 
not relevant.

I am also not in favor of the large white space between the variable type and 
the name, but that is probably the subject of separate patches.

Larry

