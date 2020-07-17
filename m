Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626EEC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4124320734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594981176;
	bh=UOSt48aO65gwAUB2x+iP6NI41YTkFaT/oMyZi4pbRB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eHuVGcIrf6049eJbOhi0FMp2iuMQIF0e11uPJ8WIwtXJu4xn+9ooIGbB5d/FMwD3u
	 kBa79EfcwlRNf1TPn8rn4hiMr9LpdV3ooN/5/Hob8c98YsIBkw03sem6MVHWDpA8h0
	 5WoMrI5032YDFJLc604acgWTm2p2ccSemqSq1kpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgGQKTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQKTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:19:33 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E7C22063A;
        Fri, 17 Jul 2020 10:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594981173;
        bh=UOSt48aO65gwAUB2x+iP6NI41YTkFaT/oMyZi4pbRB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xEp4/wQwm+BYnpeOPkED1GCD0Sd/uO+toFmvPdeSJf8s5AWO8N1KRseke5NzbCeYF
         UcE9OPw5ZFJH58C+E6CLZm/sZeAVtjw12atWQmsuRac0fPwJO7554jIl9Um59VDGGD
         1rCI7nGtpriu6D8/SGqPKGUH+wEv65DgRMjRCKUg=
Date:   Fri, 17 Jul 2020 11:19:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] arm64: Make TSK_STACK_CANARY more accurate defined
Message-ID: <20200717101929.GA8727@willie-the-truck>
References: <1594613013-13059-1-git-send-email-guoren@kernel.org>
 <20200714083715.GE4516@willie-the-truck>
 <CAJF2gTRVHs82gwctTt7ZEvgDKrrSBw_GLjJLDqa9zLY+qNywWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRVHs82gwctTt7ZEvgDKrrSBw_GLjJLDqa9zLY+qNywWA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 08:56:23AM +0800, Guo Ren wrote:
> BTW, Jim found a GCC security leak in arm64, and would you want to
> have a look at it?

Thanks. This seems to be tracked in their bugzilla here:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96191

I agree with Jim that this should be fixed.

Will
