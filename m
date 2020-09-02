Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A39C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9A920826
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599027824;
	bh=pxZT88PpiT+3Oan+fiGYB4sSuMb4oj05CTjWzPw4mh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XVRBbFFmX4wUxfNYat4sCLCNM4nu2VPbbZoDu+jLxwbait3mWU6Laq8WFRGVh+gnc
	 7rcroGzoa8dVtWdUZo0LeFyMLuVQf4vv+idfAUT6eN4UThWjvOZT1/yptfzvRr98Gb
	 gwtxGPdxWEXLneV8wowJPs1wRFnH+hEhvUZaTWaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgIBGXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBGXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:23:41 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A11D207EA;
        Wed,  2 Sep 2020 06:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599027821;
        bh=pxZT88PpiT+3Oan+fiGYB4sSuMb4oj05CTjWzPw4mh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2oUIRckydq+3wIS7EpSBv3qBxhrbCstajKk9cxp2MESgK6/DCpkMmGDJcFNunNWgX
         RWVsaZEBs7lAbs1g/lXUvipNyTmxEZrxsIEdU9xoCgzOE/xGiUwAm0ULZ0L9MoyaMT
         uzBkOsnXThan4aqioLZFF8CCKLR9OZqJ9YnU6C+8=
Date:   Wed, 2 Sep 2020 08:23:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Antoni Przybylik <antoni.przybylik@wp.pl>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: gdm_tty: replaced macro with a function
Message-ID: <20200902062337.GB142357@kroah.com>
References: <20200901201626.75405-1-antoni.przybylik@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901201626.75405-1-antoni.przybylik@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 10:16:26PM +0200, Antoni Przybylik wrote:
> This approach is more elegant and prevents some problems related to
> macros such as operator precedence in expanded expression.
> 
> Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

If this is a new version of a previously submitted patch, please version
it (is this v2, or v3 or something else?) and put below the --- line
what changed from the previous versions, so we have a chance to know
what patch to take and which to ignore.

Please fix this up and resend.

thanks,

greg k-h
