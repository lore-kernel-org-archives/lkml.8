Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E403C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726952465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579022882;
	bh=zB8Tex21D7G2o4vwjaqh+wZVt5DqD++8sxupU9BOFUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DT214llOPAi4fr07d9qKDOh5fFppxoMvFu2dMYcvXO9q2kSze+WfNzAhzR24/nHNm
	 XcIIP2+cK4MEo//TXcJK5Gp1+ROuOPKnLyWZRipuC/9TAkcFx9JFNHB8WbHL69BeE/
	 y9ha8gXwBDExrDLJKenUYtKwepStvxn4onpMuorA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgANR2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgANR2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:28:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1992F2075B;
        Tue, 14 Jan 2020 17:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579022880;
        bh=zB8Tex21D7G2o4vwjaqh+wZVt5DqD++8sxupU9BOFUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CllTOUuTl2XVsEERqQWDQhQ3c0XwQ39nXK1Wru5mIrCrp60MbrXQupMF4leJrLSsZ
         4oYAci5Udel0Ekr+bF7gWMoDTohKchBGhi4XrY+qLMb1Oztdy05RUhjOsPN5YbKePt
         rs+oHZNAdJGZTEjNlqSNi9D5yWroegPO7sEGTw8k=
Date:   Tue, 14 Jan 2020 18:27:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tty: baudrate: Synchronise baud_table[] and
 baud_bits[]
Message-ID: <20200114172756.GA2052011@kroah.com>
References: <20200114170917.36947-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114170917.36947-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 07:09:17PM +0200, Andy Shevchenko wrote:
> Synchronize baud rate tables for better readability.

"Synchronize"?  With what?  Why?  I'm all for cleaning up code, but this
just seems totally gratuitous.

We have whole serial drivers with _THOUSANDS_ of checkpatch issues, and
this is bothering you?  :)

greg k-h
