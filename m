Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09513C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC07206DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594060551;
	bh=QElTtoqqXckuhA9BZOgcYSdLXXIBOg7PR5IagnhwDho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zfclfKjvdXbMf/3wNvcP1//yZXRUkjfBk9pEfQzLVReyMFP8TzBg3QGVdBvukG4gX
	 1jLcxz7V46xENiAvm1dMqRNUqHpFTMeC60NIpupns8xBlw5jO79Kt16OjVEEuJL1Oq
	 xabFy+sSHCgCoilOzKX4KVGdDEYiM8VUlGeARufA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgGFSfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729713AbgGFSfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:35:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 007982064C;
        Mon,  6 Jul 2020 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594060549;
        bh=QElTtoqqXckuhA9BZOgcYSdLXXIBOg7PR5IagnhwDho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VujbM6QUizcvQdgwE+TRzHSqSJ0FHj+o1kzk/zYc4jni+539xqlVorsw42yU86v/1
         fj31wKt7x318hyaDbrCvT9nj6jWUPko7rLCC9SURvyoUSijZsWNZD5QNo9NlOaG4ib
         xdY1aWUQF/pAYNyJsZqgjV6qCWWfW3H+OZPzglKM=
Date:   Mon, 6 Jul 2020 19:35:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matt Turner <mattst88@gmail.com>, kernel-team@android.com,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Message-ID: <20200706183542.GB23766@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
 <20200702072301.GA15963@willie-the-truck>
 <20200706160023.GB10992@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706160023.GB10992@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 05:00:23PM +0100, Dave Martin wrote:
> On Thu, Jul 02, 2020 at 08:23:02AM +0100, Will Deacon wrote:
> > On Wed, Jul 01, 2020 at 06:07:25PM +0100, Dave P Martin wrote:
> > > Also, can you illustrate code that can only be unsafe with Clang LTO?
> > 
> > I don't have a concrete example, but it's an ongoing concern over on the LTO
> > thread [1], so I cooked this to show one way we could deal with it. The main
> > concern is that the whole-program optimisations enabled by LTO may allow the
> > compiler to enumerate possible values for a pointer at link time and replace
> > an address dependency between two loads with a control dependency instead,
> > defeating the dependency ordering within the CPU.
> 
> Why can't that happen without LTO?

It could, but I'd argue that it's considerably less likely because there
is less information available to the compiler to perform these sorts of
optimisations. It also doesn't appear to be happening in practice.

The current state of affairs is that, if/when we catch the compiler
performing harmful optimistations, we look for a way to disable them.
However, there are good reasons to enable LTO, so this is one way to
do that without having to worry about the potential impact on dependency
ordering.

Will
