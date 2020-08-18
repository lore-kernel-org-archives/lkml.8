Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF61C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FF9F20786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597760808;
	bh=v9wmnCwZq0StdpyeVbz/jpUx2XM7rEEGCM62t/WKJyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ma/iz4umdUptWXpqVX60Vz2xX8fMpjP9b3Xypd9dNbzVtW1az23v+O/GPtDsq9QxW
	 YD4qoZdlJmLzwCt+bq9cWGUAdtqHmTFGEoXLY7B9/pSUQxSsfFOLVjuNPJgGaNCid9
	 rDwGLM2PXETIxv1xR1JDYbB843xOm+zyJPeT8Lew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgHRO0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgHRO0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:26:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0849420786;
        Tue, 18 Aug 2020 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597760803;
        bh=v9wmnCwZq0StdpyeVbz/jpUx2XM7rEEGCM62t/WKJyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jf5UOYbhgw+HeH7fm80qH8g2TIEWJwBDXi1tq+w5sxCZxE6ylbB5bcWNRqaWnsfGs
         4ZiPAdVmVIm7Vk+GQEJqJ64+5k/Btm1RLbK5bkfmCDhh4rdCHC2OM1bzdDIVUmeEHT
         +DcsdbGIWIeUBExsz3ayrfFHzrLgZ2uaSccLxZiA=
Date:   Tue, 18 Aug 2020 16:27:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomer Samara <tomersamara98@gmail.com>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Riley Andrews <riandrews@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Hridya Valsaraju <hridya@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 1/4] staging: android: Replace BUG_ON with WARN_ON
Message-ID: <20200818142707.GA626703@kroah.com>
References: <cover.1597602783.git.tomersamara98@gmail.com>
 <fd55c53cb20c4887a87c05fffa28c28a740cd314.1597602783.git.tomersamara98@gmail.com>
 <20200818141106.GB562377@kroah.com>
 <20200818141940.GA357037@tsnow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818141940.GA357037@tsnow>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 05:19:40PM +0300, Tomer Samara wrote:
> On Tue, Aug 18, 2020 at 04:11:06PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Aug 16, 2020 at 10:23:25PM +0300, Tomer Samara wrote:
> > > BUG_ON() is replaced with WARN_ON at ion_page_pool.c
> > 
> > Why?
> > 
> > > Fixes the following issue:
> > > Avoid crashing the kernel - try using WARN_ON & recovery code ratherthan BUG() or BUG_ON().
> > 
> > Ideally you can get rid of WARN_ON() too, right?
> > 
> > Many systems run in panic-on-warn mode, so this really does not change
> > anything.  Try fixing this up properly to not crash at all.
> > 
> You mean by that to just remove the WARN_ON and leave the condition the
> same?

Or fix the problem that could ever cause this check to fire.

thanks,

greg k-h
