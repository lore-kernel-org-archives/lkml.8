Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295FDC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E216421775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="riCCmfUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBFQiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:38:51 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:38113 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgBFQiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:38:50 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 122bd2e9;
        Thu, 6 Feb 2020 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=zYzK/NEhj71GVhP3Ol6c67NfALM=; b=riCCmfU
        Wh7M6FwzcPNAwIkELDWRwzGmxOaomzdKYXpzYSu11gUGkpbNlfhfr0ZMimpRPvhU
        WwXawBd9puKQLo1+lJPndZasMhdfjCuAb4t50LGAaFdCw8gsjNaIliIQN6WxvNgL
        RTC6BKVCahber8XtQxTOn5a1PFB0NMCq5Ns9af7+v6iMmVQ4TbU/hvODfAuqN0O4
        j/6NzoevKpSFF8RRQ0YwJ6yrNP73wDCq0f3ld436w10f72qaezs8NDtAlokjKd2U
        tRs2rUEigiJK0kJutwGZmeAQP/iHVlOxJaB6KK6glQml44nTLhiqIjzulh7fkIJc
        RRB+mbpkLrhR1Xw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 062996d6 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 6 Feb 2020 16:37:41 +0000 (UTC)
Date:   Thu, 6 Feb 2020 17:38:44 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     eric.dumazet@gmail.com
Cc:     cai@lca.pw, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] skbuff: fix a data race in skb_queue_len()
Message-ID: <20200206163844.GA432041@zx2c4.com>
References: <1580841629-7102-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1580841629-7102-1-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Tue, Feb 04, 2020 at 01:40:29PM -0500, Qian Cai wrote:
> -	list->qlen--;
> +	WRITE_ONCE(list->qlen, list->qlen - 1);

Sorry I'm a bit late to the party here, but this immediately jumped out.
This generates worse code with a bigger race in some sense:

list->qlen-- is:

   0:   83 6f 10 01             subl   $0x1,0x10(%rdi)

whereas WRITE_ONCE(list->qlen, list->qlen - 1) is:

   0:   8b 47 10                mov    0x10(%rdi),%eax
   3:   83 e8 01                sub    $0x1,%eax
   6:   89 47 10                mov    %eax,0x10(%rdi)

Are you sure that's what we want?

Jason
