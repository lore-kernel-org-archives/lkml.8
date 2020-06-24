Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18898C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B84C720823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="mMFvGWgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbgFXIYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387686AbgFXIYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:24:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87857C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:24:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so1337782wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKUQqWYXss6UwsektNBxaUWSfkOypOmk+SBkux4cMko=;
        b=mMFvGWgskiXX5B9MQk1cfQBjIG3qZlKBwOJPyUMMYjhIZ/EBo+myrbFP36HlSsm8r4
         pod2Xgm1SBGmSNNMs0AUKNvEmgTkpqaIzxXPavKtkIZ9sMVO11c4F4vkYXC5DDPJEPZg
         zUh7ITRRHE2v5azCJkuMT+m7EOaKDYUnqMf3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKUQqWYXss6UwsektNBxaUWSfkOypOmk+SBkux4cMko=;
        b=MtLc4N7kJGbMi6Wjqlf+KG0H68P7an5QuBrDo3bngITji8iwn4jJuaXg8E2KFdjApw
         YyoPG0liZw2b5H6fzeQvU4E95QDdLR/vBTLZ/P78G2+MTrVLSaaXZAotLl8TJmGog1Ya
         69UkSq5fmu4wQlOrQIQtNvUlKODLzyiupYjaHDlvAbHImPttIzkbqBubarycgicFaZtP
         x4778sk87rCiDifOLxFJViJ8aBytlI6Woedbfh4gJ61YLI2QQ5DU9uRL7Rk4O+cWPyPN
         4Z9rvYVZR7oePYUOXWxTdvBAjepc/aieYo7libU6cFRdlLCx3CZ+QmXIesK40EVHDyfD
         If/g==
X-Gm-Message-State: AOAM531LqQAi02S8MvSOgGJ6cIK0AGtvTdXW/YBNcs+j/1YPgxw9I5v6
        FWercFXkK5h4ugeiCppncU1zRcqoMuzD6+Es7AEWlg==
X-Google-Smtp-Source: ABdhPJyKC3fB2hgjwO4U2iyPJhYP+1AXJWpKVX8yrLAoKxRHvzRgYg1hcxJiDkHh3RVaaIs2U2agEDv6018f1mhKK5Y=
X-Received: by 2002:a5d:4992:: with SMTP id r18mr3963401wrq.323.1592987058129;
 Wed, 24 Jun 2020 01:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200619164132.1648-1-ignat@cloudflare.com> <20200619164132.1648-2-ignat@cloudflare.com>
 <20200624050452.GB844@sol.localdomain>
In-Reply-To: <20200624050452.GB844@sol.localdomain>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 24 Jun 2020 09:24:07 +0100
Message-ID: <CALrw=nFduv_X83V1Dfz+bt4bZqT19OSi3q5f7umhty1-DQ2SPg@mail.gmail.com>
Subject: Re: [dm-crypt] [RFC PATCH 1/1] Add DM_CRYPT_FORCE_INLINE flag to
 dm-crypt target
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     agk@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, dm-crypt@saout.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 6:04 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Jun 19, 2020 at 05:41:32PM +0100, Ignat Korchagin wrote:
> > Sometimes extra thread offloading imposed by dm-crypt hurts IO latency. This is
> > especially visible on busy systems with many processes/threads. Moreover, most
> > Crypto API implementaions are async, that is they offload crypto operations on
> > their own, so this dm-crypt offloading is excessive.
>
> This really should say "some Crypto API implementations are async" instead of
> "most Crypto API implementations are async".

The most accurate would probably be: most hardware-accelerated Crypto
API implementations are async

> Notably, the AES-NI implementation of AES-XTS is synchronous if you call it in a
> context where SIMD instructions are usable.  It's only asynchronous when SIMD is
> not usable.  (This seems to have been missed in your blog post.)

No, it was not. This is exactly why we made xts-proxy Crypto API
module as a second patch. But it seems now it does not make a big
difference if a used Crypto API implementation is synchronous as well
(based on some benchmarks outlined in the cover letter to this patch).
I think the v2 of this patch will not require a synchronous Crypto
API. This is probably a right thing to do, as the "inline" flag should
control the way how dm-crypt itself handles requests, not how Crypto
API handles requests. If a user wants to ensure a particular
synchronous Crypto API implementation, they can already reconfigure
dm-crypt and specify the implementation with a "capi:" prefix in the
the dm table description.

> > This adds a new flag, which directs dm-crypt not to offload crypto operations
> > and process everything inline. For cases, where crypto operations cannot happen
> > inline (hard interrupt context, for example the read path of the NVME driver),
> > we offload the work to a tasklet rather than a workqueue.
>
> This patch both removes some dm-crypt specific queueing, and changes decryption
> to use softIRQ context instead of a workqueue.  It would be useful to know how
> much of a difference the workqueue => softIRQ change makes by itself.  Such a
> change could be useful for fscrypt as well.  (fscrypt uses a workqueue for
> decryption, but besides that doesn't use any other queueing.)
>
> > @@ -127,7 +128,7 @@ struct iv_elephant_private {
> >   * and encrypts / decrypts at the same time.
> >   */
> >  enum flags { DM_CRYPT_SUSPENDED, DM_CRYPT_KEY_VALID,
> > -          DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD };
> > +          DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD, DM_CRYPT_FORCE_INLINE = (sizeof(unsigned long) * 8 - 1) };
>
> Assigning a specific enum value isn't necessary.

Yes, this is a leftover from our "internal" patch which I wanted to
make "future proof" in case future iterations of dm-crypt will add
some flags to avoid flag collisions. Will remove in v2.

>
> > @@ -1458,13 +1459,18 @@ static void crypt_alloc_req_skcipher(struct crypt_config *cc,
> >
> >       skcipher_request_set_tfm(ctx->r.req, cc->cipher_tfm.tfms[key_index]);
> >
> > -     /*
> > -      * Use REQ_MAY_BACKLOG so a cipher driver internally backlogs
> > -      * requests if driver request queue is full.
> > -      */
> > -     skcipher_request_set_callback(ctx->r.req,
> > -         CRYPTO_TFM_REQ_MAY_BACKLOG,
> > -         kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));
> > +     if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags))
> > +             /* make sure we zero important fields of the request */
> > +             skcipher_request_set_callback(ctx->r.req,
> > +             0, NULL, NULL);
> > +     else
> > +             /*
> > +              * Use REQ_MAY_BACKLOG so a cipher driver internally backlogs
> > +              * requests if driver request queue is full.
> > +              */
> > +             skcipher_request_set_callback(ctx->r.req,
> > +             CRYPTO_TFM_REQ_MAY_BACKLOG,
> > +             kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));
> >  }
>
> This looks wrong.  Unless type=0 and mask=CRYPTO_ALG_ASYNC are passed to
> crypto_alloc_skcipher(), the skcipher implementation can still be asynchronous,
> in which case providing a callback is required.
>
> Do you intend that the "force_inline" option forces the use of a synchronous
> skcipher (alongside the other things it does)?  Or should it still allow
> asynchronous ones?

As mentioned above, I don't think we should require synchronous crypto
with the "force_inline" flag anymore. Although we may remove
CRYPTO_TFM_REQ_MAY_BACKLOG with the inline flag.

> We may not actually have a choice in that matter, since xts-aes-aesni has the
> CRYPTO_ALG_ASYNC bit set (as I mentioned) despite being synchronous in most
> cases; thus, the crypto API won't give you it if you ask for a synchronous
> cipher.  So I think you still need to allow async skciphers?  That means a
> callback is still always required.
>
> - Eric
