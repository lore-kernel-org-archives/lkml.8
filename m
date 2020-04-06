Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56176C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230F221841
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IqV4lCRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgDFPkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:40:08 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39966 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbgDFPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:40:07 -0400
Received: by mail-yb1-f193.google.com with SMTP id a5so65268ybo.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F00FerRMC/iZ1VNpTR4/uGlV6Ri7SKzco769wYX8wKM=;
        b=IqV4lCRJPE59U0ZhY8oViBP7OY0GP2QaVSZxP79YyR1WXHGgfTydsVq4uVn/GUxmi4
         TypEjwO1qCK3AVGAEj9PCCcgrl4TaFHieTIrQkYT5zKEmYeiw9ZXX/xdtCDTCNQDxHXa
         uyikB+hXXts4vpCIHb7+JuF+z2jppRaOChrQP7RopFAfpwIUXPvPCtl2zSevHj6mfVsE
         n41WZ4Pf3jAAVAsA6v0JXpzRrpUZkkpKY816qSSpNJrvzWx9Vo8M7e/JzVdY9J62aEo7
         UWWKuCs1sFrXl1ApGurI8/yTK76VFQ0LdfjNtjRLuQEYb2Aq348d0zPurErV130Zuw56
         tZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F00FerRMC/iZ1VNpTR4/uGlV6Ri7SKzco769wYX8wKM=;
        b=OrQwOOT3rJ7+5ox2PqxVcNGX0vNRjDUhOdw3UzFi+J+GsvjFdQ02wWkMhVPmvrMN2V
         pZph81Kta3IS0k1EPuwR35k5zPU8fCFpQGbJ5Sr6LObiIqd7Ko+ozXWJr/dlKXOMafQe
         MS9vfL/2MyuQcsUqUKZArcMoDDBYk7Whid77ku0Klp54aIEcoP2gDsbT4LTUBavR0LmO
         q9+WmowIsamyo4bzWFqN/6sGPwVqvbBGzJZxLCyqOK6fq9Ih+RKXyZHT0xDRanTbdjXw
         X3czKWcWaFMj8SUN9MzKQE/IzaJg0efEhtvPodtX/HYAVHt1vJ+PB5t6qooI2Oq79UOO
         n7FQ==
X-Gm-Message-State: AGi0PuZUOLvz91N7TQ5sjuZdhb0vO5+lCo/CbaKyt4XTsJ3qHMtkxSc9
        Q9W/pWs/EAf23OkmdC/ntlJe5G0Uuu/rlR6tORiSqw==
X-Google-Smtp-Source: APiQypJ2nxvqmsPaJbcYbfk/h7s3U0WAdHb0BAJ0U4v0ana9CI40VWbA+MdyQhuncqfmlkGhikmtq3ZdICXpJXYVV3A=
X-Received: by 2002:a25:d382:: with SMTP id e124mr33963146ybf.162.1586187605964;
 Mon, 06 Apr 2020 08:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200327225102.25061-1-walken@google.com> <20200327225102.25061-8-walken@google.com>
 <20200401134633.GS20696@hirez.programming.kicks-ass.net>
In-Reply-To: <20200401134633.GS20696@hirez.programming.kicks-ass.net>
From:   Michel Lespinasse <walken@google.com>
Date:   Mon, 6 Apr 2020 08:39:53 -0700
Message-ID: <CANN689FRvuZFGUKT+4Xd32JvHoH+OkMiB=OJzoGh+b3YtCwq3g@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] mmap locking API: add mmap_read_release() and mmap_read_unlock_non_owner()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 6:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Mar 27, 2020 at 03:50:59PM -0700, Michel Lespinasse wrote:
> > Add a couple APIs to allow splitting mmap_read_unlock() into two calls:
> > - mmap_read_release(), called by the task that had taken the mmap lock;
> > - mmap_read_unlock_non_owner(), called from a work queue.
> >
> > These apis are used by kernel/bpf/stackmap.c only.
>
> That code is an absolute abomination and should never have gotten
> merged.

I have to say, it's causing me some grief too :/

> That said; I would prefer a mmap_read_trylock_nonowner() over
> mmap_read_release() existing.

It only addresses part of the issue, but I suppose I could do that. Is
this something I could append to the end of this series, or do I need
to prepare a v4 for such changes ?
