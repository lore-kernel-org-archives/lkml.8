Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B38C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFA52085B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592975097;
	bh=ocmTrcZAYoE6qK1ZUiI6NUWQlKft2d/AVoF0jMa1qBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V/p7rdu3ujydZRPzQLSP2gokMN9/fgB0aeInNf/bGBdYW4e960O9xcQvcMbZAMqPT
	 DVUHC7/x7oEGDzqZ+rfxb8Mgo1wRd1MN3KPMQADbVicAMsedxYs2rv2p4QsG2I8QsL
	 yckn2xSyFv1IOPfl5YxinKqmXGRRKOeOxqrEshdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbgFXFEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbgFXFEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:04:55 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C2D1206E2;
        Wed, 24 Jun 2020 05:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592975094;
        bh=ocmTrcZAYoE6qK1ZUiI6NUWQlKft2d/AVoF0jMa1qBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5eTDVAXhpa43ejK2xEiUedCXRJXaYi1eoRYuYX4atuFrkQD8Hh1zBaAv7gtdiEQL
         YquK9WbN7mEqHGb1uViRLKjaSEWkOdn+fR5dwZxwt4mf7wtDEJ5gQZAER9WJGPmP16
         GjQG/ysqiWcQGkZOGubhKN32ungBIpxX0ZRZ81as=
Date:   Tue, 23 Jun 2020 22:04:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        dm-crypt@saout.de, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: Re: [dm-crypt] [RFC PATCH 1/1] Add DM_CRYPT_FORCE_INLINE flag to
 dm-crypt target
Message-ID: <20200624050452.GB844@sol.localdomain>
References: <20200619164132.1648-1-ignat@cloudflare.com>
 <20200619164132.1648-2-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619164132.1648-2-ignat@cloudflare.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 05:41:32PM +0100, Ignat Korchagin wrote:
> Sometimes extra thread offloading imposed by dm-crypt hurts IO latency. This is
> especially visible on busy systems with many processes/threads. Moreover, most
> Crypto API implementaions are async, that is they offload crypto operations on
> their own, so this dm-crypt offloading is excessive.

This really should say "some Crypto API implementations are async" instead of
"most Crypto API implementations are async".

Notably, the AES-NI implementation of AES-XTS is synchronous if you call it in a
context where SIMD instructions are usable.  It's only asynchronous when SIMD is
not usable.  (This seems to have been missed in your blog post.)

> This adds a new flag, which directs dm-crypt not to offload crypto operations
> and process everything inline. For cases, where crypto operations cannot happen
> inline (hard interrupt context, for example the read path of the NVME driver),
> we offload the work to a tasklet rather than a workqueue.

This patch both removes some dm-crypt specific queueing, and changes decryption
to use softIRQ context instead of a workqueue.  It would be useful to know how
much of a difference the workqueue => softIRQ change makes by itself.  Such a
change could be useful for fscrypt as well.  (fscrypt uses a workqueue for
decryption, but besides that doesn't use any other queueing.)

> @@ -127,7 +128,7 @@ struct iv_elephant_private {
>   * and encrypts / decrypts at the same time.
>   */
>  enum flags { DM_CRYPT_SUSPENDED, DM_CRYPT_KEY_VALID,
> -	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD };
> +	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD, DM_CRYPT_FORCE_INLINE = (sizeof(unsigned long) * 8 - 1) };

Assigning a specific enum value isn't necessary.

> @@ -1458,13 +1459,18 @@ static void crypt_alloc_req_skcipher(struct crypt_config *cc,
>  
>  	skcipher_request_set_tfm(ctx->r.req, cc->cipher_tfm.tfms[key_index]);
>  
> -	/*
> -	 * Use REQ_MAY_BACKLOG so a cipher driver internally backlogs
> -	 * requests if driver request queue is full.
> -	 */
> -	skcipher_request_set_callback(ctx->r.req,
> -	    CRYPTO_TFM_REQ_MAY_BACKLOG,
> -	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));
> +	if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags))
> +		/* make sure we zero important fields of the request */
> +		skcipher_request_set_callback(ctx->r.req,
> +	        0, NULL, NULL);
> +	else
> +		/*
> +		 * Use REQ_MAY_BACKLOG so a cipher driver internally backlogs
> +		 * requests if driver request queue is full.
> +		 */
> +		skcipher_request_set_callback(ctx->r.req,
> +	        CRYPTO_TFM_REQ_MAY_BACKLOG,
> +	        kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));
>  }

This looks wrong.  Unless type=0 and mask=CRYPTO_ALG_ASYNC are passed to
crypto_alloc_skcipher(), the skcipher implementation can still be asynchronous,
in which case providing a callback is required.

Do you intend that the "force_inline" option forces the use of a synchronous
skcipher (alongside the other things it does)?  Or should it still allow
asynchronous ones?

We may not actually have a choice in that matter, since xts-aes-aesni has the
CRYPTO_ALG_ASYNC bit set (as I mentioned) despite being synchronous in most
cases; thus, the crypto API won't give you it if you ask for a synchronous
cipher.  So I think you still need to allow async skciphers?  That means a
callback is still always required.

- Eric
