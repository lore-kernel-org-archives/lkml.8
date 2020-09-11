Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9E1C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE51721D91
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MranxbqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgIKLUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgIKLTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:19:34 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37A7C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 04:19:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q5so9505571qkc.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RF/fhPo5kBauAi3eDmZJgpqIrahl3Q40enwZDmyVW/Y=;
        b=MranxbqI0sbZTUHr/5nRrvvNnaOGVKUaAfIpgrguT3kotqu2/+vaLtFjLBr7Dchw8g
         JJmcJV/C0jOxv4hRKHMp+z8brOgZNv7zPlHzEFTxIGRfWe+oDWMX2pQve/8jTAvpKMiT
         7RN3juzzMtOiuIWBUDCT1BvIFCKf6bxkwXrdAtvSLUiKX/5kI+sFcR6JdpWoUm6ixgyF
         dLqTOenPUtqGXVDIBwggt4h+6OsbKY/DS4ZW5VLOTe31mPZEk/NO9CEvKD3cWUNhjl7s
         kxOAXY9+GRt4ctbpbjP727YWsJahqV0QyR6AL3DhYyp7rVFeR5dvwtqaEjOc69J99Ry7
         iGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RF/fhPo5kBauAi3eDmZJgpqIrahl3Q40enwZDmyVW/Y=;
        b=UnI6sIwSnJu4fAC7eJzsuyPvUfxj0mcnf1Aizyjpa5BelA8eRvPPv6cNbezwoyBlYD
         AQNBN2Ez2fw63oLr9GRMTkFLONzg1E8kR9qyDtbskMgh8NxpjEdweKMKwkPu7csgTWLD
         FROtF94Nwf+tS1bjaLX/6wlLk5YqDhTrhuAJ/qNWAnFVu7z3GC+LJOYdilqF3V1izzMv
         d2OsdhPi0jcaV3E2RcuoWGSjrLNJ2/SYS6KaPsL1eXXvEWN0ISbtvBl/6A39crj8Dxth
         6XLiQ3K4xGePYF4KJoUO2WtsTWsFYaH0GMRtRQZ1VzoCbt1LWeNWOPW1brA0wgcRwhXe
         ZMzA==
X-Gm-Message-State: AOAM533D81rRwD64DKJaDzoRkxF1LqmL7FDNg3weU7gJMb5ZBdwEJ6zU
        48Za+FL9Y5NyxogalZGix1khXw==
X-Google-Smtp-Source: ABdhPJzPJMV+cEWYRmvlb24Nbw7GCKp+KbSMxPhKphhah1G5lDmq4fX9f/inMOZg7Se/iCqj4A8+eA==
X-Received: by 2002:a37:a8ca:: with SMTP id r193mr1042066qke.83.1599823172826;
        Fri, 11 Sep 2020 04:19:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k185sm2269296qkd.94.2020.09.11.04.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 04:19:31 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGh5W-004ktM-DO; Fri, 11 Sep 2020 08:19:30 -0300
Date:   Fri, 11 Sep 2020 08:19:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     peterz@infradead.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200911111930.GS87483@ziepe.ca>
References: <20200909192534.442f8984@thinkpad>
 <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
 <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca>
 <CAHk-=wh3SjOE2r4WCfagL5Zq4Oj4Jsu1=1jTTi2GxGDTxP-J0Q@mail.gmail.com>
 <20200910211010.46d064a7@thinkpad>
 <CAHk-=wg3ggXU98Mnv-ss-hEcvUNc9vCtgSRc7GpcGfvyOw_h3g@mail.gmail.com>
 <20200910215921.GP87483@ziepe.ca>
 <20200911070939.GB1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911070939.GB1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 09:09:39AM +0200, peterz@infradead.org wrote:
> On Thu, Sep 10, 2020 at 06:59:21PM -0300, Jason Gunthorpe wrote:
> > So, I suggest pXX_offset_unlocked()
> 
> Urgh, no. Elsewhere in gup _unlocked() means it will take the lock
> itself (get_user_pages_unlocked()) -- although often it seems to mean
> the lock is already held (git grep _unlocked and marvel).
>
> What we want is _lockless().

This is clear to me!

Thanks,
Jason 
