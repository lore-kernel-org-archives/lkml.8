Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0692FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B928520C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vwgyAFNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbgIIQcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbgIIQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:29 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080A2C06137F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 07:24:49 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z25so3292393iol.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J42uWZO91Vl6z53QuSqgDQ5nEZPu3ErBMsf2V3eJXao=;
        b=vwgyAFNFY0Rk6tGpJrQKkFa2XORu9tkWL3MOvEnxMWQSsbJhAjs0wQkh45yfbxgWty
         P4LutOppwndoh6fYhlpY/FnHJ7s6roKt4SmQ4ZpkvlcGIxjeXF2o2A/OxCF6LlScMtNO
         sd1g73r4KiQVkYw0cr9Uby1XQGWuAPxYLmrDOkiYBuC6w2Lor4MVkXLDdEJOmCpTmfNV
         OooUgHeq067qTX1T/mzo/jYDU8gFVMGTX7A+wovVWcHT9Cn1BOV0cJ5c90cqkK04z5zV
         FQRf3f1tWU3m+KnOqKecj1nxHPOb0476pqidIdfBKhmVP8zKJt2dC5dXnsGG8kbtXB49
         uuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J42uWZO91Vl6z53QuSqgDQ5nEZPu3ErBMsf2V3eJXao=;
        b=AsY/b1L8WchP+J472PxfYcw90gY4q15cL39UoUjgfp6s40jSEJBmFDYgZT1EZkn/wI
         jiFI+bbfiF4j+O2B8x6WxpqFZgFhjHHYHTus8nmEXe7mahK2dxUvSNPZuRGdUeoPpCaF
         xx+7cqoE+xIOZ1f8oI6nDuZsoM5uDtiR09uBqM3vPDH6ybsxBnsMEGuf83kxrZGezyy/
         EoAt0edWiO24SvjS4IsRTy/C807ugYkFy8T1TPen9ABsSjX1BD7bEQ9VxN0IzNLPf2DH
         yIsUNi6WuASgkOFXovvH58bKWypbdnHldNfG72q2GG/7RZL1tFeot+lkbmucElZvn1GB
         pXLA==
X-Gm-Message-State: AOAM5325wcy/W/4Lq9L2tjA8lidUtCfBXjp97Au3JaoEYB6mjPpKhbWy
        dJ0WB2Jc5Jj/y8X2g1Y4A6lnZg==
X-Google-Smtp-Source: ABdhPJzw71ClM3e9xwflgpNGkqys4GZLnoSdxzDPCJW81NzzXlaCm+tbHvqOkGBBc4MqR9ZnkKGG6w==
X-Received: by 2002:a02:1142:: with SMTP id 63mr4314795jaf.73.1599661486949;
        Wed, 09 Sep 2020 07:24:46 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 2sm1457722ilj.24.2020.09.09.07.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:24:46 -0700 (PDT)
Subject: Re: [PATCH next] io_uring: fix task hung in io_uring_setup
To:     Hillf Danton <hdanton@sina.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        syzbot+107dd59d1efcaf3ffca4@syzkaller.appspotmail.com,
        Stefano Garzarella <sgarzare@redhat.com>,
        Kees Cook <keescook@chromium.org>
References: <20200903132119.14564-1-hdanton@sina.com>
 <9bef23b1-6791-6601-4368-93de53212b22@kernel.dk>
 <8031fbe7-9e69-4a79-3b42-55b2a1a690e3@gmail.com>
 <20200908000339.2260-1-hdanton@sina.com>
 <20200909001943.18916-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e04aea6a-4049-da2e-e8e8-9025aa03268b@kernel.dk>
Date:   Wed, 9 Sep 2020 08:24:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909001943.18916-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 6:19 PM, Hillf Danton wrote:
> 
> On Tue, 8 Sep 2020 17:34:26 -0600 Jens Axboe wrote:
>> On 9/7/20 6:03 PM, Hillf Danton wrote:
>>> On Mon, 7 Sep 2020 06:55:04 Jens Axboe wrote:
>>>> On 9/7/20 2:50 AM, Pavel Begunkov wrote:
>>>>>
>>>>> BTW, I don't see the patch itself, and it's neither in io_uring, block
>>>>> nor fs mailing lists. Hillf, could you please CC proper lists next time?
>>>
>>> Yes, I can. So will I send io_uring patches with Pavel Cced.
>>
>> While that is nice, it should not be necessary. We need to ensure that your
>> emails reach the list, that's more important than needing to CC a specific
>> person, because it still means that everyone else doesn't see it.
>>
>> Do you get an error from vger, or does it simply not show up?
> 
> After tapping the send button for this message, I will receive a message
> from the sina mail server saying it failed to deliver it to one of the
> targets (abc@vger.kernel.org), which has been happing over the past a
> couple of years. One of the redhat guys, I can't remmenber his name,
> once tryied to help me solve the problem, by sending somebody@vger a
> message explaining what was going on, but failed. AFAIC there's a
> glitch in exchanging info between the sina server and the server at the
> vger end, and it seems it would take more time than thought to figure
> it out. So let it be for now.

Might be worthwhile to just have a gmail account for sending patches
and replying to list emails?

-- 
Jens Axboe

