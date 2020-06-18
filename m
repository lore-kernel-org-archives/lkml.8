Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB02C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE5A217A0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592466574;
	bh=ibQowcpRzi2x8YPw80J2WJshf2seNC5tdBtJjm5PzI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I1i/9Xm+eiEfStaTRNAsfyjs8oXnP4tsOauxds+BjRuYMLyh/TZpD+IflbQFgYCfz
	 dEicFV9zzOc30ThdnmegN33CwtmJx8hGIAhM8S6nTKlAlzpz84mlyp8jcnwsXTY8ty
	 /IA7BKQYdqiaGDiZ5n1IlBtFmorVQ1ELGjnrXkuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgFRHtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgFRHtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:49:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A0C32166E;
        Thu, 18 Jun 2020 07:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592466571;
        bh=ibQowcpRzi2x8YPw80J2WJshf2seNC5tdBtJjm5PzI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8KN03xnv/ctc/iYQwbIHSiYIxPTFGKl+ydkKjqiJVpBfjSPxIvYyQ9GDvPcR2d55
         0cwTariGM9z6Q1uhJ8I/ReYD3ZVcWydA6wM/FOH1viaLqYuw+t0tkEHXT+PxBBEUL1
         3dCxg8ieQ/f4oUeL9I9WSPNfuUnUeABcPqXz/kRE=
Date:   Thu, 18 Jun 2020 09:49:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tyler Shetrompf <tyler@shetrompf.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: comedi: comedi_fops: fixed a blank line coding
 style issue
Message-ID: <20200618074924.GA187169@kroah.com>
References: <20200610195923.GA12602@archlinux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610195923.GA12602@archlinux.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 07:59:23PM +0000, Tyler Shetrompf wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Tyler Shetrompf <tyler@shetrompf.com>
> ---
>  drivers/staging/comedi/comedi_fops.c | 3 +++
>  1 file changed, 3 insertions(+)

Someone else sent this same patch 5 days before you did:
	https://lore.kernel.org/r/20200605032140.31287-1-kambojdivyansh2000@gmail.com

Sorry,

greg k-h
