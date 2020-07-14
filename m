Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CACC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD002082F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXVBKbo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgGNQQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgGNQQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:16:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33FAC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:16:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a8so17862522edy.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJAAkiMZvLbA+AbaUpZoAxP/9zA26GPbCpUDtX3Iaw0=;
        b=sXVBKbo9WzTyqzS+cenfmH7NMprrjkl7E2/IKGdTaxT3ttHcBJ/7EqcL7ThyfjJtBU
         mP00heFRE2CJNB28rt18anviIh7a8oj+q+OSqmvPZM1i4OE2pnzADns2q79a9thKjHbx
         FPkCMBIlNtHsVcU/tiGlqZ9O9rKPzMqBd70OJId2OBTjMDYDNR09B4q6TrrVY7HdULoY
         RZk9xGm1+/iij/+lPY4GyGZWYPJBGgWCF7UrFA7JLjkTJu5s2KUhW/wrledoXy1l35X7
         L7epTxjKULtM0CEQWT/XIyePNQ2gwDcrDv8qK1ssVnCMh2clXH5ucWEEPWqGnhhToiEz
         upfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJAAkiMZvLbA+AbaUpZoAxP/9zA26GPbCpUDtX3Iaw0=;
        b=rr2mYo2vEEAMuI43YrheuPaPehsyEYhUuZftzo6uJCWTrOEuc0r8MTPOUJ/NQ/v6fv
         2bBZWg4J4QanA/YKSBDfhA2WXDYe7EJnsDLYMzZN26BSCy0jeapWIHGpRWAxVFPJZWCG
         bclEF2SSB4h7bw/4geM+jp1ND++DYFKlwtGHazD6Pg2pjIlv+8K9ByySm8/P92lDm6GV
         +myeV/gscLT32/jEGv/HTxwk7SL+s+RvpvX1wagwsZ4ikf2fE5VfOAmUqaCDcOhhbvxw
         h5dW2cNKQll9jXOAxT0awzyjCxPmo78yNCORDmMCBlEZk2zAw/w67zYRVvN5d3/896Cf
         cNiw==
X-Gm-Message-State: AOAM530lWW9RR5LtZDtWHh8AOVyaMjR3wsSOlM4ewENr/PjfUrEgjTXE
        zUhIHt+yk4hPzpsbnZoSNfO1AJnW5AEiI3m4k9NB2w==
X-Google-Smtp-Source: ABdhPJzNi/7UkybDtVoiFAjUob/tmDhhxvh3g33zBS0Y7CPcLTcNAugl50BLXnG61QRkbhBFaeRXbnt4b9uY4+sUsBM=
X-Received: by 2002:a50:9e02:: with SMTP id z2mr5169887ede.87.1594743378417;
 Tue, 14 Jul 2020 09:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200630180255.GD37466@atomide.com> <20200702051213.GB3450@jagdpanzerIV.localdomain>
 <20200702160514.GK37466@atomide.com> <20200703103241.GB182102@jagdpanzerIV.localdomain>
 <CAHp75VdvNi_LWv7QhEsm1vQikeiMpi68qmCwoVttjnp7oq0ahg@mail.gmail.com>
 <877dvg6ft6.fsf@kurt> <20200706144314.GB1485@jagdpanzerIV.localdomain>
 <87o8oqa1zy.fsf@kurt> <20200708080712.GC571@jagdpanzerIV.localdomain>
 <20200708095215.GB4751@alley> <20200709132229.GD4380@jagdpanzerIV.localdomain>
In-Reply-To: <20200709132229.GD4380@jagdpanzerIV.localdomain>
From:   Raul Rangel <rrangel@google.com>
Date:   Tue, 14 Jul 2020 10:16:07 -0600
Message-ID: <CAHQZ30BEe4uPJ=7TZWAd5XtjKjFcjcfhr8GMaR6GKmEMrcTVqQ@mail.gmail.com>
Subject: Re: UART/TTY console deadlock
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "S, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,
So it looks like this was a red herring. We were getting spurious
interrupts which I suspect caused the console code to get called in
some critical section. Once we fixed the spurious interrupts we no
longer see the issue. Sorry for the noise.

Thanks,
Raul

On Thu, Jul 9, 2020 at 7:22 AM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (20/07/08 11:52), Petr Mladek wrote:
> >
> > I still believe that this is a false positive.
>
> I've no problems with that. The thing that I'm trying to improve here is the
> fact that from lockdep's point of view there are no false positives. lockdep
> reports the problem and then waves good bye. It disables itself. There might
> be some real suspend locking problems on some particular setups, but it's
> hard to tell, because console startup blows up the lockdep first.
>
>         -ss
