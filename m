Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD29EC35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB1F82082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCdiFMI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEGWUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGWUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:20:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1FBC05BD0B
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 15:20:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so8308941wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r9L5BbR1D/yVnqyNGeh7T9On6CSzY2MQWXloV95rB8U=;
        b=bCdiFMI/LGeKAfCV93K0w0RNk3p5zRb/gu9k+4Lmy1KOsTt43unQmThIhkEwkErhqj
         ffIpyeI8Qsw/VR+7tJfXPaCr8xhku04kaz/LOc1ed7WYAqBBj11RkHgCV2R8WWuJrddQ
         9f9fYr8hrPKYvHADPHAz/xc3P+ONGmR/odsOYqXNtaKE9XdAvnHMQ4og2prZ+MbWf2cw
         gHka2X4bdt5vykOH26JDjRhzwlZDzu/iQJ5MiGXNfSgcn0qkef/g7sKhwN9xy9jdMqwG
         0W/K7Cyn5ajrN/tbFX4QpPDg0e2EISxABYVIjBv7/CcfUSkoQ2dLE6gBVGT5kyn1yH5Q
         UM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r9L5BbR1D/yVnqyNGeh7T9On6CSzY2MQWXloV95rB8U=;
        b=rAb1HLJBXk55My/XHyft5imW59/EGuXi/9WPYjmCVl6s4VnMpWVZ8U/fFOSfvzsSAQ
         A1CAyKAIoaqLFCPca5zZLlLhbk2vfSltKZUJWfSCmYqAAFmsUAOQsjy3ZP/RHEcWfex2
         n8BrDtnzQI3jXd8smzaZ9o/yXKU/VMabdw29ZiXAzLPlh8Ol/LH38YatJu9ChHamh+8N
         V6EYHMC0jrdKsDVwanKA3QLqoGXOMRUoMO9MIFI2uU9Xmw2z5ptkGq38j26tqy6C3R7K
         wBe5dtaNHs25xUp2yROpP01d/sUikbyEX6I+VY8TbN+mEeVQM10yfdJtLThf1GHNmMQx
         OEGA==
X-Gm-Message-State: AGi0PuY42GQY/mQvvDdp12YFeqeniCqfAZ4UAds2C3GoyynvnyZI2u3v
        k/XTgoq/R4FFH29b0iapQD8EqRB4
X-Google-Smtp-Source: APiQypKA/L4nT1B8zrI/psQzZhDE/LV+Zp8vgbS4hJkhPPW5GZHcOjFxofXX5nHsyc6kcK/dOXhXXw==
X-Received: by 2002:a05:6000:1089:: with SMTP id y9mr18191404wrw.306.1588890016517;
        Thu, 07 May 2020 15:20:16 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id j2sm3915696wrp.47.2020.05.07.15.20.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2020 15:20:15 -0700 (PDT)
Date:   Thu, 7 May 2020 22:20:14 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm/swapfile.c: count won't be bigger than
 SWAP_MAP_MAX
Message-ID: <20200507222014.6s5szrt6zy2b6ybo@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200501015259.32237-1-richard.weiyang@gmail.com>
 <20200501015259.32237-3-richard.weiyang@gmail.com>
 <20200501154853.bca4cfb7b2558bd43a4942f3@linux-foundation.org>
 <20200502132911.u6y6hkh56ik4ojne@master>
 <87k11pv5ep.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k11pv5ep.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 04:22:54PM +0800, Huang, Ying wrote:
>Wei Yang <richard.weiyang@gmail.com> writes:
>
>> On Fri, May 01, 2020 at 03:48:53PM -0700, Andrew Morton wrote:
>>>On Fri,  1 May 2020 01:52:59 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>>>
>>>> When the condition is true, there are two possibilities:
>>>
>>>I'm struggling with this one.
>>>
>>>>    1. count == SWAP_MAP_BAD
>>>>    2. count == (SWAP_MAP_MAX & COUNT_CONTINUED) == SWAP_MAP_SHMEM
>>>
>>>I'm not sure what 2. is trying to say.  For a start, (SWAP_MAP_MAX &
>>>COUNT_CONTINUED) is zero.  I guess it meant "|"?
>>
>> Oops, you are right. It should be (SWAP_MAP_MAX | COUNT_CONTINUED).
>>
>> Sorry for the confusion.
>>
>>>
>>>Also, the return value documentation says we return EINVAL for migration
>>>entries.  Where's that happening, or is the comment out of date?
>>>
>>
>> Not paid attention to this.
>>
>> Take look into the code, I don't find a relationship between the swap count
>> and migration. Seems we just make a migration entry but not duplicate it.  
>> If my understanding is correct.
>
>Per my understanding, one functionality of the error path is to catch
>the behavior that shouldn't happen at all.  For example, if
>__swap_duplicate() is called for the migration entry because of some
>race condition.
>

If __swap_duplicate() run for a migration entry, it returns since
get_swap_entry() couldn't find a swap_info_struct. So the return value is
-EINVAL.

While when this situation would happen? And the race condition you mean is?

>Best Regards,
>Huang, Ying

-- 
Wei Yang
Help you, Help me
