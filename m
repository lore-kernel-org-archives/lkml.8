Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBD5C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75072075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579897760;
	bh=F90xNfUKvOUf2TUGknbgCQUyvynq64EpI75k+l0dmfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Np24amTduG3769CcGCr87JRDkeVJdoj/Pcj1lTrhKJ49wZL2Gs/hOwq3MTdSDTBEe
	 RPoWabFJ8OSt5pGr5evAcvOR0+zYWhwWyKEkmG1F5YL9KJBvmrvnTj5TY+UFtw3fAt
	 5ELyN0CEK0XNmJavEIYxXbOo2z5V+DgTvEOBF3Cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392473AbgAXU3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387548AbgAXU3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:29:19 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D7D2072C;
        Fri, 24 Jan 2020 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579897759;
        bh=F90xNfUKvOUf2TUGknbgCQUyvynq64EpI75k+l0dmfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yI/jzlDhjyDiy+RVAtgnDZBV+QQG7xN523HkaCfjRn/esAhwjMsYmny4VGRPuJJnH
         FCupkgTKE5EWoMbbta1nqGJ4EDxd3/Oud4h9zPl9tj5gAz/ZP0vlKW8owqg5ZjPahS
         3jEuqgDRFBjJyAdXsJ8wE6TyJOoLeka9N7XUB1QI=
Date:   Fri, 24 Jan 2020 15:29:17 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH AUTOSEL 4.19 05/11] ARM: config: aspeed-g5: Enable
 8250_DW quirks
Message-ID: <20200124202917.GI1706@sasha-vm>
References: <20200124011747.18575-1-sashal@kernel.org>
 <20200124011747.18575-5-sashal@kernel.org>
 <CACPK8XeGLW6cm9UV7gqrOF18BzsRBppzLQLY6G=Y2MDj2Yrnhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACPK8XeGLW6cm9UV7gqrOF18BzsRBppzLQLY6G=Y2MDj2Yrnhw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 01:21:40AM +0000, Joel Stanley wrote:
>HI Sasha,
>
>On Fri, 24 Jan 2020 at 01:17, Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Joel Stanley <joel@jms.id.au>
>>
>> [ Upstream commit a5331a7a87ec81d5228b7421acf831b2d0c0de26 ]
>>
>> This driver option is used by the AST2600 A0 boards to work around a
>> hardware issue.
>
>This hardware was only supported from 5.4+, so I think we can drop this patch.

I'll drop it for 4.19 and older, thanks!

-- 
Thanks,
Sasha
