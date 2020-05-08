Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BD8C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF5924973
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="ipvEwuKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgEHNGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:06:52 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:19785 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgEHNGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:06:49 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49JVw708X9z5r;
        Fri,  8 May 2020 15:06:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588943207; bh=uppDoyhwlbwoyrRyepfixLOhrOgshs3uGHxuVJsNsE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ipvEwuKk28Ab/CTNLUDVA6Vz6zgEN5GKDk6xoLAUtz3jtRh8yvdWBqsHpesbqCbsp
         n1GVnZ+jRZstbrJJP+hnqPbsmKCTO+fqSgGHeyMvGxd3UBQxYOca1YhOodHadvLQaQ
         4ZZqkOMUneH6YYbLrilKwQRNpw7wm+hJmryvwn5sGHIT/MExBe5s2Utxze0kqSxGkM
         eZJxlESvUO/912pO/5vsYPebYFd4/jal15oTZ4rgtbb62TM9H0Jdxn/uzRFraDHNG3
         Jf+Ie7ilo4znZGEZTPx/t9MYXXb555a51vIWIeVmgUSrLVK1HJgqufr+NPXMiF4xVb
         vrYOGo8zXNjsQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 8 May 2020 15:06:43 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cb710: Replace zero-length array with flexible-array
Message-ID: <20200508130643.GA9591@qmqm.qmqm.pl>
References: <20200507185224.GA14209@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200507185224.GA14209@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:52:24PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/linux/cb710.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cb710.h b/include/linux/cb710.h
> index 60de3fedd3a7..405657a9a0d5 100644
> --- a/include/linux/cb710.h
> +++ b/include/linux/cb710.h
> @@ -36,7 +36,7 @@ struct cb710_chip {
>  	unsigned		slot_mask;
>  	unsigned		slots;
>  	spinlock_t		irq_lock;
> -	struct cb710_slot	slot[0];
> +	struct cb710_slot	slot[];
>  };
>  
>  /* NOTE: cb710_chip.slots is modified only during device init/exit and
> 

Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
