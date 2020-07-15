Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EBCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07DD12065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="VB27AG9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGOUzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOUzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:55:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E3C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:55:04 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u12so1872742lff.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DLG1tBaoE9BO9pWX659OlAVtEZXhuuumMlAWDILOJGk=;
        b=VB27AG9iwRhJsDz2tFcRHmAng2Z9TEKwor91BN8i3YJAVCn9pl6GBy3XEL0ETGJnXD
         9HvJ5hhMyeWjQtJPdGiUWUYGDIhYBzah09uIop996c+tK2eEoYHruwKK6812KPn9KsLL
         nRm0SvB4CM/c1kCu7/JSsZzNUpiVWJA25wgMg6ZKdLP735erIwDcYAymz3I576S5u9Qb
         /88OhtDpFmmJq3+LnxeNh8psQ3cT5btBh1OnASrtwpf3v3prqpqLBvBEP9q2ywfYBfVg
         sijubuLNRhfIOX0SYcjrCusLLPqAmqtu4xROWHUIHJPA0oZbL5Ddu3mgYShhtlb392hs
         q+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DLG1tBaoE9BO9pWX659OlAVtEZXhuuumMlAWDILOJGk=;
        b=k3CHS+HjzLhlfiK/aVDE2yhZMdNMmbwvSJyaEW5tmIdMCktBCtWZ+USk/IcT88lj2Q
         9I7CutRnNNF3yAp1DB5a6knAohwV/vUxrAUlTe/FxZANuoJXgvD6ndzkFiVWViJCHNUy
         tQLzoB5IOMQ635asMiu2EnhlMBCPPypw0Q1PDwLfRckgdTLOWqxcxD0MTadKVtJmuo3D
         XwvbDVyWKzisFp2kpBZP0dqRWzHq8dPZdpwMTfFrFuiHiT/oTL10+I3HNbXb9MY4q2Z9
         kBpTNBoYWG/s5DF5QdOHByM6mmpv2LRgq0AZ92atB1K+2z0oq2Bfp1hwBsjrqT5JdB8J
         0Png==
X-Gm-Message-State: AOAM533d7dZJYamhUFLmtPMuFgbZfCh7Bo/0nlOofZW6jtbnkH39lwv4
        KGluX0Dl3DoBlo/Dyhth7f7RaXD5niY=
X-Google-Smtp-Source: ABdhPJzWhykc/WCUeRfE6WSX7VQjb88uxneZFyAg1LMmhA3ll7gKJPNukxznwmI9SCbM0O1MuA2BIw==
X-Received: by 2002:ac2:43dc:: with SMTP id u28mr417591lfl.17.1594846503041;
        Wed, 15 Jul 2020 13:55:03 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m11sm642901ljb.47.2020.07.15.13.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:55:02 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8D840102143; Wed, 15 Jul 2020 23:55:08 +0300 (+03)
Date:   Wed, 15 Jul 2020 23:55:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
Message-ID: <20200715205508.3rzrkhulruzpy6iv@box>
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:36:59AM -0700, Linus Torvalds wrote:
> On Wed, Jul 15, 2020 at 6:50 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > mremap(2) does not allow source and destination regions to overlap, but
> > shift_arg_pages() calls move_page_tables() directly and in this case the
> > source and destination overlap often. It
> 
> Actually, before we do this patch (which I think is a good idea), I'd
> like Naresh to test the attached patch.
> 
> And Kirill, Joel, mind looking it over too.

I don't understand 'len' calculation in try_to_align_end().

IIUC, it increases 'len' by PMD_SIZE if 'new_addr+len' is not aligned to
PMD_SIZE. It doesn't make sense to me.

Maybe
	*len = roundup_up(*new_addr + *len, PMD_SIZE) - *new_addr;

or something?

BUT

I *think* there's a bigger problem with the patch:

For stack relocation case both VMAs are the same and always(?) the only
VMA around at the time. It means none of ADDR_BEFORE_PREV and
ADDR_AFTER_NEXT are going to stop us.

Consider the following case, before and after try_to_align_start():

		before		after
old_addr:	0x0123000	0x0000000
new_addr:	0x1123000	0x1000000
len:		0x1000000	0x1123000

(4k PAGE_SIZE, 2M PMD_SIZE)

On the first iteration we would attempt to move 0x0-0x200000 to 
0x1000000-0x1200000 and step onto the same WARN(), no? 

-- 
 Kirill A. Shutemov
