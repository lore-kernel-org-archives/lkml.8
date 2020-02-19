Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F5BC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0FA2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oad5ul2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgBSCNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:13:48 -0500
Received: from mail-pj1-f46.google.com ([209.85.216.46]:53594 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgBSCNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:13:48 -0500
Received: by mail-pj1-f46.google.com with SMTP id n96so1886957pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h3tV4S0r8Xq95lxRY98z1zfIs74BXQjGM8f1J1KjwCw=;
        b=Oad5ul2+5v3Jb1DwLO1sTnm7xES/z32bxAG/kYEFeN8L1anPcv2/uAMu29EOp0ZW3x
         SZo97zJGVSwaCJf9PU6nPVg90IRPEUWutv5cD5INnbGmQEoSs+x7jVTwxJyaaVGBc5iW
         xaxC8QcUC9cmNugyA9k8TQJUxTLiS2DSZFpJZGub5ysJIJ/7LaaDVLj4zTk+Xu27uVXs
         48FHnBmz6syyFiGrY7MCXUTmzUw2VC4VR9nH++0To6R6NGnOHqJ9Hm1oCt/+ETdIRRcO
         vSXc0MNHNH/Couy0rIQuF8d9oanR1qqFNTEoyd3CdfBetNN3fcNynNGKUFHiudUe9uaR
         g4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h3tV4S0r8Xq95lxRY98z1zfIs74BXQjGM8f1J1KjwCw=;
        b=R3nNTERxxGr2DlgU2Zrqz9kqZO2K18QBp2GhEdX00vFtwzCskCKTbOSDuB+jEsiIZd
         fdpiPLrqpy9JbWBhO4gntzCThl8IL0CGJZua1R7Z8y2bTap7p5osYk8bMKN80ZQWW4WI
         mvKxwQ3KbV3UsgO/C814tJujhqQIipU9C8wAnVk/uHCHlp5MRQI3EOjj3WaXb+vRd4aM
         LinwMFz2u0VPU820UdayKu9jaZYP98IK3cxYAzdfkrCFNgvyKvRKKSSdy5f3ZX5su5mN
         Gq4i0nscUdUMSKqRexa3pAD6evJD0te+8MvGpn7Kru3hnBc9Daud819n1pTiHF44cJAV
         LvPg==
X-Gm-Message-State: APjAAAWruS4w5RHQe6Iw3gA3hgI0a/WDk7mHobYxPrNDd9pQtGmXxpsz
        3EkMYgl7QCobxV5qxbk36oI=
X-Google-Smtp-Source: APXvYqxuQyjHgDRYPGyql+VKPnbX/qWBKYCRFH0fK087eLi39hs4J7/HYCx9XVxHRKkJ22mkzbR90A==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id o14mr6487969pjq.11.1582078427769;
        Tue, 18 Feb 2020 18:13:47 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id t8sm235237pjy.20.2020.02.18.18.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 18:13:46 -0800 (PST)
Date:   Wed, 19 Feb 2020 11:13:45 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH] vsprintf: don't obfuscate NULL and error pointers
Message-ID: <20200219021345.GA17186@google.com>
References: <20200217222803.6723-1-idryomov@gmail.com>
 <202002171546.A291F23F12@keescook>
 <CAOi1vP-2uAD83Vi=Eebu_GPzq5DUt+z9zogA7BNGF1B1jUgAVw@mail.gmail.com>
 <20200218103346.5hbe7d5aj2ma7trk@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218103346.5hbe7d5aj2ma7trk@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/18 11:33), Petr Mladek wrote:
> It would make sense to distinguish it from a hashed value that might
> be in the NULL or ERR range as well.

[..]

> Reviewed-by: Petr Mladek <pmladek@suse.com>

FWIW,

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
