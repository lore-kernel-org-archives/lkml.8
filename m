Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49836C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A8C20709
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595232150;
	bh=YWX0T0Km4CQxwzthmPHWk15E4G6K+rvEZicBswWqlQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KhRv4q6Pz2mcb+6vg/MibFm3/kuklXjVKt6T06GiPmSiQQvXyHsQHR5ICLjZYmACa
	 CIWBYPgxzj2HjXKSisN8v1juBkkV7SEHE1w7d84OsF7e7M69e1IF+WKoQMuidFYKwF
	 htDR+PVXjSzmB2L48ca/R4zgaolMrTAdqQBHc+Yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGTIC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgGTIC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:02:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E38720702;
        Mon, 20 Jul 2020 08:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595232148;
        bh=YWX0T0Km4CQxwzthmPHWk15E4G6K+rvEZicBswWqlQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0bBpJQWLUxeHEAVfDX+zZpddkA4SunlFzeU/0fuL0MYB9iyTUdVGZ+vUm3WAgMRT
         xTmYH5Tnsk7YwS1TNQvrmAUnSEBq6ln51Msby80CNavikEZAKqA9OZ8BZXX4zo4n/5
         YEw4xguk25vhBiwL3xW7YK8Cr8YiwFgXT6HkAUZg=
Date:   Mon, 20 Jul 2020 10:02:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes pull request for kernel 5.8-rc7
Message-ID: <20200720080238.GB553171@kroah.com>
References: <20200719061322.GA31592@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719061322.GA31592@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 09:13:22AM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This pull request is for 5.8-rc7 and it contains an important bug fix for
> possible out-of-bounds access error.
> 
> Details are in the tag message below.
> 
> Thanks,
> Oded
> 
> The following changes since commit b279b1fe5799cf653de3822ca253f5d21639d90a:
> 
>   Merge tag 'misc-habanalabs-fixes-2020-07-10' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus (2020-07-17 11:56:58 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-07-19

Pulled and pushed out, thanks.

greg k-h
