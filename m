Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A6FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 12:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847832076B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 12:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxmBpl43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEaMrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgEaMrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 08:47:13 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5559C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 05:47:11 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m21so5164922eds.13
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vAcOiewiM0GfwCw2XnuxYEzbIf1e34d11aUvmTPE/c8=;
        b=AxmBpl43qmr1n4pMYsrWnuMrKz0emm4HEPhS4rQZALGPVFt7WwlJXXy+AlzsfuY7/5
         ny+Mk9nnc2S5h5M2WWbq1LqVajGB0pxvY7Ods3ieiCZ09XF2BbhjeZi1gOOoxu8+283S
         6BysulO5bbTAEmoqj21cr8szOzl/y6hdK2U8/QHAXlUIJ5JdrXPk28lUyL1KLse0em6z
         HTh1k1l2kJTG1h++MkeeE4sPhm9OJ7CSC5xmUAK2SYzHgfWKaEYXji82JqX81J/sm7t4
         bHcMlF3ycyU4aJIGlbtclgnzWufvMW/ntMPsmwCshabL92kdrtuZgDboJtmds+7CopRK
         8AcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vAcOiewiM0GfwCw2XnuxYEzbIf1e34d11aUvmTPE/c8=;
        b=GNRsCXfbxnpyfTqq793ixr3wY6+sUolkYI0yTaTxXpzH8dP/5dKF9Hsr9Fr4gsDIJN
         XIKV6PhocRcYO5a0cv6TfDNeOnG+ZqaFwQyzU5SvxzQUsrDjHvBn9+bqPNjY/YjvQtth
         w7IvXybWN5/1YyZ9yjT/BEy7uXgqHFN3oBBjUdaMGefQnaGgKEFeWZdqRu29wV4SbBjB
         BCUxP+gHr6K4p2uwKD/04nmMa6g0pPxEl9XisbFpMXvf9wdagGhR3zVhPzCjkcVa8F59
         8NgSkpWuPh155KsCYZQthWcTtHwYu9wLcs4QmWoSgMWkiSuPUu+Hbhxt+jAZ4ZSUM9D8
         vvvA==
X-Gm-Message-State: AOAM5326Cl6/ElxPQCGJ389L/P9dLzsYuZIY5mVMVffNz014Wa2vkuC0
        n/srlI+l9yVj0vb03euPg4c=
X-Google-Smtp-Source: ABdhPJw2sYsIw0h83AxbF8AbdTYSdYC2EDIpdcs9FNnopbXVNAxvIw0rtFJbfkY4QRWlFgrk8oZdZQ==
X-Received: by 2002:a50:b2e1:: with SMTP id p88mr17120454edd.198.1590929230528;
        Sun, 31 May 2020 05:47:10 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id lf23sm12245273ejb.46.2020.05.31.05.47.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 May 2020 05:47:09 -0700 (PDT)
Date:   Sun, 31 May 2020 12:47:09 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: make a test module with get_count_order/long
Message-ID: <20200531124709.c7o7pw7o2rfv4klc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200530004328.30530-1-richard.weiyang@gmail.com>
 <20200530102531.GA1634618@smile.fi.intel.com>
 <20200530211940.yninqlngnzfvsvki@master>
 <CAHp75Vev_a_VrjoLUxfNo3AZybSteuV28t2EChaqydeFjCq=PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vev_a_VrjoLUxfNo3AZybSteuV28t2EChaqydeFjCq=PQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 12:56:29AM +0300, Andy Shevchenko wrote:
>On Sun, May 31, 2020 at 12:23 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>> On Sat, May 30, 2020 at 01:25:31PM +0300, Andy Shevchenko wrote:
>> >On Sat, May 30, 2020 at 12:43:28AM +0000, Wei Yang wrote:
>> >> A test module to make sure get_count_order/long returns the correct result.
>> >
>> >>  lib/Kconfig.debug                  | 13 ++++++
>> >>  lib/Makefile                       |  2 +
>> >>  lib/test_getorder.c                | 64 ++++++++++++++++++++++++++++++
>> >
>> >I didn't get why it's not a part of test_bitops?
>> >
>>
>> I see the document of test_bitops says it does exercise on clear_bit and
>> set_bit. So not sure it is proper to put them together.
>
>It's not a problem to amend a documentation as well :-)
>

Sure. I am fine with this.

Andrew, do you expect me to merge it into test_bitops.c?

>-- 
>With Best Regards,
>Andy Shevchenko

-- 
Wei Yang
Help you, Help me
