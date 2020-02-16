Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F086C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 16:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26177208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 16:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LYzJjga0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgBPQCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 11:02:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgBPQCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 11:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=cWzOpiOu7VlYjJzjka/uz4Y9eKUv0MO2UGlQ+F9pXEg=; b=LYzJjga0YcaHKF6XPZepjCtZ38
        dhiVAEks0WShzXhYlaM/A1Iz8WQgtfujRfXxn5Oob1gZsp84rhBVs0u8Bfh30DshXhtvN9TGpeHk/
        p1HFg9+cIjx/2d6+TTauS4/GBYKLXI+GaJwfyEkDLR4oJGdbo0YwWJ7c6ubEtJIijejvFEEw0/naP
        6hw3SnC1YNrQclZK1qeRbDYefSX9/NPwCjiVxZLJ6I7SBOyCvPwrMG+MF8cconRoaxt1a5ORVea6g
        kQbnTkHybVVU7Tm7qoPuJMC5O79/bgu0DQ0lZr6ITT2KQrJFgBHXZSA3YaVAo0fKxx1CUB/YpmrDL
        oTF8ffDQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3MN3-0005FL-1O; Sun, 16 Feb 2020 16:02:13 +0000
Subject: Re: x86: Fix a handful of typos
To:     Martin Molnar <martin.molnar.programming@gmail.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <0819a044-c360-44a4-f0b6-3f5bafe2d35c@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d311681b-3481-b808-71e4-258bfc01c788@infradead.org>
Date:   Sun, 16 Feb 2020 08:02:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0819a044-c360-44a4-f0b6-3f5bafe2d35c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/20 7:17 AM, Martin Molnar wrote:
> Please find a couple of typos fixed in the patch below. Let me know if I should do anything else.
> 
>      Martin Molnar
> 
> Signed-off-by: Martin Molnar <martin.molnar.programming@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/x86/kernel/irqinit.c  | 2 +-
>  arch/x86/kernel/nmi.c      | 4 ++--
>  arch/x86/kernel/reboot.c   | 2 +-
>  arch/x86/kernel/smpboot.c  | 2 +-
>  arch/x86/kernel/tsc.c      | 2 +-
>  arch/x86/kernel/tsc_sync.c | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)

Thanks.
-- 
~Randy

