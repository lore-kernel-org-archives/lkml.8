Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18B2C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CE420674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584379642;
	bh=wXFLBrkpKhjpY6+Ujrinlm5M6ZYSupEkDI0IB7eLs6I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BDyKAoml8KN9NJRH7bZqYBf8uGPzC7uZhQgwBe9Ze5J/Nvbf+r5ncc5kqul3w/L7g
	 jkCW7LjKz9syGS7Qp9VgzT81djJmWtduGupM76wodiVEXvliDpQCdre51a6Zxp3Y+4
	 HFOa3C8iOYUiesRq3EQdfEoEXdZWJOA652XTVx1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbgCPR1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:27:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41710 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731136AbgCPR1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:27:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id o10so19599879ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DMMGwqm11i++eOrcoQ51CLKjc9B8b60ZGiRJoVHy98E=;
        b=MJ9Q/HYw+ovlaE/zZJRh9JpRhaw6V6SXu5XO1Fqqu6ZGU01dZu/JLzEnPevXgP4zYB
         fn3GePVRLo5oklQpIogzLt9PPFM4dRyaGtnemw6mxcBTBnDjLUI1HuYPUqH98zL/Dqq5
         uadBDvnI/AUR6Dw/rt2wU0UlVVYE8g2lIyAVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMMGwqm11i++eOrcoQ51CLKjc9B8b60ZGiRJoVHy98E=;
        b=MrCOA6pjyb2FLX9zqkQBwqzMgvS9pz2/8tJKFPBJpxzCDfDVuBXdxVzwPwcgsb/e1b
         y0bh3kJfv1q4q+8F0Ig2+bX/pQ72kZ1pMGYbtpufHMpTELP+tt5T61B7bgGZue3si/ii
         noyYmsIoi4Af9IqwfUqjDqFrWx8ojuIrvoBxyHqGLtAwXHh0ApwaSbdiNW4rKffAxvDl
         yCTlVJtoXdZa0gFKqPnKY4HTyiRScK9OYW8llBBpWK64wNiaM/PJZLjVJKQ3zAFQaTjh
         SohhnY2tVDZV5Z7kdIppgfzbwH1VJlo07xaIjV9/IPHkw+2Biqd4JYN27muBCzgeN1uK
         MuvQ==
X-Gm-Message-State: ANhLgQ29q4+3Q6E0hlKymnyeqZFJsvTaNIigbNAqPHARvuUuqR0OjJQl
        diJjsCnLrmkTAIWiOrIqYBEl5Xqc5d8=
X-Google-Smtp-Source: ADFU+vs4/Wz2QyQREY+hmCMGffc6j4ceG3eK/j2SWkwTX8B4pHDGNFBWH8/FcnXTDzM13b6SUwipNA==
X-Received: by 2002:a2e:868b:: with SMTP id l11mr212434lji.69.1584379637779;
        Mon, 16 Mar 2020 10:27:17 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m16sm355035lfb.59.2020.03.16.10.27.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 10:27:16 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id j15so14815691lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 10:27:16 -0700 (PDT)
X-Received: by 2002:ac2:5508:: with SMTP id j8mr273495lfk.31.1584379635940;
 Mon, 16 Mar 2020 10:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200308140314.GQ5972@shao2-debian> <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
 <87blp5urwq.fsf@notabene.neil.brown.name> <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
 <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com> <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
 <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
 <878sk7vs8q.fsf@notabene.neil.brown.name> <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
 <875zfbvrbm.fsf@notabene.neil.brown.name> <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
 <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
 <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
 <87v9nattul.fsf@notabene.neil.brown.name> <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
 <87o8t2tc9s.fsf@notabene.neil.brown.name> <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
 <f000e352d9e103b3ade3506aac225920420d2323.camel@kernel.org>
 <877dznu0pk.fsf@notabene.neil.brown.name> <CAHk-=whYQqtW6B7oPmPr9-PXwyqUneF4sSFE+o3=7QcENstE-g@mail.gmail.com>
 <b5a1bb4c4494a370f915af479bcdf8b3b351eb6d.camel@kernel.org>
 <87pndcsxc6.fsf@notabene.neil.brown.name> <ce48ed9e48eda3c0f27d2f417314bd00cb1a68db.camel@kernel.org>
In-Reply-To: <ce48ed9e48eda3c0f27d2f417314bd00cb1a68db.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Mar 2020 10:26:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnqDS0NJtAaArVeYQz3hcU=4Ja3auB1Jvs42eADfUgMQ@mail.gmail.com>
Message-ID: <CAHk-=whnqDS0NJtAaArVeYQz3hcU=4Ja3auB1Jvs42eADfUgMQ@mail.gmail.com>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 4:07 AM Jeff Layton <jlayton@kernel.org> wrote:
>
>
> +       /*
> +        * If fl_blocker is NULL, it won't be set again as this thread "owns"
> +        * the lock and is the only one that might try to claim the lock.
> +        * Because fl_blocker is explicitly set last during a delete, it's
> +        * safe to locklessly test to see if it's NULL. If it is, then we know
> +        * that no new locks can be inserted into its fl_blocked_requests list,
> +        * and we can therefore avoid doing anything further as long as that
> +        * list is empty.
> +        */
> +       if (!smp_load_acquire(&waiter->fl_blocker) &&
> +           list_empty(&waiter->fl_blocked_requests))
> +               return status;

Ack. This looks sane to me now.

yangerkun - how did you find the original problem?

Would you mind using whatever stress test that caused commit
6d390e4b5d48 ("locks: fix a potential use-after-free problem when
wakeup a waiter") with this patch? And if you did it analytically,
you're a champ and should look at this patch too!

Thanks,

              Linus
