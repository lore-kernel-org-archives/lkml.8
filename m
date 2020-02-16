Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89B0C7619D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D98520729
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFOD3H1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgBPPww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 10:52:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46012 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgBPPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 10:52:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so7584812pgk.12;
        Sun, 16 Feb 2020 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iPFMbfU6diExASqyRYQaLYTU+lXefr7fxHQr7uWuD1Y=;
        b=dFOD3H1/B31VEchMzaUoJ9SUKJtUO6Ioafl/z7DDVOwR6NtDtBMs/13RMPQQzMJ18Y
         c5C04QkzccXncDGICuf/5t/aIGwm7HczFeWtMY+Jo3fy/YcQCQRsbKRTbmcFsW15LoeS
         5M5xHHjjHalh62RK5nUwazqACK6SczFYM1kEOfjlJRCmKpAnWL3N2Dep6gnyRcSdCy0j
         drXeDHCcx1PHXAG2jqXie+iYrkyxLoed7F+tWrFY6O9hhTv2nZuJnslWCSQRk5+QSpNy
         sE6STD6lqxoHPqpbLU3HpctlWUYllldWX66W6Xuc8lCiNKK33NnaGyAvPFFaJicEiWcX
         AudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iPFMbfU6diExASqyRYQaLYTU+lXefr7fxHQr7uWuD1Y=;
        b=Ce5Uvke37UAa8RpF2SW3BtSKhcv7DautnH5GjasaD7SQArf0wyJ2IGjeL54vqs5iJd
         Vd+DB2MtxuXHk1GnNYhDHquVe4ufSoS37hNnJjt9ysz+tnJ4/NZoAdF1vejy00Ofyifu
         hjXMUn/8jcfVJg+qlQGd8jNZBbMSia+GPFFPmd4nPt2N91xlFMH8kIwkGo6x+NoOrLBj
         yK6+rv8027dfrgp1eoMJgnyakfzsBWBTlt+850pRdPLedPoJV3rURFDr3VSNi274aOc+
         cRjDORUAft+oFsm8Z4RKyz1xllj6xaZZLTHurJsuu/HHrHBLs3W087A+BNWLzpbwcmXy
         eJ3w==
X-Gm-Message-State: APjAAAUlIwzSKLBYn1VZq8gDS7zo54V2MrJ60P4ySu5MByEr0vXcNT8W
        GOte4ERV7OC/cIh7FZ0cR1ooYac=
X-Google-Smtp-Source: APXvYqx4ANLkD4bX8522tWsKbJuWTodQcLty70mtlhDXz7killP931Qu5hSGCSz5PkBfEfbEtN3CHw==
X-Received: by 2002:aa7:961b:: with SMTP id q27mr12847463pfg.23.1581868370704;
        Sun, 16 Feb 2020 07:52:50 -0800 (PST)
Received: from madhuparna-HP-Notebook ([2402:3a80:d03:50cf:14b2:4950:fe83:57e])
        by smtp.gmail.com with ESMTPSA id c1sm13631769pfa.51.2020.02.16.07.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Feb 2020 07:52:50 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Sun, 16 Feb 2020 21:22:44 +0530
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
        davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] net: batman-adv: Use built-in RCU list checking
Message-ID: <20200216155243.GB4542@madhuparna-HP-Notebook>
References: <20200216144718.2841-1-madhuparnabhowmik10@gmail.com>
 <3655191.udZcvKk8tv@sven-edge>
 <20200216153324.GA4542@madhuparna-HP-Notebook>
 <1634394.jP7ydfi60B@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634394.jP7ydfi60B@sven-edge>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 04:35:54PM +0100, Sven Eckelmann wrote:
> On Sunday, 16 February 2020 16:33:24 CET Madhuparna Bhowmik wrote:
> [...]
> > > Can you tell us how you've identified these four hlist_for_each_entry_rcu?
> >
> > The other hlist_for_each_entry_rcu() are used under the protection of
> > rcu_read_lock(). We only need to pass the cond when
> > hlist_for_each_entry_rcu() is used under a
> > different lock (not under rcu_red_lock()) because according to the current scheme a lockdep splat
> > is generated when hlist_for_each_entry_rcu() is used outside of
> > rcu_read_lock() or the lockdep condition (the cond argument) evaluates
> > to false. So, we need to pass this cond when it is used under the
> > protection of spinlock or mutex etc. and not required if rcu_read_lock()
> > is used.
> 
> I understand this part. I was asking how you've identified them. Did you use 
> any tool for that? coccinelle, sparse, ...
>
Hi,

Not really, I did it manually by inspecting each occurence.
Thank you,
Madhuparna

> Kind regards,
> 	Sven


