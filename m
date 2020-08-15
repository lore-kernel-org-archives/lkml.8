Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33736C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107B02053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597528695;
	bh=P3mGb/iWurMA2BwTBBPR4xcoSs4Gc0eaHiJXsynU7y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eHNIE0PjpN9ThWweJIVD7TBS7WT4UAgAIA6t1OOk7flptiHTohVAy7gEW7ZunzAxx
	 skvg8qd2fch5TMwOifyZcdxzrXsDE28tZfhqvG2t5iGjwmQ3u7Zj7fQND93AoHExtX
	 YwLlT2Ng3ZwMB+ThrfFHgldVqbBFj9wheCC/hLkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgHOV6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgHOVv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381F2C02B8E7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 04:48:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so12567388ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1m/YguZxj6AkoCmXEKP4B7t8uP7/c1T/6fMSQDFqceU=;
        b=nt0alZa5zu359g1uqNvpfQxEkzUzwcnXmATTJ9r6eeoMp+jE/fOZXoQAFuJene9+jj
         waJfslxi/nQ+im8IRI4n8v8fq5IEYUGKkxLoBtU6KpC++23dLYbUha1NHhDJnFl2zvg/
         pdb+g7+8PqobjhtwQGMhMxUrkzEc1TJ0XKx1nWhH7fdzfsZXk9tPDToJ1iakPetynnMh
         uNbmZ751y66uejuiw7Skh17lcqxCjpzptvHTa7dGtg2+UaDvU6N6mjAcpAwe5XrqNXHq
         QHXlLmr57FgzVTFiDRumDwU9JHBvdv9lYnfR7s2JcUE0zaICWjuSkYi4Jl38J1cDdSb2
         /L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1m/YguZxj6AkoCmXEKP4B7t8uP7/c1T/6fMSQDFqceU=;
        b=GHDHtVzUXUU/JFMeJvfWBnOpHcCiifS0ZeXrox3mAG9RW40690xfOo0fHcsVl+0YQv
         OvBvxFDqhE8QkrGnfB2+WYEZpclYdsYmEvnpJZIS16ySoGCQA5pYJQHSiy1daQ63fQFl
         +sbqPfbBqyMb+UxSxC1l6ip5HJT7NUlpny2xJv2PI05G5WPdAHbnbqnd+cS6vHNGenXA
         OJHcxPRPSV3MD72wh5Wb8oOKqKIvykHsD5Dl34XPGJqBROebb0n/7sNzGJxDWoLakcoW
         4iTOPlfbYDdTlwGgfIcu/JcDF9F3iAtugTItd5TVCKZbaSSqmxDVpgEx9S35Sv32iN74
         /aDQ==
X-Gm-Message-State: AOAM5328/jMUvBgQmJgMWoPMAQbq4CwmLmbpEe3s7MxFTBgokKxDOSpR
        TXy33qIG7aKngQV0jXAHvIo=
X-Google-Smtp-Source: ABdhPJznF3xZpAPBU4vntarEcyKRnp8hF0aI1AeLUjciKUpsXCY12tBdRu9Lk5su89y2A1ADTPg98A==
X-Received: by 2002:a17:906:e289:: with SMTP id gg9mr6970538ejb.448.1597492108245;
        Sat, 15 Aug 2020 04:48:28 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id n25sm8963089ejr.21.2020.08.15.04.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 04:48:27 -0700 (PDT)
Date:   Sat, 15 Aug 2020 13:48:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/fsgsbase/64: Fix NULL deref in 86_fsgsbase_read_task
Message-ID: <20200815114825.GA2685004@gmail.com>
References: <20200814181617.442787-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814181617.442787-1-edumazet@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric Dumazet <edumazet@google.com> wrote:

> syzbot found its way in 86_fsgsbase_read_task() [1]
> 
> Fix is to make sure ldt pointer is not NULL.

Thanks for this fix. Linus has picked it up (inclusive the typos to 
the x86_fsgsbase_read_task() function name ;-), it's now upstream 
under:

  8ab49526b53d: ("x86/fsgsbase/64: Fix NULL deref in 86_fsgsbase_read_task")

By the fixes tag it looks like this should probably be backported all 
the way back to ~v4.20 or so?

Thanks,

	Ingo
