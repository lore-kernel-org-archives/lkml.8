Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B10C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0422253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579621368;
	bh=XFxVdvoPAuJ1iwI987V6w4EhmdrR0YxBJZYSGNu2ljE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZLLarddSeAqTCyK+LsXMX49pkml6YyYKg9LSokbabPrQt5RUNnzyhldcBHQHaUUaT
	 RADEG2Gq2w8TA8GZOMKt/IsO4CqTQmJiyrCnv/qDTO581IXDrBfNIisiussBoglb0L
	 PGH2GXxlTB/Popsq1QOTf23Zucx/ggnYP/GuxD8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAUPms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:42:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgAUPmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:42:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAEC6207E0;
        Tue, 21 Jan 2020 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579621367;
        bh=XFxVdvoPAuJ1iwI987V6w4EhmdrR0YxBJZYSGNu2ljE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x/tQI8lJofEWRICGoADMClZDO4s5h3meL46SM30o72NslG0+c00XU00B5a4sfczEG
         Yp/NiX5Ao0K38QGigKcNMhNqgh5tsF6ALo9iLinCiB1LVr260lX5hHdk9ZWWWh6Mu3
         fmCtibKLMFcllf39Ri4O5GzPkuJ4HiAFosZXjVPY=
Date:   Tue, 21 Jan 2020 16:42:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question about dynamic minor number of misc device
Message-ID: <20200121154245.GB588670@kroah.com>
References: <CAFH1YnOad7aVjoX_PR6mLqT=pXQjpBW9ZDHkKYzNkeistFkA4A@mail.gmail.com>
 <CAK8P3a3DwaZnRff7CCrJoSxP_MeVUn1S6nRd+hb5rHnv9dBgLQ@mail.gmail.com>
 <CAFH1YnMDL1gBNT4vr+C=eGGoCYJvkVDnoXUVN8OL9Xs3668Z+Q@mail.gmail.com>
 <CAK8P3a0aFr546fF+=LDm3rwZ-sK-xC8VLYTZjOEn+o6fVixRHg@mail.gmail.com>
 <20200120221323.GJ15860@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120221323.GJ15860@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 05:13:23PM -0500, Theodore Y. Ts'o wrote:
> > - FLASH_MINOR move and rename to avoid conflict
> > - change speakup to dynamic minors
> > - support for high dynamic minor numbers if you are really motivated
> >   (probably nobody needs these)
> 
> Are we sure that reassigning minor device number conflits isn't going
> to break systems?  Especially those on random, older, architectures
> they might not be using udev.

Note, I do not think udev has been in charge of creating /dev/ nodes for
well over 10 years now, that is up to devtmpfs.

thanks,

greg k-h
