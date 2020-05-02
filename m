Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F60CC47257
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD8221974
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFsXSuI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgEBN3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgEBN3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 09:29:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F326C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 06:29:14 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so3061147wmj.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7fgGtqyzL/Sj2g+73BGn6b3nve4tTxBVOiuWb2m+SYk=;
        b=nFsXSuI8ZhlJ9+6dQXFcFImncSkTD+VcPf7wjZAkyfn5I0TQG3AE+lEKyfVt7XmmLP
         QCHzZ7sKGUf1RTVD1lHZhiSEk8gPFax2TQvpeAszNZAPopIcnTZUbfNSJEt3+SPXc+4e
         tj/p2TDObgTCucbOfIQfL/OV8Mi9nXDm6ZpDmsWgvklI/SnKPwaVUJcCcXVar0XhkO5W
         oGlcHXmPcJz3jMr9+Dakk6tjzYtzlbwlhJzSdJFURBurOB4RrK8DRzbtGtuYMvE36/EI
         4T26fZkgiZfVBJb5Tsw0IDP9CYcX8M7E/mwCxYFOxK/Lnv1TXLD1PSKz8Wb8ulnGnFPD
         IYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7fgGtqyzL/Sj2g+73BGn6b3nve4tTxBVOiuWb2m+SYk=;
        b=RC7LxVWOi+HNCE75XZb89iwy5yPEhJA99KyxcSqmX1U1lXof0uqifLDrU10wasgVu7
         ylKF3cQ9jPCaZmd3vsj98BhTIR0O2r/FjbTce/CAJ5QtInry2LnUXc0TJqzY3SIXFRi7
         GU072pwmblJ65NPhOCOW/LDxrUDXhdsLy3G/1z8LzPFZGo4AP54A+bFKqjn15KbIukkO
         Z93aKCO6ZL6sAGjP6+U2DkscOr5voEkP9FUFdb0LFxJUelVxpteZyih+xP460tWxAoFt
         sP7Tgg9jmpU6zrqEle+OK4Vhv1bNWmyUKftj7QFTlYFuOffvaZc4HqOagv45unvuaMfL
         yFLw==
X-Gm-Message-State: AGi0PuZp5jQtHeNxnep5Og9beV399gdmgVeY7QkE1N5mmfEoqL7enmKv
        m4cs4i4neV8ELWzxGXxPhkg=
X-Google-Smtp-Source: APiQypLhNrrDEVmqdWszMzQt+KZIaxQxc/esTzpN8FhiGyw1qJZj/TzWleC0geFHd6bgHKBpbZ8ldw==
X-Received: by 2002:a1c:4ca:: with SMTP id 193mr4751167wme.18.1588426153168;
        Sat, 02 May 2020 06:29:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v131sm4670262wmb.19.2020.05.02.06.29.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 May 2020 06:29:12 -0700 (PDT)
Date:   Sat, 2 May 2020 13:29:11 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, ying.huang@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm/swapfile.c: count won't be bigger than
 SWAP_MAP_MAX
Message-ID: <20200502132911.u6y6hkh56ik4ojne@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200501015259.32237-1-richard.weiyang@gmail.com>
 <20200501015259.32237-3-richard.weiyang@gmail.com>
 <20200501154853.bca4cfb7b2558bd43a4942f3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501154853.bca4cfb7b2558bd43a4942f3@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 03:48:53PM -0700, Andrew Morton wrote:
>On Fri,  1 May 2020 01:52:59 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> When the condition is true, there are two possibilities:
>
>I'm struggling with this one.
>
>>    1. count == SWAP_MAP_BAD
>>    2. count == (SWAP_MAP_MAX & COUNT_CONTINUED) == SWAP_MAP_SHMEM
>
>I'm not sure what 2. is trying to say.  For a start, (SWAP_MAP_MAX &
>COUNT_CONTINUED) is zero.  I guess it meant "|"?

Oops, you are right. It should be (SWAP_MAP_MAX | COUNT_CONTINUED).

Sorry for the confusion.

>
>Also, the return value documentation says we return EINVAL for migration
>entries.  Where's that happening, or is the comment out of date?
>

Not paid attention to this.

Take look into the code, I don't find a relationship between the swap count
and migration. Seems we just make a migration entry but not duplicate it.  
If my understanding is correct.

>> The first case would be filtered by the first if in __swap_duplicate().
>> 
>> And the second case means this swap entry is for shmem. Since we never
>> do another duplication for shmem swap entry. This won't happen neither.
>

-- 
Wei Yang
Help you, Help me
