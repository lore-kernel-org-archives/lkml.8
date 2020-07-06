Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93998C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718CF2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594065445;
	bh=iF1FiOc4slS7eU/PLo4Z0R6mRoEKDUyHXy7msXbvWmk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xeSaKQFLy373drAuqD48yC7cLGkNPOkW8On8ZJ9RtZmP2ctkGJH8oH9Pm2Zgy0tRg
	 Lmis4x/c1l8ODQq0FPYuFLTM3gf5TJUwAZSu6oB9MhE6oDUPjcNlahAU1xBsUnsj0B
	 2SFnPNbauW+8X+G3e7sCupONA6tgWethinLJ+QNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgGFT5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFT5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 15:57:23 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C8AC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 12:57:22 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id c25so14973872otf.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 12:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NNkS68aIGFVWNR7YnFBQ30+uEJYalVEOdCqtNuMpEVI=;
        b=gBD/5cT2i401HN6B8Xf0dgioJhJUoFa2hqp/mBLMCOxZZdfmjI7U+27ntRFx9CsWnS
         3QfkIj0dwEbb37umw1r1PJaBabSFfSI4YVaq64bFKm8pj5jSYBixY6uXJ1sC9zq9Z/8p
         62I52tTPNAgyWSN8b8yLyfx3cq/RAexHBfr5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NNkS68aIGFVWNR7YnFBQ30+uEJYalVEOdCqtNuMpEVI=;
        b=I6YRlRxh9ebd3tCR7CAN2ULza1LkKGCSzbQ+xTtEZwDU0wjKk7rSzv7yN4bFnKcXKy
         1ORusNHBvdhLJvZuCxpLZ7UI8SASXIf03jAGK485lK8jiueMfvXP4T/OthsOHTjk5J0M
         irZGAP8CTeK9g4aigH6kOo2GdOxs90Z35Nky++YhWKypNF6kEVHXhjqcQ51Y0V4HL5ld
         XQ4yq9Nqm7/AU2eNOJuHmdlYsie/dL+1EujW23x/94steoO3phyzXgic4RTonZRD+PDU
         JzEVdeV9LdTahzj9VL6yMFSAhvwhfFiatuDFzc5xcdoqU9iUgPifC1+dX2cKl1Of7x2I
         P1ug==
X-Gm-Message-State: AOAM532S7o34Scx6IQjxraeSbcuEgrmpV5H2L9kJpuwMXhgLwQl6NTUA
        O3ZzLkYqHjGYrqV9smEInadfXw==
X-Google-Smtp-Source: ABdhPJz1hUqPFyeMR4FGnhixYt0cFJ82a6OJplHRat/2wN471E/UNGGbhp2991+h6Bp+8Q62qmoj/A==
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr43441517otn.75.1594065441858;
        Mon, 06 Jul 2020 12:57:21 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v137sm5293827oia.23.2020.07.06.12.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 12:57:21 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] selftests/harness: Switch to TAP output
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
References: <20200622181651.2795217-1-keescook@chromium.org>
 <202007042245.BCC693126@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <026732c2-5713-eeba-0706-b533ea488db1@linuxfoundation.org>
Date:   Mon, 6 Jul 2020 13:57:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202007042245.BCC693126@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/20 11:46 PM, Kees Cook wrote:
> On Mon, Jun 22, 2020 at 11:16:43AM -0700, Kees Cook wrote:
>> Hi,
>>
>> v2:
>> - switch harness from XFAIL to SKIP
>> - pass skip reason from test into TAP output
>> - add acks/reviews
>> v1: https://lore.kernel.org/lkml/20200611224028.3275174-1-keescook@chromium.org/
>>
>>
>> I finally got around to converting the kselftest_harness.h API to actually
>> use the kselftest.h API so all the tools using it can actually report
>> TAP correctly. As part of this, there are a bunch of related cleanups,
>> API updates, and additions.
> 
> Friendly ping -- I'd love to get this landed for -next, it makes doing
> seccomp testing much nicer. :)
> 
> Thanks!
> 

I will pull them in today. OSS+ELC set me back with getting ready for
the talks and presenting. July 4th holiday didn't help.

thanks,
-- Shuah
