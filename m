Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182BFC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCD42467D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579014031;
	bh=ewkfQLHn3r2LyHEiaqi6hnCRUDM1wfpr+ibMYSnLNss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c2IxNBHnIWrW+6S9EuJM6m5opOpyPLQ8r8NI0kNMaNnnTqG6Dj3K6X1pDeK3M9ER0
	 IrzIRoQFpKUmzzEXB4jXjNQVGFubR2uZao+MJ2xO2LNP37SagFwxl3MRag1dHa7vRo
	 wslJoQPoat1waCNWSediQY5UJUSsbDMUp1znoFrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgANPAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:00:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgANPA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:00:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01ED724672;
        Tue, 14 Jan 2020 15:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579014028;
        bh=ewkfQLHn3r2LyHEiaqi6hnCRUDM1wfpr+ibMYSnLNss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDnAI0lr7X25ghGqamdd2dfgEj6zMPnAXSUyj0USFm1e1o0SomwDZIZuPhUjBV831
         usrAMoRGuA6OutcvqqU98y1j6UoQML4WM+RpaLgMvaEEV55RgngCfmIc86Qu/cg4WZ
         UHci+644WxkVlJQV4qUHQFd8plKHrlx9fsTFrlL8=
Date:   Tue, 14 Jan 2020 16:00:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     andre.pascoal.bento@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 101/101] Accessibility: braille: braille_console: fixed
 three missing black lines coding style
Message-ID: <20200114150025.GB1964134@kroah.com>
References: <20200109020125.16019-1-andre.pascoal.bento@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109020125.16019-1-andre.pascoal.bento@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:01:25AM +0000, andre.pascoal.bento@gmail.com wrote:
> From: andrepbento <andre.pascoal.bento@gmail.com>
> 
> Fixed three missing blank lines after declaration.
> 
> Signed-off-by: andrepbento <andre.pascoal.bento@gmail.com>
> ---
>  drivers/accessibility/braille/braille_console.c | 3 +++
>  1 file changed, 3 insertions(+)

Also, where are the patches 1-100 of this series?

thanks,

greg k-h
