Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376B0C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E75220838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="grsTIxw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgAJQpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:45:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41878 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbgAJQpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:45:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so2429009wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 08:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ympT5AY/DLl6UvuOCQnir9hVpWD64MMWty4h6MSY0Uc=;
        b=grsTIxw69aF1wk5b95935hZWjq6OuMW2LUVE+UZgYwNKRK2xArvuAAXFlmsla9UBic
         QoxoszrvgwSlKPFJlE6/tOUAJ+8skkaNMQWEI6v7uWzO3mvd9qiUS/otfZMFQUAlHm/w
         8up97pyFZiEUl3kFEo+kNrPE/vlE2s0yDRVBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ympT5AY/DLl6UvuOCQnir9hVpWD64MMWty4h6MSY0Uc=;
        b=W6ksR6IsvsxsNNQTJLrq/+EQdSRKCrTGrVZ6HJlL6a/Yj6GTW8vmN6dLQIHT2Dmy/x
         EAUj3xUb/QJMyIvzrD6a6/XAXDGTOwmLKEcPR1iF8E0euMRqkotgAAB1oc7ySNLjwoM0
         jz3pqXohXM4L7BjJvoB7yIwxvbi8Xy0jfRG+WlvCynbAwTVUGdzsG2TOjOdoRq0UBC7q
         WMJ9r2SqRc4U5bHfgn+VCpEfM37ol6O+ntTgFAXaefikiQh4rByzmt5s31LrllWNOrQl
         z7/aeW53G5mCYrpL+bWbtWHUzX6t9fRBg0niiHLXO9CUp8HQIhepBRLCStH3BIW6Q+C1
         x4Ww==
X-Gm-Message-State: APjAAAXL4qX+NPuJZ7jXxwPx5BN76grun2nFuO9p4sBbAOQbRn3yIxrl
        +oeAG5NhRQrIif6XBYMUz+HKcA==
X-Google-Smtp-Source: APXvYqx8rXwpLQ7ifI81LfMYzyilHJtApNJMIaEHlbBH7ZTahixW6jrbn4b5p2Rj+1+wR/12UcK4Gw==
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr4518896wrx.66.1578674705827;
        Fri, 10 Jan 2020 08:45:05 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id x10sm2823222wrp.58.2020.01.10.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 08:45:05 -0800 (PST)
Date:   Fri, 10 Jan 2020 16:45:03 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Hugh Dickins <hughd@google.com>, Dave Chinner <david@fromorbit.com>
Cc:     Chris Mason <clm@fb.com>, Amir Goldstein <amir73il@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
Message-ID: <20200110164503.GA1697@chrisdown.name>
References: <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name>
 <20200107001039.GM23195@dread.disaster.area>
 <20200107001643.GA485121@chrisdown.name>
 <20200107003944.GN23195@dread.disaster.area>
 <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com>
 <alpine.LSU.2.11.2001070002040.1496@eggly.anvils>
 <CAOQ4uxiMQ3Oz4M0wKo5FA_uamkMpM1zg7ydD8FXv+sR9AH_eFA@mail.gmail.com>
 <20200107210715.GQ23195@dread.disaster.area>
 <4E9DF932-C46C-4331-B88D-6928D63B8267@fb.com>
 <alpine.LSU.2.11.2001080259350.1884@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2001080259350.1884@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh, Dave,

Hugh Dickins writes:
>Dave, Amir, Chris, many thanks for the info you've filled in -
>and absolutely no need to run any scan on your fleet for this,
>I think we can be confident that even if fb had some 15-year-old tool
>in use on its fleet of 2GB-file filesystems, it would not be the one
>to insist on a kernel revert of 64-bit tmpfs inos.
>
>The picture looks clear now: while ChrisD does need to hold on to his
>config option and inode32/inode64 mount option patch, it is much better
>left out of the kernel until (very unlikely) proved necessary.

Based on Mikael's comment above about Steam binaries, and the lack of 
likelihood that they can be rebuilt, I'm inclined to still keep inode{64,32}, 
but make legacy behaviour require explicit opt-in. That is:

- Default it to inode64
- Remove the Kconfig option
- Only print it as an option if tmpfs was explicitly mounted with inode32

The reason I suggest keeping this is that I'm mildly concerned that the kind of 
users who might be impacted by this change due to 32-bit _FILE_OFFSET_BITS -- 
like the not-too-uncommon case that Mikael brings up -- seem unlikely to be the 
kind of people that would find it in an rc.

Other than that, the first patch could be similar to how it is now, 
incorporating Hugh's improvements to the first patch to put everything under 
the same stat_lock in shmem_reserve_inode.

What do you folks think?

Thanks,

Chris
