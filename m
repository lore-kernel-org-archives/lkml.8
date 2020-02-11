Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76D8C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAF220656
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XC8adwkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgBKPrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:47:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgBKPrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=mq3LQX9wO8/g09UvrA/Cz7o3Mh7cczr8fTXMWKbcmPc=; b=XC8adwkMizhDpFLmWQK6HzqL1P
        6FEqwtj0E66E1eMEMQ0qiS1VbxJoO+9VsuAjpQnSgal3pwAoGPCOwTPScOgVXugaU4WZG9IvPWhV1
        /kwVZwJUSwWIszWUeHQ5U71ePPBGeKnu/XYpZigV5xs/EP5YHimzPDVXUxToNgCFlLfYNqZXof1RF
        +llsAvwIsT4TK+8mlEMh22sZyNVupS4yY4YTLQib9Qg9VpB/94A0qXnkFdOS/0I46fu+nTA46cahD
        hflOoefNZtFt0GB1TBx9NXBwPIA4rKjHYGWNevl3vh+0zX3jyJr/5Z2X0l5hFrH7D8GTAviwGeiD4
        3VXsBwsg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1XlQ-0002s4-Ip; Tue, 11 Feb 2020 15:47:52 +0000
Subject: Re: 56.rc1+git: kalllsyms aborting
To:     Meelis Roos <mroos@linux.ee>, LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <da71451e-6518-c013-570a-ee8b01633d67@linux.ee>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c0126899-62fd-c744-8515-244277ea8a2a@infradead.org>
Date:   Tue, 11 Feb 2020 07:47:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <da71451e-6518-c013-570a-ee8b01633d67@linux.ee>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/20 6:10 AM, Meelis Roos wrote:
> This is todays git v5.6-rc1-5-g0a679e13ea30 on 32-bit x86 (Debian unstable), seen on 2 machines, running on 5.5.0 kernel.
> 
>   KSYM    .tmp_kallsyms1.o
> kallsyms: malloc.c:2393: sysmalloc: Assertion `(old_top == initial_top (av) && old_size == 0) || ((unsigned long) (old_size) >= MINSIZE && prev_inuse (old_top) && ((unsigned long) old_end & (pagesize - 1)) == 0)' failed.
> Aborted
> make: *** [Makefile:1077: vmlinux] Error 134
> 

Fixed by (?)
https://lore.kernel.org/lkml/20200210161852.842-1-masahiroy@kernel.org/


-- 
~Randy

