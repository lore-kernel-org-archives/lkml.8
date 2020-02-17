Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6B2C3B185
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BD720725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581937130;
	bh=KAecKzbksm362LyseZ4il2faFrv8yGbQSnxM6r1Jf/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qF0Empn+458/x2+DSMj4igFgROiMt6RSQbFmC5VV8CZBb/jRt0a5MJF7Zkn51aB6N
	 7LhYgA2engkKI1KThHabgVvk3cjgnbv8eeh+CbWZJ1EFXi9ztPBuOTn+TRn9lnRSk8
	 jfQJK3DW1WqELZZGzlRre7JV0HnAuiG6VZZsBmlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgBQK6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:58:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgBQK6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:58:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5085020725;
        Mon, 17 Feb 2020 10:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581937128;
        bh=KAecKzbksm362LyseZ4il2faFrv8yGbQSnxM6r1Jf/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LfCbwDLzLrQLg+RBz/whWsMceXTPO2g28iUWGE1z3mJx/uBE/eEKcSGIS3BXw4I92
         D+MI8XdZgw4xgZTnNvcK00AA1HJeYsjEsMfc/YQbDm9PzZRyBM5uDbZVpAFBPFh95p
         1p91ON79onHVjd+Znj/fZHMKS4tx9onyMyx1K5cw=
Date:   Mon, 17 Feb 2020 11:58:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.6-rc2
Message-ID: <20200217105846.GA95702@kroah.com>
References: <20200211092211.GA23598@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211092211.GA23598@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:22:11AM +0200, Oded Gabbay wrote:
> Hello Greg,
> 
> This is habanalabs fixes pull request for 5.6-rc2.
> It contains two important fixes for the reset code of the ASIC and another
> fix to reference counting of a command buffer object.
> 
> Thanks,
> Oded
> 
> The following changes since commit 95ba79e89c107851bad4492ca23e9b9c399b8592:
> 
>   MAINTAINERS: remove unnecessary ':' characters (2020-02-10 15:29:09 -0800)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-02-11

Sorry for the delay, now pulled and pushed out.

greg k-h
