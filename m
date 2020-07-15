Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAE3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76588206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594821714;
	bh=/+c6GQhNx6ax1x+aHu7X8iXUbjiO1EdMOqPaNBADTgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V4/2wfyPtA9YV8s8C5iAW3MBnm5H1Wz8W+KxQ1uV88s0Z+VGoEhS4nEDIFEkzvcuw
	 7iJ/7tUjfyY5n5usyq4seb7g7JwpvoXm7dIERLeh/f2UbNgA+5Qx1PTftCvRb/U0Nw
	 ZG6VLnj36tJTk0ioMtrbzAYxNFLEOvZQSVGSg8cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbgGOOBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgGOOBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:01:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DB4420658;
        Wed, 15 Jul 2020 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594821712;
        bh=/+c6GQhNx6ax1x+aHu7X8iXUbjiO1EdMOqPaNBADTgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1sd7lvkkOAtL5/vXes+HWs9pBPSws/+6ratW+pLdYlvxSQWJfjGrcV1P3uxI33h5q
         ijolfnQH1Ss45me7O2DxHSNu0FwQLPHjvb5/6TTt8QBroiSik9BEiswJzXiiR1Jc55
         fP5zAp9A5TY6pM2ofQrvHQXcW1Foqw1gcIOP2U9I=
Date:   Wed, 15 Jul 2020 16:01:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arpitha <98.arpi@gmail.com>
Cc:     Larry.Finger@lwfinger.net, puranjay12@gmail.com,
        yepeilin.cs@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: core: fix coding style issues
Message-ID: <20200715140147.GA3344754@kroah.com>
References: <20200714212559.57584-1-98.arpi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714212559.57584-1-98.arpi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 02:55:59AM +0530, Arpitha wrote:
> Fixing WARNING: Prefer using '"%s...", __func__' to using 'function_name'
> in a string in rtw_ioctl_set.c
> 
> Signed-off-by: Arpitha <98.arpi@gmail.com>

We need a "full" name for kernel patches, what you use to sign
documents.

Same for the From: line.

thanks,

greg k-h
