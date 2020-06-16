Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072BFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1A6208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="P6F/6Li0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbgFPQ7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgFPQ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:59:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F73AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:59:52 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k11so22311340ejr.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9c3XpUNRuxc8tvHN/G/s1TeMtn7R53E47RIpJ3K1Kjo=;
        b=P6F/6Li0cNofNpVQGyh790TSj0hnEC9itlHPgIsadxqJsMTv2HLDoSobSlbltEfUh2
         vsx03Q2EGLSEX7+lQl/MFwECf5bdmgM/HEP7HOpYfqkTdczVCH17cPrTGFDJe3AEkS5o
         pf8zQoNctOFIsW4Qb46xAtZ3QA+nKYUdOu7KlruHzayUM/3u36JTjcwVVu7dI78fRVEu
         i5HYmeba9xv0+8lhJ3e7NcOji7wdwUegQuxlSH8ohKTtEU1xlc/1cFLccXTVL3AHSEnC
         6VvaV4Nh34wT3F3OsOOF5xnel9B2+wAVGlu2+qDsFzs4oEACd3ex/bFB2/yaZmCvdUPy
         0rOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9c3XpUNRuxc8tvHN/G/s1TeMtn7R53E47RIpJ3K1Kjo=;
        b=HcBsSlmLWxnllwRDLEhI9ycWaw/J0MERNSColFhYHMSHEPsPOcTm+TERtQgGi4EoRi
         qkCOaY/2yK/hB7Ag3JdtKOQK0ktYEWmEFzhzDeZRAn8UrHhHOQQVFmEUbnqslFWAXDqr
         lLNE/L/CCPThWS6JDrwY7IPTxSP9C+JCXn1GtnNmENu8uBnqECiEn4s9HffvoiF7nPKY
         UDZTHDLU28CsdYtjXq9yUvETBoU2XtCwLlmF8wn1KUBktesoRY80zlu4TQZTwasPJPRD
         gsAykrCm9Q0h90FNhc+mnLYWEhEfQlaq5hgaB3CSiVfgHcttz/O8gGVvuaENWS8aJQsH
         9Tjg==
X-Gm-Message-State: AOAM532x8wJOohKyxZioQPIjdvN5y9i7GiTLKgIyVZCgDGU0T6pf02kC
        J0O4f3NXSE/Gtl72RgrT1dNezN8VfG1zrMe/svnPnA==
X-Google-Smtp-Source: ABdhPJxUcerRmdzyFUvLtbWcqtliDcNlbqG0p6OLPpFJjZwLdfD/UvIdP+kEnW0mIo2vb6TxUppF8iaiEBWW8qw+7w8=
X-Received: by 2002:a17:906:22d0:: with SMTP id q16mr3584102eja.455.1592326791128;
 Tue, 16 Jun 2020 09:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200616115213.13109-1-david@redhat.com> <20200616115213.13109-4-david@redhat.com>
 <20200616124120.GF9499@dhcp22.suse.cz> <30c35cd2-8167-d402-2c7e-94f5fcce0274@redhat.com>
In-Reply-To: <30c35cd2-8167-d402-2c7e-94f5fcce0274@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Jun 2020 09:59:40 -0700
Message-ID: <CAPcyv4irwGUU2x+c6b4L=KbB1dnasNKaaZd6oSpYjL9kfsnROQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mm/shuffle: remove dynamic reconfiguration
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 6:45 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 16.06.20 14:41, Michal Hocko wrote:
> > [Add Dan]
>
> Whops, dropped by mistake. Thanks for adding.
>
> >
> > On Tue 16-06-20 13:52:13, David Hildenbrand wrote:
> >> Commit e900a918b098 ("mm: shuffle initial free memory to improve
> >> memory-side-cache utilization") promised "autodetection of a
> >> memory-side-cache (to be added in a follow-on patch)" over a year ago.
> >>
> >> The original series included patches [1], however, they were dropped
> >> during review [2] to be followed-up later.
> >>
> >> Let's simplify for now and re-add when really (ever?) needed.
> >>
> >> [1] https://lkml.kernel.org/r/154510700291.1941238.817190985966612531.stgit@dwillia2-desk3.amr.corp.intel.com/
> >> [2] https://lkml.kernel.org/r/154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com/
> >>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Minchan Kim <minchan@kernel.org>
> >> Cc: Huang Ying <ying.huang@intel.com>
> >> Cc: Wei Yang <richard.weiyang@gmail.com>
> >> Cc: Keith Busch <keith.busch@intel.com>
> >> Cc: Mel Gorman <mgorman@techsingularity.net>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > While I am not against removing this unused code I am really curious
> > what is the future of the auto detection. Has this just fall through
> > cracks or there are some more serious problem to make detection
> > possible/reliable?
>
> From the bouncing mails I assume Keith - author of the original patches
> in [1] -  is no longer working at Intel (or I messed up :) "#5.1.0
> Address rejected"). Maybe Dan can clarify what the future of this is.

People are actively using this via the command line option. In fact it
has saved some people that have deployed platforms with mistmatched
DIMM populations where no HMAT autodetection would be possible. It's
also been useful for mitigating other memory interleaving performance
problems that are sensitive to a given address line.

The reason this is still manual is the dearth of platforms that
publish an HMAT, but again the command line option is actively
mitigating performance issues or otherwise allowing for testing a
"pre-aged" memory allocator free list.
