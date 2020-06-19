Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E55C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 680E5206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="wvaHmbVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390197AbgFSTpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389877AbgFSTpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:45:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C04C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:45:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q2so8369232wrv.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qa/SGQ5p7b66E33hW6+x88Sl1GCC1UqRDbxtplLHMyo=;
        b=wvaHmbVc03z8sxgT5+NeeKq3DtEy5tOUopJ7aMUNhvLSMwsgffuoLV2dQPsd8V4kqj
         8ts2lc6IPfPipbb7WWOFp4dHelewrAYPn4gKiratsUGrHGmu4dDfqDZHH1aWt7m3MY5/
         eTAiR8q6MNyw901TqZbnZnp0NFFOCfE2e/+S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qa/SGQ5p7b66E33hW6+x88Sl1GCC1UqRDbxtplLHMyo=;
        b=WFpu9yW+ETyv1xB17XKrKekWduBiWTavHozU6N2yirb/9Z4iRYh5M4rcUraYwBFs66
         lHU3DkxL1q+dp2duqsZzBKNYFE6qItyBzCOZxCsMKyslYq/VL53fpb+pyUUjlCdmm33T
         rwyluFys4DDfDHslngNKSfTqCQzPNNiqkJB/D6BrgsbIi5zrHUXfMwf9GPYDbOiRTZGt
         YIo3F9RqhQpU8hY+xeRqQmWWr1t3p/OPdA9gu0NmEeS2bNqZEbUF0eFpi04fVIsvIuZ/
         wTRnrDQlZrnzVtLMkqQSAj3YVGgM2Cdy5Yp3q/ieFCoePFcYtvy4lUFnaKY+vCteynBB
         WNgA==
X-Gm-Message-State: AOAM532gvCGDYzWKBPIkRMvnNGzWZMOwgoZVkNyswsPWLlqOSgik/Lkm
        EzU1WnC83J9I0AfurBZGPingiw0hFtluY9c8dXB4xA==
X-Google-Smtp-Source: ABdhPJxbC6lp4MxQf0dfsCqDKCB2VGeC8/eWBp3p6IZm0evbtMuNDv3X63KOzuz2U5svP/1Vk0NdYx1m+kIGwkUHFrc=
X-Received: by 2002:adf:958a:: with SMTP id p10mr5367723wrp.323.1592595908766;
 Fri, 19 Jun 2020 12:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200619164132.1648-1-ignat@cloudflare.com> <20200619165548.GA24779@redhat.com>
 <alpine.LRH.2.02.2006191429060.23991@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2006191429060.23991@file01.intranet.prod.int.rdu2.redhat.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Fri, 19 Jun 2020 20:44:58 +0100
Message-ID: <CALrw=nEBjfV5e35z89Nxy0Gix1SeLyGOP5pvxF8xS0Wy7XfDYw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] dm-crypt excessive overhead
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, dm-crypt@saout.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 7:39 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Fri, 19 Jun 2020, Mike Snitzer wrote:
>
> > On Fri, Jun 19 2020 at 12:41pm -0400,
> > Ignat Korchagin <ignat@cloudflare.com> wrote:
> >
> > > This is a follow up from the long-forgotten [1], but with some more convincing
> > > evidence. Consider the following script:
> > >
> > > [1]: https://www.spinics.net/lists/dm-crypt/msg07516.html
> > > [2]: https://blog.cloudflare.com/speeding-up-linux-disk-encryption/
> > >
> > > Ignat Korchagin (1):
> > >   Add DM_CRYPT_FORCE_INLINE flag to dm-crypt target
> > >
> > >  drivers/md/dm-crypt.c | 55 +++++++++++++++++++++++++++++++++----------
> > >  1 file changed, 43 insertions(+), 12 deletions(-)
> > >
> > > --
> > > 2.20.1
> > >
> >
> > Hi,
> >
> > I saw [2] and have been expecting something from cloudflare ever since.
> > Nice to see this submission.
> >
> > There is useful context in your 0th patch header.  I'll likely merge
> > parts of this patch header with the more terse 1/1 header (reality is
> > there only needed to be a single patch submission).
> >
> > Will review and stage accordingly if all looks fine to me.  Mikulas,
> > please have a look too.
> >
> > Thanks,
> > Mike
>
> +       if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags)) {
> +               if (in_irq()) {
> +                       /* Crypto API will fail hard in hard IRQ context */
> +                       tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
> +                       tasklet_schedule(&io->tasklet);
> +               } else
> +                       kcryptd_crypt(&io->work);
> +       } else {
> +               INIT_WORK(&io->work, kcryptd_crypt);
> +               queue_work(cc->crypt_queue, &io->work);
> +       }
>
> I'm looking at this and I'd like to know why does the crypto API fail in
> hard-irq context and why does it work in tasklet context. What's the exact
> reason behind this?

This comes from
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/crypto/skcipher.c?id=5e857ce6eae7ca21b2055cca4885545e29228fe2#n433
And, I believe, it is there for the same reason kcryptd was introduced
in 2005 in dm-crypt:
"...because it would be very unwise to do decryption in an interrupt
context..." (that is, when other interrupts are disabled). In tasklet
however we can still service other interrupts even if we process a
large block.

>
>
> Mikulas
