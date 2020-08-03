Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA27C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76EAA2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596469269;
	bh=vkBCBkF4ZAHZcMpJ+bypEWZ/AlvYl3GE+TSE47hokTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AmNrd69QPOpu+YxcIWzoLCiry49o8K+7PoQKhnBIuGMzqPjyy/1GrBGtT5do+FBjQ
	 VxyRn/YqV7oipk2uYlxF1ZopeF+eSh7EWlS3IruoFkjYXBc4aY+gLfMCfisKyI41oK
	 0M2n0FeIjufcH4V1gL037o5BUyxhaAfNDua4S2mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgHCPlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgHCPlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:41:08 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3715D20678;
        Mon,  3 Aug 2020 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596469267;
        bh=vkBCBkF4ZAHZcMpJ+bypEWZ/AlvYl3GE+TSE47hokTU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V9P5zt4ff0T42yNwHk8wtCra4wrhH7MXPoXCneEMvcRqvTodILCyBxC7DhzLcBvnv
         Cn3Heov+tA4GCb1UNZZcaO/2yQQ0v2PXksGl/AedOkvO7OTbRGTW2Oqy2vWuxIWAc+
         oh3VM2tE++tmS+iFM7HQIC0IDlz9l6vw6kfwetxA=
Date:   Mon, 3 Aug 2020 08:41:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     csully@google.com, sagis@google.com, jonolson@google.com,
        davem@davemloft.net, lrizzo@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] gve: Fix the size used in a 'dma_free_coherent()' call
Message-ID: <20200803084106.050eb7f6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200802141523.691565-1-christophe.jaillet@wanadoo.fr>
References: <20200802141523.691565-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  2 Aug 2020 16:15:23 +0200 Christophe JAILLET wrote:
> Update the size used in 'dma_free_coherent()' in order to match the one
> used in the corresponding 'dma_alloc_coherent()'.
> 
> Fixes: 893ce44df5 ("gve: Add basic driver framework for Compute Engine Virtual NIC")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Fixes tag: Fixes: 893ce44df5 ("gve: Add basic driver framework for Compute Engine Virtual NIC")
Has these problem(s):
	- SHA1 should be at least 12 digits long
	  Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
	  or later) just making sure it is not set (or set to "auto").
