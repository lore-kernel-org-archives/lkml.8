Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EBFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786BD212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590536444;
	bh=OG7FJRqcNuF6shGlW2vPk/VpKT8NITLKmyGCoanPK4Y=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=2pEIwLL11eRbaOIZY1X5oeqZYxoXGXqM4NfzZKrJNvMWFaGJ8schYnCjmKtJrKhIs
	 7Sfyicm7zCSp3DB1DsXw1rmrutkPIFejFCG8YDJ7/hCEtW2UuCqhhUvbcMAYRLDQ9I
	 f5a7c6XExF68SAevq/DC1NxlYUAKZU/jY2cM+7oY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgEZXkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 19:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgEZXkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:40:43 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B78C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 16:40:41 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d7so17803662ote.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 16:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gpaHub3+Ebc0TiJ14S9sQ7y5uOm5zkNwuvn/54f39VY=;
        b=WtWLygSS9hQfVD/pQgDMxTRnmbQSlkrrMNGE/UOzn+qv4x9SLNm5CmLFI4LkzVfOH/
         nX6Y/NjBBb473rnLdjO/tMVrYkyw89PzL9tk8mjB/gE0gjLlk4JEImyqHAJIDssMpqEI
         JfFoBYhnKBCUTMZeB/i3I2JqpXWseEZHvqUrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gpaHub3+Ebc0TiJ14S9sQ7y5uOm5zkNwuvn/54f39VY=;
        b=YqB8SK6fCUfrohSyyQhLMHPyY1oLC2kdiwfopuciybwqe/p1thRU9WB9EHGiytQh4c
         mcbO7hN9aoG1yHFywUBDQNMZE6jTzRaS9pzplsQflWs2x2NqoaEuvsMBbf5/loYcqmBo
         julUDnybd3zJguQWAvDNxpAhyNX18itdtx02JBzrAZpAxI7PQADTZrozy5l+w68ByPMB
         C/tSwBgjuL732xxSX7mHWo0cQ9gQwq8sNFVfdM7Pbr8SLx15kRYCOBHxqlW5JtvsLrP8
         ghJKsQxuhEfo2iwzjTrIF6op9WWZK/PAtyMWSs6SuZbpZD4ocIWaAQ8UZfnUNDE65NsX
         jY8w==
X-Gm-Message-State: AOAM531Hf519BF1FajPyuov8D87ozTPhCjQI2Glpy6UBwr38+ktk/sDN
        jy2TorcfOvGRMhmOfxkERbtUVoc44Bc=
X-Google-Smtp-Source: ABdhPJxtt8OlHLfNxdtty/UIw2VhUrVJdEFodPXAZ/GIgH67OHXshUYzhwqKEt4gGUNWI+xZHg9eWQ==
X-Received: by 2002:a9d:7998:: with SMTP id h24mr2773029otm.316.1590536440832;
        Tue, 26 May 2020 16:40:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w8sm361333oie.12.2020.05.26.16.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 16:40:40 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Update my maintainer entries to reorder
 email addresses
To:     Joe Perches <joe@perches.com>, mchehab+huawei@kernel.org,
        davem@davemloft.net, robh@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20200523021928.67126-1-skhan@linuxfoundation.org>
 <7366c990d4352e093ff7d17953079d7f0420c3a9.camel@perches.com>
 <661f53a3-b15c-76b0-f220-0d292b0843d5@linuxfoundation.org>
 <b0854ec2906323d34514875a58a79d4cb74e44b0.camel@perches.com>
 <ea204501-84a3-badb-63f6-0a9d2fe12b19@linuxfoundation.org>
 <fd6892ca0191b67491416318958d1ece23e840ff.camel@perches.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <21d9569d-40b7-3cdd-5176-cbb7d4cc6892@linuxfoundation.org>
Date:   Tue, 26 May 2020 17:40:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fd6892ca0191b67491416318958d1ece23e840ff.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 5:33 PM, Joe Perches wrote:
> On Tue, 2020-05-26 at 16:54 -0600, Shuah Khan wrote:
>> On 5/26/20 4:27 PM, Joe Perches wrote:
>>> On Tue, 2020-05-26 at 11:04 -0600, Shuah Khan wrote:
>>>> On 5/22/20 8:26 PM, Joe Perches wrote:
>>>>> On Fri, 2020-05-22 at 20:19 -0600, Shuah Khan wrote:
>>>>>> get_maintainer.pl picks only the first email address found in the file.
>>>>>> Reorder my email addresses so it finds my linuxfoundation.org email.
>>>>>
>>>>> OK.
>>> []
>>>> Sadly, people that don't run get_maintainer.pl, leave alone running it
>>>> with --noremove-duplicates option. So your suggestion doesn't really
>>>> help me.
>>>>
>>>> My preference is to get patches to both Inboxes if possible which isn't
>>>> possible unless -noremove-duplicate is default. Having this option as
>>>> default probably will annoy lot of people . So I am not asking for
>>>> that.
>>>>
>>>> That being said, I don't understand your comment. Are you recommending
>>>> using just one email in these entries?
>>>
>>> Yes.  And maybe set an autoforward rule in that email to
>>> forward the received email to your other address.
>>>
>>>
>> Sounds good.
> 
> Another option would be to write your name
> slightly differently in the 2 entries.
> 
> For instance, add "(LF)" to the linuxfoundation.org entry like:
> 
> CPU POWER MONITORING SUBSYSTEM
> M:	Thomas Renninger <trenn@suse.com>
> M:	Shuah Khan <shuah@kernel.org>
> M:	Shuah Khan (LF) <skhan@linuxfoundation.org>
> L:	linux-pm@vger.kernel.org
> S:	Maintained
> F:	tools/power/cpupower/
> 
> and then the get_maintainer.pl script won't
> collapse the equally named but with different
> email addresses into a single entry:
> 

I like this option.
> $ ./scripts/get_maintainer.pl -f tools/power/cpupower/
> Thomas Renninger <trenn@suse.com> (maintainer:CPU POWER MONITORING SUBSYSTEM)
> Shuah Khan <shuah@kernel.org> (maintainer:CPU POWER MONITORING SUBSYSTEM)
> "Shuah Khan (LF)" <skhan@linuxfoundation.org> (maintainer:CPU POWER MONITORING SUBSYSTEM)
> linux-pm@vger.kernel.org (open list:CPU POWER MONITORING SUBSYSTEM)
> linux-kernel@vger.kernel.org (open list)
> 

Thanks for the idea. I will rework the patch and send it.

thanks,
-- Shuah


