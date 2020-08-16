Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CACC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE21207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=labbott.name header.i=@labbott.name header.b="j55Ja//6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgHPLzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 07:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgHPLym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 07:54:42 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEBEC061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 04:54:41 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l64so12525182qkb.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 04:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2z9xB6h0onVuiLPOfpcwkvpQxk2cuNCblaJiNFPAzzs=;
        b=j55Ja//6hpyID8SYN5OXZxcsDjLL36bzN+ax4aTtyjQyJmqc33kKQrm3ti2+AkwLCl
         5je5kbHER6uRwNhYwymBdkg7qHG5RvHWu6TA9gTF3VyzMtvIytI3r6xvti9Atk3JE4XG
         0j/a/dQ/w6bZSOtUA2Zz2aBQDBcHC5s3hkJE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2z9xB6h0onVuiLPOfpcwkvpQxk2cuNCblaJiNFPAzzs=;
        b=L9kUmZIhAkp6jFHieuZzFV//E5CuXNQPJ+CNKR7/fX6nbPKmCsqFs77160CyytgMmn
         jF16VE5fJqvePgJAnr6mRVZqJxmdIRCSDtapvOfdouGHrFAqCt/qJ9umgkpsSeC4O3Xm
         F31sT19v4CIHht81PNfDi6vfi+mP1wXltjREunUHRqy3lSq6t/10S6/ZoPnGF5tQymGh
         kLwkqrbQC6ebpFPQnr8D4wAAFQmKO4xhcK109G8YwwIOU7S8QKEoNpxQEEBXxIWtYwDO
         Eudzgp574vKTENWD6L0qe/7Li6OzMnvtAn6LD7+KPNBD5/O6nmK7Dvdupyjf6tErC4vs
         NVjQ==
X-Gm-Message-State: AOAM533FMYYhuipWtTnxp9J5Zj9pbShQmkVZEnyO0TQmkuJY8eabs6bw
        6RxCxgavgCokBqAwMJC4WRxIAqTwPQC1uzge
X-Google-Smtp-Source: ABdhPJy717NtIXf4F7Bc/QD5KeATpNzaWMpeduYDvszI77GbKr/KjXiLBY8kQK6l+CdAX1eE4W1duw==
X-Received: by 2002:a05:620a:c16:: with SMTP id l22mr8774158qki.271.1597578878370;
        Sun, 16 Aug 2020 04:54:38 -0700 (PDT)
Received: from [192.168.1.155] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id d203sm13836069qkc.10.2020.08.16.04.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2020 04:54:37 -0700 (PDT)
Subject: Re: [Ksummit-discuss] Linux Foundation 2020 Technical Advisory Board
 election: call for nominations
To:     Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     tech-board-discuss@lists.linuxfoundation.org,
        ksummit-discuss@lists.linuxfoundation.org
References: <20200803153612.24ef78d9@lwn.net>
From:   Laura Abbott <laura@labbott.name>
Message-ID: <2b19dec5-7596-f82e-709a-cd246427d78c@labbott.name>
Date:   Sun, 16 Aug 2020 07:54:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200803153612.24ef78d9@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/20 5:36 PM, Jonathan Corbet wrote:
> The election for the Linux Foundation Technical Advisory Board (TAB) will
> be held virtually during the 2020 Kernel Summit and Linux Plumbers
> Conference, August 24-28 2020.  Nominations for candidates interested in
> serving on the TAB are currently being sought.
> 
> The TAB serves as the interface between the kernel development community
> and the Linux Foundation, advising the Foundation on kernel-related
> matters, helping member companies learn to work with the community, and
> working to resolve community-related problems before they get out of hand.
> We also support the Code of Conduct committee in their mission.
> 
> Over the last year, matters tended to by the TAB include proposals for
> developer workflow improvement, overseeing the Linux Plumbers Conference,
> moving toward more inclusive terminology in the kernel, and more.  Minutes
> from TAB meetings can be found here:
> 
> 	https://git.kernel.org/pub/scm/docs/tab/tab.git/tree/minutes
> 
> The board has ten members, one of whom sits on the Linux Foundation board
> of directors.  Half of the board (five members) is elected every year to
> serve a two-year term.  The members whose terms are expiring this year are:
> 
> 	Chris Mason (chair)
> 	Dan Williams
> 	Kees Cook
> 	Laura Abbott
> 	Olof Johansson
> 
> The remaining members' terms will expire in 2021:
> 
> 	Greg Kroah-Hartman
> 	Jonathan Corbet
> 	Sasha Levin
> 	Steven Rostedt
> 	Ted Ts'o
> 	
> Anyone is eligible to stand for election; simply send your nomination to:
> 
> 	tech-board-discuss@lists.linux-foundation.org
> 
> With your nomination, please include a short (<= 200 words) candidate
> statement focusing on why you are running and what you hope to accomplish
> on the TAB. We will be collecting these statements and making them publicly
> available.
> 
> The deadline for receiving nominations is 9:00AM GMT-4 (US/Eastern) on
> August 24 (the first day of Kernel Summit). Due to the use of
> electronic voting, this will be a hard deadline!
> 
> As always, please let us know if you have questions (the TAB can be reached
> at tech-board@lists.linuxfoundation.org), and please do consider running.

As a reminder, the deadline for nominations is coming up. Please get
your nominations in!

Thanks,
Laura
