Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3E2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FCB620787
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589552108;
	bh=sdZ0vgVW4GdHLhNFdigrTPAfmgUh3pGhv4/S9Isnj4k=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=tcpUpNsaG5AFaSwTrz8vIPmtfXSxEwwEQL5i4Tb0IYDl/KiLorCl9EeeEYQUX7UnC
	 HwSes4S7hYQW3o0WKgvDJX5PSwGQREXbTOnR73DLVVbu0inMPvMTYa0fhWEqWxxmLb
	 d1vOLTo/HI+iWwUsq37UHi/1KadeItfo8aJTw/eY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEOOPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726016AbgEOOPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:15:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FCFC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:15:06 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 79so2899602iou.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Vc6zetwP6+V6hm8FQe6RbS/l4eRIu3Ah4JCuV/PbuI=;
        b=hKBf3EEFOcPEiSyCVBNCGrUN55mtqZDnXEMs91YKh3J/kddvuN4mGwrT/B/7tryAP7
         lfv2MTggP7Kk/Df4GxkdIkoWXNJZu9PCbBhCd1phg4+1bNFPg+2ZaOPmtMGGmSH20hAD
         3t3icSe2FiR1CKCYpR5WfB3C2PN2/iaZynzlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Vc6zetwP6+V6hm8FQe6RbS/l4eRIu3Ah4JCuV/PbuI=;
        b=lY0shnzYjVS9Hv+wIAyRaVkpTbtT3CMZeFSTar64bnPOsnKo55sYLSIZ/lm9q5kxiT
         OV595UHDLQ6RTa0m1bznFgb4x0OQSW1qeyHLabrXFaFXK9IR0uo6Hh9Bpa2REcs8WATn
         khxueZv4qglLbLcp2sMVz96/aqcNw3ILx5njd/jKOWtt4dLq4dBYfDSnA/nZsdbkL5yP
         V/WuB6EdD7ZSiH0cuGUUTZkNQ0a73UuJHYUaFCFHWPWJSN20jyPN2Fx/a1uL7CsUiXe4
         5ofbSRBq6ruAcyechfRNHbVdutkzh3qL3ztM8c8QcoxQsQaofZCanKsTSl+S6Zb9JGxN
         jvAg==
X-Gm-Message-State: AOAM53300ZSq+8WLNtDQZGMAFjNkeOTaTwS6yTwLGiPq1xGQEnSvVN5q
        mtgW8f+ceEPmScSSIH36JaASng==
X-Google-Smtp-Source: ABdhPJxUWoLgEw9pDcP5zoizEWrT9AfP7Dr+SeOivEeaMsHN4oDP8N2KSFbXjeQjNoWaCo0YjWqqLw==
X-Received: by 2002:a05:6638:3af:: with SMTP id z15mr1842637jap.4.1589552105324;
        Fri, 15 May 2020 07:15:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r80sm960355ilk.65.2020.05.15.07.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 07:15:04 -0700 (PDT)
Subject: Re: [PATCH 1/4] selftests: Fix kselftest O=objdir build from
 cluttering top level objdir
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>, shuah@kernel.org
Cc:     mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
 <58d954867391c90fe0792d87e09a82bda26ba4fc.1583358715.git.skhan@linuxfoundation.org>
 <7hwo7qijn0.fsf@baylibre.com>
 <ceb910b1-2ab7-b27f-7e53-c445d96cdeb1@linuxfoundation.org>
 <11765b79-f19c-4aea-5c4a-d9ad24e550de@infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d9a50dff-f634-f8d0-a25b-7f33ccf46d9f@linuxfoundation.org>
Date:   Fri, 15 May 2020 08:15:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <11765b79-f19c-4aea-5c4a-d9ad24e550de@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 8:27 PM, Randy Dunlap wrote:
> On 3/11/20 4:31 PM, Shuah Khan wrote:
>> On 3/11/20 4:58 PM, Kevin Hilman wrote:
>>> Shuah Khan <skhan@linuxfoundation.org> writes:
>>>
>>>> make kselftest-all O=objdir builds create generated objects in objdir.
>>>> This clutters the top level directory with kselftest objects. Fix it
>>>> to create sub-directory under objdir for kselftest objects.
>>>>
>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>> Only somewhat related to this patch, another problem that wasn't in your
>>> doci is that the current O= support doesn't support relative paths.
>>>
>>
>> Yes I am aware of it and it is in the document as something that will
>> be addressed later.
>>
>> "Note: Relative paths don’t work - supporting relative paths breaks work-flows e.g:
>> powerpc. Explore fix. Compile work-flows. Not planning to support at the moment."
> 

I attempted to fix it once and had to revert the patch. This relative
problem needs to be fixed and being tracked as a bug.

>>
>> I am looking to address build and install issues first.
>>

As I said above, there were higher priority test build and install
failures in cross-build and native build use-cases when I made this
call to prioritize fixing them first. I fixed all the known issues.

As of Linux 5.7-rc5 all of the know issues related test build and
install failures have been fixed.

With tha done, it is time to work on the relative path fix. I have
my reverted patch to start with and get it to work with the
workflows so it doesn't break them.

I also have the following patch you gave me as reference for fixing
the relative path problem:

https://lore.kernel.org/lkml/158351957799.3363.15269768530697526765.stgit@devnote2/

In any case, based on my previous experience fixing this problem,
I plan to take the fix in rc1 to allow enough time to fix any
problems that show up. It will be fixed for sure.

Hope this helps addresses any concerns you may have on whether or
not this problem will be fixed.

thanks,
-- Shuah

