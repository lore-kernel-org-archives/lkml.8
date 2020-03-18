Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EA5C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199D220724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YuSDXBnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCRTfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:35:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgCRTfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=bbgRRZ2gCZEZOog9XVx8bG1GYUVWexLbbc29Zf4M3g0=; b=YuSDXBnExetmPxSmK2i/cerQ6E
        0Eq4OFdRLotBSm2TzxVEHs1p0btrNw3NA7Z3fD3HcL25nogZ++vdRcZ6cF+T4TA21B2nlNPJLTj1c
        mdz33sOXFZDesXARGduoPTNJ80szTw69Ue8c44J88NntS/4yP7f3wKez1bAaqUXq+JSTQcdnvT67V
        QAOAZgu9bJfgFArAGT125BZGYqANflRRfz/Oce92U1hzRaEaIz0LT9EOmE4ndBhvfLH4gtya+6CsG
        fb5Q2PGj4xUU8MUY8i9RbYhPa3p05C/wcOnLD1ucfM/R8RBJhExHklsAS14vbJQtxEEr6OF7+R0HT
        HMH1c8Ww==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEeTo-0003Pe-VO; Wed, 18 Mar 2020 19:35:53 +0000
Subject: Re: [PATCH] x86/ioremap: Fix CONFIG_EFI=n build
To:     Borislav Petkov <bp@alien8.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200316183039.0d1c45ce@canb.auug.org.au>
 <7561e981-0d9b-d62c-0ef2-ce6007aff1ab@infradead.org>
 <20200318151707.GB4377@zn.tnic> <20200318183451.GC4377@zn.tnic>
 <cf994608-c5cc-6e0b-6fd3-a7975cc4c8cf@infradead.org>
 <20200318193451.GD4377@zn.tnic>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <29dd14c2-765b-63cc-b22a-04844d485d7b@infradead.org>
Date:   Wed, 18 Mar 2020 12:35:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318193451.GD4377@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/20 12:34 PM, Borislav Petkov wrote:
> On Wed, Mar 18, 2020 at 12:30:09PM -0700, Randy Dunlap wrote:
>> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> 
> So
> 
> Tested-by: Randy Dunlap ...
> 
> ?
> 
> :-)

Sure, that's OK too.

-- 
~Randy
