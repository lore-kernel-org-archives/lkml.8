Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3F9C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74014214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888029;
	bh=otuaNmTFeR1cZEWlvlrN8JZo+5WGyGy52K7YN8szaGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hgmWTzrtpL366a8UPK4TNYiFxYcwC+tnBfzyeMIzX278o3IhSg4wjIJYN8TGsoJuW
	 isQ/SzPeps6QT4LfddEcgq1xW9e8EkU1LqtEDbt4lPUfGcJdonYzY+XiUqfiGv8LBI
	 RHN2nleikF634TynTVABY8+cIUPgq4oWD4dQ9NBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgHaPds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbgHaPdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:33:38 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCD47207EA;
        Mon, 31 Aug 2020 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598888018;
        bh=otuaNmTFeR1cZEWlvlrN8JZo+5WGyGy52K7YN8szaGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7ji3dYkdFx/lhVBpAlgWVNUumcb97mLLmaULWc2HZF1SCNV+0vn8gB6/EX3Jesa0
         TYQo9Cyw2WEX/5MQHBMHAI1qxLB9wZhvSOyYytxc0kSFEyY4+z712lYwzwrugn2wO7
         r7awxU3mYrzFJXQB8ajSViBM8MuzGSlq9+NdMu7k=
Date:   Mon, 31 Aug 2020 17:33:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH AUTOSEL 5.8 07/42] speakup: Fix wait_for_xmitr for ttyio
 case
Message-ID: <20200831153345.GA2525965@kroah.com>
References: <20200831152934.1023912-1-sashal@kernel.org>
 <20200831152934.1023912-7-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831152934.1023912-7-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 11:28:59AM -0400, Sasha Levin wrote:
> From: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> [ Upstream commit 2b86d9b8ec6efb86fc5ea44f2d49b1df17f699a1 ]
> 
> This was missed while introducing the tty-based serial access.
> 
> The only remaining use of wait_for_xmitr with tty-based access is in
> spk_synth_is_alive_restart to check whether the synth can be restarted.
> With tty-based this is up to the tty layer to cope with the buffering
> etc. so we can just say yes.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Link: https://lore.kernel.org/r/20200804160637.x3iycau5izywbgzl@function
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/staging/speakup/serialio.c  | 8 +++++---
>  drivers/staging/speakup/spk_priv.h  | 1 -
>  drivers/staging/speakup/spk_ttyio.c | 7 +++++++
>  drivers/staging/speakup/spk_types.h | 1 +
>  drivers/staging/speakup/synth.c     | 2 +-
>  5 files changed, 14 insertions(+), 5 deletions(-)

Not needed for 5.8 or older, sorry, this was a 5.9-rc1+ issue only.

thanks,

greg k-h
