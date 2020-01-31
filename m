Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40598C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F275520707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBwi+v3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgAaSxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:53:00 -0500
Received: from mail-yw1-f49.google.com ([209.85.161.49]:38936 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgAaSw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:52:59 -0500
Received: by mail-yw1-f49.google.com with SMTP id h126so5728960ywc.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 10:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0s7YpmADBv+t+tBrz8o8hArCzglfv7ZyrkHlwe8Xs0Y=;
        b=fBwi+v3OiAWodzp2Ig6HRxK2tYzwRLxmcZN8FM/4XdodTKWRFelgoGATjmyI0Hz54u
         W+5md8mn4LzEUlNuQ1saf0BQHdwzh9QMzWghJhqyqlCT6k5zqRi9Yzo0H0tjLznleCIL
         iBQVGkVcKsE7QjUBVe+wTqIpsnnkspeoUJGtvSQFP2GuyH3PiCKgbftEg0CS0dfLG+Ml
         Kf1vbdzXbrr94PGg+V8aCZcUY9HZ7uyt3ulQEYRsbWuTUVkaiXbi9lzg1zb1FrFb6djP
         xJGhKgOxCOvrMa7CctuPXhE4a88uOmjxsrUZQZ3MwAnxssg+71FBUCDvZGiatShVNAQP
         KGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0s7YpmADBv+t+tBrz8o8hArCzglfv7ZyrkHlwe8Xs0Y=;
        b=U81KeGB5XjIx4PqPX9yajhq687tmHt13NtAYouzkxTHAjiJ52bdMSLuIL33v4oPWMA
         VaSOmEy/gRgdx4PU7lNL4gHnExDkNOK9WZ+zBbou0gGnkG9V2y5IXvuvQcl0Zk8yxG77
         FWaRX02O1ib+J2GTn+T1iIMurQM/T81yxePyBJJvekXxZdOJzKgDfRH/ExOSYKcVXWLZ
         9m9K3IGR7QV2pDrHqM6rkU3Xi32Qg7OCQbkOS5Vv6mJGoqaKNkFyWiI7rSdR5IOOydA0
         Card7fJT52GuVpd6PpfQ3d6Q2miBNWcxFnoZYGKfZiq43MQG3z/lrI5SllcnMrR915Ce
         kOuw==
X-Gm-Message-State: APjAAAXDfxIf6lPFbY58We0/FdnR1imCluZ12fROZBi/jSZXB+Ml0FXu
        HpwXsFpECmye5kBX1xLKfOCNt/S+cbYVQ/ohKsRleg==
X-Google-Smtp-Source: APXvYqxxYLiRs9Aj7YwcdJ1UtdGWJM2u8g4ZtSeojEOgMsSWPiWPdWK81fOk+T++sHs3LCv5GyHQE7YEf/iRuzV4Ai8=
X-Received: by 2002:a25:d9d4:: with SMTP id q203mr1874186ybg.274.1580496777997;
 Fri, 31 Jan 2020 10:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20200131164308.GA5175@willie-the-truck> <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131184322.GA11457@worktop.programming.kicks-ass.net> <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
In-Reply-To: <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 10:52:46 -0800
Message-ID: <CANn89i+pExLRqJxbamGv=uDi2kWY-1CKsh1DcAgfdh9DjpQx3A@mail.gmail.com>
Subject: Re: Confused about hlist_unhashed_lockless()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:48 AM Eric Dumazet <edumazet@google.com> wrote:
>

> This is nice, now with have data_race()
>
> Remember these patches were sent 2 months ago, at a time we were
> trying to sort out things.
>
> data_race() was merged a few days ago.

Well, actually data_race() is not there yet anyway.

Is it really scheduled for 5.7 kernel ?
