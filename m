Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0042C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C428C20575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiHAQB5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440017AbgDNMTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439999AbgDNMTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:19:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C304DC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:19:01 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k21so12270267ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V2uhKGH1niG1NZ7O2reXhRZkgbh6RqYNoAWaTPDRwBc=;
        b=OiHAQB5F+9MwiQLWbGcwkrQZ+osTSBwOsMy5kcZtWYnR8k4okAp2XelXhano8lZPN8
         cTgJOzPaPkoedcEvWsPG8cUVy6bI6l+Ko4XsThFW7ZK98rWYn/FklZgdXjhHchDgZt1D
         XjfdLPT3NpV9MpKflOoTutBnaP0uW9SxRzWNoFjANUJzO1XoKeQa5C4rkZ0kH4MCrbmh
         VjZKURhgVMqgpALpuf6u+sPip5a62otDAQ00BsuDlPSReYgZPKY9LY2WdgOQ/GxZ+AFn
         RghZSY82owdeScpFYe++gpFet5hJNmIK/WYU81+cxy0a8PijDYkuButVbIdPSvRI5xql
         vtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V2uhKGH1niG1NZ7O2reXhRZkgbh6RqYNoAWaTPDRwBc=;
        b=r0YuCQ9CntoDp5DKmbBt3Q26Ce/0B0CqXjD0DBh4gg4JlQdM/TlTzN9QEQej4iUkrC
         ooAOk/fbp32hEt2kxMMnl5gkg4q38B2ok/YhsuuEsXqHmRBg/fDFW/vmT/8Uf5NopSwh
         cOipmi9aCLJXxGiIqaTBKYYVHKWwAoMi8d8B1GYlkAg6Iha9n51Euw/6K5PbKx1EhS4K
         yaZC4cY97mW3TSoPUruTlqmplxwi/UFIR+GJSD8PTgL7DgNkuXU/RnowhwqJDVABRdY+
         2Bw60krACPsTNxxi+jGR+kCh/g2d7OzgkYDJOCWyJPdxJOaSXs9KknlepUkxGV+/cRPP
         DpEw==
X-Gm-Message-State: AGi0PubReGGg3Y8lU7SrhF5C2AiolepLlp5HnPf47vjglQ1O5oWvjaiQ
        ++VwdLLIckvqv28SFGFy5H5rh80A
X-Google-Smtp-Source: APiQypI3Nkfx8h6Wo157c8g5j+hbkgjomDF7OWCyYPa7rvJI4EQxOHRF0nZqN8Psc+SKKr2KzD+ohA==
X-Received: by 2002:a2e:8996:: with SMTP id c22mr9952749lji.155.1586866739156;
        Tue, 14 Apr 2020 05:18:59 -0700 (PDT)
Received: from [192.168.0.160] (84.188.smarthome.spb.ru. [80.249.188.84])
        by smtp.gmail.com with ESMTPSA id c22sm8980495ljh.66.2020.04.14.05.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 05:18:58 -0700 (PDT)
Subject: Re: [PATCH 5/8] staging: rtl8188eu: Remove function rtw_modular64()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190712071746.2474-5-nishkadg.linux@gmail.com>
 <66fb1e37-107e-54f4-4986-ca4e4bb99d2d@yandex.ru>
 <20200414115604.GF1163@kadam>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <20becb6f-7bf6-8618-9525-b64c226088c7@gmail.com>
Date:   Tue, 14 Apr 2020 15:22:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414115604.GF1163@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/20 2:56 PM, Dan Carpenter wrote:
> On Sun, Apr 12, 2020 at 04:34:08PM +0300, Ivan Safonov wrote:
>>> Remove function rtw_modular64 as all it does is call do_div.
>>
>> This is wrong. Macro do_div(x, y) change first argument x, but
>> rtw_modular64(x, y) preserve it.
>>
>>> +			tsf = pmlmeext->TSFValue - do_div(pmlmeext->TSFValue, (pmlmeinfo->bcn_interval*1024)) - 1024; /* us */
>>
>> rounddown(pmlmeext->TSFValue, pmlmeinfo->bcn_interval * 1024) - 1024
>> is a better replacement for
> 
> You're absolutely correct that the patch is buggy, but I'm not sure that
> rounddown() is what we want.
> 
> rtw_modular64() took the MOD of x.  So it should be something like:
> 
> 	tsf = pmlmeext->TSFValue - (pmlmeext->TSFValue % (pmlmeinfo->bcn_interval * 1024)) - 1024; /* us */
> 
> But what the heck is that even???  If pmlmeinfo->bcn_interval is zero
> or one then the subtraction ends up giving us a negative.
> 
> regards,
> dan carpenter
> 

1. pmlmeext->TSFValue can not be negative, because it is uint64_t;
2. pmlmeext->TSFValue is cyclic value:
     https://en.wikipedia.org/wiki/Timing_synchronization_function ;
3. (rounddown(a, b)) is equal to (a - a % b) by definition.

Ivan Safonov.
