Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758E3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E012078C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589547271;
	bh=TotoL9YXsj+E4MwRDKyj3GbWs9IEi6m6QDbCpdIsCQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ze1aUgwYF7p8tYdkGZJZYr1jiroddm+n4+fghA9hZAoeqjl/ZwohtPYJrYrys6qo/
	 h05DXvAY4vnlfMlD/kQ0+wuIXY2BYC0Pav/pMcQdl03Ec5td9jMbbW9d5GV36ddny9
	 Gyl93B3UWsrTwSUffZKtn38ng/4bJeHNYvOh7JdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgEOMya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEOMy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:54:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4FF420787;
        Fri, 15 May 2020 12:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589547268;
        bh=TotoL9YXsj+E4MwRDKyj3GbWs9IEi6m6QDbCpdIsCQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/zXyDtwPlnFMqEQDPslfgMp9FZncwD5Y623ZF6geSYAJDxstXP18RdhxSzkoQv5C
         +2UlOmeRnhVgPrsdSsTLzBIoBlufLx5x7KT25dXY3Q0bvDa0jwMOPg8fBIZblClI6G
         YRoRBwIqyER8H2ya1QhRxnTyos5uf8y+IjyLsbZs=
Date:   Fri, 15 May 2020 14:54:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 01/11] tty/sysrq: alpha: export and use
 __sysrq_get_key_op()
Message-ID: <20200515125417.GA1928406@kroah.com>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:43:41PM +0100, Emil Velikov wrote:
> Export a pointer to the sysrq_get_key_op(). This way we can cleanly
> unregister it, instead of the current solutions of modifuing it inplace.
> 
> Since __sysrq_get_key_op() is no longer used externally, let's make it
> a static function.
> 
> This patch will allow us to limit access to each and every sysrq op and
> constify the sysrq handling.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> ---
> Please keep me in the CC list, as I'm not subscribed to the list.
> 
> IMHO it would be better if this gets merged this via the tty tree.

All now taken, thanks!

greg k-h
