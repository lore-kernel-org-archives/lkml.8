Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3524C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFDB220708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589216087;
	bh=+cmhZ7rQWxtakkUxWzeTlbXAzXea4SDhu3uYx57iTHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OlTnIfRxu5Tn7lZ+ym2d9vvcXXP8Sgj3nc8P75AI3doRBVhhqtPkeMq5RA/UAc0yI
	 tE7bBgQgmbJntOGrDH4SoL8VJISCrJDdr6rojpRLrdTX+LIh2sWGQbI7gpCc1afs7D
	 SAMmod4P8VWGD7HC7FjCY3tfRA/4WjHyU47FrOJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgEKQyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgEKQyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:54:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1426C206D7;
        Mon, 11 May 2020 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589216086;
        bh=+cmhZ7rQWxtakkUxWzeTlbXAzXea4SDhu3uYx57iTHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RE1b8HCSu0+7YpG60Tc9Bb0jmlk6yhVnexlAMOxMKr9XGmpifIMZopnGPqxq1fMFb
         nnRleX6q+9Yr/VnHQqpSdnoC8FLbrkvW+6elJMXsxhpzjY7JKtBrwrHy7Pvtq70Jbl
         qNA2SH6Yb3eZZEz4KrdpVzJE+9UlZf1HnWLgwm8k=
Date:   Mon, 11 May 2020 17:54:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Elver Marco <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH -next v2] locking/osq_lock: annotate a data race in
 osq_lock
Message-ID: <20200511165441.GB23081@willie-the-truck>
References: <20200511155812.GB22270@willie-the-truck>
 <D8F8F41A-F785-4E17-83CE-4101137ADC5B@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8F8F41A-F785-4E17-83CE-4101137ADC5B@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 12:44:26PM -0400, Qian Cai wrote:
> 
> 
> > On May 11, 2020, at 11:58 AM, Will Deacon <will@kernel.org> wrote:
> > 
> > I'm fine with the data_race() placement, but I don't find the comment
> > very helpful. We assign the result of a READ_ONCE() to 'prev' in the
> > loop, so I don't think that the cpu_relax() is really relevant.
> > 
> > The reason we don't need READ_ONCE() here is because if we race with
> > the writer then either we'll go round the loop again after accidentally
> > thinking prev->next != node, or we'll erroneously attempt the cmpxchg()
> > because we thought they were equal and that will fail.
> > 
> > Make sense?
> 
> I think the significant concern from the previous reviews was if compilers
> could prove that prev->next == node was always true because it had no
> knowledge of the concurrency, and then took out the whole if statement
> away resulting in an infinite loop.

Hmm, I don't see how it can remove the cmpxchg(). Do you have a link to that
discussion, please?

Will
