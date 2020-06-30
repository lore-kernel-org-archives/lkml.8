Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7BFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A58220780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I91ieOQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgF3XfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:35:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38299 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726093AbgF3XfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593560116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BEw6JckLIBvAc9GmD7VOhuJynHaqvfGs3fNWT+nS+BQ=;
        b=I91ieOQ4bWHqIcA5X3MWFgGdL9IPri21Rj0tcr/ex04CNVem3o08K9uqFYVYgBSrFnC+Pw
        KKlwN1/h6x55AswHH1Blqjr9CwaQ1lIfH5sDCFThewWN7vicJq++zyRzNsKDh/5JGsbdvi
        9GcngRt/B+McNB+wkEaMiz3Gj0rhOvc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-Kw-1Gd5xP-ewmGN17r6X7g-1; Tue, 30 Jun 2020 19:35:06 -0400
X-MC-Unique: Kw-1Gd5xP-ewmGN17r6X7g-1
Received: by mail-qk1-f198.google.com with SMTP id i6so15726901qkn.22
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BEw6JckLIBvAc9GmD7VOhuJynHaqvfGs3fNWT+nS+BQ=;
        b=jqbYqzEQTGB2NfLZQwI7ZtXW1sBEADRxXWgPDhZVYHqoX0GUORF8QGjlPsuQ3o/AIe
         ot88e1oSTIrPRR/Zz8UU7Oo3CsJZy1J9biTxqza8JwsuWRgAY+YUzOF9xaMFehZa/BnV
         mq2XdxwA4/gIyQyJCRr/8x/bYLkGnHv6Ayu8vxib4pnKODe6ApFWci2V0rRnubfUA7gp
         lsLnwq2TLfFi99VK1Z7L2KkSZcujy3Rn92tmoICFAwC9cAVB17ZkFt9sW+g9D8R4nTPe
         uTCMu5WwLBlPdb+T0o0pJsvXCp+27RTxgnFgMXFy3ktqQgLFaLnzN8Ife+872aC2S6Kn
         Hd7Q==
X-Gm-Message-State: AOAM532mGaM/HfShv4UvSqUqdceUBJn8vPPkNUBOfWYIE/GldvDhVkDY
        8YWoOwPLKBI8yIBusQIcxCju0svl24EUDCIQ6SkaZlcAW06gl4A5miLNS2C9RKm6dgkmuoqZEcz
        IebzXm6jpT/+3ZLR4ynhIKxGf
X-Received: by 2002:ac8:7189:: with SMTP id w9mr23857085qto.69.1593560105605;
        Tue, 30 Jun 2020 16:35:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxulFIjWBFRg9U0OOMQI77HYyEMoQXyRaiZHF30Rs2nCNMTu4ktt9LDtWqkkii49ZZsWYkK9w==
X-Received: by 2002:ac8:7189:: with SMTP id w9mr23857063qto.69.1593560105333;
        Tue, 30 Jun 2020 16:35:05 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id d8sm4158408qkl.118.2020.06.30.16.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 16:35:04 -0700 (PDT)
Date:   Tue, 30 Jun 2020 19:35:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 00/26] mm: Page fault accounting cleanups
Message-ID: <20200630233502.GC40675@xz-x1>
References: <20200630204501.38468-1-peterx@redhat.com>
 <20200630211155.GA40675@xz-x1>
 <20200630160548.fc8d1f93148e74e544850bf3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630160548.fc8d1f93148e74e544850bf3@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 04:05:48PM -0700, Andrew Morton wrote:
> On Tue, 30 Jun 2020 17:11:55 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > On Tue, Jun 30, 2020 at 04:45:01PM -0400, Peter Xu wrote:
> > > v4:
> > > - rebase to linux-next/akpm
> > > - picked one more r-b
> > 
> > I fixed some stuff in the send scripts but definitely broke something else on
> > the chaining of the messages.  Andrew, please let me know if you want me to
> > resend...  Sorry for that.
> 
> Well, the words
> 
> : Since v2 changed quite a lot from v1, changelog is omitted, and I also
> : didn't have a chance to pick up any r-b in previous version.  I really
> : appreciate anyone who has looked at v1.  V1 for reference:
> 
> make me think "not yet".  But this patchset is v4, so all confused.

I posted v2 & v3 with incorrect versioning, so they were all shown as v1 in the
subjects.  I fixed it in v4 so it seemed to have jumped from v1->v4.  Sorry for
the confusion.

Regarding to the cover letter: I rewrote the cover letter in v2 because it
changed a lot.  While v3 & v4 changed little, so I kept the v2 cover letter
then appended with changelogs for v3/v4 at the top because the content of the
v2 cover letter still stand.

> 
> I'm thinking we give this v4 a week for people to check it over, gather
> up the revews and acks, incorporate the change suggested by David, redo
> and double-check the cover letter then shoot for a v5?

Will do.  Thanks,

-- 
Peter Xu

