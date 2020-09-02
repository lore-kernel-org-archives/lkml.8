Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF87C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D8720773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599056511;
	bh=gM9T3vWDXP+R8rA9KXPhmDwJIIC+hPMMGQ6hZ5o8Ui8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jGYfHGcHrd08YE2AFp5DfLwber/EKFZDntnDrrd55Pl5vF6sY92CYdN+QFSk3ueGd
	 KXux3Em1VTBccVBoldn5z2i64SzeyIlMyG8GQ1zvCnm57C+4P8My5r1KciKAGzthwo
	 99EVHzyVEqS5XhEv6IaZ+viyzyV/8GhM8yU46fWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgIBOVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIBOJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:09:38 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B9CC2078E;
        Wed,  2 Sep 2020 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599055775;
        bh=gM9T3vWDXP+R8rA9KXPhmDwJIIC+hPMMGQ6hZ5o8Ui8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0BnISZH8FpmdrWOwzjHoRStWKDv4AA9A++fzHBjKhNv18807g3uusiJeoMNKQym3J
         aANb53n4A5ZzhOj8pX8kOwQawqHjR3Ky0y0Tx9uFTjUs5Ze3ogq6ZSPSg15x2oq/ep
         gOHSkPNqUBUs+57a+6ZMCjWAEmYnyu6zZDSvJWEI=
Date:   Wed, 2 Sep 2020 16:10:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Antoni Przybylik <antoni.przybylik@wp.pl>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: gdm_tty: replaced macro with a function
Message-ID: <20200902141000.GA2020271@kroah.com>
References: <20200902132419.61220-1-antoni.przybylik@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902132419.61220-1-antoni.przybylik@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:24:19PM +0200, Antoni Przybylik wrote:
> This approach is more elegant and prevents some problems related to
> macros such as operator precedence in expanded expression.
> -------------------------------------------------------------------
> Changed return type to bool and removed inline sepcifier.

What is this here for?

Please read the documentation for how to properly version patches, it
should be in the submitting patches file somewhere...

thanks,

greg k-h
