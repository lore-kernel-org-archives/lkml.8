Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1C8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208E9214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590741807;
	bh=WXicRjEV9+SwtPOR0p72vmHsLtEkefjIl0MeB7P2Oxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ugQKoIqV7dE/Fbt8iGYjh+pmiIpqIyPIgakNEakE2grLSgHZ5DJdT+zE4FBN3qy1P
	 4TvyfJsFUQgnXuwynthmtM9xyoi2/0vfyCzU3U8bq81XgZ+xeECBV8MypSLwObqYq8
	 Xi+8lnwcsfLxZO2JLYUekgoDeTZDQrvzxJFsM1t0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgE2In0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2InZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:43:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E166A207F5;
        Fri, 29 May 2020 08:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590741804;
        bh=WXicRjEV9+SwtPOR0p72vmHsLtEkefjIl0MeB7P2Oxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8NCpCv1ynYu622W2ei3j0eZMTPaPzkG1WuE6hqEyd18fPypoDGS0rdsKRqxrHuRh
         /ZgUfi0BdN/NT8iJfCZ9gSRKdjGir0auX6Sx/T4sioVFI8H0pCCZaxwzE91f0Yijky
         Xe+dGSdg92ilKctSzFnefAr4MmlryojB5cOHVYvM=
Date:   Fri, 29 May 2020 10:43:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] GNSS updates for 5.8-rc1
Message-ID: <20200529084309.GA996343@kroah.com>
References: <20200529074915.GA14457@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529074915.GA14457@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 09:49:15AM +0200, Johan Hovold wrote:
> The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:
> 
>   Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-5.8-rc1

Pulled and pushed out, thanks.

greg k-h
