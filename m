Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23F7C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886242077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585139524;
	bh=rf/P+eDEMEoAk4VolJB4/OiZXXea+0/Hks9LZcUH3mE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MNVZeNZo2Xtcs5NG+5Pnl4FNIpn5nrsMob4o90tbhE31ZsSw6fCQoCTsZINskChZ8
	 BKWDOsCo/t+XePGZHQKoN1b1oeezcS/GpbbBf//B3A9fjO6+rSMeDDbxF+PkFVTUSe
	 N+TCtMJcso5sZLAqp2MdqkbThmR6AXMzgl29KPSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgCYMcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgCYMcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:32:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64AA12076A;
        Wed, 25 Mar 2020 12:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585139522;
        bh=rf/P+eDEMEoAk4VolJB4/OiZXXea+0/Hks9LZcUH3mE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mqc1eQzdVHBiL1PCbuIKRGTrIKX37Jj0iYd45NcCS8/tYCt1ghc/dtEycNdY8ZSNQ
         bkgxCYVlI49XI6RDvndauRXLBVrLFBcdn7VQBQ9NAR5WbBt4FaKnI7IvD9St+hFDgk
         Bb3Opa5Ew0C64QzZEqmEsf93D3G6iPmG9iukfS2g=
Date:   Wed, 25 Mar 2020 13:31:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.7
Message-ID: <20200325123156.GA3371428@kroah.com>
References: <CGME20200324231543epcas1p2302f5fe248059301b6ea67cb9dafb8f2@epcas1p2.samsung.com>
 <60060403-c2ee-2794-ff44-319e8e5272b5@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60060403-c2ee-2794-ff44-319e8e5272b5@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 08:24:39AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.7. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> est Regards,
> Chanwoo Choi
> 
> The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:
> 
>   Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.7

Pulled and pushed out, thanks.

greg k-h
