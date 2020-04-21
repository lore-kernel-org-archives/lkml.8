Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83637C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547C5206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYm640oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDUVDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgDUVDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:03:34 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB8CC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:03:34 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id i16so34333ybq.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D01UCKv/MItQguC8mrAilu88fpXx1W32uPOZRB3PJZw=;
        b=bYm640oeAhVA9NCZK2CCkb7t+VHMSBtBdHc230ZONtXxPm6MZiX5XvVPs8HaO2dWtu
         27oqBNPDjPru7rEjMPUxcfNoLx/hERJNnPAI327ME2uQLv6xbAWEULPfUZjkDvqWG5fg
         mcDCZcEQLgfvv0lG4j4GSmu5vkqKYta7aAF6dXIdj5+RsMxaYWYvu/LBG2I46AhLwcga
         QJNMyOa3+qK9uGrd1WZEViqP7edeGBY5pw98RZnzwCvx8/TRVWKDCSRXXwZx2wpca0S/
         JSAyA9M7ePLvVvrCfSZ1pnvqdRT3xMvZZdZXyjvj4JW/ipQ5SyVItafXOCTe7dAOtJCc
         N4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D01UCKv/MItQguC8mrAilu88fpXx1W32uPOZRB3PJZw=;
        b=YVy/lc9GtDQFBCPQguSVmlR4dnkFHXEYDJWuaN70gsfsS7SIQlQKW6/Azsp9WV5Ukt
         mqR/bAl2PRkpDjhuvKKNPv9xPPn/kBFFsYSoRdljzbqHbwuxeXSEnpr9u6hyMvpgp4gC
         zX0CEiNo/qXCAkDUdJcp2LuyKE3e1stNAV2uUotiogJ3/keOTwfcctClwTv88TVhXXIM
         sAB3Z1HDA+PUJV407bQ2kcwY6JCiEsTDuEK/000HIxhJf6DvB/gDL8X6GGIfYclREbT9
         njPXanExcdRf95wbafeybxCTVD19Z0vOXGExqW/ouFAvE1l4N81s5qsj5Ajd96EF7ezY
         BRmA==
X-Gm-Message-State: AGi0PuY8JzM/EIfB12MsO5J/zrR2vWPXUNDrYDhNTV0bqPSKgTJEv/3v
        4KImdbxKx+ZngbMwwlZ1B4j0MDY290GZlz4Vg3ObEA==
X-Google-Smtp-Source: APiQypLtN97fWtQ1tE6aTvwjmihM5lZ2075m+3KltJR1tPsePNmOSac2Wq+aX/nXHf+0gAdo3xFjvesh5VyBQdhlKtM=
X-Received: by 2002:a25:4443:: with SMTP id r64mr29908611yba.41.1587503013619;
 Tue, 21 Apr 2020 14:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200420190916.GA11695@gmail.com> <CAHk-=wiejBvKnrDysDva=DNFgyX02TZred_JMjzUnjFgVOUtOg@mail.gmail.com>
In-Reply-To: <CAHk-=wiejBvKnrDysDva=DNFgyX02TZred_JMjzUnjFgVOUtOg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 21 Apr 2020 14:03:22 -0700
Message-ID: <CAP-5=fVhWREzzjnXH4j+dcnP-GbSMnT_07qVrZM8huAhx6wtVw@mail.gmail.com>
Subject: Re: [GIT PULL] clang-format for v5.7-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 12:10 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Apr 20, 2020 at 12:09 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> >  - Don't indent C++ namespaces (Ian Rogers)
>
> I've taken this, since it doesn't matter, but I'm wondering at the
> motivation for it (exactly because it shouldn't matter).

Hi Linus!

We (Google, Stephane Eranian, ..) have a tool that converts Intel's
topdown metrics:
https://download.01.org/perfmon/TMA_Metrics.xlsx
into the json format used for metrics in perf. It is written in C++
and we are planning to upstream it. In C++ there is preference for
anonymous namespaces over static functions and the namespace
indentation was pretty annoying for this. There's a little more
motivation in the commit message too.

Thanks,
Ian Rogers

>                    Linus
