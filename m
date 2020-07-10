Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC9AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1603A2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sy4hD54S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGJWzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgGJWzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:55:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16AC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:55:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d10so2846182pll.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4hGIhomb0LBlqZeWlHfi6+uoq7TnGBnqLNWsx4a+7J4=;
        b=Sy4hD54SA3U4GzVNUhu3WHT/Se2HlZOeuny0PIHf3LkEsFN3L5vd5FV2YLuTq48trs
         lWbPmMqV4THQNSS85KE3qi1I9n3GmAfqgc8R/eR1989HZ8itAMB4uS4uJyRb4W3k48PO
         s6X4+JhsAyqy/acuNsVI/2UrSlydqmcYjXkhHsbRJ5fvAd+tQFJjQbvv/e72XHffd1WX
         bkzGJ1wsGSb6C8LW99I1rjcYW4ZmrKhqMcLDWz1H/fn0aE4FgwL2wA4hmyaLR2TLVjbS
         U6oL5+3Zay7lNtmD7gYDoGlKCrOsTBLNX9dsjPeWnGZjZK7ROrMTcTtpN3AdmY1Ejtdx
         gZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4hGIhomb0LBlqZeWlHfi6+uoq7TnGBnqLNWsx4a+7J4=;
        b=DT2pfnxtnkOwvfBtFBfSJAnn9Xl/OGziLBead3S31lmtLbSjCfkJlL6iwYH/mO8+wu
         KOhh4fH1eZULQRC6ql8zvYr9Zalbu+JHusOzkrczA3xqCYNh8YKwrzQ6dbw8+S7PL98F
         5ki3Tctuj3H/aNeMV3Bfh8WFuqlYYrQVKXlnILo45oKjjDFpiy2Rbxcbf0YcbPfGcvyd
         4XM3MA/Sjf7aN/iSH2r/eHJyp/xNsQLro+sGlLvmX3Ehk2W7nwhyMbpR+sDwFBIlHOTs
         ntBzIxBOk9GLXayB5Q71BSRyVH/4a5VZ0cRfUDSfhd/JjvyCSJZF36s2Tj6HqezNoTNx
         ywzg==
X-Gm-Message-State: AOAM5300S0qkLMZ3UIXRJT8wjg9BmQp1/NQab1oaafMeWS5v21L1h2AZ
        Y0NSZ+yzzleLgxlcrfsC9NTohA==
X-Google-Smtp-Source: ABdhPJzSoiJAa+Kgv5cLkAEBovyk20hEpctnbVme4FL/uFge5pdDBgtSVtzCycujqzLrVcWveqMuzw==
X-Received: by 2002:a17:90a:148:: with SMTP id z8mr8452357pje.197.1594421719716;
        Fri, 10 Jul 2020 15:55:19 -0700 (PDT)
Received: from google.com ([100.117.212.88])
        by smtp.gmail.com with ESMTPSA id nl11sm16403347pjb.0.2020.07.10.15.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 15:55:18 -0700 (PDT)
Date:   Fri, 10 Jul 2020 15:55:15 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Plumbers session on GNU+LLVM collab?
Message-ID: <20200710225515.o2d7aic2qgn5ac6i@google.com>
References: <CAKwvOdnT5ZMjvz2_UJ4MtvDEs9+90bsDp-Rd2SnXZZ+AqebYHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdnT5ZMjvz2_UJ4MtvDEs9+90bsDp-Rd2SnXZZ+AqebYHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-09, 'Nick Desaulniers' via Clang Built Linux wrote:
>Hi Segher, Rasmus, and Ramana,
>I am working on finalizing a proposal for an LLVM microconference at
>plumbers, which is focusing on a lot of issues we currently face on
>the LLVM side.
>
>I'd really like to host a session with more GNU toolchain developers
>to discuss collaboration more.
>
>I was curious; are either of you planning on attending plumbers this year?
>
>If so, would such a session be interesting enough for you to attend?

Looks like a good idea. I am interested.

Perhaps Tom Stellard, Jeremy Bennett, Nathan Sidwell and Iain Sandoe have some ideas.
They have a talk about GCC/LLVM collaboration
https://gcc.gnu.org/wiki/cauldron2019#cauldron2019talks.GCC_LLVM_Collaboration_BoF

>I was curious too, who else we should explicitly invite?  I ran a
>quick set analysis on who's contributed to both kernel and
><toolchain>, and the list was much much bigger than I was expecting.
>https://gist.github.com/nickdesaulniers/5330eea6f46dea93e7766bb03311d474
>89 contributors to both linux and llvm
>283 linux+gcc
>159 linux+binutils
>(No one to all four yet...also, not super scientific, since I'm using
>name+email for the set, and emails change. Point being I don't want to
>explicitly invite hundreds of people)

Might be worth sending an email to gcc@gcc.gnu.org as well.

This month's archive: https://sourceware.org/pipermail/gcc/2020-July/
