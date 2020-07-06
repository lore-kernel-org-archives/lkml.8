Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17CCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8735420720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/TCBF0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgGFMvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbgGFMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:51:15 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE8C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 05:51:15 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id r8so31873673oij.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 05:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6K/gQHllEjKG6V7YEHC6mXh/d0A0514HaiYTu/7w0KE=;
        b=K/TCBF0arGBnub2yuM3Ys+hpRCXziFaidd7zsSp0WfPRRm5JlDOr69c3fBFCg5UIag
         wTtJovMb5C34s9ydSrtWByPa7OEyJjEegho979Fh3aHsI1Mlo+GInoBSmQwLYp7wioKP
         k4nd3QBJKNtxBZRp7fOUa7db9ylyf785/kjfROQUsra4S0o5e9gzyF47ChDRGtDYbxcz
         xTPAZ4W2+lmxklAYq6/nGvfZttv807MlTfemY76Qr/K9e7Pd503oOVddnMSOZ0TI+AqO
         9RA/nQ9uBGeeXxYxveVhEK40dDHAyicI3EZitQ4KEkPb9rrbx20Oz5MU3cxyAbM9xulV
         ZBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6K/gQHllEjKG6V7YEHC6mXh/d0A0514HaiYTu/7w0KE=;
        b=W4wFLIbiiSk/+D/KW+TWCXDgr1vFLCPwXpwiNxMjcI++ys9L3o3ctQiKgd8uYBIHz+
         OWkNMv4QKRSqX2ecuD5X+eNKUA9NWKV91lh1A9D1cvLwVWCuC5J9BujSH/MSFAi2DHuU
         JN1mf3bYxmXJcQa7DxvcLwgvztdaGeD4jYwBDzRMONfADhrh2P9HldWPXueNzIGFE6MC
         XrLJwjx7bW+VKvh+1Wvy4HBC+P6h1o/Bpt2Ho5SQ6fPMonbNB9+c6zBViZ2r12f/GqnC
         3eyyqr1JCdLYJ7CUswxfOCKiN8N7LP1CzG2f1uaVwhIt37Qj+frwkbZUUbkKo5x8IhyO
         zGRw==
X-Gm-Message-State: AOAM532osRft2khvdZleKslJflRmpr2B6SuTtJpEUswFthUliiR1uxI2
        66t1QmxUYyijBX00wRpIrJksSgD40B9ikQ/DDFEIH5tP
X-Google-Smtp-Source: ABdhPJzypBqvNsr8B06CaWYR9FFAwMjmPnbqqe1yxbcFNniqNgggV9UZ+VA+lxsoXy6uTDCrXRDhksKauqBsaNFyPO0=
X-Received: by 2002:aca:e0d6:: with SMTP id x205mr25402446oig.176.1594039874235;
 Mon, 06 Jul 2020 05:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAFhKne_ZVWVhZX5hNEbeGBfU6BMRN9JKQeTsVYOcMmEH1cd3xg@mail.gmail.com>
 <87h7ul15le.fsf@notabene.neil.brown.name> <20200706072221.GA1947246@kroah.com>
 <CAMuHMdWj2d5GF1ZkuhzQxg9teA51zjF0oQQPWcphzK=kJ6-x9Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWj2d5GF1ZkuhzQxg9teA51zjF0oQQPWcphzK=kJ6-x9Q@mail.gmail.com>
From:   Matthew Wilcox <willy6545@gmail.com>
Date:   Mon, 6 Jul 2020 08:51:03 -0400
Message-ID: <CAFhKne9vswg3Q4mTOz4WP6QWJ8tDH+SNx1Pu7LotLagoNURKgw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chris Mason <clm@fb.clm>,
        tech-board-discuss@lists.linuxfoundation.org,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 3:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Jul 6, 2020 at 9:22 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Jul 06, 2020 at 05:10:37PM +1000, NeilBrown wrote:
> > > On Sat, Jul 04 2020, Matthew Wilcox wrote:
> > > > Another suggestion for "slave" replacement should be "device". This is in
> > > > the context of the w1 bus which is by far the largest user of the
> > > > master/slave terminology in the kernel.
>
> W1 the largest? Really?

I should have said "most obnoxious".  They managed to put that terminology in
filenames, eg drivers/w1/slaves and Documentation/w1/slaves

In terms of number of lines of code using the word, it's only seventh
in drivers/:

$ for i in drivers/*; do c=$(find $i -type f |xargs grep slave |wc
-l); echo "$c $i"; done |sort -rn |head
5218 drivers/net
1341 drivers/dma
988 drivers/i2c
695 drivers/gpu
666 drivers/soundwire
665 drivers/spi
559 drivers/w1
461 drivers/infiniband
389 drivers/media
301 drivers/scsi
