Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E80C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AEE206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aet29nPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgELNeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgELNeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:34:16 -0400
X-Greylist: delayed 184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 May 2020 06:34:15 PDT
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50571C061A0C;
        Tue, 12 May 2020 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1589290453;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=iioaOC2kwzSvST2vkplX1ofGaA5MXnollnoM6Iyjnu4=;
        b=aet29nPvce+u6VcTVK9T1X3vIERya2mcys21wxc5I/hKEnmhJERSpkbK8P7GsIjnYA
        rXq+JvRmnCFl8AuvrxuKnGteq04nDU4fznG8jixNSvmdoXlNQ00t8Vo5OxEAZmDll3nj
        0T9jU4d14Bk84DQSSUsdbxsRDGVaA3Owkt8+0mNWlztWaDZ6jyuAIGMR1hcbh+2dBqto
        +MIjpZ/qNg57+xD7NfnL5qzst/dOuP8GdDSI4m8rmAxI0DNspzb3oKJlEnl6MWFqGccZ
        lXp/mc5lHLzF39oPhXSHkdpm37qHg10ZuEdQGLCsXmdhjlHAkDY/JaUXvjf53OE8NxPf
        8djw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGX8h5lSA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.192.66]
        by smtp.strato.de (RZmta 46.6.2 DYNA|AUTH)
        with ESMTPSA id j023c5w4CDV5xsj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 12 May 2020 15:31:05 +0200 (CEST)
Subject: Re: [PATCH] can: Replace zero-length array with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200507185118.GA14022@embeddedor>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <0420f571-2d6a-c830-2029-8da60e3c2094@hartkopp.net>
Date:   Tue, 12 May 2020 15:30:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200507185118.GA14022@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-05-07 20:51, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>          int stuff;
>          struct boo array[];
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
>   include/linux/can/skb.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index a954def26c0d..900b9f4e0605 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -34,7 +34,7 @@
>   struct can_skb_priv {
>   	int ifindex;
>   	int skbcnt;
> -	struct can_frame cf[0];
> +	struct can_frame cf[];
>   };
>   
>   static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
> 

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

@Gustavo: Just to be sure:

 From the referenced URLs I got the information that the sizeof() 
operator causes problems when applied to e.g. cf[0].

We don't have this case in our code - but one question remains to me:

We are using the above construct to ensure the padding between the two 
'int' values and the struct can_frame which enforces a 64 bit alignment.

This intention is not affected by the patch, right?

Best,
Oliver
