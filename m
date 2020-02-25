Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA12C35E10
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7D921D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582660970;
	bh=KOlmvJtWquDJPDlc06aCKIh/YFN8OrRacdQA5R8ywwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nHZ5+gZjiElSFLlmAEQuFiG+e8wjy/aX2tsmDQ7BmDLSU/52XXfn2bkfguVq3eCNE
	 bWiomlZJd3z49h/xVjrG6vBopHG6oIrJHDqXxFlr8bx33p3HWe4UDqP2XBih3DKmgf
	 Tct2Mx/EGlBVsUxILyxKgLQvN0kR4aZztDFe8BDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbgBYUCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731226AbgBYUCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:02:46 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74F2621744;
        Tue, 25 Feb 2020 20:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582660965;
        bh=KOlmvJtWquDJPDlc06aCKIh/YFN8OrRacdQA5R8ywwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iuzi5rShJKqo388BDfT24JOXFZesCGa+yCjew299CxkKt0IkmCCarej2W8nlKaFQY
         Ro7eaFOLbTBxOAQr+SfXTzkbWKv+hpb7eEeR7+UfT0YrWA8DHEnpU8wChDEYVu5PYi
         Ctcg1Nk3bg5r4OZWMBGv4QDa5DMs3huU7SpaoPOg=
Date:   Tue, 25 Feb 2020 12:02:44 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: testmgr - sync both RFC4106 IV copies
Message-ID: <20200225200244.GB114977@gmail.com>
References: <20200225154834.25108-1-gilad@benyossef.com>
 <20200225154834.25108-3-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225154834.25108-3-gilad@benyossef.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 05:48:34PM +0200, Gilad Ben-Yossef wrote:
> RFC4106 AEAD ciphers the AAD is the concatenation of associated
> authentication data || IV || plaintext or ciphertext but the
> random AEAD message generation in testmgr extended tests did
> not obey this requirements producing messages with undefined
> behaviours. Fix it by syncing the copies if needed.
> 
> Since this only relevant for developer only extended tests any
> additional cycles/run time costs are negligible.
> 
> This fixes extended AEAD test failures with the ccree driver
> caused by illegal input.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Eric Biggers <ebiggers@kernel.org>
> ---
>  crypto/testmgr.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index cf565b063cdf..288f349a0cae 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -95,6 +95,11 @@ struct aead_test_suite {
>       /*
>        * Set if the algorithm intentionally ignores the last 8 bytes of the
>        * AAD buffer during decryption.
>        */
>       unsigned int esp_aad : 1;
> +
> +	/*
> +	 * Set if the algorithm requires the IV to trail the AAD buffer.
> +	 */
> +	unsigned int iv_aad : 1;
>  };

What's the difference between esp_aad and iv_aad?  Are you sure we need another
flag and not just use the existing flag?

If they're both needed, please document them properly.  You're currently setting
them both on some algorithms, which based on the current comments is a logical
contradiction because esp_aad is documented to mean that the last 8 bytes are
ignored while iv_aad is documented to mean that these bytes must be the IV.

>  
>  struct cipher_test_suite {
> @@ -2207,6 +2212,10 @@ static void generate_aead_message(struct aead_request *req,
>  
>  	/* Generate the AAD. */
>  	generate_random_bytes((u8 *)vec->assoc, vec->alen);
> +	/* For RFC4106 algs, a copy of the IV is part of the AAD */
> +	if (suite->iv_aad)
> +		memcpy(((u8 *)vec->assoc + vec->alen - ivsize), vec->iv,
> +		       ivsize);

What guarantees that vec->alen >= ivsize?

- Eric
