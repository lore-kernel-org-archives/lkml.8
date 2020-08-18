Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA41C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C6120709
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597790181;
	bh=tmPGx+VazV7/X1sMjLH0CQwXw3CFX+iZ3U7SbcIT+HQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=WC0naM7JbZDJrhOEhhVlgXm+HH2kKKfLBjYYptafgNGwYibL77EEtEGjMMKKLZ0OL
	 QGseQS1S7OzPXGfoEdcOO4tJdvJ9C6Xzi5FbhWiH/Vy1hnR2BUPhv0F121t+2PKbop
	 Wk2jaYoD741Cke3e0Hr3sn8sQCnfxGrOmz7xJIUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgHRWgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgHRWgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 18:36:17 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FC7C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:36:16 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h16so17573234oti.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BGwu3Ds0lw1nWujgjMlTgJ2swL0a/mGPBlrtoFhYI7A=;
        b=K1q6wCriz1mvkgWRy3bIzsmUPGlnOhmtun/yZdnwkRGIkfEF6TEAtZlu9WzD/wjk/T
         PsxARtcw5m+ub2tmEIf7AMcGIXANDXVD/TG54HlaGs1+EgwGYZkEiv6Nux7m9WKb4Ba7
         4BjcxeOognk+Q9mdSZm+882cXOYtGhxx+OQzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BGwu3Ds0lw1nWujgjMlTgJ2swL0a/mGPBlrtoFhYI7A=;
        b=LurLT6soViPsIlFEVa0nMKmcUjrmavMaAZDBE6zOTmLUuEeiIU9QVtWScJtksNMwA2
         XZGc6asoJH8yTg12xb3/jtKGj+/s/JBuacMhkTaKnHgrLlClAs8/9gNVgNQ+VGfGG7is
         8kD2eR3/HIRlo8ezWLc9RDvUCDeP+nIl7W5e6DCurt1QwnnXmRARzaJDsFzV3WKMlWYa
         FANEpEeXiRP7CQo/TR10xnlWawlHT6g7DvzIqTsfnAYzNBfJFVErhqLuN+0JVqBjGy1z
         C87X6HzMRf6vEVe2KfYGMgYoSTnVHRjGhRUPDZcrIX4XfJMkW8AL7obnuFw68hXG1XOo
         EcVQ==
X-Gm-Message-State: AOAM530xveYs1ykljTp9fR2tugdOe5sUpvTHQ9S7U317lXRpMHL2VV7M
        4VQrN92nkKzBALPC3ZnnSsqGRA==
X-Google-Smtp-Source: ABdhPJw2iZqlHJiP8nQv+clZaUptBeUGbLFXBjCxkIDvpJyhd/VyMmWUSQlhCqF+cbiBKcEEBFTRuA==
X-Received: by 2002:a9d:6e18:: with SMTP id e24mr15840134otr.132.1597790176318;
        Tue, 18 Aug 2020 15:36:16 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o24sm4297429oov.8.2020.08.18.15.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 15:36:15 -0700 (PDT)
Subject: Re: [PATCH 5.7 000/393] 5.7.16-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200817143819.579311991@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <65aa9e77-5bd3-d8e1-36b4-2d1c306767a1@linuxfoundation.org>
Date:   Tue, 18 Aug 2020 16:36:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 9:10 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.7.16 release.
> There are 393 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2020 14:36:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


