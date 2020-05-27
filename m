Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_HDRS_LCASE,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B48C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790A42088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnKZJrMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgE0Uzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgE0Uzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:55:39 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A92C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:55:38 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id x22so722910otq.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CR9dwsvfsyVy6G6eufz7hLC4jiMaO3cWV54dCy7eHCU=;
        b=tnKZJrMIcf0/z4kaB+rJl3FXPTJHht//RCQa4J59uzyChfalXhlpPFz5E0fYsdyFFE
         ZJvl5QVLp1xf7s4kzKZpAW5feSDjc2nAFIp4uAutc73kgMQqJ7Qf4gVH0kuM6JXaf4rr
         Cc5K/SBc3R3k210aYcI++2fWr6jGHExFKnZYm/oJqnBwanurHfAFGaTRti3RuuUw2v1a
         KjoFcUj5mweabEKNICEPUCPMZzsVLMma4k1+nxXVAD/X/3p/r9fScN26LuA3aBf30jkv
         WRC8LDsOwmZKb7/sIxW3Qk/N0n3lIJT5LPbRwMNKnRAl8DuZN85iuQMQXMRdU6NhSJ2A
         ONMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=CR9dwsvfsyVy6G6eufz7hLC4jiMaO3cWV54dCy7eHCU=;
        b=EJy2oufIOBhmnkrI8+Mt/HyQQ9xttxhQ8En2JQhcgILJl4+t5JM8Ts6ZBlF0mhDj47
         0Ss+yshdxrAxX1nbAo5DphTEbkkHofERzqscVeKxn9GJSA5VMlWjz0blG8PpzIMlf88z
         dW4Oi1ywaPYJ/NOpd452+Zb4vrmmWD9aCM20BoB6LlnF/emAHLG0zDrJFWwR5K5JcMzI
         rqvbB+xecyHUGrSofmPRmg0bXNM3DWTddVCvFIDidFBtjBr7GgQuHTZ3Zx9xRoQD/inR
         VX3mSsywKjohz4gmBOPkCH4sX1CVu+Q7j0gZ/DAwBifArUxbTJdmZ1jv+5QgEeXByJVM
         dGJA==
X-Gm-Message-State: AOAM532xNzjdigICQryw4mf/WfLnZrP8FLi4QVm1ZseAeGoVTWKtt3tz
        EGHq1EBJHEY4A2cTbnaG75XEqg==
X-Google-Smtp-Source: ABdhPJxe3WPDsF/Ss6eKC+aL78ToDj1r+IEd2rMAwohSMI+2b4yzHLOnjhl8EBq8paJZUxhB9cJ54g==
X-Received: by 2002:a05:6830:18a:: with SMTP id q10mr6226851ota.25.1590612937438;
        Wed, 27 May 2020 13:55:37 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g22sm1150339ooh.36.2020.05.27.13.55.34
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 27 May 2020 13:55:36 -0700 (PDT)
Date:   Wed, 27 May 2020 13:55:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     maobibo <maobibo@loongson.cn>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paulburton@kernel.org>,
        Dmitry Korotin <dkorotin@wavecomp.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Stafford Horne <shorne@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "Maciej W. Rozycki" <macro@wdc.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 3/3] mm/memory.c: Add memory read privilege before
 filling PTE entry
In-Reply-To: <d1646320-51ec-4b5f-bcad-41eba85b78cf@loongson.cn>
Message-ID: <alpine.LSU.2.11.2005271329050.6217@eggly.anvils>
References: <1589778529-25627-1-git-send-email-maobibo@loongson.cn> <1589778529-25627-3-git-send-email-maobibo@loongson.cn> <20200518135747.d8837ba6742b2d193e14fbb0@linux-foundation.org> <d1646320-51ec-4b5f-bcad-41eba85b78cf@loongson.cn>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020, maobibo wrote:
> On 05/19/2020 04:57 AM, Andrew Morton wrote:
> > On Mon, 18 May 2020 13:08:49 +0800 Bibo Mao <maobibo@loongson.cn> wrote:
> > 
> >> On mips platform, hw PTE entry valid bit is set in pte_mkyoung
> >> function, it is used to set physical page with readable privilege.
> > 
> > pte_mkyoung() seems to be a strange place to set the pte's valid bit. 
> > Why is it done there?  Can it be done within mips's mk_pte()?
> On MIPS system hardware cannot set PAGE_ACCESS bit when accessing the page,
> software sets PAGE_ACCESS software bit and PAGE_VALID hw bit together during page
> fault stage.
> 
> If mk_pte is called in page fault flow, it is ok to set both bits. If it is not 
> called in page fault, PAGE_ACCESS is set however there is no actual memory accessing.

Sorry for joining in so late, but would you please explain that some more:
preferably in the final commit message, if not here.

I still don't understand why this is not done in the same way as on other
architectures - those that care (I just checked x86, powerpc, arm, arm64,
but not all of them) make sure that all the bits they want are there in
mm/mmap.c's protection_map[16], which then feeds into vma->vm_page_prot,
and so into mk_pte() as Andrew indicated.

And I can see that arch/mips/mm/cache.c has a setup_protection_map()
to do that: why does it not set the additional bits that you want?
including the valid bit and the accessed (young) bit, as others do.
Are you saying that there are circumstances in which it is wrong
for mk_pte() to set the additional bits?

I'm afraid that generic mm developers will have no clue as to whether
or not to add a pte_sw_mkyoung() after a mk_pte(); and generic source
will be the cleaner if it turns out not to be needed (but thank you
for making sure that it does nothing on the other architectures).

Hugh
