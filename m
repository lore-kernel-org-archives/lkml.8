Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E5FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A690A2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589890440;
	bh=bFycJ6timOxlOWfG9iyAet6O/y7aqP8pCPZJr3zjOrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0ROi1jdIeubcu8TJuG4CnScezRBK9jmoqZj3BjFl+T0m72VdVVjaNeH5XN5jfQcZv
	 MZNemm/URhl4e/m4BcVWn/7o3BlfOFJzR24WKKIIs+M9fGHKBSOG2byhabIAFQ9Wcs
	 boqmxUZH+Doa8i2AknFTf2I7CC7RXEBEALi9zYmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgESMOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgESMN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:13:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB1F1207D8;
        Tue, 19 May 2020 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589890438;
        bh=bFycJ6timOxlOWfG9iyAet6O/y7aqP8pCPZJr3zjOrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efAjeWdtgiJrlkwyWdQ+NhYP1SS9GNVSYKaB0Ce/lJXVoVJvbWtufzXW+b5JsrSe0
         nY8VISeYYhtDsl/26Gxw6qR/8NeRmvScxOEvfrDMtTgmNIKbMGFxyQmUxgZZ+E0kFY
         FJUHjdVSfSG4+5ZLV5+LAuJHiLrUPkjC+13+bFN4=
Date:   Tue, 19 May 2020 14:13:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Stefano Brivio <sbrivio@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 41/80] netfilter: nft_set_rbtree: Introduce and use
 nft_rbtree_interval_start()
Message-ID: <20200519121356.GA354164@kroah.com>
References: <20200518173450.097837707@linuxfoundation.org>
 <20200518173458.612903024@linuxfoundation.org>
 <20200519120625.GA8342@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519120625.GA8342@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 02:06:25PM +0200, Pavel Machek wrote:
> Hi!
> 
> > [ Upstream commit 6f7c9caf017be8ab0fe3b99509580d0793bf0833 ]
> > 
> > Replace negations of nft_rbtree_interval_end() with a new helper,
> > nft_rbtree_interval_start(), wherever this helps to visualise the
> > problem at hand, that is, for all the occurrences except for the
> > comparison against given flags in __nft_rbtree_get().
> > 
> > This gets especially useful in the next patch.
> 
> This looks like cleanup in preparation for the next patch. Next patch
> is there for some series, but not for 4.19.124. Should this be in
> 4.19, then?

What is the "next patch" in this situation?

thanks,

greg k-h
