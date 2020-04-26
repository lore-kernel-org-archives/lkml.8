Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9591FC55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 21:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3E32071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 21:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oloDzFST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgDZVUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 17:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725996AbgDZVUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:20:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FB5C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 14:20:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so18144560wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 14:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BjvPjhl3FfO2FNQfurAQAhXjPjZlH3zWtbKhfmVQ/uo=;
        b=oloDzFSTSo97AMs4LU21xavzxmzRB265Ud9P8mCCmGB29fP5Uhwod2XqEgrgalryEK
         VUNAIJcl8Srkpy3Yq+JR02qXT0Hbx9sGdApKGNh1Oyh5UonfIiPNG7i+wnxVN+no604D
         te66H2jawzn1GDEQF30dn1Y9JH4Yyc5pGpA4HEHYvejeVfAoy4pXpkNU1xpkcOpnmbdD
         zRiZRZ7Y6q0dVj8p8LIqPYQPX0oTiN+oJ8/4ZUOBNMTdm42JyK8jd964sm/5klMU+92c
         9N4Hs8+HA+rFMl8ak368mr9egGuUOlC06KfpCofLqw2hHDjKqunXBTY7v6pMbfHiiz9/
         jb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BjvPjhl3FfO2FNQfurAQAhXjPjZlH3zWtbKhfmVQ/uo=;
        b=DGazn9EY1OV308OxFot7/nENGGsYzT4lWvW4WR/5shykDf13CGsO+xtVxHo95OUy8v
         zEKVLFw1TZh9AA3MDyoQBYvOVeHp+ReTxrd1mjHqPtaOpDBbSd4T3fgQ3IWFgHUv3bJy
         gtoEoAGmi7ZIJwG53I0UjHeHr78OD6wj/UwlsIdMF7v5uPXZdUXz3k5oEj11ZaTEJLS4
         kS27NA8ZO8/RVLH3QYtDyLv0+q2GdZvJZJOcZ8eleaef+ynZNtDiCE5BB4OSZJ9x3NH2
         pUDi3aAIOISeCLnf4i2Iv+BpXso+8TmQgLZp6/J3yzHwHux8zeWfMtW5NWmrBVv6En6t
         rgfQ==
X-Gm-Message-State: AGi0PubK64P74Lm1Po0jdjLvT/HV8RP3rfvKLsevH1/YMVYXEIh+rLrp
        R2ztaMRDK59G8AM1aKbPlC8=
X-Google-Smtp-Source: APiQypImWK8sOynJOPXWqejPuutlS/ro662B+NUZsGNGN8c5Zizm4x8yijAj55UoP5Bcepe6BMmsnA==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr21599480wmh.141.1587935999751;
        Sun, 26 Apr 2020 14:19:59 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z2sm17756359wrm.77.2020.04.26.14.19.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Apr 2020 14:19:59 -0700 (PDT)
Date:   Sun, 26 Apr 2020 21:19:58 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/swapfile.c: simplify the scan loop in
 scan_swap_map_slots()
Message-ID: <20200426211958.m7aheswirqaj2nte@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200422214111.19370-1-richard.weiyang@gmail.com>
 <87d07y2181.fsf@yhuang-dev.intel.com>
 <20200423131507.2rgrk3okh42oo6gh@master>
 <87r1wdzlm5.fsf@yhuang-dev.intel.com>
 <20200425003012.uuqh547feq3kz4y5@master>
 <87tv17xdfk.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv17xdfk.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 09:07:11AM +0800, Huang, Ying wrote:
>Wei Yang <richard.weiyang@gmail.com> writes:
>
>> On Fri, Apr 24, 2020 at 10:02:58AM +0800, Huang, Ying wrote:
>>>Wei Yang <richard.weiyang@gmail.com> writes:
>>>
>> [...]
>>>>>
>>>>>if "offset > si->highest_bit" is true and "offset < scan_base" is true,
>>>>>scan_base need to be returned.
>>>>>
>>>>
>>>> When this case would happen in the original code?
>>>
>>>In the original code, the loop can still stop.
>>>
>>
>> Sorry, I don't get your point yet.
>>
>> In original code, there are two separate loops
>>
>>     while (++offset <= si->highest_bit) {
>>     }
>>
>>     while (offset < scan_base) {
>>     }
>>
>> And for your condition, (offset > highest_bit) && (offset < scan_base), which
>> terminates the first loop and fits the second loop well.
>>
>> Not sure how this condition would stop the loop in original code?
>
>Per my understanding, in your code, if some other task changes
>si->highest_bit to be less than scan_base in parallel.  The loop may
>cannot stop.

When (offset > scan_base), (offset >  si->highest_bit) means offset will be
set to si->lowest_bit.

When (offset < scan_base), next_offset() would always increase offset till
offset is scan_base.

Sorry, I didn't catch your case. Would you minding giving more detail?

>
>Best Regards,
>Huang, Ying
>
>>>Best Regards,
>>>Huang, Ying
>>>
>>>>>Again, the new code doesn't make it easier to find this kind of issues.
>>>>>
>>>>>Best Regards,
>>>>>Huang, Ying

-- 
Wei Yang
Help you, Help me
