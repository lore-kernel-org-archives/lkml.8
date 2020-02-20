Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819F4C5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1372465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582161715;
	bh=/gXQCLejWet2wB1RtNnXTfft6r8xlIGrgmxJlT/VpK8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cSdxaNpt1ubEjg3H8rQ3HN1vC95uwff/iWFYQzuBz3aRfM/HIZffDx8sr4BDAEMc9
	 z59zd4fuJ1sXyV8T3NI8zKUZ+ntFVs/IhzgmNszuob/KJe8I9yhWhE40Qoj6NHRDFb
	 zFMZI0pBaK1wmUI+Mw2ysnFB566FQkZx6npCoIi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgBTBVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:21:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36848 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBTBVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:21:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id f24so1701420lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 17:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbQuf+GtIv5ENkR5EOBV/0SjhBAjvOXcFmXLUjHR2lU=;
        b=XnycSrB0jCwOgjAd3Tk6WrvlvVoT7sGo/6hbjO/h17hHZbwSad2xHVSEurbThdfKcw
         IjbcEMvts9odqDAPeKQrOB+po4yNFk6ZQwUgiYxvXDRHn/9ZXwwMjrof8oZcnJ1NLe3F
         1a4LZIPhqkrmhgz/lVmfbuWYq8UagFoajp4YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbQuf+GtIv5ENkR5EOBV/0SjhBAjvOXcFmXLUjHR2lU=;
        b=W652yYKfImmJq0Pa4Pq/ua/1kEh/G5dEiZcu95qYbgOq9tYlzARChvhOg5U84cNm+s
         UDUHobPyrroRcdK24yPe8LTLFASKolYbEBn0Kq4R1NtOW2zVFJzAEsBndgxVxWdx8m3K
         vF5f5ijH9wg78YsV3/TtjH53qRlnyhMYoViEDiEAj0lfWjQnj9/BLzzZ+vN3O1uO3Nxx
         TPDOE1d+oyBEtjJSDJqyxZz+hOoiPbqThzpChbTgkT5dqSthc9k7N+cKjAELCh5ngNdY
         cQ2yscdi27YLiZCADY9VcC81mEjyJ6XaYW3Pug7LXJ33TFMBF1ijTayxtWL9R6+CWNMr
         Clmg==
X-Gm-Message-State: APjAAAUTHsXG7Gi0i2qhlm4AAaChyBjCXiz1h59Ws8BLcrnTtSchuBVg
        73XJg52q00v6fep8xxWidbiDksWkSq8=
X-Google-Smtp-Source: APXvYqx1Uhs0oMaR89/j9aseniboyF2Ck6tyDQBH5usWea+YE7OnRvP3pSfEkEO5X5DV0IF33MlAag==
X-Received: by 2002:ac2:55a8:: with SMTP id y8mr15181167lfg.117.1582161711140;
        Wed, 19 Feb 2020 17:21:51 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e5sm696678lfn.66.2020.02.19.17.21.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 17:21:50 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id o15so2415890ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 17:21:49 -0800 (PST)
X-Received: by 2002:a2e:461a:: with SMTP id t26mr17213618lja.204.1582161709449;
 Wed, 19 Feb 2020 17:21:49 -0800 (PST)
MIME-Version: 1.0
References: <158215745745.386537.12978619503606431141.stgit@warthog.procyon.org.uk>
In-Reply-To: <158215745745.386537.12978619503606431141.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Feb 2020 17:21:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=whOAg2EJycA=x=8RzBy3dnDFsgnyxrjREyNu6-8+eTTHA@mail.gmail.com>
Message-ID: <CAHk-=whOAg2EJycA=x=8RzBy3dnDFsgnyxrjREyNu6-8+eTTHA@mail.gmail.com>
Subject: Re: [RFC PATCH] afs: Create a mountpoint through symlink() and remove
 through rmdir()
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 4:11 PM David Howells <dhowells@redhat.com> wrote:
>
> If symlink() is given a magic prefix in the target string, turn it into a
> mountpoint instead.
>
> The prefix is "//_afs3_mount:".

That sounds sane.

Your argument that if the prefix is made really long it couldn't be a
valid symlink at all on AFS is fair, but seems somewhat excessive.

The only issue I see with this interface is that you can now create
these kinds of things by untarring a tar-ball etc.

I can see that being both very convenient and a possible security
pain. But I'm assuming that the real security is on the server side
anyway and not just anybody can create arbitrary things like these?

         Linus
