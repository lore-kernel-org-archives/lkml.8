Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1C6C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50D924677
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ap/afzah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgB1Shm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:37:42 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:32841 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Shm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:37:42 -0500
Received: by mail-io1-f67.google.com with SMTP id z8so4539946ioh.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mpwUvULyCQjRqfOVbaP/yJdxCEN7LqjKSbCeb+zGAUA=;
        b=ap/afzah12DCPM2OvRp7gX/rjZ1GqmNYaQi4CZZJVD25LOmeh9L5r/zaPBOCW0G3BC
         Mr1G0487ckwd3XuZgEQYTyKpga5ZnTwFcw3W2xs43Y7n1l18SBJs9QgKWvXGfsc17Ons
         J0IpVo+OMriLKV0tZ83egJpCsZPzwtqzyqvCHPCyNA4opzfOS4Wqz0wYZNb3h+USdcPt
         jNdcQqtGjd3BI/DHHEQcrdgcolvGwjtfINAhJg9QsoU6lHrv4D5J6T+2JnZiCDChKobw
         n/an9zqWxhWdxVCoY6AyYL1ranTl+ACEXD0ZdKnyd8fjm/S6oslXcC5RloMzEjviZ7vB
         Eg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mpwUvULyCQjRqfOVbaP/yJdxCEN7LqjKSbCeb+zGAUA=;
        b=I8+EoAxreQuIFDc/7k6xBNdrv4aXKH/0kuxcLpW1gYJ8PiuHvKhRbMeITzE0efILZh
         VrleqdsT6Bu7beUvXbd2crmWHmjJWL776qpOKs7C8bcwMz243PZryz10fhT9yiXr5tHQ
         WSK1T5Ii49tCPS0XB/zR6Emh1RRGB87o1LcYZtuGUOjO8fecuwrFzEqNnyn06llWAPky
         LBWWdneHavD6QV+dSTPvceN7t/BvI4aOUkZcjhzDqipUGCH6ydFGMyOT17MsKR/W8MyK
         JKlu/uz0LeooippJkLi7k5rLnq+kg/4sTOSnt9DetS9n3WkQKti5MhJIylz0utmcZY4I
         13Rw==
X-Gm-Message-State: APjAAAVU7kUvfXLDeDuAuc87o13XHFRmU/Zatl+VJ11a6bCdYHX4Yrd2
        yy8IhgVfnjssBbm3S+ALU5YjSoJ0px0=
X-Google-Smtp-Source: APXvYqx59E1TSxym4fAW5s3AkBTbutLFfz5yhGE0VcST3r5aKmQL7RxZMmvISyfOOPS75uWrngqqcQ==
X-Received: by 2002:a6b:b8c1:: with SMTP id i184mr4208428iof.68.1582915060999;
        Fri, 28 Feb 2020 10:37:40 -0800 (PST)
Received: from [172.22.22.10] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id b12sm3339815iln.62.2020.02.28.10.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 10:37:40 -0800 (PST)
Subject: Re: [PATCH] bitfield.h: add FIELD_MAX() and field_max()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20200228165343.8272-1-elder@linaro.org>
 <20200228095611.023085fd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <d6bf67ba-3546-c582-21a6-30cbd4edd984@linaro.org>
 <16889e77-31cf-58f6-c27e-5b8a6b3e604d@linaro.org>
 <20200228103339.4f36d6ae@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <d2fc495b-0520-2acc-accb-4f03637dfd85@linaro.org>
Date:   Fri, 28 Feb 2020 12:37:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228103339.4f36d6ae@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 12:33 PM, Jakub Kicinski wrote:
> On Fri, 28 Feb 2020 12:06:09 -0600 Alex Elder wrote:
>> On 2/28/20 12:04 PM, Alex Elder wrote:
>>>
>>>
>>> I find field_max() to be a good name for what I'm looking for.  
>>
>> Sorry I wanted to add this but clicked "send" too fast.
>>
>> Yes it's the same as field_mask(), but that name only *implies*
>> it is the same as the maximum value.  I mean, they're the same,
>> but the name I'm suggesting conveys its purpose better.
> 
> We got FIELD_FIT tho.. The comparison is part of the macro there, 
> and it catches negative values if they manage to sneak in.

Ahhh!  I was using the lower-case macros and it looks like there
isn't one (despite seeming to have all(?) of the others).

How would you feel about having field_fit() be a lower-case
equivalent of FIELD_FIT()?

					-Alex

