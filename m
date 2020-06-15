Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53B6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFC72071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592255054;
	bh=SmZW9pDr3DEpE/eP7ZF3mkQyJtcI6kFVuvjGY7YFSGA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=cQEp9DQduZe3bLq9PoG1iWm2cwj5oIUKgf74bCmDDrjZHtUyVqhONN6Zf1Fluymme
	 D/Ybn1s5PPV7WgHZwcD21r3YTAF6zsz7jbd2Wx6JV0tgPyJY7KvUeTCGDdR6eIfkKr
	 /VxPWIbz/JPYq4iSTFsQ6fWfBhXDEniXTHK9iKpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbgFOVEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbgFOVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:04:10 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F680C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:04:10 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r2so282663ioo.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0H5DiKRntw4JxOQ2UKOfB+LA6+SClfcgg8Bl/UF1SbQ=;
        b=SANTsYm6L2RzIRJMZCZYuO5UNhpC5qEq7EUZjOMtwL4ufMTX3KN7eX7+Qjxo+I9QAe
         LuLNWwftpoGYoiFdyBtO9y38RNzrIiL8KJdH3jOld8RaHMvgYIHTgXJis+Pp1hneBixb
         39CmfjTrJ+HRIRBzBkcMtsDpOl00btvkM2xHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0H5DiKRntw4JxOQ2UKOfB+LA6+SClfcgg8Bl/UF1SbQ=;
        b=dtFRk9Z7CbAZaa0GlP8MN+xW3+/xmLjHIAasy2hzqLAOnSuFHBgZIRA10RYiWKCxmS
         2uXG1fxHwuIPlNPz33DOpYYELKIJ9oOegGrP/KfxfJEB2g5tBttKVFU5vIxqTNu+vrfK
         +enXdl6QdPGpWfbUzcfrSA/NnOordEOC3cliscIdg7/yQCfpwZ7Fx+t3bdnHrDSwGBn7
         V+/m2mjT4Qs9MnZ2eqR6C1K+AKSN5OvesUd5YoLwmI1DeIfTLzIigvZ5sgbS61p+216/
         Ml5nA5XblwaFV1dMaRIqo7xQYscqfyMVfyAyl8gf3BgoJ8Yhlj/H4cqiG9Ta6dGxqal4
         Fllw==
X-Gm-Message-State: AOAM530cNtkP7PWyBrUv1Da8xkjkp8ffnoC9rkvgWgc69XXRNArzOA9G
        w6QMi1agbDRZMZKdXT5Lsx/SdQ==
X-Google-Smtp-Source: ABdhPJwZl4Uj8H5Rkx+nqMi7W8kW6vGz/2iqeFI3L9YM8rQZOqr6vgxCgnDP1rCppfQO32xCa355Nw==
X-Received: by 2002:a05:6602:1243:: with SMTP id o3mr28833645iou.89.1592255049117;
        Mon, 15 Jun 2020 14:04:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n82sm8506653iod.23.2020.06.15.14.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 14:04:08 -0700 (PDT)
Subject: Re: Linux 5.8-rc1 BUG unable to handle page fault (snd_pcm)
To:     Takashi Iwai <tiwai@suse.de>, David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <446c7a14-db97-6389-a03c-9ffccd251529@linuxfoundation.org>
 <s5hsgew2jbl.wl-tiwai@suse.de>
 <ef100771-ae52-dd35-2d6b-762e5dda6e81@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ab725932-ad87-5b32-b57b-a4f11b8f8734@linuxfoundation.org>
Date:   Mon, 15 Jun 2020 15:04:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ef100771-ae52-dd35-2d6b-762e5dda6e81@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 2:53 PM, Shuah Khan wrote:
> On 6/15/20 1:57 PM, Takashi Iwai wrote:
>> On Mon, 15 Jun 2020 20:48:11 +0200,
>> Shuah Khan wrote:
>>>
>>> I am seeing the following problem on my system. I haven't started debug
>>> yet. Is this a known issue?
>>
>> Yes, the recent fix by David should paper over it:
>>    
>> http://lore.kernel.org/r/alpine.DEB.2.22.394.2006110025250.13899@chino.kir.corp.google.com 
>>
>> IIRC, Christoph already merged it in his tree.
>>
>> I also made another fix series in the sound driver side (found in
>> topic/dma-fix2 branch in my sound.git tree).
>> But I guess I'll queue it for 5.9 after more testing.
>>
>>
> 
> David and Takashi,
> 
> I applied the patch David pointed me to.
> 
> http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/dbed452a078d56bc7f1abecc3edd6a75e8e4484e 
> 
> 
> I have CONFIG_AMD_MEM_ENCRYPT enabled. Building now. Will keep
> you updated.
> 

This patch took care of the problem.

thanks,
-- Shuah

