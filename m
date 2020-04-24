Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B9EC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823582074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udSdbqxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgDXBo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725884AbgDXBo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:44:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9623C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:44:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 145so3987936pfw.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pSqeJ5EgdhEUYq/5PiKiFsCIJkBQmBkYz7RsM9vACbM=;
        b=udSdbqxp70VPrgUbVyag1+rsW6qg2OpecWf95x9vJnJGSlkyevj1rJu43WToLgr1AD
         DQQtHOHEejtogMj2p9q+K870sYiE4hHXHGvLScCVyEHsSQl6VzrPXei4pRtFQ80AVMD3
         5B6Tkoa/GGyG7tgTgFe/JCTFgXYBesFkOyDjmPli2FiJ620J3AutzVCcNM45g74q2cyn
         DNl22Tvg/tt6CsdYgQn+IxLmYuwBlvvzzV/Gyl3TAgJHUHWNrRbqZgty3dM+YKAE6Wtf
         rZmQ1VLywDKf0exbZwkVX0cWujaZDop9TA9KdBb3u0fk7okRI+TqfWdsZ5WjpavuoRoP
         ciVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pSqeJ5EgdhEUYq/5PiKiFsCIJkBQmBkYz7RsM9vACbM=;
        b=oPsxCEmJEw0OieedP0PyjMEV0jCi7RI9GpsFxVfWN0St3Pr5e1uQ7zWT6dpXhaoXKQ
         ul3y8QWbFgOmOsAx+qUGuGc7ftJWZwjL/SntIR8urpvmoocaCu+bHu+XTL0yjOoikRg9
         mqPs0MUlBHFbE4Ds9kmloVptRE8YMae5ZzO+dSuB68LVavOLKioLwDKn0rF4a+OAyUKw
         V4tZeAHDehDXqs3F5lyuLgIv3O3nxOyyMTLW2OmFKe6xuZhxrq6BbNTD2aEj6T657EAM
         LoUDuMGAfjKiFQek2CP4CyczqOnDs6HpA6tbHxQogRroA3QYSgwk7eBf9g9sAVE5mMNZ
         OMGg==
X-Gm-Message-State: AGi0PuYI86+3ZfLmr+a8hCw9wW3bXnLyzR2Rl73LUEDrPZr8LrnFM2Gh
        XFdHGy7l3vFF3rq/BawRZZF/OQ==
X-Google-Smtp-Source: APiQypJWFxReK6uKdWrYupl4KTYHJ/mZkElbm5sgg9dujSKAliPsqgNsM97wJ6Ag+D+BKy6Nbuw7lA==
X-Received: by 2002:a63:f64d:: with SMTP id u13mr6625326pgj.151.1587692694955;
        Thu, 23 Apr 2020 18:44:54 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:2523:d194:de3b:636f])
        by smtp.gmail.com with ESMTPSA id c3sm3864956pfa.160.2020.04.23.18.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 18:44:53 -0700 (PDT)
Date:   Thu, 23 Apr 2020 18:44:51 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v5 09/10] mmap locking API: add mmap_assert_locked
Message-ID: <20200424014451.GD158937@google.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-10-walken@google.com>
 <CANN689FQf3gMTTXr7vwYujvuoVNDHdRFWWwaBQAdhifeE=zBbg@mail.gmail.com>
 <20200422021850.GS5820@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422021850.GS5820@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 07:18:50PM -0700, Matthew Wilcox wrote:
> On Tue, Apr 21, 2020 at 07:10:39PM -0700, Michel Lespinasse wrote:
> > On Tue, Apr 21, 2020 at 5:14 PM Michel Lespinasse <walken@google.com> wrote:
> > > +static inline void mmap_assert_locked(struct mm_struct *mm)
> > > +{
> > > +       if (IS_ENABLED(CONFIG_LOCKDEP) && debug_locks)
> > > +               VM_BUG_ON_MM(!lockdep_is_held(&mm->mmap_sem), mm);
> > > +       else
> > > +               VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
> > > +}
> > 
> > Turns out this function definition does not work for !CONFIG_LOCKDEP
> > as lockdep_is_held is not defined in that case.
> 
> Oops, sorry.  It only defines
> 
> #define lockdep_is_held_type(l, r)              (1)
> #define lockdep_assert_held(l)                  do { (void)(l); } while (0)
> #define lockdep_assert_held_write(l)    do { (void)(l); } while (0)
> #define lockdep_assert_held_read(l)             do { (void)(l); } while (0)
> #define lockdep_assert_held_once(l)             do { (void)(l); } while (0)
> 
> which seems like an oversight, but not one that you should be fixing.
> 
> > The following should work instead:
> > 
> > static inline void mmap_assert_locked(struct mm_struct *mm)
> > {
> > #ifdef CONFIG_LOCKDEP
> >         if (debug_locks) {
> >                 VM_BUG_ON_MM(!lockdep_is_held(&mm->mmap_lock), mm);
> >                 return;
> >         }
> > #endif
> >         VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> > }
> 
> Yes, I agree.

Sent an updated version of this
(also integrating your feedback on patch 10/10)

Please look for it under subject: [PATCH v5.5 09/10] mmap locking API: add mmap_assert_locked() and mmap_assert_write_locked()

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
