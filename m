Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F0BC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C377206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587997093;
	bh=zXQ51mgKn2086N6wizSp+QElbF+XlMV+kXnI1pYIupo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0YYUcozMoW4PtELKYqvRPvmZrhGZ6cNeD2ULewhfeiQmsTWAPJULbFopYA2FHX0A1
	 VqONasBK9wPOp+e2kS1efVg9xHol4Qn3B8EEhgpjIboVXZ5MneQeynjKX7C60s5HLM
	 sloG4X7PlwWmYBzHP47hV8Zu/xCg5Z6QRlJS6s8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgD0OSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbgD0OSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:18:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B519C206B6;
        Mon, 27 Apr 2020 14:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587997092;
        bh=zXQ51mgKn2086N6wizSp+QElbF+XlMV+kXnI1pYIupo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHBDofvS1ltNw6wWUrFj55BdrcHAE70kn5woRvDyehi5xL+/TT4oRzt1Ml7SBMnef
         vFNOYaZfQeW/NwSztgHp9kwV6aO2xMmBMnVMPWLI9VCvYCX2XDVhhs1Sf53m2A+LCK
         ppdFpHrESeOTXvt38mBbE1npB34ytmj0WdOt4mXo=
Date:   Mon, 27 Apr 2020 16:18:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     devel@driverdev.osuosl.org, hslester96@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: staging: rts5208: rtsx.c fix Unbalanced
 braces around else statement issue
Message-ID: <20200427141810.GB3158628@kroah.com>
References: <20200427135212.26285-1-john.oldman@polehill.co.uk>
 <20200427135212.26285-2-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427135212.26285-2-john.oldman@polehill.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 02:52:12PM +0100, John Oldman wrote:
> Make a better job of fixing coding style issues, this time fixing 
> all blocks as per Joe Perches' comment.

Trailing whitespace :(

> 
> Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> ---
>  drivers/staging/rts5208/rtsx.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 

You sent 2 patches with identical subject lines, yet they do different
things, which is not ok.  Please fix up.

greg k-h
