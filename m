Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2158C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E3B206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R9nzzvmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgGVQfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGVQfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:35:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FFBC0619DC;
        Wed, 22 Jul 2020 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=5XZN44V6CF32fCmbu6lN9a7A+gJGo7nDxcGvT72Gh9Q=; b=R9nzzvmIS+N0vrYDloMBSCBYaj
        THJs3mLaZ4vD8p/YZNaKSeo8B0l6g69cdikZ5e4hzc9JcOFXBLrj8H4f1IM7iqbB0MO0fLOdIDZyT
        YwqozO+H84qg0S6WYJ4NqKDDBPD2id9gqNI64bdk9scHdmf846NSW4vBoJZO9WAP82XYUWJkRyITP
        4Y3FA9gM5aCCU+hDyHrDjqlSjt3zEfy1wYlbGoXdYl2t2ZficHKqHaBr40Ir2h1t5W2M6nXhP40nC
        xyeCyjfxhQD2sCkqyeGB0biqA3rHF6pE+TeVRwgxvKJFFdgwkmntKlmHPEIXj9ifwgm+ZnYGUEDkD
        sor7GMlQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyHiW-0000XQ-MQ; Wed, 22 Jul 2020 16:35:41 +0000
Subject: Re: linux-next: Tree for Jul 22 (drivers/net/vrf)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        David Miller <davem@davemloft.net>
References: <20200722231640.3dae04cd@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e1fc4765-db64-2876-2f3c-857c45d4fb45@infradead.org>
Date:   Wed, 22 Jul 2020 09:35:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722231640.3dae04cd@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/20 6:16 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20200721:
> 

on i386:
when CONFIG_SYSCTL is not set/enabled:

ERROR: modpost: "sysctl_vals" [drivers/net/vrf.ko] undefined!


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
