Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEF0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D389C20781
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593558351;
	bh=7wvKYJjHegtiIXQCxjX/XdD8dbA7iI59ejeA+RBNcZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=B6PJFm2ZK+ZY8kCmHkEnK925ZMEtJATv1ESxMcdol3SWcGTHFDx51Y9oUUA+EV6z9
	 h0JPUSGp3sEn9AHOJjiCf4ivOHxTqxJPfm3ZJv5LNs5G7+FldrVt2ZkWOOdp3HyBO8
	 oozV0sPA/j2hsonjr6CJ4VJ0qsrcjDBep6rdwTxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgF3XFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgF3XFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:05:50 -0400
Received: from X1 (071-093-078-081.res.spectrum.com [71.93.78.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37D0E20771;
        Tue, 30 Jun 2020 23:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593558349;
        bh=7wvKYJjHegtiIXQCxjX/XdD8dbA7iI59ejeA+RBNcZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DDUzWrCnPY63PbbQqYUZI8eKXAHLsP8zU/LU/eNbhO6Sme8sE1IzsrtZ/ZW9M1SzL
         kbAeXeXHtqp5PXiqPO5p3hMrunVLSDh1c2mFKiW8j3ojyGrczTue4/ANl/0pCpSx+p
         eqfvDP6Fzig4QnY395uv/ApFiMVLqz52piRtx+jA=
Date:   Tue, 30 Jun 2020 16:05:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 00/26] mm: Page fault accounting cleanups
Message-Id: <20200630160548.fc8d1f93148e74e544850bf3@linux-foundation.org>
In-Reply-To: <20200630211155.GA40675@xz-x1>
References: <20200630204501.38468-1-peterx@redhat.com>
        <20200630211155.GA40675@xz-x1>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 17:11:55 -0400 Peter Xu <peterx@redhat.com> wrote:

> On Tue, Jun 30, 2020 at 04:45:01PM -0400, Peter Xu wrote:
> > v4:
> > - rebase to linux-next/akpm
> > - picked one more r-b
> 
> I fixed some stuff in the send scripts but definitely broke something else on
> the chaining of the messages.  Andrew, please let me know if you want me to
> resend...  Sorry for that.

Well, the words

: Since v2 changed quite a lot from v1, changelog is omitted, and I also
: didn't have a chance to pick up any r-b in previous version.  I really
: appreciate anyone who has looked at v1.  V1 for reference:

make me think "not yet".  But this patchset is v4, so all confused.

I'm thinking we give this v4 a week for people to check it over, gather
up the revews and acks, incorporate the change suggested by David, redo
and double-check the cover letter then shoot for a v5?
