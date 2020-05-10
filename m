Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695A8C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 250E42080C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p7llejn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgEJQC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgEJQC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:02:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01509C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=sJhFZu1ebEDTAuwI/fi7Vdy+pxTGala5If/60j7qvFg=; b=p7llejn1Ia0xEX96ok8+Zlwyfc
        Xer8lcdQAE6ycHTmU0K03rx/XtkJG8V1mnFTp0Y993LZ1jBdIb0h05jfXW1HkQXvhsPXbDp7AHBHt
        IAklnjsiGakg50PLtEKRAgQ6aH+OyGNDG0XOD/LHZvxEIGYIcH7GoFCdC9J0h0uECNeiLKkRoWbdX
        I6T9FVw5hVhVDbOc3av0cR0DqYFWatJJ2sTSWhCu2zDbo6q7xcj3V1ssc5sMwsq07dTX5Qfqo76ET
        vlzfsCNaWD0YTaZb5gj7EjSnS2G0EKn6FtesNNpVh9VhDYQ3/qe6we+XVlsBRrYGg6sElULqioGef
        vyHXvUNg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXoPm-0007Ap-Az; Sun, 10 May 2020 16:02:54 +0000
Subject: Re: Using a custom LDFLAG for all objects and binaries
To:     Mahmood Naderan <mahmood.nt@gmail.com>,
        linux-kernel@vger.kernel.org
References: <CADa2P2UP1AtEmQYtyqUFKVNz8Rxii+-Zut3ibc5pMYnQB90-zw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <32637993-b73f-c2cb-6823-590c1638b5a6@infradead.org>
Date:   Sun, 10 May 2020 09:02:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CADa2P2UP1AtEmQYtyqUFKVNz8Rxii+-Zut3ibc5pMYnQB90-zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/20 6:35 AM, Mahmood Naderan wrote:
> Hi
> I would like to modify the kernel makefile in a way to include
> --emit-relocs for every file that is linked during the process of
> kernel make.
> I see
> 
> KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
> LDFLAGS_MODULE  =
> LDFLAGS_vmlinux =
> ...
> 
> But I don't know which one is the main. Should I put that option in
> front of every LD* variable? Or it is possible to apply one variable
> for every file that is linked?
> Appreciate your help.
> 
> 
> Regards,
> Mahmood

Hi,

Have you read Documentation/kbuild/makefiles.rst ?

    LDFLAGS
	Generic $(LD) options

	Flags used for all invocations of the linker.


You could always build with V=1 to see all of the
command lines that are used in the build.

HTH.
-- 
~Randy

