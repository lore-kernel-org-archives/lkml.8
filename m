Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAC5C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49CE21473
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585513668;
	bh=/gWJX1rvKeF8+QyuO02hp+NvSXj/gzpNvL41nTUckds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ihWQs4wT6qUmskidXJec6Nef28Ju7r+DlSMRZ8VXq/JqNDo3pYuKn2DerNwoV0ind
	 yoiihnZU+LTioQ++Ux6KH/djGV6BxaorsKZkv/Uan1khD2nt5VehptpOQPfhs8PS+s
	 qQ7M89ecEVeWwxhVQvfmgZ15FrTfDMBJ5ltySUeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgC2U1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:27:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46050 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgC2U0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id t17so15831481ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjHMmMd59/cxYEdKGlAwW6M66LpLwe3PsPILP4gPHiw=;
        b=EdJ1prhvQM7A56Jz9+hAIwqiX6OVKihI9jXqCp4roC2tJmrzqMzJ+qbvXhVv9b0H6K
         eJEyxncd02WGwWxSU+G76BIj++DAEHI0vwtpWMPF0beIyIyJqaS2bPyMMbmZHr+OQ7Fi
         RzVktQp3SBbVmlEUTy8bCPfsTVneCmn3SeHog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjHMmMd59/cxYEdKGlAwW6M66LpLwe3PsPILP4gPHiw=;
        b=ACl+yP1AvBZjo5ryvPndPbBoKbgtB4ONH0eTJwRYnxOTCVZw7LsP2reduQoBXUanbC
         XZfT0SN63Yth1tkDh9XYQecK3MBvnrlaNd4+wbC9318CcBt1ivsiGM4wVlwh9BXD6HtA
         Td56EcP92Wv5vY3Sm5sOGwC7JzAUONeoApkahhSIc+2jRoMI7y6369IF14ihJKz7eya0
         WBXtRY4vtXROg7oexPYyNDamIwmeGuDneg8GR0o3BERXh2heTT+LQdy3KMiYK8dVjtem
         vnr0a49tuZtvS0/WIYUxi5fnazc/kAMtb2v/w3EmE5B6HQcWoz8S1pTbQL4BOe5MAsxX
         akmw==
X-Gm-Message-State: AGi0Puajg6Fp7En6OzwPr3YbmUDsfdJPr7beYpCOCvPBasZP57vJN1zt
        I4Zfhp2nXnqCLPq6yzSLqdyAPuqhQRE=
X-Google-Smtp-Source: APiQypLCcyVJnPRod9DOqis61m9EK0EgpetLGmwj1b8bb+qJM1r8hIx4eSQlI4gdYp/2q8tTctbxuA==
X-Received: by 2002:a2e:b5d1:: with SMTP id g17mr5205401ljn.139.1585513580319;
        Sun, 29 Mar 2020 13:26:20 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id y20sm5983943ljy.100.2020.03.29.13.26.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 13:26:19 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id j17so12315183lfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 13:26:19 -0700 (PDT)
X-Received: by 2002:a19:6144:: with SMTP id m4mr5937145lfk.192.1585513578763;
 Sun, 29 Mar 2020 13:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjEk_smqiRh4-JosHsRxzhedJddGf5EQV0JxqZtHYMdkA@mail.gmail.com>
 <DFA2A279-A6B4-4F0C-A8B9-38E1A7A6B400@redhat.com>
In-Reply-To: <DFA2A279-A6B4-4F0C-A8B9-38E1A7A6B400@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Mar 2020 13:26:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGC-GDppUuAAGohy756VbzRYwsS7xxdz6j75My8YGoiQ@mail.gmail.com>
Message-ID: <CAHk-=wiGC-GDppUuAAGohy756VbzRYwsS7xxdz6j75My8YGoiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: simplify calculation of number
 of pages in __remove_pages()
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 1:17 PM David Hildenbrand <david@redhat.com> wrote:
>
> Interesting, at least the patch in -next is messed up. I remember Andrew adapted some scripts, maybe this is a leftover.

It does look like s broken MIME decoding script somewhere.

But it's odd, because as mentioned, Andrew definitely handles MIME in
other places correctly - including your messages when it comes to the
patch data itself. It's only the message above the patch that hasn't
been properly decoded.

Curious.

              Linus
