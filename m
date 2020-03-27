Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2542FC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22FE20705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P7EwGWtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgC0Hop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 03:44:45 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46455 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgC0Hoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 03:44:44 -0400
Received: by mail-yb1-f194.google.com with SMTP id r16so4035489ybs.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 00:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fuJBH1/qFJ0xcFrTragWViWx3N3gcqaqROLp9eE2znM=;
        b=P7EwGWtFPjtTjEzIV0rKm6jn99Yc1fMjxaFRXJ1zH6pEW8ueA6Y6ksIM0Jc7DNqF8p
         rgxpJlJ042hYCS7ekPQefhJWZAWqMAGpmIwZg1VGogMthR0SuKq1CahCLOWZ4YgfK//l
         neFT2gm6oKLmcbdiVPxifGuQqPmtiLVQ/bDPk0E5xz3rzPxLIjSwMgeXwdedkOYeznn1
         uLsJBBd/XmvExI0hVcB0bMSdN65LuAMItjbNMWaNgVLmOyKD603LHdWpfRtxC7UUUzYp
         5BkYOKLd32ZzxusItUg94/LR/yu5BKCkyaeAJTC4Ku/NPkxulfGPTlP9Ce8Ep/mFbYDF
         bsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fuJBH1/qFJ0xcFrTragWViWx3N3gcqaqROLp9eE2znM=;
        b=Hxx/3Qu7+sUAm0S83nx1pUPj7nkFZC9JrtBynRcjVLXWmMMhN4FD16th8NUOLPNuWf
         eTR9ku67jQj+WjENzeWsk941tQ6itLHLzkDPIY/aqjirX93dfga2yas0V++j0w6hsr1k
         2860VfbvQ2Etulz2N6+ANFG+Ru4FjcQwhHzeFMMjCLjYEosvyXjpEfWhs1cw/zpAjya5
         D7AqQj2HLIYUscBZ/HnKXbyZyiQScUrBMbBnrYk79YdCs2YQpdr69ZsKr5frgnayyXGB
         rct5m/8gwuo300GviBzLeTVenPLmbpGr5QHKDKu6o0h/NSE3dwFwZfEkEQHMtSHgPvlP
         8SQg==
X-Gm-Message-State: ANhLgQ1q8Uwc+6qQ8d85U8JVw/tk0hTmWeh5Qaj70jtyS1VyuzXjWoDR
        uJn1/7BjVKIXkfPsWt5DFzY6Ljtd9ZsJ7ykUbFgbJA==
X-Google-Smtp-Source: ADFU+vuq4HJ6geuH9mDBbQTCLLZdmNY6A4XEtkti7le78Dg4PDcoGQ027nMwXseJyxdatD0xpwnX38cOtr1cMkaCAHI=
X-Received: by 2002:a25:ccd0:: with SMTP id l199mr19110500ybf.446.1585295081895;
 Fri, 27 Mar 2020 00:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200327021058.221911-1-walken@google.com> <20200327021058.221911-5-walken@google.com>
 <d780d91f-43fa-b2ec-1a08-80013b153a56@web.de>
In-Reply-To: <d780d91f-43fa-b2ec-1a08-80013b153a56@web.de>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 27 Mar 2020 00:44:29 -0700
Message-ID: <CANN689E-SZhv3tvYc11cNuvGwCi1V1n1ztAnLkUPGvvz7C85dQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] mmap locking API: use coccinelle to convert
 mmap_sem rwsem call sites
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Ying Han <yinghan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 12:22 AM Markus Elfring <Markus.Elfring@web.de> wro=
te:
>
> > This change converts the existing mmap_sem rwsem calls to use the new
> > mmap locking API instead.
> >
> > The change is generated using coccinelle with the following rules:
>
> Would you like to apply only a single SmPL rule here?

I think this version of the patch is already a single rule, similar to
what you suggested ?

> > // spatch --sp-file mmap_lock_api.cocci --in-place --include-headers --=
dir .
>
> Command parameters like =E2=80=9C--jobs 8 --chunksize 1=E2=80=9D can be a=
lso helpful
> for a parallel execution of the desired software transformation.
>
> I suggest to consider another possibility for a bit of fine-tuning in the=
 shown
> SmPL script if you would eventually care for nicer run time characteristi=
cs
> for the application of such a SmPL disjunction.
> How do you think about to order the elements according to a probable
> function call frequency?

I'm not sure it matters that much, as long as it produces the correct
end result. The run takes about 25 seconds before any optimizations,
which I find very acceptable.

--=20
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
