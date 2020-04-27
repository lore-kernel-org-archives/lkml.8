Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D90C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5768206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588019281;
	bh=d3NnitaxAGg+vCMdnEMNb8t8IqXAlbbqQRiS9YQrdIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ScvMBQ5h1qPFvYQqvs/MKLQ6LmdWmcyxg/cu/pmUTT44KRgAwqu6MFzKinG6+VvwU
	 arI9ZZDau54R9IE/o7Hyq6TGPOj55Gff5X9XTloYjvTzEzqnHvcaMh6HrB4+2Mo1vP
	 LMFl4uOtpGGGlV88qZ5/CskyXfUBzp/am7MhJOxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgD0U2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgD0U2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:28:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7BFC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:28:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l19so19057610lje.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ai+rmEpn02qg4BdEO/ZE6kOX/94j7td8pRB+ptKEnVM=;
        b=O1lgqypRxFfC+vFZsk3/9/KPI2PcZLA1mM/B20gc8yvnWS47pxSazg3digWF06v8IL
         RKAAvSH2pMe/bStrBhAr1F9weq0Mr/w01Euy1dRvf3JlL/YV1rIWnHbyzEnsfoJAv5qf
         C2xIbuvQvx9oklaGI3hdIGJx3zSFp3Uf5kvuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ai+rmEpn02qg4BdEO/ZE6kOX/94j7td8pRB+ptKEnVM=;
        b=l0XoAEH6iOBGYfDRJaVuHfVtceI/RUIhpJ4dMwc1glgHQ9JIkbXsNdM0cm7/xoNHAH
         z8In7/blGQtbwUberfgLLHXPcJzhnx//aSSuHnnd0BUfAH14pKUEqZgua8fTa3fzcUxF
         4FzTu88XYLSGPBAy4gnAluVjncl94jKmidhYksqnILsS9b9KBOrsYuOm8hBtG1xeDRJ6
         YuOv83tD2/DkwnHPmDgWp1yXJ8gSEWftZVSdYIaCC80fjEjF6EQbHfArMq2wyjZBHJ4u
         FtLjKjVRyHkonoCagPS5DHOc2oETGZnVQQaIU8zDViiSrDWL14zAvzmOcL2DKXQv9+Bo
         aDag==
X-Gm-Message-State: AGi0PuYsrYz7jMJhvWt7C+FoI9aLxhpG++BCCVCnP+31dGe+qFInQOBT
        EJjAZSKWfvZeYAZ2I9TXXAdDyEHFm6E=
X-Google-Smtp-Source: APiQypL6C59oVRZAwRVZ1iwn5u2WFSib7mGWYznCCB43lrnBtTU4zfT+7B9pOspvhk4EFGkCCQT60g==
X-Received: by 2002:a2e:2245:: with SMTP id i66mr15634106lji.191.1588019277860;
        Mon, 27 Apr 2020 13:27:57 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id m15sm5631294lji.21.2020.04.27.13.27.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 13:27:57 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id e25so19076343ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:27:56 -0700 (PDT)
X-Received: by 2002:a2e:3017:: with SMTP id w23mr15585804ljw.150.1588019276500;
 Mon, 27 Apr 2020 13:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <20200424173927.GB26802@redhat.com> <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
 <875zdmmj4y.fsf_-_@x220.int.ebiederm.org> <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
 <878sihgfzh.fsf@x220.int.ebiederm.org>
In-Reply-To: <878sihgfzh.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Apr 2020 13:27:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
Message-ID: <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] rculist: Add hlist_swap_before_rcu
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 7:32 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Would hlists_swap_heads_rcu be noticably better?

Edited out most of the rest because I think we're in agreement and
it's not a huge deal.

And yes, I think it might be nice to just call it "swap_heads()" and
make the naming match what the user wants, so that people who don't
care about the implementation can just guess from the function name.

But I also think that by now it's mostly bikeshedding, and I'm
probably also now biased by the fact that I have looked at that code
and read your explanations so it's all fresh in my mind.

A year from now, when I've forgotten the details, who knows which part
I'd find confusing? ;)

               Linus
