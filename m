Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425AEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DAC620774
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594218908;
	bh=HXNP1CCqkAPDnbD3/kV/qQs15e0zF+67DUbdr8l0wbI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=oCk7ntB42wmoetGeHooWt+bIf6cApaF48qGfm4hj3y0D0d7uNIz6P+mZByXwE1GO9
	 dL0uWbwXlbRMSsdrKL6GsS7LIPIpiSBTYQ87bz2L2nJSd9BeNXdp/urPqLR93XvnOn
	 S8j1P7XhOqoGcU5a0AK1mlCaVHmj0PCEBUMrlmS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgGHOfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbgGHOfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:35:06 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B98C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 07:35:06 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 5so35063452oty.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8hC3XvGyCsI20W0CB9NNMoDweDfY9pNGkQ9Zc0NBsrQ=;
        b=Hz0dHVKfKtEdJFlXltQaUHZzx6WteXWGkmSB7eD22oIwFeZVZELMu9EA49dnk3KZf/
         aS/ETKRKmCiOmiwgysN/+jpT7uxyUI58Z009UkjClozxMn7u/xlsXr9AbkwKe+uZv0VU
         RgWoSkklvaEdXxPUMaPjLgy3/DeSC40KLf2oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8hC3XvGyCsI20W0CB9NNMoDweDfY9pNGkQ9Zc0NBsrQ=;
        b=Pgnjl0c7h5naB6AotNfmlKFfQHJWSbYts2whm60lye3BiG010lBFEyXIIqaHKjeWcn
         DKecPXFrrdGiCNIRyKR0gMAYDOAn47efPsj8IS/Go85a87wbxtq2Cub1O/yvFVZVTKtE
         4Xaz5paDkifogsrXXAp8Xp44A1+mzC/msLphJ0OsD5pEk2TSRpmCAloDim8kFpl5tldk
         QHlIRf/ZtXBxdXAwFWO1gfQhRo5w3iUsc8IY2U8O8OEbd4C2nvMOGxVt8zoz0/OQkDi0
         iiO0tjnWcXnepN4iwL+LsEDxNqw76JEl0Btkunyy0sBOGEc3ieC+e5pvnwoRTLNv4XjX
         /qog==
X-Gm-Message-State: AOAM531UYI8Hp0D7ou6cro5W691YUwrhCdXLRvJFwpoM2iTmJ7CLawsu
        m2AuEZBihNPpAxCyHOsVsv+8ng==
X-Google-Smtp-Source: ABdhPJw0gOV53aPbW5ql2DbAxEGAYpwAxjrPK+hBKhUzJEU+vwTdPq884fkUySj6uv8O6gWuq7ZXvQ==
X-Received: by 2002:a9d:7853:: with SMTP id c19mr28772727otm.68.1594218905540;
        Wed, 08 Jul 2020 07:35:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r25sm3572oot.38.2020.07.08.07.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 07:35:04 -0700 (PDT)
Subject: Re: [PATCH] usbip: Use fallthrough pseudo-keyword
To:     Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200707195214.GA3932@embeddedor>
 <977e88c2-58cb-9507-c889-854e574a8f31@linuxfoundation.org>
 <8e08240671d65f1e92dbf5e1e066190149e0d074.camel@perches.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1b6b83f7-c749-6e0a-0001-2febbf01b603@linuxfoundation.org>
Date:   Wed, 8 Jul 2020 08:35:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <8e08240671d65f1e92dbf5e1e066190149e0d074.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 7:56 PM, Joe Perches wrote:
> On Tue, 2020-07-07 at 14:06 -0600, Shuah Khan wrote:
>> On 7/7/20 1:52 PM, Gustavo A. R. Silva wrote:
>>> Replace the existing /* fall through */ comments and its variants with
>>> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
>>> fall-through markings when it is the case.
>>>
>>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>>>
>>
>> Is fallthrough syntax supported on our min gcc version?
> 
> No.  Introduced in gcc 7.
> 

Gustavo,

In which case, this patch would break usbip build on older gcc
revisions.

thanks,
-- Shuah
