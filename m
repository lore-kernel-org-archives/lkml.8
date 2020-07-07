Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0768CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2CB2067D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594152390;
	bh=Q8cYr3emIBz5I2SVRAbSwt8x/mXTe6S9IVSIduWrF8M=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=eD8lFylprs8/9mdBGozad1zcs5n6NcW86O661w9MHGR0Y2HwDCdJyuRH0O4XbSTVt
	 +VmANcFnJOm43/RBd5dYCLuMgShhAuXM93sspxibTH6rvqvuUaAISa8+07YBli/U+m
	 09ufHq46U0OFBqoFe3s+vQ6REgHPbJFfcSN4ojoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgGGUGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGGUG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:06:28 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9281CC08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 13:06:28 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h1so13093277otq.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r5PL45TtpUanLMjUFz1CcEwQghycNM5MHybEf6+OAdY=;
        b=Ia/xRu4E5EmGy6Euz2yN+Lu4bpiUJmEdWdzTD8OqM8AxBU6FQFBhSUpyKT01Vr8Gfb
         B1Z5wCAkGvzqfHGLEzzzBaknQJXeNrxuVnCP9kf8bRooXqJKq6zqnMXR+v5lLmKVtu5A
         QTSvpd1Xn3a+ElGJKiVI+MGiIxrLD5plOOwc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r5PL45TtpUanLMjUFz1CcEwQghycNM5MHybEf6+OAdY=;
        b=ikEi5yLFEhJYdTBwppK19DCtFLOaUAKn+LacFom1mkv5acJuz2lpRE+mwEnJ+x8OOG
         1i660JCY8aoPP9hy1T0N89jnUq2eWArYGuocF3OgcaR3DTuAbfDB7cUywOo/qgrTTE4g
         DxSEbIk9aAfNkDW38ixnzupSz5ow9jXMUMFJv2Nq5tq3XDuHRrl4yjkmI1GMSCeOmCt6
         TkyfVwY07J7u8WyFaFv0d48BVXuXaZSgTky7LriQncEIOIrpfBAPBopOq9O+d0lPyKSL
         Brl2urzc1pkS3GdHVCYIrwx3HqUPe7qPhrRE4MopLvwBZF9xgx2jVm91MRDBua07LxPh
         OdKA==
X-Gm-Message-State: AOAM533T08aqGECNAnRlk70wYY2gBLUF7mfUHH0rMn3qsr1viIZ9CDYh
        KOwt5Vbvquv7ZY+BVSi78OvbIA==
X-Google-Smtp-Source: ABdhPJwwnZXLOhRRrCJBbJ2DZTfTavUWiRd8aI97qtpmNCNSuXiRBk3Odg92UJhZ/9Q7+WOFz9Le2Q==
X-Received: by 2002:a9d:2261:: with SMTP id o88mr8252897ota.334.1594152388040;
        Tue, 07 Jul 2020 13:06:28 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d193sm302792oib.53.2020.07.07.13.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 13:06:27 -0700 (PDT)
Subject: Re: [PATCH] usbip: Use fallthrough pseudo-keyword
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200707195214.GA3932@embeddedor>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <977e88c2-58cb-9507-c889-854e574a8f31@linuxfoundation.org>
Date:   Tue, 7 Jul 2020 14:06:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707195214.GA3932@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 1:52 PM, Gustavo A. R. Silva wrote:
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> fall-through markings when it is the case.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 

Is fallthrough syntax supported on our min gcc version?

Does checkpatch or coccicheck catch these cases?

The patch looks good.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
