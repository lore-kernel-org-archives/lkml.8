Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9309C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F502064B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R7muKjGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgIJRVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgIJRUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:20:00 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21647C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:20:00 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e7so5439222qtj.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wS3Cxs+LxMo6gPPzfzs9JS4wraYUHvaNngFKImlbYPQ=;
        b=R7muKjGsMqQxjYn/v3laT3wxz696cPiiZUGTarCqWEmD8sEHzFMnpmRv1NbdWuvxUl
         ES4sa/jWMnYWk8X4X6idi0ndI491v7kNFTPa5GqC+PbSliK0PxcG7BbrKL1SGaFULExx
         kGCtyImpN4w3JYZEvlwpotauF+GyY/wqoWRoFKEJsIkkaaCf8ZEqmuepKdImBUgzQsFC
         Vc+IXldSoElxGSHRRDrr1U2IvhE0zAiCRYQ16d8EWEqzrgIPV6ZfSpzmZYP6/ZBNfv4U
         wV4KH/FXvtzAig33Lc4SwlzTJpcb6YSdw29FHxZ2Fklak2OM0YAdYreU9PkLtv7plyJk
         DE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wS3Cxs+LxMo6gPPzfzs9JS4wraYUHvaNngFKImlbYPQ=;
        b=BlISPEqZXAP7ezCWR7JR7AhAOkGounuNBvrpT5gOgcXmbaWF3S4Z8OKUMcuJD2kW9D
         gyP+lpBI2PZTAQJHc4B4yUNTAE2VKef/JqRNoiAR+zmOp3WVQZOZ8EZxkJvprTH3GnQf
         VHopRCBTMkjJfhAHAXb+Muz3ABjXOn+WAvcC4cGESayCt+kbvcIjewRlgwxUFEtPjaEk
         FISP7AbvFZU7MUer57h6abfj4Yw97gjArlbSRyLJXALFqibyaSSoIBjhlqcMf+XIhvcO
         2kSQbMIV3jgvJGUyHfXNujhI4H/KGXneKy/17M08iJEemV0BxmUxR0Gd/iQ+UzOxeYoR
         fn5g==
X-Gm-Message-State: AOAM532z4/vn6HjONu8vmiQSifd2gxL5OHgp6qOoLXVWLPKPNlFzY8/+
        6H127iY5Nq6oM/h/3OwUa/eg2g==
X-Google-Smtp-Source: ABdhPJzOK6FcVm6akWqNTL2Hu85OsyALxMrEucVBwOeXC6OwPNTX8vss/Xw7hopiKEc6u3QVNfxIcg==
X-Received: by 2002:ac8:54a:: with SMTP id c10mr9299916qth.251.1599758398248;
        Thu, 10 Sep 2020 10:19:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x126sm6934696qkb.101.2020.09.10.10.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:19:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGQEm-004NzL-RL; Thu, 10 Sep 2020 14:19:56 -0300
Date:   Thu, 10 Sep 2020 14:19:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910171956.GM87483@ziepe.ca>
References: <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad>
 <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
 <20200910130233.GK87483@ziepe.ca>
 <20200910152803.1a930afc@thinkpad>
 <20200910151026.GL87483@ziepe.ca>
 <20200910190757.153319d4@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910190757.153319d4@thinkpad>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 07:07:57PM +0200, Gerald Schaefer wrote:

> I might have lost track a bit. Are we still talking about possible
> functional impacts of either our current pagetable walking with s390
> (apart from gup_fast), or the proposed generic change (for s390, or
> others?)?

I'm looking for an more understandable explanation what is wrong with
the S390 implementation.

If the page operations require the invariant I described then it is
quite easy to explain the problem and understand the solution.

Jason
