Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB01C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8FD206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HrvEj8+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGAFw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 01:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGAFw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 01:52:26 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96C7C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 22:52:26 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k6so15724855oij.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 22:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsQWUhxGHI4qfc235hpMf/7Q2ttwpb29HIoPyRwKMMI=;
        b=HrvEj8+kAfMpIVuEg8rKntHthW5PBJgjWjOHDW/5EwGtEb35gdr9WknU9/JdnzmV2q
         pq2XxKb+EYL+6wv1yg+ZzhikjN8a+4K1MFRZaVKGwu7qKKybw6SR5dhcVAkEGeYtRU+z
         HY72d4W/cmjwDoifgZPmGVs3gtw9GEGIBE5t9AlX5ng1gjVCvaiYxhtM6Fo6uAqdNWYW
         Mfa/ExUkAu1cEtj8IG6szT3aHy2m3sfydr687Ek1QhhxU6WbS7aCbPDd/CTRbU10b2kO
         BgTGwTgMfWqpfStoYJtBgGVT+y1xh2cflHTTdh6S4mBUgHreb3ZGuF66wnnVYDslqb6K
         NBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsQWUhxGHI4qfc235hpMf/7Q2ttwpb29HIoPyRwKMMI=;
        b=mixzmQYjR66nXRgWXJ4P2NAJepuC0oePGaIaEjA+G+752IiYKQFY9tJEs9/jLjTZtb
         RWC18IvB3p8cXRcD62IVRf5Aax9fVcyCXbmKDgiFppiiJZ7nAxUC2F1xki1kL0m9oGUg
         cNjS7YfgZ6QCeHEgSvmMzpZMaegawWdwaNa9ow4tVpPM4r5m74ywqpG2YqGR45z/WkxX
         g9IO9m4TD33LUDOepCJJOzJLtv/5LfcuEjeSFDRoDPzzDoiPPF0/wVRw9CkQe4hINSoc
         mstKZmjpMJ47JWXr7U1zhui+CLDDKJ6EeVRC2gvbgHfA1Tk2LOLKdiNR5PdCLiZm+FUx
         bqTw==
X-Gm-Message-State: AOAM532MvOOFkn4TL+jSoIIaitOvTPAf2cqaOPKlrGdAOehX1yEO3SeV
        hy+uTY1uvNs2zUhIc0nGAcmd2LJ8Pv8I4fAcrJeUEw==
X-Google-Smtp-Source: ABdhPJz7ANpdueEAdE+f31hXBrnPSYVTZC7iD2Dj5fjYx9dxzyDA682ZXvad81d0C1UdShsUEVoVgf9jCNdpgGi5WWs=
X-Received: by 2002:a05:6808:3ab:: with SMTP id n11mr13900356oie.121.1593582745833;
 Tue, 30 Jun 2020 22:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200701113448.3119f64f@canb.auug.org.au>
In-Reply-To: <20200701113448.3119f64f@canb.auug.org.au>
From:   Marco Elver <elver@google.com>
Date:   Wed, 1 Jul 2020 07:52:14 +0200
Message-ID: <CANpmjNMz0rtC7AnXUnZKfg+egqqQ3BKPznsWUdEqJQDLTgAaAQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rcu tree with the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 at 03:34, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the rcu tree got a conflict in:
>
>   kernel/kcsan/Makefile
>
> between commit:
>
>   f7c28e224da6 ("kbuild: remove cc-option test of -fno-stack-protector")

Is it possible that this patch drops the KCSAN portion? The patch
"kcsan: Simplify compiler flags" does the same, but is part of a
future pull request intended for 5.9.

The KCSAN changes had been in -next for well over a week. Also, I'm
sorry I hadn't seen your patch before, otherwise I would have noticed
this.

Please see: https://lkml.kernel.org/r/20200624190236.GA6603@paulmck-ThinkPad-P72

> from the kbuild tree and commits:
>
>   2839a232071f ("kcsan: Simplify compiler flags")
>   61d56d7aa5ec ("kcsan: Disable branch tracing in core runtime")
>
> from the rcu tree.
>
> I fixed it up (I just used the rcu tree version) and can carry the fix
> as necessary. This is now fixed as far as linux-next is concerned, but
> any non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thank you!

Thanks,
-- Marco
