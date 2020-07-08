Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C38C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA3720786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594222745;
	bh=x84iBjiieL3w+F4vkQ5MJ2yGtH9rgv6udppvVcFiFJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RUm7nb2H9LZWvtLICH+wwHyruhwUpdiCdwUOx91okkuXsrv3YvMApTo2xDEW9xlY0
	 8oOcxofbWUJ5DI4jXsctDCcj+svAQnqw1u5MbDXRLEy8mvndaWN6ukNdy/XgyaRPW/
	 lTHwkE2PwMgF9a2MZlcqWIgrHW05LBMpV1hgEFsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgGHPjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgGHPjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:39:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A40F5206DF;
        Wed,  8 Jul 2020 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594222743;
        bh=x84iBjiieL3w+F4vkQ5MJ2yGtH9rgv6udppvVcFiFJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uNLNkZcL+cR8Xh2dZhDosU6+u1/iGUa4g0yKVur/jGZXPx2qI9I0VnNEvuHCsJO7z
         bRkf2i2AF7YAd3e3WFpIatDb6ca5xK0yj6ICQbKVTpQhA9tQfN02E0O/APl76S0EvR
         SJRBE2wCCkbKuleYu3Dj/5g8ITLOXw+b+wp56jbw=
Date:   Wed, 8 Jul 2020 17:38:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org
Subject: Re: Vectored syscalls Was: [PATCH 0/3] readfile(2): a new syscall to
 make open/read/close faster
Message-ID: <20200708153859.GB715257@kroah.com>
References: <3ADE6606-6572-4D7D-BB8F-9286B368DF93@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ADE6606-6572-4D7D-BB8F-9286B368DF93@exactcode.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 05:16:41PM +0200, René Rebe wrote:
> Hey there,
> 
> maybe instead of this rather specific, niche readfile syscall, would it not be beneficial
> to allow issuing any group or bundle of several arbitrary system calls so this could also
> be used to speed up other, more demanding high performance applications that need
> a bit more than just readfile()?

Why not just use io_uring for that for I/O calls, that's what it is
designed for.

More "generic" syscall batching always ends up falling down in
complexity anytime anyone tries it.  Good luck!

greg k-h
