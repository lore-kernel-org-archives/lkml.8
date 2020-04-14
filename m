Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D54C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1A82074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="los3CO0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633084AbgDNUYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633075AbgDNUYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:24:46 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DA7C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:46:00 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id t3so10886019qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AoePh0L7clLZ89TR81gTXNvMVga1FwbfbOjDUCAzwJo=;
        b=los3CO0FB7m4TgWuhqYzQR9FgWSb+21Q/SsMnuebxBbbGNW0gnNyNNsG8i1o3kPehA
         UqL9YGAdbGZNeabsFe79vHOobEfGn5IiAQRKWfhGlzSf93RnDfTney3of7o4lszoFunu
         yGf5wit5RwJbEA9VKXsP5wv1fv5NJjKWLC8RrDWlS7GSaWqWhFGU7qRWB6b60HDupVz+
         HglqxNMYFqrSFMyX4ou6DU0TITyXM6yXa7HeCrheAjkz8i7Vn7kyJBnN4du+aF3ie6bl
         qgStYXPy4Un9Ya4J/zFIhuIpTRky+QTn42egiYvSAZsBknJgEm1Q6/ILQS2zLGG1Lwzz
         +xVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AoePh0L7clLZ89TR81gTXNvMVga1FwbfbOjDUCAzwJo=;
        b=XK+N6DG5sJTygyVd/JM31sSsYFl1GSo/zbWEt1GlED1VVQDL8hSV6P38yvtDvxsPL8
         zll31sOYVS5UydmQysvoDnRMc4b1Cmw0oFlR/+w50MZhC9Z6lW5bmZvp10UbxPOO3rbx
         VBJOwF705U7pwGRTnFDBlFKDCLDYcc1uGyOLp0buWjasq1fnnXO7UhFRkUpgqrK3PsyG
         VfqtXoKsoxSDycWo8pO5HWSqmd3+M4k34oDoGyN69zMK1pW7fuV+VxuS6URD9W/2OE7n
         GHLqWjbVyYTpKQy+HLQPH9bN8/uW3Nn8vXkJBII86hcCOrCJQoUzCZhjRRzWSXbRtMOr
         rHBg==
X-Gm-Message-State: AGi0PuZMbuBDrnA0pyWkeNTbnpa/UsE+2up9SqN+isG4pIlpyo7qm6wO
        CTnwZnhtqURUqkMRgazE08P3Vw==
X-Google-Smtp-Source: APiQypKWcghcF21Ly93yW8h4XKqSbHAzXJ816BD2DogniN0JD3EUK/8yLkrkRxEkIDIcEq13qbx6OA==
X-Received: by 2002:a37:b702:: with SMTP id h2mr23400870qkf.491.1586893558885;
        Tue, 14 Apr 2020 12:45:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p22sm1550903qte.2.2020.04.14.12.45.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 12:45:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jORVN-0007BW-VY; Tue, 14 Apr 2020 16:45:57 -0300
Date:   Tue, 14 Apr 2020 16:45:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/gup: dereference page table entry using helper
Message-ID: <20200414194557.GL5100@ziepe.ca>
References: <1586877001-19138-1-git-send-email-agordeev@linux.ibm.com>
 <20200414163234.GG5100@ziepe.ca>
 <20200414185829.GB1853609@iweiny-DESK2.sc.intel.com>
 <20200414190620.GJ5100@ziepe.ca>
 <20200414193952.GC1853609@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414193952.GC1853609@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:39:53PM -0700, Ira Weiny wrote:
> On Tue, Apr 14, 2020 at 04:06:20PM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 14, 2020 at 11:58:29AM -0700, Ira Weiny wrote:
> > > On Tue, Apr 14, 2020 at 01:32:34PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Apr 14, 2020 at 05:10:01PM +0200, Alexander Gordeev wrote:
> > > > > Commit 0005d20 ("mm/gup: Move page table entry dereference
> > > > > into helper function") wrapped access to page table entries
> > > > > larger than sizeof(long) into a race-aware accessor. One of
> > > > > the two dereferences in gup_fast path was however overlooked.
> > > > > 
> > > > > CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > CC: linux-mm@kvack.org
> > > > > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > > > >  mm/gup.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > > index d53f7dd..eceb98b 100644
> > > > > +++ b/mm/gup.c
> > > > > @@ -2208,7 +2208,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> > > > >  		if (!head)
> > > > >  			goto pte_unmap;
> > > > >  
> > > > > -		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> > > > > +		if (unlikely(pte_val(pte) != pte_val(gup_get_pte(ptep)))) {
> > > > 
> > > > It doesn't seem like this needs the special helper as it is just
> > > > checking that the pte hasn't changed, it doesn't need to be read
> > > > exactly.
> > > > 
> > > > But it probably should technically still be a READ_ONCE. Although I
> > > > think the atomic inside try_grab_compound_head prevents any real
> > > > problems.
> > > 
> > > I think we should go for consistency here and use the helper function.
> > 
> > It seems quite expensive to do two more unncessary barriers..
> 
> But won't a failure to read the 'real' pte result in falling back to GUP slow?

If there is no concurrent writer then the direct read will give the
same result.

If there is a concurrent writer then it is a random race if fallback
to gup slow is required.

Jason
