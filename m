Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD57BC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 02:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9B120637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 02:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbc6m1pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgCKCpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 22:45:46 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36715 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbgCKCpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 22:45:46 -0400
Received: by mail-il1-f195.google.com with SMTP id h3so600578ils.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 19:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k8BnMRt8VzyM9/Iob3jnPHEoeEkg0bXf9PoCpKaIZBI=;
        b=cbc6m1pzHmkwjtaxbA17HMxOxKMQ1amglEFAzXX0JbE5LeXphwmaTjoxEESrql9dFH
         Q5J0exL0ehWlNONBMYVn2xLlm4cp1NjVsCPKJRelZU/PO8IZel6NM/kIa28Do74fHxgX
         zapR1DbTVFWbojlaVEa7VKnkyRRRhTWJxtv8hbwdTQRoeXjiLMOP0dz9TkRtjBwZmjUi
         8vEDDyTtgyOOlUZ0xwiLlgQQ4FLrFuWGV0RXUbkhbzV22TQRs208amZF2B+mM5Z+nZMq
         q9+7L5+VHPxHuYUxQ7pU/rvlyJrmn7E47UBRd1xQYHYAEM9e0DCN2t9Z+aaiVI06S5jJ
         ONMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k8BnMRt8VzyM9/Iob3jnPHEoeEkg0bXf9PoCpKaIZBI=;
        b=CWDupUwF/rGVLmMngAy74ylPwa1uEV2/tOSFRqt9AZYWP98GFnEOluIAsyFf24b57R
         za+v0AQrENo11EYs5N7hY5b8I9WJ8JXRL2QbzC0yBisxghSj12NPIF5ctf0AEJb5MJyQ
         A782S0DGhMfsfskGQWr7eEh5xMY/XLOkXNhSFfczqFLJUNpx/r7kwRP1ru2Ol8bx/Ky1
         r2krHJnH62x+UiNFJus6is6IoltK1MI/8XQg6lSBlckEJ9TKG+HYUlkh34qmV11HXftt
         vGWrYrvS+BOWjajF2OYP8yuGekNVE/QEs0ynwNx+l1XJrVCcFODe7wYwKUPfGCGoKZ7p
         7nAA==
X-Gm-Message-State: ANhLgQ1Djz9tVMnOI0M0t3RM+3xkCGoVuP9p4qcQ0a7HvTZd3RASFDy9
        X+//21EultRGZ9lBBERjWkuEpbE4H7w=
X-Google-Smtp-Source: ADFU+vvXQZI3zbstWEqnSOSoYO5IMA8Gp3GzX6wkJJtuJijLgwEv5ZzmSf6QLJuVD9ydV8p2lNaijQ==
X-Received: by 2002:a92:d851:: with SMTP id h17mr1105410ilq.104.1583894745118;
        Tue, 10 Mar 2020 19:45:45 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id t24sm2002503ioj.13.2020.03.10.19.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 19:45:44 -0700 (PDT)
Subject: Re: [PATCH v2] bitfield.h: add FIELD_MAX() and field_max()
From:   Alex Elder <elder@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20200306042302.17602-1-elder@linaro.org>
 <20200310212938.GA17565@ubuntu-m2-xlarge-x86>
 <20200310145825.6ddb3797@kicinski-fedora-PC1C0HJN>
 <bc50d249-60ab-767d-ae0c-02629483df34@linaro.org>
Message-ID: <e46a1ba6-e169-e5b5-7933-ab22848407df@linaro.org>
Date:   Tue, 10 Mar 2020 21:45:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bc50d249-60ab-767d-ae0c-02629483df34@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/20 8:48 PM, Alex Elder wrote:
> On 3/10/20 4:58 PM, Jakub Kicinski wrote:
>> On Tue, 10 Mar 2020 14:29:38 -0700 Nathan Chancellor wrote:
>>> Without this patch, the IPA driver that was picked up a couple of days
>>> ago does not build...
>>
>> 😳 
>>
>> Yes please, Alex could you repost ASAP with [PATCH net-next] subject
>> and CC netdev to get it into the netdev patchwork?
>>
>> Please also make IPA:
>>
>> 	depends on (ARCH_QCOM || COMPILE_TEST) && 64BIT && NET
>>
>> Otherwise it's really hard to make sure the code builds.
> 
> Sorry all.  I have been on vacation the last few days and only now
> saw this.
> 
> I will put this together shortly.

I just sent an updated version of the field_max() patch.  I will do
the COMPILE_TEST change separately (and not today).

					-Alex

> 					-Alex
> 

