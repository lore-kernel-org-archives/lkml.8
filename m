Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB15C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1862080A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599762882;
	bh=XM28JILTxb8tsYrY/oIiO81iI1b7wzf6S0aEyMgsOHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zkJ6cQKwYIwm6LSvXuhhV2N0t6XYNpGq0X26YNoPEkC3zIPawBFkvSP5d4mvL4ack
	 DU3OimqHtJkrAmQCtcEXsoO/IUAQGg/5PUCnQkuLo9rDsIeVAwv0J9Qqz5uSMhLWKg
	 ekUPlrg/WT0fPHkloURDpae46MR7Thd3RNon9cGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgIJSef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgIJSdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:33:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34922C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:33:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u4so9454515ljd.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxUvMosCQmqJOT3+XnukK6QXCPsj7s8SUCtblFuQCtk=;
        b=KlHKM3khaRQUhJpR9UdzFB5LWAQF17Brw1Ft7CKtiriIUBpvA7+djFgchHKossZjUO
         VhqJr4lFUYp9ylSJpdlZ0hFaIz/Ssta/iioJv0jWuQQR7zk9LpCYLPwRfEoZmfrs0FFc
         eJ9cpxyshw+kFNXrIvj9XAnDrbJSgUK0YSwsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxUvMosCQmqJOT3+XnukK6QXCPsj7s8SUCtblFuQCtk=;
        b=Sudkn3v1XH6YYqBgF1IqTdkIbI24XQuk/iExF4p68ziMANCYVq6nkkpf7GllAw6kOr
         DgEB2Z0ryzpKS/LHCX6vTc3DMm0m4r0een4B+NgVVC9jyHTEXhlyO14JLsLTg7TNQ4W6
         9CsSRRHvBKPsMLVYp8cRcJX6vl3nHqCXFK0gcWo7Pgygg5mtpvSu0uURe/7vNw2blKXM
         3eTacmu/dD245o5QNqcdiXpd7byLFpI5sj2935qbumjrVJpNP06BMJjEz/GR3xbxURME
         thvESio8XyLzFSardS2nSOyz9XnMFzC9CajNdtV3vGiytRikxwVBiYqZ03DdWbfuDzu2
         NuHw==
X-Gm-Message-State: AOAM533+nnRAnDuq9VkFqHFGMg9zFzdfEjtH+mqH6F9SZEYSUZLj6fBx
        WenHKPo7AWoq4w5jIFI3pKsG5l4ItwQvMQ==
X-Google-Smtp-Source: ABdhPJzR6z+2Y7iFcjjmJcjXBpXziQuCKNAQP05/wVK6p2zPm9wjwuh1HVjvgpZYt4uRLWcMROfp1g==
X-Received: by 2002:a05:651c:290:: with SMTP id b16mr4845804ljo.307.1599762815007;
        Thu, 10 Sep 2020 11:33:35 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id y4sm1789051ljk.61.2020.09.10.11.33.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 11:33:34 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id u21so9487403ljl.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:33:33 -0700 (PDT)
X-Received: by 2002:a05:651c:104c:: with SMTP id x12mr5572300ljm.285.1599762813344;
 Thu, 10 Sep 2020 11:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com> <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad> <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad> <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com> <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca>
In-Reply-To: <20200910181319.GO87483@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Sep 2020 11:33:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3SjOE2r4WCfagL5Zq4Oj4Jsu1=1jTTi2GxGDTxP-J0Q@mail.gmail.com>
Message-ID: <CAHk-=wh3SjOE2r4WCfagL5Zq4Oj4Jsu1=1jTTi2GxGDTxP-J0Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table folding
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 11:13 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> So.. To change away from the stack option I think we'd have to pass
> the READ_ONCE value to pXX_offset() as an extra argument instead of it
> derefing the pointer internally.

Yeah, but I think that would actually be the better model than passing
an address to a random stack location.

It's also effectively what we do in some other places, eg the whole
logic with "orig" in the regular pte fault handling is basically doing
unlocked loads of the pte, various decisions on that, and then doing a
final "is this still the same pte" after it has gotten the page table
lock.

(And yes, those other pte fault handling cases are different, since
they _do_ hold the mmap lock, so they know the page *tables* are
stable, and it's only the last level that then gets re-checked against
the pte once the pte itself has also been stabilized with the page
table lock).

So I think it would actually be a better conceptual match to make the
page table walking interface be "here, this is the value I read once
carefully, and this is the address, now give me the next address".

The folded case would then just return the address it was given, and
the non-folded case would return the inner page table based on the
value.

I dunno. I don't actually feel all that strongly about this, so
whatever works, I guess.

                Linus
