Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5D7206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5BqlN/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgESNKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESNKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:10:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C255C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:10:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so5609622plt.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/t5Q76brEmiFOkE+Fa8TY6sSlQLt/nYO/w8O35DojmA=;
        b=h5BqlN/+Hn9SGQ7i05BQI6KcD+y4PK5BC4LW9aaiaupa6G3aE45naOipKdwg6RCH+z
         B1aROfQf/swVtAmV9Q3WeWZ6cxIsb+NILK6oCN+zT/pcV6GNvbUxUZShW7odj65ms9R+
         xIHvXzL8IXOcwWQWXRWasRMqYVHG+zpsWktfOzu/vaVlJ6dY+5GV5WqPfDhIKy3bmBMI
         IxR34xfF9zHeKIsmCn0KXpRlOJNbyyejvuM01J+4gWx251icBsDDdvF5y1PkMqlTyBzq
         k1114wNiX4ZBbXhPocM00mrka6IDLFqrh7hNym8mGF/Qh3XdmakcA4euR3EnadEZskH9
         rTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/t5Q76brEmiFOkE+Fa8TY6sSlQLt/nYO/w8O35DojmA=;
        b=P9tvTuASbJOCs8oZ1eGuGjSzPKMOIQ83z9lF1MTKjL3Wg1mM8vSw4DG7S2gQH7etXw
         zxyhV+bagjcumA6ZkATD3XZhGRdkY5VcmDKtnsPu6uqqeETNxGHl6RXw4ciKIxacllqN
         WDeiTQWAZhoG9UnpVLGTakyk98fSkrLDLEeY8e03/epYYhdU+wej/3yHDBFDXFApM2GT
         Mdwf30VJg0NzyxJ3Anqg+9kAGSrUHu4yutMd/kaG1ffgmFC6ehsk/pWUBEt5b/PNEiFq
         CFPc+4hIEpuDqL3zG0a3T/VjfYbrShOL0qcO7n6Q7fIaDCg3yLSEU/mG/KIYkltj8PO8
         YJUQ==
X-Gm-Message-State: AOAM533VtoLduiHUZL6SnGe1WYRUP1ho54SMGmDcevTlTtLoS19BhtJp
        wGkT32/PasP9SRquQU6Xk7mdAw==
X-Google-Smtp-Source: ABdhPJyRXNx07N2fTf9QLSdqn0WHYd/NSH1ZR/mcHjoNMJ6OQpXvCcLfl4Fg32pYTm7gQbAm2QJ0Sg==
X-Received: by 2002:a17:902:d693:: with SMTP id v19mr15203765ply.288.1589893813434;
        Tue, 19 May 2020 06:10:13 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:2523:d194:de3b:636f])
        by smtp.gmail.com with ESMTPSA id 7sm8757569pfc.203.2020.05.19.06.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 06:10:11 -0700 (PDT)
Date:   Tue, 19 May 2020 06:10:09 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v5.5 10/10] mmap locking API: rename mmap_sem to mmap_lock
Message-ID: <20200519131009.GD189720@google.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org>
 <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org>
 <20200424012612.GA158937@google.com>
 <20200424013958.GC158937@google.com>
 <f20ab834-cddb-eaa7-c03e-18f0c4897a33@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f20ab834-cddb-eaa7-c03e-18f0c4897a33@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 03:45:22PM +0200, Laurent Dufour wrote:
> Le 24/04/2020 à 03:39, Michel Lespinasse a écrit :
> > Rename the mmap_sem field to mmap_lock. Any new uses of this lock
> > should now go through the new mmap locking api. The mmap_lock is
> > still implemented as a rwsem, though this could change in the future.
> > 
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> > index dc9ef302f517..701f3995f621 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> > @@ -661,7 +661,7 @@ static int etnaviv_gem_userptr_get_pages(struct etnaviv_gem_object *etnaviv_obj)
> >   	struct etnaviv_gem_userptr *userptr = &etnaviv_obj->userptr;
> >   	int ret, pinned = 0, npages = etnaviv_obj->base.size >> PAGE_SHIFT;
> > -	might_lock_read(&current->mm->mmap_sem);
> > +	might_lock_read(&current->mm->mmap_lock);
> 
> Why not a mm_might_lock_read() new API to hide the mmap_lock, and add it to
> the previous patch?

I'm not sure why this is needed - we may rework the lock to be
something else than rwsem, but might_lock_read should still apply to
it and make sense ? I'm not sure what the extra API would bring...

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
