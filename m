Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411DEC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124D32082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586464075;
	bh=rQn1E82s+Wz9eXHAjfpDkQrmhvgxgLdem6FaW3tpr9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s1AlDLl15WEQPCHf96DIXgA0N3NRXcfDPSK6EVtI+uIUinjx4zgjcHkrlvDl+og/K
	 omKeI05gh8Q2Y7j7BSlU68MwEOOBqcwtS/XKAWfoqqasANIATZIMLchjsmUdyRjFd/
	 CT+FUvendBz5pHUPgDnik8GKeibQ3sB+5kySeah0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgDIU1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgDIU1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:27:53 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DCA220757;
        Thu,  9 Apr 2020 20:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586464073;
        bh=rQn1E82s+Wz9eXHAjfpDkQrmhvgxgLdem6FaW3tpr9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ffj940nkA1lIrJN5l+P3LzxRVEWe3smiiPZZOY9+OsfkgKJX80vkYoTUJKDY2MUH8
         ebOerQPnpEedPCXKUPzFelsN0Ulsv5AGBjeQHMSyULhIGh/7l3ztMZ1XnEViB9XGpk
         pT1SgC49kT5NfH2z964ePkVBFfjlog0PZX6XP8XI=
Date:   Thu, 9 Apr 2020 13:27:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-ID: <20200409202751.GA7976@gmail.com>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <20200409114940.GT21484@bombadil.infradead.org>
 <CACT4Y+ZvQ9UvVAwTjjD8Zxo0X_nfxa3+6n6TqWk2g+hahBwdCw@mail.gmail.com>
 <20200409111604.c778ff091c00fab5db095e48@linux-foundation.org>
 <CAHk-=wiU77DeNxQsU4XrDCk59asyTs=Hn+mnTx6-SHB1_fA2NQ@mail.gmail.com>
 <20200409121250.d6bba6965b86c8dfcf325fbc@linux-foundation.org>
 <CAHk-=wgy3XRiyRP7vdfF6bHwWGaB1RwyWJmyphh+Q3qYk6w27w@mail.gmail.com>
 <20200409195633.GZ21484@bombadil.infradead.org>
 <CAHk-=wi50jKXOFpsRkxrqu4upNnEKm1oRZ_SG1yJB9QVh=VJZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi50jKXOFpsRkxrqu4upNnEKm1oRZ_SG1yJB9QVh=VJZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 12:58:48PM -0700, Linus Torvalds wrote:
> On Thu, Apr 9, 2020 at 12:56 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > We should probably give Stephen a cc here ...
> 
> Heh. I already did, but then that got broken because Andrew had lost
> that part of the thread and the discussion re-started.
> 
> So Stephen was already cc'd for my original request to have linux-next
> kick things out aggressively.
> 

Well, if (for example) we look at
"linux-next test error: WARNING: suspicious RCU usage in ovs_ct_exit"
(https://lkml.kernel.org/lkml/000000000000e642a905a0cbee6e@google.com/),
it was sent to the maintainers of net/openvswitch/ where the warning occurred.
It was then ignored.

Would it help if bugs blocking testing on linux-next were Cc'ed to
linux-next@vger.kernel.org, so that Stephen could investigate?

FWIW, the issue of "syzbot report sent and ignored for months/years" is actually
a much broader one which applies to all bugs, not just build / test breakages.
There are tons of open bugs on https://syzkaller.appspot.com/upstream which are
definitely still valid (sort by "Last" occurred).  Long-term, to fix this we
really need syzbot to start sending reminders.  But first there's work needed to
make the noise level low enough so that people don't just tune them out.

- Eric
