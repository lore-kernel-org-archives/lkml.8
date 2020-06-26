Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67543C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACCC20773
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593185110;
	bh=ZGX/YTzUYfouZvqtpZFc4AkbZkT9J2f7pysPMXpHv8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dxuG0jZyHK+GB4EfQViwkv4YFuWhL3wYvcqAvYHtny4eN3279LoPGFMNngExpW1qL
	 Z68KBgTkGTYl33q86CDk5JySy0bOcrF7AIaCFp3VOhWuba9Cm656a2rUHTlnJcKRA2
	 WVqDH4viB7OBzdh5Ay15gygqvAUcTWctEE/y4k1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgFZPZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgFZPZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:25:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBCD620773;
        Fri, 26 Jun 2020 15:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593185108;
        bh=ZGX/YTzUYfouZvqtpZFc4AkbZkT9J2f7pysPMXpHv8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a62ASZsrpfXTGUx2r8u1taukgGI0khKEJNS+rEgjrH/vIrfrxzfJ4RdzftqY2Eo+H
         3nzVmRNzPlkP2k36HAux6s9VTW2Q7xSjcY5eIU10Fa45h74wohXKYBS8J//uefbG+x
         SWCn3tBrRBQob/9vcCNZab8bhYCbQ3xjLaUGPf8k=
Date:   Fri, 26 Jun 2020 17:24:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes pull request for kernel 5.8-rc2
Message-ID: <20200626152450.GA1417020@kroah.com>
References: <20200624115539.GA8680@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624115539.GA8680@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 02:55:39PM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This pull request contains important bug fixes for the GAUDI code that was
> just merged. Details are in the tag message below.
> 
> Thanks,
> Oded
> 
> The following changes since commit 8c289ea064165237891a7b4be77b74d5cba8fa99:
> 
>   mei: me: add tiger lake point device ids for H platforms. (2020-06-23 07:55:47 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-06-24

Pulled and pushed out, thanks.

greg k-h
