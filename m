Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E21C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2447A2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586196387;
	bh=ItpFslEAysnniGgOGIyv0Ga3hUuMVLyO3EMtZ1VdRKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mwpI8WGlt4fp+6tGKRasXlgQ9F9qf2Ejl0iNxd7AxIO52SPYoenl9p9Ib+8V1apmV
	 l/btcXHbZxqsGvuUTDdgoaqqm+JwasS+XtwAC/4MWrrjecaMsgus5i+3S7DgJWxFh8
	 uwIGB5asi4YhM7JBCqBn6Q0iSJ5T1fAu70vacDr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgDFSGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:06:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37050 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgDFSGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:06:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so720497ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BisFcRtdDqZDWx9x/qe3YqGCVBMdPDBaYv2iQPpKZGk=;
        b=hycTOvQuFUOqWorRTq3COTwoQhv5QArTInVPi3BJzNZEYA8ClFHnf/Pog4SwnExpqW
         O0t2iPzj1sC3CqfuWGAAmBs3m/sWjxm/70oydN4qonvFZVSKIYy24kF2rhRlFk/itgBj
         OXm3JM0/7A+VH/EVB7RjlP5C0H9ZpQ3DCrkLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BisFcRtdDqZDWx9x/qe3YqGCVBMdPDBaYv2iQPpKZGk=;
        b=DKfC2lxE2Fcp/13FObzfjVZNANoXcfrYKEPWXgh+SsAyzU1pAEf4ZkehEE1gBUtn0q
         of69a1H4q5tx4IUhrZIOO4+caJymxLMpX36YmyZfKJot2Cn7J42ppOl9ySx6rWqHOTMI
         bpoBwl9NPKZ+070iTLsvgjO3mERtFnvLRqHChJVoqIZORxRstk6mMo/E2UkTaJVkfiLG
         fEI9Hit278WlpgHY/VGnoWQYJ4ZGS3jF4c27Dh2FAnvf+wmiOesF3BPcCS7V5c9AKBaZ
         9DYUqs7JxyiVSAjU2pej89SXzktFqytzr5KHF5vkNgrX8/F8iWtGODGuNuhEXPe2kRlK
         Mrpg==
X-Gm-Message-State: AGi0PuZusTa/yh4d4EvrukwEM3Rp77B3JNB/BDqNWQyZsSYAanat8eVr
        L3qZfOL13ss/DMxiT6w5WbZO7GdcXVU=
X-Google-Smtp-Source: APiQypJk2RQB5JdBwUoI9NsyVZdVncAn5bo1kjLN2pRlJGZ7bDV3sbSRAHzwkzr2epdLHVb6buryYQ==
X-Received: by 2002:a05:651c:200c:: with SMTP id s12mr305827ljo.30.1586196380083;
        Mon, 06 Apr 2020 11:06:20 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id v9sm10358687lji.11.2020.04.06.11.06.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 11:06:18 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id p14so660816lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 11:06:18 -0700 (PDT)
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr319344lji.150.1586196377903;
 Mon, 06 Apr 2020 11:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
 <20200406023700.1367-1-longman@redhat.com> <319765.1586188840@warthog.procyon.org.uk>
 <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com> <19cbf3b1-2c3f-dd0f-a5c6-69ca3f77dd68@redhat.com>
In-Reply-To: <19cbf3b1-2c3f-dd0f-a5c6-69ca3f77dd68@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 11:06:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjiHUWLZWKZJ4eU+RrOc2xNZCHn4ETmJ0S+H=Eig28Cw@mail.gmail.com>
Message-ID: <CAHk-=wgjiHUWLZWKZJ4eU+RrOc2xNZCHn4ETmJ0S+H=Eig28Cw@mail.gmail.com>
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
To:     Waiman Long <longman@redhat.com>
Cc:     Joe Perches <joe@perches.com>, David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 10:59 AM Waiman Long <longman@redhat.com> wrote:
>
> I have actually been thinking about that. I saw a couple of cases in the
> crypto code where a memzero_explicit() is followed by kfree(). Those can
> be replaced by kfree_sensitive.

Ack.

Doing that (and renaming kvzfree) should be a fairly straightforward
coccinelle patch.

Somebody (maybe you) asked whether we could just use
kvfree_sensitive() for everything, We probably could. The extra test
is cheap - much cheaper than the memzero_explicit().

That said, _there_ I think that consistency with regular kfree/kvfree
naming means that we might as well keep separate names, and keep the
kmalloc->kfree_sensitive and kvmalloc->kvfree_sensitive pairing. Even
if technically we could do with just the one function that works for
both cases.

            Linus
