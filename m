Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19043C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53F5207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnYkuHEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgFAWB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 18:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgFAWB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 18:01:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4243C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 15:01:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so1368300wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 15:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=IehB16ofl2ZisYz7uWBSmj+l64Pb8TcSH/YFdQJ1EqU=;
        b=qnYkuHENPemrBrlTtRR9gi8u2PI01ntZSyA1KQRr/H+OsjAScQxABBcGMga3dPHBXF
         B5rzYp0EZkBZZ7oM0VaSkhWPHp5zlfBv9WEgX/QZWiGyPG2x/DfuNR9Ui7Z0rdxr7GPV
         53s8NVYi/UhvexR/LhNeT34HD9E4r9zrHH9EyDHey1agJ9zwL75vdR2QwA7EC5W7lAFa
         BZIvtUlPyV0pzKxqPueB2bWTeMgXAOV+IQFF6UNnXO+SZiQgy948PFkWRwZPyJHwS205
         xJ2woveqiw4yPN3xKPZ9Au92uyX6LwX9ghrWSyymfEsyuyI5qfANUSbFX/FwsOizdGz8
         4N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=IehB16ofl2ZisYz7uWBSmj+l64Pb8TcSH/YFdQJ1EqU=;
        b=G1KT2093DC55Y+1kvd0oj9SxJo+p3qGEbRkA1zduBhCpRVD8bmw9hMLxOwsT+JKALK
         /9mR23aPXEejRSSHo4pgQ5Ff3wStPWNotj/Va+pBNimR9wyfKQ1E6v/ipUXr/Zo3M9K0
         CxvOz70actZNkzMFTZOWhM2ZBICJrXtQcLvhJQByapz8UFj1x7Q8O4FBAtbDp5Xr5Ur5
         +n7pNvFuDBVN9RgUzqP408dJ4+xonVGR/9xRCWOQofaDKjsx6c/2sz9Q277/N4sHrbWq
         OVkNOD3O0RKngx/Y2tCvl+fTQYRMbYYJJgnk4nOf4e5GB8YnuLqF1qCI/oQ4kCgRY6Dy
         i31w==
X-Gm-Message-State: AOAM53364gvzr/d6BciX7QDDksbUuZwqeq5RgcH/VHWC2ls2FdBiv2qN
        xJyM1ez8vfG3Sl32uYii2g==
X-Google-Smtp-Source: ABdhPJy7qi0JzbO9zOj1Ie44EtEG1GtzsS6DHrQZsX6A68U4Y2B3BTj55Mgwton+CsrB4H/cktGPxw==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr25377462wrw.179.1591048916188;
        Mon, 01 Jun 2020 15:01:56 -0700 (PDT)
Received: from earth2.lan (host-92-15-172-76.as43234.net. [92.15.172.76])
        by smtp.gmail.com with ESMTPSA id v2sm1018113wrn.21.2020.06.01.15.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 15:01:55 -0700 (PDT)
From:   "=?ISO-8859-15?B?/YCAgISB?=" <jbi.octave@gmail.com>
X-Google-Original-From: =?ISO-8859-15?B?/YCAgISB?= <djed@earth2.lan>
Date:   Mon, 1 Jun 2020 23:01:15 +0100 (BST)
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, paulmck@kernel.org, mingo@redhat.com,
        boqun.feng@gmail.com, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 4/5] x86/ftrace: Add annotations for ftrace_arch_code_modify_prepare()
 and ftrace_arch_code_modify_post_process()
In-Reply-To: <20200601154647.581fa345@oasis.local.home>
Message-ID: <alpine.LFD.2.22.394.2006012259520.4793@earth2.lan>
References: <20200601184552.23128-1-jbi.octave@gmail.com> <20200601184552.23128-5-jbi.octave@gmail.com> <20200601154647.581fa345@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Jun 2020, Steven Rostedt wrote:

> On Mon,  1 Jun 2020 19:45:51 +0100
> Jules Irenge <jbi.octave@gmail.com> wrote:
>
>> Sparse reports warnings
>>
>> warning: context imbalance in ftrace_arch_code_modify_prepare()
>> 	- wrong count at exit
>> warning: context imbalance in ftrace_arch_code_modify_post_process()
>> 	- wrong count at exit
>>
>> The root cause is that even if
>>  the annotations on the function are correct,
>> mutex do not support annotation
>> This makes Sparse to complain.
>> To fix this,
>> __acquire(&text_mutex) and
>>  __release(&text_mutex) annotations are added
>> inside ftrace_arch_code_modify_prepare()
>> and ftrace_arch_code_modify_post_process()
>> respectively.
>
> Wait what? This looks like either a bug in sparse, or we just remove the
> annotations. This just makes the code ugly, and looks silly.
>
> Nack!
>
> -- Steve
>
>
>
Thanks for the feedback, I take good note.
Jules
