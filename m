Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0FCC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10CD21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599766386;
	bh=aloI9zn6pT5iiPm2GPUnkRhR22DDXmljQEw/xLcySz4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pJStrGVdxoGbZUWb/xbcNsvDxiHMp5iOBi3YpEL1GPp7QCUzpmqHmOj3N80Hdzo1R
	 TLq9wzCd3MIqeRuKDtygU9gR0uL0UMhFgX+8+3YlkLLo/TVx2nVioS0HTcwPIBWkdP
	 raOKYSwRKKuU4hYMQpKmQtvu6MQPZBMyC6cMWIjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIJTdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgIJTcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:32:31 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6710BC061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:32:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so9731430ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTbGWidANXm2pjjCI9iaMQBY/df45EdumvXop+9a4ao=;
        b=gkhGKJWFcLTHyB5x5aFfN6rnXH8dCRqQWjJKd9NZmHZK/NC/oX0q6HVDmBmeekhRv6
         GTPYMsgUuX5KTeHU91CyIJtiMizZNYrRnX9QG0ENhdKweAOaB0W4mGxVSrji+PC28UP6
         VshPJp7YLq+DwXcjz/A/kXWDuc/ae+MhCxRmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTbGWidANXm2pjjCI9iaMQBY/df45EdumvXop+9a4ao=;
        b=c2ZH5sV/Mm0/NWAhnFLpVnUe2pD1GcaIgJcKi+ImIef/K1YmOiCCI31tCzecQTpcOH
         hUgHjlttlQ+vkz2MuH68Dmt9ULdUcBSwUHHoZWW0FOhTb1oUT5PDSHJLoeBE7/0XRixZ
         SDYILq8it4iaWA+sVo0soPQJfvH7m5xbp+X3m5Ig6dpATAYGiRDMhq95Nm0k55L9e6SF
         X9Rusg9H27kRny5rgS8+meGmc+h6AV9m/vYxUeQweI1smyxJElFZ+vrj16aXcf9l+rE1
         xSPoLBGXjYdSIsmKG0ykBbbljkoZ1CUKGfpSmUhjLV11BMSebKiAweSUfvZfn4y08NyU
         pPqw==
X-Gm-Message-State: AOAM530HmLBW4voBmTvorr9z/XEPlEAIZHLw/MEjSR6t9Fo2rs73316/
        SbvdjBySIcTIAmUDzIHHEkTlqVOpK+svdA==
X-Google-Smtp-Source: ABdhPJzmNePhsjN2hIWbsgPhIenG5kGXElwpO2C8PxKGUtODX8ehCZTBhoZFrNe31lwbPEFHcAf/6Q==
X-Received: by 2002:a05:651c:107b:: with SMTP id y27mr4844962ljm.338.1599766342760;
        Thu, 10 Sep 2020 12:32:22 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v25sm1821740ljh.102.2020.09.10.12.32.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 12:32:22 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id y4so9669671ljk.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:32:22 -0700 (PDT)
X-Received: by 2002:a2e:7819:: with SMTP id t25mr5043564ljc.371.1599766341582;
 Thu, 10 Sep 2020 12:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com> <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad> <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad> <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com> <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca> <CAHk-=wh3SjOE2r4WCfagL5Zq4Oj4Jsu1=1jTTi2GxGDTxP-J0Q@mail.gmail.com>
 <20200910211010.46d064a7@thinkpad>
In-Reply-To: <20200910211010.46d064a7@thinkpad>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Sep 2020 12:32:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3ggXU98Mnv-ss-hEcvUNc9vCtgSRc7GpcGfvyOw_h3g@mail.gmail.com>
Message-ID: <CAHk-=wg3ggXU98Mnv-ss-hEcvUNc9vCtgSRc7GpcGfvyOw_h3g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table folding
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
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

On Thu, Sep 10, 2020 at 12:11 PM Gerald Schaefer
<gerald.schaefer@linux.ibm.com> wrote:
>
> That sounds a lot like the pXd_offset_orig() from Martins first approach
> in this thread:
> https://lore.kernel.org/linuxppc-dev/20190418100218.0a4afd51@mschwideX1/

I have to admit to finding that name horrible, but aside from that, yes.

I don't think "pXd_offset_orig()" makes any sense as a name. Yes,
"orig" may make sense as the variable name (as in "this was the
original value we read"), but a function name should describe what it
*does*, not what the arguments are.

Plus "original" doesn't make sense to me anyway, since we're not
modifying it. To me, "original" means that there's a final version
too, which this interface in no way implies. It's just "this is the
value we already read".

("orig" does make some sense in that fault path - because by
definition we *are* going to modify the page table entry, that's the
whole point of the fault - we need to do something to not keep
faulting. But here, we're not at all necessarily modifying the page
table contents, we're just following them and readign the values once)

Of course, I don't know what a better name would be to describe what
is actually going on, I'm just explaining why I hate that naming.

*Maybe* something like just "pXd_offset_value()" together with a
comment explaining that it's given the upper pXd pointer _and_ the
value behind it, and it needs to return the next level offset? I
dunno. "value" doesn't really seem horribly descriptive either, but at
least it doesn't feel actively misleading to me.

Yeah, I get hung up on naming sometimes. I don't tend to care much
about private local variables ("i" is a perfectly fine variable name),
but these kinds of somewhat subtle cross-architecture definitions I
feel matter.

               Linus
