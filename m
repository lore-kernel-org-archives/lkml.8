Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9AEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8EC20702
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="phHD9sZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgGFQ7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgGFQ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:59:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA79EC061755;
        Mon,  6 Jul 2020 09:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=C53Wi7QFgG4SXyckPFgiwxQN0pndUxQvzd6BzkrXp4o=; b=phHD9sZ89ifS6lP8nTLgg+42+K
        eIQuBwFxqgO8oo1MV5LVm4+88D7RF6CkHQ6v2JdIC8EmSN2djGjrc9J/IxW24frvostP/6rWB2w/U
        uZTrudIkBlJc3pnO8oGUctxx13tbPMBYuKCr6btOzBe6won9+eJIVAN6YIa4+6PaslvcB16CEkVhj
        ihtYHJgq9j0qT9LOE3y5hKS+Ya2gDwa19xtFT+q6JL7CP4EFnZvliA8wMVSvIybdbH/hI05IxYk/e
        Rz/Lnw/WekvjYkfbb7LQyvT/N8ULJAVR+g8UQt36MXGF7Y/pesaQFdBf2ruWWcqqjFA6ydeX7XubN
        hd9Sz1lw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsUSS-0003Mj-Rl; Mon, 06 Jul 2020 16:59:09 +0000
Subject: Re: linux-next: Tree for Jul 6 (mm/memory_failure.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200706174001.2d316826@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d458c18d-9c5e-9c45-0d65-e317571b6d56@infradead.org>
Date:   Mon, 6 Jul 2020 09:59:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706174001.2d316826@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/20 12:40 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20200703:
> 

on i386:

when CONFIG_MIGRATION is not set/enabled:

../mm/memory-failure.c: In function ‘new_page’:
../mm/memory-failure.c:1688:9: error: implicit declaration of function ‘alloc_migration_target’; did you mean ‘alloc_migrate_target’? [-Werror=implicit-function-declaration]
  return alloc_migration_target(p, (unsigned long)&mtc);
         ^~~~~~~~~~~~~~~~~~~~~~


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
