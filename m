Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51031C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 06:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229FE206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 06:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579244183;
	bh=RL6Suh/Keq4jZcRU9Xr3AdFfyHTsGr1REc7Cisq2aSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hkbK6lnCSLvVCF8tXe7UVQq2AQH4xbCxKCqBeH8VAQwmEMKzDexTMMWWuk/q3cGuY
	 v5yvKL4y32N7k8ZiE8APZyj91BVVBXepGCB4MJrZs5Sg7OGPvHPpyhFa7DI4UCAZMq
	 sj+YXHqkc6+z8dGH8l950SmOeRDUGBzkRap1GbgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgAQG4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 01:56:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgAQG4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 01:56:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2CB52072B;
        Fri, 17 Jan 2020 06:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579244181;
        bh=RL6Suh/Keq4jZcRU9Xr3AdFfyHTsGr1REc7Cisq2aSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRY0XkAek+7pTgd7uKpNvBFyBzvlmpJVHK5TqszaeG+o2P/NnBhCYKljP1Jv8Ec+/
         sAQrict3f2vUkY5QwPiebRd/+iy1yR1/UbjcffvUWyp/XjCMEieCHWdLDZKKJaZ4eq
         dFarjSUnJ/nILpHSDECkgVDB3B8LYUF+YgtonTzQ=
Date:   Fri, 17 Jan 2020 07:54:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] PHY: For 5.6
Message-ID: <20200117065426.GA1699866@kroah.com>
References: <20200117053540.20451-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117053540.20451-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 11:05:40AM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the updated pull request for 5.6 merge window below.
> 
> Here I fixed the incorrect commit ID in Fixes tag on one of the
> patch. Rest of it remains the same as in v1 PR.

Ok, that worked, I've pulled this version now.

thanks,

greg k-h
