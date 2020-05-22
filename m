Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4CFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23032072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590152996;
	bh=uWs+pQLbB3O1kljlpnyCJVrMVYmgPf/+2jg/zjG1YXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yi+ydo3kJa6p707PIuo4nhZVjOIqEBC1a/F2cV1nZ1NYG6WCx+jcTxtnmUA+VfCUL
	 upgrB6qtsC94xu9XfM3bDrwFq6TuoONdHVF2CbwYhDrlA5vnK7koiijMjGHulHKliZ
	 bNnq6mCc2a9pHEIkXoKLiKiLB6rasrTe3uY5arzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgEVNJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 09:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbgEVNJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:09:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4EDB206B6;
        Fri, 22 May 2020 13:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590152995;
        bh=uWs+pQLbB3O1kljlpnyCJVrMVYmgPf/+2jg/zjG1YXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpVcay8sgfxElSsC/TApY5pXzvtyUilTjrTEyyULITkIqO0fHOSuN6S+pWvdKG7ob
         Dc4Yt0BalykH3ER4jAGlImA6IM9XTh5fjysu+kQENqmYSzSNKenlRj1abaKPt5KD4I
         6BtdqmqGWGNoUFAEXtbslwrwTNcJnNUgBiUet2so=
Date:   Fri, 22 May 2020 15:09:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mircea Caprioru <mircea.caprioru@analog.com>,
        linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        kbuild test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] mux: adgs1408: Add mod_devicetable.h and remove
 of_match_ptr
Message-ID: <20200522130951.GA1629195@kroah.com>
References: <20200520120122.67528-1-andriy.shevchenko@linux.intel.com>
 <20200522125215.GE1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522125215.GE1634618@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 03:52:15PM +0300, Andy Shevchenko wrote:
> On Wed, May 20, 2020 at 03:01:22PM +0300, Andy Shevchenko wrote:
> > Enables probing via the ACPI PRP0001 route but more is mostly about
> > removing examples of this that might get copied into new drivers.
> > 
> > Also fixes
> >   drivers/mux/adgs1408.c:112:34: warning: unused variable 'adgs1408_of_match
> > as has been reported recently.
> 
> Maybe Mark or Greg can take this?

$ ./scripts/get_maintainer.pl --file drivers/mux/adgs1408.c
Mircea Caprioru <mircea.caprioru@analog.com> (supporter:ANALOG DEVICES INC ADGS1408 DRIVER)
Peter Rosin <peda@axentia.se> (maintainer:MULTIPLEXER SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

Not me!

