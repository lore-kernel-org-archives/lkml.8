Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9EBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 857692074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595955509;
	bh=eCkMT76O+xXbROm2ziLq2LEQ8IQGqoTiQPmsQE6GmSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F4EliJ0e2QIRXiZeGQhPymDBPdn7KJp7I5PprzwFdUClQGZuDBdYAn+jNYFwizKII
	 3HqmHslKJnmooQ6s8bkLlOs2M79rCxJa01r6zl3Be29AgqGLwgruJ4R0bA64L0Qvoq
	 +ak+CF7KxtzqvKEedpDC7N0bYjTu1BWL0deg5r6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgG1Q62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731673AbgG1Q62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:58:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD502053B;
        Tue, 28 Jul 2020 16:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595955507;
        bh=eCkMT76O+xXbROm2ziLq2LEQ8IQGqoTiQPmsQE6GmSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkLeWrMSP5SsQvlOglsFMOpx8DwH3ZewI0sb7ElO/NMoScbkZX3y6q6IpQ+9ai7HG
         MBuCCak3t9e8fWWzHEB2gMXerpDKrbJQ5WopWlPs6dohvcwOqzaptEonYk9ztUSE98
         0kMKtn5+ytWk3Z4IQj6LDv1JzAxyuvwAJFqe8ijw=
Date:   Tue, 28 Jul 2020 18:58:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dhiraj Sharma <dhiraj.sharma0024@gmail.com>
Cc:     devel@driverdev.osuosl.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        stern@rowland.harvard.edu, jrdr.linux@gmail.com,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: usbvision: fixed coding style
Message-ID: <20200728165820.GA42656@kroah.com>
References: <20200728143004.3228-1-dhiraj.sharma0024@gmail.com>
 <20200728145419.GA3537020@kroah.com>
 <CAPRy4h1Xs1JpQinnWm04dOi07Ch0RLL0U4Z5DDCKHmombXE0sA@mail.gmail.com>
 <20200728155311.GA4178776@kroah.com>
 <CAPRy4h2Zbw=QwJ7=0+FzGnK_o1esn2GTRSuv5ZE30Vu=Oj=x=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPRy4h2Zbw=QwJ7=0+FzGnK_o1esn2GTRSuv5ZE30Vu=Oj=x=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 10:13:22PM +0530, Dhiraj Sharma wrote:
> > As the bot said, only do one type of thing per patch, and "fix all
> > checkpatch errors/warnings" is not one type of thing.
> 
> So should I send a fresh patch with minimal fixes? instead of replying
> to this mail with [PATCH 01]

Why are you ignoring what Hans said?
