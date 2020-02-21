Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77337C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4891420722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2qRZDR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgBUSFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:05:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37395 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBUSFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:05:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so1177019plz.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 10:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vc/oNHZrVih+q2Wtn+OIaEagT0TK1906/KUzqovtsWk=;
        b=M2qRZDR0w0N9TtAzvAhQVyBgCTUZsUJIVKjS0fJfLsSi2BD1Aiv3Z+5K//qXvLxSYo
         g3CBX3z4HGbflblb3zaFb+c+wk5KD+vAjLflfdZN5mo2yVk3DBNSIYRQUL/0HoDK5epv
         jJuqBDRt28YxlC4mUCUeiERSc54eTh37p3PVzzpHYUckHOf+Pn59L7jBWaD0ATFH2bNE
         oeHRf39oYqxf3hx9ONMosK+9a7gg8cJXWLnupLhBfeDFbmuGebdanTmf/jEAJLKp46dp
         Y/tFMmqR8UqvbBQc6AuB3F6Zs+mMTr0Nrr4UwuhH8ZvnTy8hGH7WL5N58YaOqfRWCXcT
         x0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vc/oNHZrVih+q2Wtn+OIaEagT0TK1906/KUzqovtsWk=;
        b=QRmeoVt57zRj4cn8UhWL8LjFFQaPO/s4MUtAXsYNCGn/ksHxu3K/j7hctKqoTmw1Pm
         bfG4dxsHgyzWxp22DmU7hdudNKZ2qoeAQN5MRaLcSZ5/NaaEdVYm4aRAoyIImPx16Uwg
         w2TOu3i8iO0At7qhcsUiWpi+44O6o0RU/zg/o1HuoqCGbuZ3eDxAjUSkGai858KxFr3A
         Nl1CVMXjOHsPYSKZ/ljkp6dSb5mwynk/qQj3woZ7HI1aRykit8Dfn2ChYsiMWbOk4uK8
         J8nCDdkDowR22zqZULSESO3S+viylgSBXtq4z1cFnNT2FkA8bmEYPp1WZcmNUQsmuuO0
         remQ==
X-Gm-Message-State: APjAAAV/DIiYhGEoRvO56WBA+UePZq7YDDYVTUETKblFQTuFXo/MbGDy
        aqIYFq4efeU3K5tfW4Vs8e0=
X-Google-Smtp-Source: APXvYqzf4h+MKzqKo6yp8to/XMq/SAEWHlDnmYGqE3oMTfdRBQiHu6uGRXaNXVbzCvPYKsR0f1UqIw==
X-Received: by 2002:a17:90a:2223:: with SMTP id c32mr4700805pje.15.1582308335057;
        Fri, 21 Feb 2020 10:05:35 -0800 (PST)
Received: from workstation-portable ([103.87.57.170])
        by smtp.gmail.com with ESMTPSA id 78sm901780pge.58.2020.02.21.10.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 10:05:34 -0800 (PST)
Date:   Fri, 21 Feb 2020 23:35:29 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        joel@joelfernandes.org, madhuparnabhowmik10@gmail.com,
        paulmck@kernel.org
Subject: Re: [PATCH] tcp: ipv4: Pass lockdep expression to RCU lists
Message-ID: <20200221180529.GA3256@workstation-portable>
References: <20200221152152.16685-1-frextrite@gmail.com>
 <20200221.081958.1917105498519528151.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221.081958.1917105498519528151.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 08:19:58AM -0800, David Miller wrote:
> 
> netdev was not CC:'d on this patch, please resend with that fixed.
> 

Sorry for that. I've resend the patch.

Thanks
Amol

> Thank you.
