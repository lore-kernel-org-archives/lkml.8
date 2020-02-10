Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49564C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7F520714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581347957;
	bh=JqaNMooa6dE5vSnfD9rwkvCtggIprvOdi7XG448QR40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v1Qc2anajUUW3ztkrv5hU9T2pOqt6FAsT3AytkdocNkcdMXdkBUScNsHd8/8FJVFE
	 TD0gmYv+O3l/6qbtFa4v//1haeOSDe9EjDXEc74taruccW+HlqR5FfvejDNcCf2qzD
	 vfX3NgjqY36Q3uKnu+HyD0K4s85wFqibuRqCxFgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgBJPTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:19:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbgBJPTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:19:16 -0500
Received: from localhost (unknown [104.132.1.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D359206ED;
        Mon, 10 Feb 2020 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581347955;
        bh=JqaNMooa6dE5vSnfD9rwkvCtggIprvOdi7XG448QR40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtjiMHXEg2E9MoB5ocWMybjprlQPDyTnSWglv3Rx7JV2pDWQJZX3Yxhj7FEyHIUZ9
         sRup8fP/LSYmY6WQoxcKADmXbUnNnhGeGhtKvWe8/3qRfPFz84N7KkJqmlfKDHtlss
         gaipYqNj01BwFElHx9vdrfdwKNHkUlzmlPmrwkTI=
Date:   Mon, 10 Feb 2020 07:19:15 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6] powerpc: powernv: no need to check return value of
 debugfs_create functions
Message-ID: <20200210151915.GA686798@kroah.com>
References: <20200209105901.1620958-1-gregkh@linuxfoundation.org>
 <20200209105901.1620958-6-gregkh@linuxfoundation.org>
 <CAOSf1CEKwjDkp-=SMjmJfQirxdGCkadougZbdDS6FK1muNNCZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CEKwjDkp-=SMjmJfQirxdGCkadougZbdDS6FK1muNNCZw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 02:01:53AM +1100, Oliver O'Halloran wrote:
> On Mon, Feb 10, 2020 at 12:12 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> 
> For memtrace debugfs is the only way to actually use the feature. It'd
> be nice if it still printed out *something* if it failed to create the
> files rather than just being mysteriously absent, but maybe debugfs
> itself does that. Looks fine otherwise.

No, debugfs will only spit out an error message to the log if a
file/directory is attempted to be created for an already present
file/directory.

For other failures, no error will be printed, other than the normal
lower-level "out of memory" issues that might rarely happen.

thanks,

greg k-h
