Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C36C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E228120786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594221661;
	bh=Xx+4KNBuzV3AiLuzuysYJKHCNwrksGIG+/xMtnsWNZk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=tG9ZlcEtMktmyR86LByWT1iJtkdP7G6r2BkPlLJoAsoZhepoKelyJgb6DCieshXnS
	 PL7Vs96cpHjuI7F+XoEn9fvlLrH1aPigl9//xfeVvE14zcbZLHPZ65JqGyQY+QhN8w
	 qekaKQV+/dy2VZJWmuXT8jgxHTUhL9gq+heRA1eY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgGHPVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbgGHPVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:21:00 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62B0C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:20:59 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d18so5300997ion.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=upDvnN501B9Woeqk+Gky2vENWRjvgbK/EAznbDWi4SM=;
        b=KEE4SSYMIk+VDfx6X1TKQL0jHgyQkHOnmPVgf7+HEmk5QlJla2qUI3gJryg2iZECXG
         IoJvrJ5L0zCUZD/Iglwd4maNeH8u1rQRXJs4KEusTBBUpMKP/QH3HiJGVEbMisCMwdWT
         aC+vhLm+xzn1blAlWBSrotPv+Z7af2OBAbzqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upDvnN501B9Woeqk+Gky2vENWRjvgbK/EAznbDWi4SM=;
        b=bKCScaSb+Eahczt4ODSq1pFl5S5DDvFRjPRa6DFmvwiWs17qh+Y2JO0PWdYftWz/VL
         yFGHEJOiyJtl7aZm/fB3OTe5N8NqOIoHN2HVQBd1jKdJmiS5FLVavqB256r7/RhxCdBB
         F/Vjo+MqVW3yHehBjCKd85uqRRmHx3OnlkC/gVHXn8B4gkEttqmcj8zoliPcGD8Uh7X1
         D+9zltW7XAGh07AF7aJueLrMgxNSHlwGP189jD4XRjfrSNpLrKHgnlZZWz0vIEAbApBX
         yDmiFZskZJO6cLM5fIYp6/YcDcjDrHob4CWeKOpUJV+82XyzkN4icQb3EwY2ROea+zve
         +A1A==
X-Gm-Message-State: AOAM5328EgfbmqkuWmy3jlrTHmKYEjmMSRPJg95qvqWUqLngBCikuXX+
        K0EtV5osZqpsC0uT1E62cSJfZA==
X-Google-Smtp-Source: ABdhPJwMZ6MEMXRL9JUI8ZQMhMu+CbM7A/4K6TZOo9a7aDORzDTJqzFB3b5Zeule8UGW4xdgW8uDmQ==
X-Received: by 2002:a02:ccb3:: with SMTP id t19mr66889054jap.122.1594221659242;
        Wed, 08 Jul 2020 08:20:59 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j17sm28425ilq.7.2020.07.08.08.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:20:58 -0700 (PDT)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: KMOD KERNEL MODULE
 LOADER - USERMODE HELPER
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200708071337.13108-1-grandmaster@al2klimov.de>
 <20200708115324.GE4332@42.do-not-panic.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <57601e00-d351-fa06-0fe0-1a0238f68912@linuxfoundation.org>
Date:   Wed, 8 Jul 2020 09:20:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708115324.GE4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 5:53 AM, Luis Chamberlain wrote:
> On Wed, Jul 08, 2020 at 09:13:37AM +0200, Alexander A. Klimov wrote:
>> Rationale:
>> Reduces attack surface on kernel devs opening the links for MITM
>> as HTTPS traffic is much harder to manipulate.
>>
>> Deterministic algorithm:
>> For each file:
>>    If not .svg:
>>      For each line:
>>        If doesn't contain `\bxmlns\b`:
>>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>>              If both the HTTP and HTTPS versions
>>              return 200 OK and serve the same content:
>>                Replace HTTP with HTTPS.
>>
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> Shuah, can this go through your tree?
> 

Yes. I can take this through.

thanks,
-- Shuah

