Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51687C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2610720724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rR8TitqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgCVPQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:16:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39644 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgCVPQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 11:16:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id j15so8201901lfk.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UiQbUXjkv7dvJPYjix5G08GTr5tXFgyICC/8mG3TbLM=;
        b=rR8TitqVvdTSiG5IDnpTZycycf9Juv73G4Oq20wrsO8YxX6DngsUCy1LjlHZFtog/3
         on1H0z4jKEsE7lu9SGJQBZNtm2p5U4MCd2jXKDFUfA4N7DG1Rg3+onS0YfLmPZrV6NFc
         D3rkIpEG5nDNe8TiUYZojIxcUN9l4MfSeTF2afJnAid9bRhFmKCsrJbI6GtajF2Y/t6j
         Moxs1vzKpPPSpvA5pH/J/OtZ+ps2dHwAx2Nq8oT1Lx6YXSzRjvYPEML/lxQWcIjwajSS
         +d+JlSGOzOYo1xvlFTSuMBKTp1rbRcZ9Ew9rRjFUhLXaXvHfQpcJBkRHF4fRhBhyKViP
         TzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UiQbUXjkv7dvJPYjix5G08GTr5tXFgyICC/8mG3TbLM=;
        b=FBhq+R4kNuUR33P9Ilh0zwG//5jH9BflJ78apTHeOfGz1QTV16TddnhVNTliP5OWji
         CCFV1C1HWUs66xu0K0iyf3UKK2g4ELVe3SmZXquigi81/ZRNYREm7tvWE8oxLaLs5SN4
         O6MGRyEZ3WGNL896/Vw1SvoUYq1I34QY8+nnGKbpbHVF52npjXz+NvIiExuy0a/C6WCk
         l+BIpbHjAp7tx2k8UmfNP4OSneanXftYtlyxkeLNAIifzKPo+1kaXbbWEOoUdIrUrTt5
         uTK/7KvKG5QbfaKGyYIlDEc6fqABiP7PwfLkhiay8InDaOtOplnsP5QCYu5mHtGZuVG4
         mSlA==
X-Gm-Message-State: ANhLgQ0yDlGC1dhFZmGi4Wow/IXb9QDclLWIVSYgBYQI+Rx0cdlmQbSx
        jgutLmoScjH+PTFvYuHpzIbkQy8OVCsNsEoFtDQULA==
X-Google-Smtp-Source: ADFU+vsCUq5yboISgFixyCY71nyL49myzuOxRv5IfB4yL45p/mq8M+oDVJbl73ER46yiPXZDDtpIUZVSaAp5CwjfWDc=
X-Received: by 2002:a19:ac42:: with SMTP id r2mr10521930lfc.38.1584890184772;
 Sun, 22 Mar 2020 08:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <1584065460-22205-1-git-send-email-jrdr.linux@gmail.com> <20200313122210.GB31668@ziepe.ca>
In-Reply-To: <20200313122210.GB31668@ziepe.ca>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 22 Mar 2020 20:46:13 +0530
Message-ID: <CAFqt6zY-ahQwj0wUD4KgR+NwTejqNNJ4-gTjAqV7Lr7Wh3dT9A@mail.gmail.com>
Subject: Re: [PATCH] mm/hmm.c : Remove additional check for lockdep_assert_held()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 5:52 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Mar 13, 2020 at 07:41:00AM +0530, Souptick Joarder wrote:
> > walk_page_range() already has a check for lockdep_assert_held().
> > So additional check for lockdep_assert_held() can be removed from
> > hmm_range_fault().
>
> Is there a reason why you think this redundancy is bad?

Other than removing an extra check , I don't have any other strong
reason to support this patch.
>
> IMHO it makes it easier to understand the API contract if key top
> level APIs have their assumptions coded in lockdep.

Ok, I will drop this patch. Sorry for the noise.
