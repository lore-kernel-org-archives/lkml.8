Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DF8C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49DE020760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 17:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599325428;
	bh=bYePyoygb5sypUBeDHzAvhU73UeSVNStq9eAPSiouAY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lorbqfk4/gafXHnnycEw4G1wXkqrpLNIICKmFZl+9JbH/tAbUWucJKxz9f9E3Go2c
	 h9FL49ZKsoKg6zymeuJTRwam7+u03FKp8gyLLgnjU7Fl3Yyd049pFw0q58EwBPv8RU
	 jPlVsPy2X0ORqWax7Uds0zfa4Sig1kXu5+T/nteg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgIERDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgIERDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 13:03:41 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC539C061245
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 10:03:40 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m5so4567750lfp.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yq3SfrK7yZAtmYRnvDmja3vYq8mdQSVjPiEi6mwaMYI=;
        b=b0r56yrMlN887hWaFszKtt3otNFfkTZGY9PBeAnyiPugAfYpUMCfOTBWDohK5Luc/G
         +LqYWBwLdx1jUaxLPC79yX0fHBJTRyN1py7Wq/ZzjBRr+LK88BEB8cL1Zhj8z/OzGL05
         1K+nOaaiL2yDxhltK+DQ4feWYgd8jEHvr7JnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yq3SfrK7yZAtmYRnvDmja3vYq8mdQSVjPiEi6mwaMYI=;
        b=sGNIAibCK96IhcNvUXVyizvrksmD2w1gwwd/7GckscipmVz7EqIfF6lwZ80vrlHCz9
         EjfKl3W8XPJ7p7r5i3A9nacWVC0n4+tG8OhZXs/2CleowNBzHafqHUBDj7I72oiIqawo
         C8WnG1g4fI6n257Kn/AS7vLGdcR9jjNH1cygNAroizXFPbFQvhMROD8Lzz550X/6KDJx
         /Lsov+GOx8oCziyaHWYNmskEnmMouZ9QMbWJaIgj8MZVBNz3EF4iLgNnrHNBvM62OW0q
         LtDgQD2IbM7jYP3ObbJY28T3WxV+IhSCSK8PwoN8Pf47bpbRMLZH7J2UiCIXL0ASMs9X
         0tug==
X-Gm-Message-State: AOAM532JS7kchx+mM4W1bGTPsG0osIflZVTZXoJB9gujLzAuSWS6b/hx
        FEV/nd6DAvh4wmaITV/AfTg9fvXjgFYFbA==
X-Google-Smtp-Source: ABdhPJxPuZvEJ7ypQ2lWYJaBDd6klSwkfw1LdhE3Yo0D+jpJZSOJYCHHMzH54F1rGknzuwIQkVxopw==
X-Received: by 2002:a19:ee0d:: with SMTP id g13mr6420213lfb.139.1599325418311;
        Sat, 05 Sep 2020 10:03:38 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 69sm2563820lfm.83.2020.09.05.10.03.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 10:03:37 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id z19so5466982lfr.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 10:03:36 -0700 (PDT)
X-Received: by 2002:a05:6512:403:: with SMTP id u3mr6534077lfk.10.1599325416665;
 Sat, 05 Sep 2020 10:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh=0V27kdRkBAOkCDXSeFYmB=VzC0hMQVbmaiFV_1ZaCA@mail.gmail.com>
In-Reply-To: <CAHk-=wh=0V27kdRkBAOkCDXSeFYmB=VzC0hMQVbmaiFV_1ZaCA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Sep 2020 10:03:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNoq2kh_xYKtTX38GJdEC_iAvoeFU9gpj6kFVaiA0o=A@mail.gmail.com>
Message-ID: <CAHk-=wgNoq2kh_xYKtTX38GJdEC_iAvoeFU9gpj6kFVaiA0o=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] xfs: don't update mtime on COW faults
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 5, 2020 at 9:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So your patch is obviously correct, [..]

Oh, and I had a xfs pull request in my inbox already, so rather than
expect Darrick to do another one just for this and have Jan do one for
ext2, I just applied these two directly as "ObviouslyCorrect(tm)".

I added the "inline" as suggested by Darrick, and I also added
parenthesis around the bit tests.

Yes, I know the C precedence rules, but I just personally find the
code easier to read if I don't even have to think about it and the
different subexpressions of a logical operation are just visually very
clear. And as I was editing the patch anyway...

So that xfs helper function now looks like this

+static inline bool
+xfs_is_write_fault(
+       struct vm_fault         *vmf)
+{
+       return (vmf->flags & FAULT_FLAG_WRITE) &&
+              (vmf->vma->vm_flags & VM_SHARED);
+}

instead.

            Linus
