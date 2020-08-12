Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538F4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 22:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2610520771
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 22:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+0wAnnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHLWzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgHLWzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 18:55:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9261AC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 15:55:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mt12so1849514pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/KpAP02Xa1uBqBuQDwinbHXESDgjtCwQvrKW1vEk3M=;
        b=A+0wAnnZ1NzudMlDqlkDRY6VeTQdyTuzPYepBr7Y2iR0rJh+jtdFd+Qb3RR1UBSIBi
         pPkr9VJsTDT2VoXtxGdVutRg3atWYm/E2Eeuvjl5lq02ulnLztm8LQVFL1E9kG6yeVBu
         OjmW1XfMz7RwCe2IaZ+6Dlsoe8UYtsZ0tYRIolIzmHfd65Y/KG/tS+3VaWuaLtTIgWu+
         jLnVk8vvP1mfgGvV8NDlYwcSF2EaB2/FB1hR0x7OkKW/ZkvzS1SrHPWx1p1zR17ZsgiM
         dn9QyMbWLahhRkZlLcgEpq0re7Q0tvVgXnxSUz2oqjAH3IdXok7G5NP6hztGux6SZjaw
         DuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/KpAP02Xa1uBqBuQDwinbHXESDgjtCwQvrKW1vEk3M=;
        b=Pa56DBx594ec/v8Lbehwz2p8OHOsfe8XT64Z1NWdITVD9CBEFOQMycLwiRgJBaVcjg
         iN4WFIFb6pFmu1BbC9mLPSE50iBhJJRM56q8TC2t6CQ4ClrTaJO3KWjT504KwSvWiRNC
         JK4kIjMBXSpfeqrgqGjUo6Pq64U4cuzu8oylaDKm2nDvxyrM11pr3bEWGYcssDn0kuLG
         oI68qO9JIKQ7xX9/dqrB2v9TqIRlXAXwCzVMWL5iGqiDAP8qGzXbGkWG+FY3pHjizNfM
         omLXrEKTYbPZ8fFSrhWlMUpz1xQCRLzyKcGmEFoFbTM38RckIAVfUaPEQkjBSH/45JZi
         gNbA==
X-Gm-Message-State: AOAM5307y1U41Ph8rmcPoCo+3BZrwGzwhYj1Qwyzmwg44ie1SzMcf069
        CpFsnmdVMIGzGENDuCGogR7ASkRF6LLOuui30bTQWw==
X-Google-Smtp-Source: ABdhPJxyf/PlaUXc6AtvZUsahdrfU7MGf5TTtxmO9c8ZgkjNdDDFoStZHp+BPXCP19q55mnPNy69CjlAJrcWuFILh5A=
X-Received: by 2002:a17:90a:fc98:: with SMTP id ci24mr2301691pjb.101.1597272940960;
 Wed, 12 Aug 2020 15:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200812173958.2307251-1-masahiroy@kernel.org>
 <CAJkfWY6vhW9kNK-t+2vZQ7Rhn3HedykvT2du7AfO0_9oUAXvjw@mail.gmail.com> <CAKwvOdm3VTZ2QXXxf9pjM6n87UE=Lc-9Cx=V70sNsYGmHCb-hA@mail.gmail.com>
In-Reply-To: <CAKwvOdm3VTZ2QXXxf9pjM6n87UE=Lc-9Cx=V70sNsYGmHCb-hA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 12 Aug 2020 15:55:30 -0700
Message-ID: <CAKwvOd=xpCnupJN+y-CVmsYMK7UpXT4xQDd-XgJNCmgQFpRKDg@mail.gmail.com>
Subject: Re: [PATCH 0/3] kbuild: clang-tidy
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Tom Roeder <tmroeder@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 3:52 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I wasn't able to reproduce Masahiro's reported failure, but seeing as
> he has `GEN` for compile_commands.json and I have `CHK`, I wonder if

Nevermind, I misread the output from the build.
-- 
Thanks,
~Nick Desaulniers
