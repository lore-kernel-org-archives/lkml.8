Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF57C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBFE22B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598532118;
	bh=8/Uo/bTKsupSIoAgh+tXShD0dKwcGgGzU0K627XFrFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LUHA3kRnU1Pw2nuQl/NM9LhRFknTepM85xx9JmMv8PC9FhOp84OUEffbL3vGkTM+z
	 cIucW8+KkzhQJEfgn3R5ux7bgRqZs3gCropIo79JpaY3XG99euOv2CTNfk8EO9SAuH
	 oZxLtHKDYHF0mo6TtiGfOTLMipz0TCR4uJtJY2xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgH0Mk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbgH0MPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:15:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D921C207CD;
        Thu, 27 Aug 2020 12:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598530517;
        bh=8/Uo/bTKsupSIoAgh+tXShD0dKwcGgGzU0K627XFrFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PzKvfy1hGR/NN+N9EjNznIChtG5H44kvPSm86JsQGtfu+fceycAShj9VaBWI4C3D9
         jPsIp0d49ZuALDccnFbexxD5okRzl4CmBC4YPIdQzG3pswyiIvV4QcchFZsNHz/XWL
         87K3RFXizjXgfVf4XITuYOeAAOriC2BS/ltXc1gw=
Date:   Thu, 27 Aug 2020 14:15:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Stultz <john.stultz@linaro.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Tomer Samara <tomersamara98@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Riley Andrews <riandrews@android.com>,
        Arve Hj?nnev?g <arve@android.com>,
        Hridya Valsaraju <hridya@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v4 0/2] staging: android: Remove BUG/BUG_ON from ion
Message-ID: <20200827121531.GD417381@kroah.com>
References: <cover.1598023523.git.tomersamara98@gmail.com>
 <20200825064729.GA30014@infradead.org>
 <20200825065229.GA1319770@kroah.com>
 <20200827071654.GB25305@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827071654.GB25305@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 08:16:54AM +0100, Christoph Hellwig wrote:
> On Tue, Aug 25, 2020 at 08:52:29AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 25, 2020 at 07:47:29AM +0100, Christoph Hellwig wrote:
> > > On Fri, Aug 21, 2020 at 06:27:04PM +0300, Tomer Samara wrote:
> > > > Remove BUG/BUG_ON from androind/ion
> > > 
> > > Please just remove ion.  It has been rejected and we have developed
> > > proper kernel subsystens to replace it.  Don't waste your time on it.
> > 
> > It is going to be removed at the end of this year.  Why we keep it
> > around until then, I really don't know, but John and Laura have this as
> > the plan.
> 
> It keeps getting in the way of various projects and has no path
> going upstream properly.  Seems weird to keep this dead and not all
> that great code around.

In looking at the mess of ion changes that are currently in the AOSP
kernel tree (where android devices are pulled from), it looks almost
nothing like what we currently have here in the mainline kernel tree.

So if what we have here, today, is not of use to anyone who actually
wants to use this interface, why are we keeping it around?

John, why can't we just drop all of this code from the kernel today, and
then Android will keep their own copy for their next LTS release anyway.
It doesn't look like what we have here, and the merge issues it causes
is a pain (as I know from having to do them...)  So keeping this around
in-tree any longer feels pointless to me, and actively causes me, and
others, more work for no gain.

I'll go make a patch set to just drop this code now...

thanks,

greg k-h
