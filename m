Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F0C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D786820A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oosTixpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgEHVUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgEHVUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:20:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6678AC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 14:20:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j5so3563683wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MfGO3pjQpz1FBRiqCb0+KptNcnlzs41SYOqSqBBspK8=;
        b=oosTixpZ3ZazMDUIgl65wMlu5Yu9BNLoLL9U6epBBWcKc/5DCtc9hxB84eEYGju6IR
         KUzI1CaESJWKx9QPhjL+L0sMKs2Z0qCfBVL0foEbAKx9gxcU8DdZ7dtoeljayPAlA/AI
         loye5aZqDYIor3pIL8TMWJU/2gqphzvv4s1oBem51L1WEQqlKN7YREis4K5k1s33twMc
         GTA1EtoNFXCjSCCbCCyHgRE6j04kOvf7s427dNTdcPyEbvX+899yvSY3mXKp1BhkfX0z
         y7kFdyBMSLY3AjWshZYSiUjzTB/yI4Rzs3vbY7OsJovZpJOePjZnk0yJ3XdLq0TpLzES
         SFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MfGO3pjQpz1FBRiqCb0+KptNcnlzs41SYOqSqBBspK8=;
        b=MdL/UbFgVyk6RaI2QNGgo7mtsrRnO3rF/F9k0h+/7d+JIvYJo5SUYcveixBi20/fp2
         GhewJBaE8hIGSecJgnBaIvZdSPFEt0BU1ZykXWMOlhBhTVATvWqqSuvW7smptMIhbr6Z
         nPfbGvwfIeudioJTgLccTC4fDVXlmvdFJg4ia0n3PBXKWTjkNzezuoNLqMrzD1fN9no2
         F9CX9hP5i1B5j8a9ipE+Uiz2pi+PpbOoO3tGvtR0EoNUv14/OHrRWPUAZgmS64fgOrA4
         GHnMM3mwBZUWT7MAQKk/pX7zW5gN/0mNk80w73WOct2FUFxy7RlEg2zIiAR2oTZza6Pj
         EZBQ==
X-Gm-Message-State: AGi0PuboscXmhTWkS4jaYi6uPsO5G/I9VY+dybmBAO2NMXC78XCIM3JV
        aNiGUwAq9tgfioRERE5Cxck=
X-Google-Smtp-Source: APiQypIf0RzejCInE82KNZmNq2Oj6brtFqFFCn3Muhdad42KKIOt1o7sFgUdgn1DTL+KgGOw7A9Owg==
X-Received: by 2002:a5d:6108:: with SMTP id v8mr4776133wrt.286.1588972798797;
        Fri, 08 May 2020 14:19:58 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id j16sm4646416wru.13.2020.05.08.14.19.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 14:19:57 -0700 (PDT)
Date:   Fri, 8 May 2020 21:19:57 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org
Subject: Re: [PATCH 3/3] mm/swapfile.c: count won't be bigger than
 SWAP_MAP_MAX
Message-ID: <20200508211957.haw4m2ityh6z5zzh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200501015259.32237-1-richard.weiyang@gmail.com>
 <20200501015259.32237-3-richard.weiyang@gmail.com>
 <20200501154853.bca4cfb7b2558bd43a4942f3@linux-foundation.org>
 <20200502132911.u6y6hkh56ik4ojne@master>
 <87k11pv5ep.fsf@yhuang-dev.intel.com>
 <20200507222014.6s5szrt6zy2b6ybo@master>
 <87ftcbtiha.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftcbtiha.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 07:48:01AM +0800, Huang, Ying wrote:
>Wei Yang <richard.weiyang@gmail.com> writes:
>
>> On Wed, May 06, 2020 at 04:22:54PM +0800, Huang, Ying wrote:
>>>Wei Yang <richard.weiyang@gmail.com> writes:
>>>
>>>> On Fri, May 01, 2020 at 03:48:53PM -0700, Andrew Morton wrote:
>>>>>On Fri,  1 May 2020 01:52:59 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>>>>>
>>>>>> When the condition is true, there are two possibilities:
>>>>>
>>>>>I'm struggling with this one.
>>>>>
>>>>>>    1. count == SWAP_MAP_BAD
>>>>>>    2. count == (SWAP_MAP_MAX & COUNT_CONTINUED) == SWAP_MAP_SHMEM
>>>>>
>>>>>I'm not sure what 2. is trying to say.  For a start, (SWAP_MAP_MAX &
>>>>>COUNT_CONTINUED) is zero.  I guess it meant "|"?
>>>>
>>>> Oops, you are right. It should be (SWAP_MAP_MAX | COUNT_CONTINUED).
>>>>
>>>> Sorry for the confusion.
>>>>
>>>>>
>>>>>Also, the return value documentation says we return EINVAL for migration
>>>>>entries.  Where's that happening, or is the comment out of date?
>>>>>
>>>>
>>>> Not paid attention to this.
>>>>
>>>> Take look into the code, I don't find a relationship between the swap count
>>>> and migration. Seems we just make a migration entry but not duplicate it.  
>>>> If my understanding is correct.
>>>
>>>Per my understanding, one functionality of the error path is to catch
>>>the behavior that shouldn't happen at all.  For example, if
>>>__swap_duplicate() is called for the migration entry because of some
>>>race condition.
>>>
>>
>> If __swap_duplicate() run for a migration entry, it returns since
>> get_swap_entry() couldn't find a swap_info_struct. So the return value is
>> -EINVAL.
>>
>> While when this situation would happen? And the race condition you mean is?
>
>Sorry for confusing.  I don't mean there are some known race conditions
>in current kernel that will trigger the error code path.  I mean we may
>use the error path to identify some race conditions in the future.
>

Yep, NP.

For the code itself, do you have some comment?

>I remember that Matthew thought that the swap code should work
>reasonably even for garbage PTE.
>
>Best Regards,
>Huang, Ying
>
>>>Best Regards,
>>>Huang, Ying

-- 
Wei Yang
Help you, Help me
