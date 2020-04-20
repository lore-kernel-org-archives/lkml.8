Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1404C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A99CA206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aaK9QPyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgDTPpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgDTPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:45:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66A6C061A0C;
        Mon, 20 Apr 2020 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=fkfnAhp5CM6mmeL7Sr7+YSkpNnHA+3cpF10slzhH73s=; b=aaK9QPykvzVz29xusBdJP3YQPK
        wRz6J5hikf5OXHuNcmcJ0qmJ2ZNJr01VQb0aL/PjypLCX7pN5GehZW1VPLRFbajaJT+pdbGUXfPdR
        vtWNiyxss75N1xRJ1YrhBshdKfnnZITTcL7+4P7yhNLFp5w5kyR80jRjc/PZEFVcQJjsdfAsG6nR1
        RuzlIB7RIVdltNGES5FhWrAISyUq3n0chQAoafvc4xK8vFOzYF8eOQAHRNEaNjmJgvum6CT6PCdJg
        U1KUiTrKeND9VQ1LMNFmaAeZ7eqAT/kaezpRApsGJgNIR691i+7r/MS5gE3BXQDjKqANdo81qpIBR
        asGo2qPQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQYcF-0004qG-Da; Mon, 20 Apr 2020 15:45:47 +0000
Subject: Re: linux-next: Tree for Apr 20 (media Kconfig warning)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20200420142610.390e5922@canb.auug.org.au>
 <c53a2fa4-1efe-07d5-6cfa-6ebc37b7d013@infradead.org>
Message-ID: <752826b9-46d2-5fd9-4759-df5d8bfba1d0@infradead.org>
Date:   Mon, 20 Apr 2020 08:45:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c53a2fa4-1efe-07d5-6cfa-6ebc37b7d013@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 8:21 AM, Randy Dunlap wrote:
> On 4/19/20 9:26 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20200417:
>>
> 
> 
> on x86_64:
> 
> WARNING: unmet direct dependencies detected for PHY_ROCKCHIP_DPHY_RX0
>   Depends on [n]: STAGING [=y] && STAGING_MEDIA [=y] && MEDIA_SUPPORT [=y] && (ARCH_ROCKCHIP || COMPILE_TEST [=y]) && OF [=n]
>   Selected by [y]:
>   - VIDEO_ROCKCHIP_ISP1 [=y] && STAGING [=y] && STAGING_MEDIA [=y] && MEDIA_SUPPORT [=y] && VIDEO_V4L2 [=y] && (ARCH_ROCKCHIP || COMPILE_TEST [=y])
> 
> 
> Full randconfig file is attached.
> 
> thanks.
> 

This kconfig problem also causes this build error:

ld: drivers/staging/media/rkisp1/rkisp1-isp.o: in function `rkisp1_mipi_csi2_start.isra.11':
rkisp1-isp.c:(.text+0x1184): undefined reference to `phy_mipi_dphy_get_default_config'


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
