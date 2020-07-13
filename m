Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9CBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD40820738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594647525;
	bh=wyDj5szV8OmNtohY+xQpY+G0Z1pE2OR4OnJcyQ88UEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZA5lvI7HCV+dqt+D8SV+iYvGIm5nXjWs2UCbHbaIEFfshyUvLnEGT6mYCNbPW3Td1
	 q0w9b6fmpnF4Trbs50SJol2LTIcdDdNc81Gyt9wnOxElz4tvQdvxhLystnCv41s+i7
	 PU21LarMs0fi/VtgcKLhzickPQkF7y2WCbVgMcMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgGMNio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729613AbgGMNin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:38:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15EF82072D;
        Mon, 13 Jul 2020 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594647522;
        bh=wyDj5szV8OmNtohY+xQpY+G0Z1pE2OR4OnJcyQ88UEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ob6zrZtahjAV8QMihS44IWx0ZFiu/QvHuO7fjyFxcLvdeXk+Q82PcWJwKKXo7+L0J
         pUiS/BngnJLf5fidss3pOB+WDKwTcQknIAia8e2cjSDbAam08NwhEFRHP1g8rNSpp/
         AQeFS0mmiGUylPn4dd6IkGVeTX6UfqqabxrERrkY=
Date:   Mon, 13 Jul 2020 15:38:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        devel@driverdev.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] staging: qlge: qlge_main: Simplify while statements.
Message-ID: <20200713133842.GA3138742@kroah.com>
References: <cover.1594642213.git.usuraj35@gmail.com>
 <1bb472c5595d832221fd142dddb68907feeeecbe.1594642213.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bb472c5595d832221fd142dddb68907feeeecbe.1594642213.git.usuraj35@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 05:50:14PM +0530, Suraj Upadhyay wrote:
> Simplify while loops into more readable and simple for loops.
> 
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> ---
>  drivers/staging/qlge/qlge_main.c | 49 ++++++++++++++------------------
>  1 file changed, 22 insertions(+), 27 deletions(-)

This patch did not apply for some odd reason :(

Please rebase and resend

thanks,

greg k-h
