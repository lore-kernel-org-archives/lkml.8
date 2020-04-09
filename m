Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A32C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C1920A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586440506;
	bh=u95OMMVK9eb6dy/F0/3kmGSdhzJH2nqJgLn1FqXaxQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bU7oErWypmj3ZaK7/ptKsK1E+JaPDwfEAUKEbZFcSBGPCo3KX3WWu9MUVNZNoC859
	 xtLldCuG9rgHtX8PHlJbIUj2vsoFBioNN92BhTHNLXiceY+ZK/o2QW2jLOkuXmUIKC
	 tt76Cyb+C5zlXnCyw1DApPK3PDE3oZtDhd29Dw1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgDINzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbgDINzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:55:03 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54ECF2078E;
        Thu,  9 Apr 2020 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586440503;
        bh=u95OMMVK9eb6dy/F0/3kmGSdhzJH2nqJgLn1FqXaxQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rf3pFoVhhdKX/hXOeijUgQVrWVz4G3hKTA3l5nXuRmQ9y+RgzAQK9k6qzp7fx4Ilm
         L2MJPZEKVshUGP0k4B9iJxlsjg9aGzAhUSNhdFI+b8fT5YxCbv1ulqu6fLkVps7q0U
         WclVAw4tK230taCd9rWndmoFPxmWctKbKHKwQrY0=
Date:   Thu, 9 Apr 2020 14:54:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Introduce ID_PFR2 and other CPU feature changes
Message-ID: <20200409135458.GE13078@willie-the-truck>
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <20200406170911.GA7446@willie-the-truck>
 <05f6eb1e-a82c-bd02-1871-e44ea00683d8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05f6eb1e-a82c-bd02-1871-e44ea00683d8@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 02:20:20PM +0530, Anshuman Khandual wrote:
> 
> 
> On 04/06/2020 10:39 PM, Will Deacon wrote:
> > On Tue, Jan 28, 2020 at 06:09:03PM +0530, Anshuman Khandual wrote:
> >> This series is primarily motivated from an adhoc list from Mark Rutland
> >> during our ID_ISAR6 discussion [1]. Besides, it also includes a patch
> >> which does macro replacement for various open bits shift encodings in
> >> various CPU ID registers. This series is based on linux-next 20200124.
> >>
> >> [1] https://patchwork.kernel.org/patch/11287805/
> >>
> >> Is there anything else apart from these changes which can be accommodated
> >> in this series, please do let me know. Thank you.
> > 
> > The latest Arm ARM also talks about DFR1 and MMFR5. Please can you include
> 
> Sure, will do.
> 
> > those too? Might also be worth checking to see if anything is missing on
> > the 64-bit side as well (I didn't look).
> 
> Yeah. Now there some missing ones, will add those as well.

Thanks. Just as a heads up that I've also got a handful of changes in
this area, but we can resolve the conflicts at -rc1.

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=sanity-checks

Will
