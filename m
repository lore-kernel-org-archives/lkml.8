Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0167CC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98E6214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580437118;
	bh=pZJmJTyhSz18bLrQ2/dhn2g7VLznLenFg9l2cjRSjBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AzT12XXr2BdtOi2lP2N6Vjk2L3Y2XZUQd/AwErJgx5oMOs1aV5se+PzDbWldHy2Cd
	 Tq0OUL0vDHfrmXgBFzzawTsdwp08ZOm5tjAeziPsvtjwxTSpoxIlbfmSkvo/XX1Kfj
	 oNo1NgNGRPdgMkhFsR/s4jZH9WIN3BJ5ZsdQ08/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgAaCSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 21:18:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbgAaCSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:18:37 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E478206F0;
        Fri, 31 Jan 2020 02:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580437115;
        bh=pZJmJTyhSz18bLrQ2/dhn2g7VLznLenFg9l2cjRSjBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eae+eNxY53/34/Xj41ogh1eNWzPt3CuS3icd2Nnz4wsszfgQfFIHkZgGlqlGnlRiV
         jfJ+fgE+ng/iNr0jgOoDzmUhwbRp9MRk4ypKv1emeGlge5LUq4OwwNZJT52M7WCYGp
         x60f2KmIEGy8npPLiemBH9VcUgSAeWQNFIaC9JR4=
Date:   Thu, 30 Jan 2020 18:18:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Qian Cai <cai@lca.pw>, Matthew Wilcox <willy@infradead.org>,
        dennis@kernel.org, tj@kernel.org, Christoph Lameter <cl@linux.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/util: fix a data race in __vm_enough_memory()
Message-Id: <20200130181834.633c201c7d0a2638aacbc7ba@linux-foundation.org>
In-Reply-To: <CANpmjNNr_Kq6Do+UYrR-3aF0sO3++psUfN7Ppt8mmgcF5ynzrA@mail.gmail.com>
References: <20200130042011.GI6615@bombadil.infradead.org>
        <1135BD67-4CCB-4700-8150-44E7E323D385@lca.pw>
        <CANpmjNNr_Kq6Do+UYrR-3aF0sO3++psUfN7Ppt8mmgcF5ynzrA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 13:35:18 +0100 Marco Elver <elver@google.com> wrote:

> On Thu, 30 Jan 2020 at 12:50, Qian Cai <cai@lca.pw> wrote:
> >
> > > On Jan 29, 2020, at 11:20 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > I'm really not a fan of exposing the internals of a percpu_counter outside
> > > the percpu_counter.h file.  Why shouldn't this be fixed by putting the
> > > READ_ONCE() inside percpu_counter_read()?
> >
> > It is because not all places suffer from a data race. For example, in __wb_update_bandwidth(), it was protected by a lock. I was a bit worry about blindly adding READ_ONCE() inside percpu_counter_read() might has unexpected side-effect. For example, it is unnecessary to have READ_ONCE() for a volatile variable. So, I thought just to keep the change minimal with a trade off by exposing a bit internal details as you mentioned.
> >
> > However, I had also copied the percpu maintainers to see if they have any preferences?
> 
> I would not add READ_ONCE to percpu_counter_read(), given the writes
> (increments) are not atomic either, so not much is gained.
> 
> Notice that this is inside a WARN_ONCE, so you may argue that a data
> race here doesn't matter to the correct behaviour of the system
> (except if you have panic_on_warn on).
> 
> For the warning to trigger, vm_committed_as must decrease. Assume that
> a data race (assuming bad compiler optimizations) can somehow
> accomplish this, then the load or write must cause a transient value
> to somehow be less than a stable value. My hypothesis is this is very
> unlikely.
> 
> Given the fact this is a WARN_ONCE, and the fact that a transient
> decrease in the value is unlikely, you may consider
> 'VM_WARN_ONCE(data_race(percpu_counter_read(&vm_committed_as)) <
> ...)'. That way you won't modify percpu_counter_read and still catch
> unintended races elsewhere.
> 

That, or add an alternative version of per_cpu_counter_read() to the
percpu API.  A very carefully commented version!

