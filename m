Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D75DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008332065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQdhQX7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGZSaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgGZSaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:30:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D63C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:30:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k1so7928244pjt.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WGV4I1F24zGyDcgOFIAM1fKYXa7cDhdo3lPZzJ+IeHU=;
        b=SQdhQX7LOSO8S52kUprbIGF3FK5tDE4p2OCregx1V6MT1FfKnSnp2QFVAYgSStcFcL
         b75kah/jFr6FFhZAhR0/VGP4zcvxdxJ/HuwfKS9eaUiDXT/kvFQSyuQBt0rsaEoKGA5S
         oUQm/nB9H1g3OuaEe6UNYT+EK43eRdCCtcgKxGQymmCC03gsPkzUyVd6DJxIc3NsvOv2
         FsIDM+bQ7gYjKKP5iU0s4TU9ynzqiQ7w8mC9OeSoyV5sUaA8dQcss6BVbeK/t0xx3R/l
         T2Qudg8q2iaNC9IwTMNmZNC5RQVntTG0M64LIS8rXmpPRxjm1zvPB4O0kK+39+LCooed
         VkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WGV4I1F24zGyDcgOFIAM1fKYXa7cDhdo3lPZzJ+IeHU=;
        b=Ydl/sIG1Z642bJ09xl+YI4LX6bJtlPCynujBEz2fvUXOMrV28gEyeXVsYntE5r+sDO
         dvox0+9fT+PEiuefjFDJLAc19Yf4eXMc0vnTCzu2Pz2ZusNDv7spi9VTL9vis7iCCP3b
         ZbX362NZyiUwADouID4Ch7nt6LiM3EgauK3LcrZgGEr1/n/vI8W5VSStNjSOaVugNqfM
         /uzU3J2HhEKB4VN4YfuFzXoOU2t6taxz6tcM/QtJc5Ksi0zYm/56j8sISmZxGzr8wzLt
         h+leNvvJYi0MyWHcXgnroHAGbOEepS8vWPH3acEjZ0bfd9D2F1QXWCkJi+b87G9e1neh
         ckPA==
X-Gm-Message-State: AOAM532uftQ2G3bstsSRDVdbLJwa5at/GBCbn1mDiQ1qdn3on+xfY8cx
        2Mlu2M8xhj07xfGdb1gXnulNweTZRRDfwg==
X-Google-Smtp-Source: ABdhPJx9whbcHwiglTcBtEqIK+2T5/5MLdC9HEU/dfBdthL5uoNrZ8YerhCwocoAx/pDtMRDbDVYaA==
X-Received: by 2002:a17:90b:1812:: with SMTP id lw18mr9449844pjb.70.1595788203264;
        Sun, 26 Jul 2020 11:30:03 -0700 (PDT)
Received: from [10.0.2.15] ([122.167.86.75])
        by smtp.gmail.com with ESMTPSA id f72sm12672731pfa.66.2020.07.26.11.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 11:30:02 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: include: Fix coding style errors
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org
References: <20200726080215.41501-1-aditya.jainadityajain.jain@gmail.com>
 <20200726082636.GA447282@kroah.com>
 <CAJAoDUjVBon2iiztdER82mHgJtVS6s5XYSajbCTne0KWAzoLvg@mail.gmail.com>
 <da3da8d5-7227-ad65-1449-de9fb46561c7@lwfinger.net>
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Message-ID: <9aa9f610-41f2-18cb-e9e6-6980a965c3e3@gmail.com>
Date:   Sun, 26 Jul 2020 23:59:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <da3da8d5-7227-ad65-1449-de9fb46561c7@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/07/20 11:33 pm, Larry Finger wrote:
> On 7/26/20 3:40 AM, Aditya Jain wrote:
>> On Sun, Jul 26, 2020 at 1:56 PM Greg KH <gregkh@linuxfoundation.org> 
>> wrote:
>>>
>>> On Sun, Jul 26, 2020 at 01:32:15PM +0530, Aditya Jain wrote:
>>>> Fixing ERROR: "foo *  bar" should be "foo *bar" in hal_phy_cfg.h
>>>> as reported by checkpatch.pl
>>>>
>>>> Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
>>>> ---
>>>>   .../staging/rtl8723bs/include/hal_phy_cfg.h    | 18 
>>>> +++++++++---------
>>>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h 
>>>> b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
>>>> index 419ddb0733aa..fd5f377bad4f 100644
>>>> --- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
>>>> +++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
>>>> @@ -42,7 +42,7 @@ u32         Data
>>>>
>>>>   u32
>>>>   PHY_QueryRFReg_8723B(
>>>> -struct adapter *             Adapter,
>>>> +struct adapter               *Adapter,
>>>>   u8           eRFPath,
>>>>   u32                  RegAddr,
>>>>   u32                  BitMask
>>>
>>> Ick, these are all horrid.  How about just making these all on a single
>>> line like most functions have them instead of this one cleanup?
>>>
>>> Same for the other changes you made in this file.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Agreed. I'll clean it up.
>
> While you are at it, drop the "include;" from the subject. For 
> staging, the usual subject is of the form "staging: driver: thing 
> being done". In your case "staging: rtl8723bs: Fix coding style 
> errors". The directory of the files are not relevant.
Ok, I'll take care of this and update the subject in the next version of 
the Patch series.
>
> I am also not in favor of the large white space between the variable 
> type and the name, but that is probably the subject of separate patches.
>
I think, the v3 patch series resolves this.
> Larry
>

Regards,

Aditya Jain

