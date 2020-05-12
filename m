Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EAECA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1723120714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589306602;
	bh=hQk0S1yJ70rST/GSmYuGPqAK8UD3U8opXJDuyLeuq74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=er+AfvyGTBGX+26La/wL4EGbeXTizUu3W2JyGbZpD/iAoLrd7xHDPRa8164SmQ/8F
	 dcFVYHet3oCAdrzlmWG+rBdUQP/AkgREz5aTEgGiomzMeBlfuepUu0E0xEGKZLWi8m
	 Fo62G+uCvoFsvJcT+OflTdETDP0JOhpV7jzReezM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgELSDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgELSDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:03:20 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0872220673;
        Tue, 12 May 2020 18:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589306600;
        bh=hQk0S1yJ70rST/GSmYuGPqAK8UD3U8opXJDuyLeuq74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hiWEmaCJxtteCzKgEpk3ScqKypcslzHaJKpzXPTM/myPshzlMocgTDf34jV4wxzqC
         cZIVwNGpcaco49PyjLp0F3iZGxx809hXuzCQ+oO/RPh11XIl8fIaOEu6V8EFKOvM2e
         Q8zk76DxQHfy1zdcSh3DKPYLqbJF56FTPRKsLpW0=
Date:   Tue, 12 May 2020 13:07:54 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: Replace zero-length array with flexible-array
Message-ID: <20200512180754.GE4897@embeddedor>
References: <20200507192223.GA16335@embeddedor>
 <s5ha72j32sh.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ha72j32sh.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 10:31:26PM +0200, Takashi Iwai wrote:
> On Thu, 07 May 2020 21:22:23 +0200,
> Gustavo A. R. Silva wrote:
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks, applied now to for-next branch.
> 

Thanks, Takashi.

--
Gustavo
