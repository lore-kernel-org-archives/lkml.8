Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F701C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6406F20772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNTx6mqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgFDNK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgFDNKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:10:55 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76CFC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 06:10:55 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id n123so2892823ybf.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bsgm/TKaQa1WLgF7Jlo3Jkj2UeTFocZUCUKf1011cuc=;
        b=dNTx6mqqy7cKYr6LeBPm8T8QMP1bWemgs9tn5LA8PwwT5b9uYGoEOO7nrOaxI8HSgF
         sEkATWLylk3rMeS/XsK4JQOIle/TBs+afxA6rQs0zIYiJ0x62J6r+GwZ2LCTYxp0BCKb
         9rt5tPJGyKGDibCWDRwcopwAeXl7sqD6BwjYGQY47CJ0L6/WdO4AHMy9r1ZUDb133Xjn
         nui8+40mbwrG5+Ol0llqxLbYmTQHQtjzRbkxRoIm0I+24yleuQpyUDGZ6vqGtTLdPtGL
         4t1QXO+QZbPsYYArVgVv0FvLy1RiB6Sph6aE7NfPVSzXPeciKWwSSTs8wAsr4xPySlWW
         ikTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bsgm/TKaQa1WLgF7Jlo3Jkj2UeTFocZUCUKf1011cuc=;
        b=e7Nn//LPnsccPw8YJ7ToWSPGa6Ax0t8llAXr3kiC7bVU2ddEFbkdbkv7Xj9jfqLoFi
         Sk7tV1KHKCLDLwpPR0FjjiMNaLKml1u+qIbESUdQS6EX7gRxBbv2Fif5NcZchLL+Hoso
         T7Jka6KQKriOYxhXVMo2mJ4K090I26nVRuiVHXUZ/eAiHvjHF51jat6couFf0L/8HAmO
         gQRB8g28+KbvNXCqg2CWxs+bNkCfJJ463m1w1P+G9F9TER+5urzfq7CNByh9VhBSqwqy
         PC6Y/bZEkWrLKYm5yF4bJCli5WjKDq9ugNcCRjn9mXamlQ4I/fCxuaFyNckQryDzzpce
         uJrQ==
X-Gm-Message-State: AOAM5309HYBhzC4BqOHXraE9JY1arYhvbYgjMNNH8GdMgLgJ+OUm3mJ2
        If1oiIf/VfHtdIImKh4xQxNbf+S2d1IFBlRU1jtcUg==
X-Google-Smtp-Source: ABdhPJznZ4kgf3E7pVsIR+yXbd62nObH+ZoygHL56PaPVrmzBCCzB1mkH7ELrGSGj1vCTfsXKYF+txj1dTIRXd0BCe0=
X-Received: by 2002:a25:4cc4:: with SMTP id z187mr8163120yba.274.1591276254605;
 Thu, 04 Jun 2020 06:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200602080425.93712-1-kerneljasonxing@gmail.com> <20200604090014.23266-1-kerneljasonxing@gmail.com>
In-Reply-To: <20200604090014.23266-1-kerneljasonxing@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 4 Jun 2020 06:10:43 -0700
Message-ID: <CANn89iKt=3iDZM+vUbCvO_aGuedXFhzdC6OtQMeVTMDxyp9bAg@mail.gmail.com>
Subject: Re: [PATCH v2 4.19] tcp: fix TCP socks unreleased in BBR mode
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neal Cardwell <ncardwell@google.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, liweishi@kuaishou.com,
        Shujin Li <lishujin@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 2:01 AM <kerneljasonxing@gmail.com> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
>
> When using BBR mode, too many tcp socks cannot be released because of
> duplicate use of the sock_hold() in the manner of tcp_internal_pacing()
> when RTO happens. Therefore, this situation maddly increases the slab
> memory and then constantly triggers the OOM until crash.
>
> Besides, in addition to BBR mode, if some mode applies pacing function,
> it could trigger what we've discussed above,
>
> Reproduce procedure:
> 0) cat /proc/slabinfo | grep TCP
> 1) switch net.ipv4.tcp_congestion_control to bbr
> 2) using wrk tool something like that to send packages
> 3) using tc to increase the delay and loss to simulate the RTO case.
> 4) cat /proc/slabinfo | grep TCP
> 5) kill the wrk command and observe the number of objects and slabs in
> TCP.
> 6) at last, you could notice that the number would not decrease.
>
> v2: extend the timer which could cover all those related potential risks
> (suggested by Eric Dumazet and Neal Cardwell)
>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> Signed-off-by: liweishi <liweishi@kuaishou.com>
> Signed-off-by: Shujin Li <lishujin@kuaishou.com>

That is not how things work really.

I will submit this properly so that stable teams do not have to guess
how to backport this to various kernels.

Changelog is misleading, this has nothing to do with BBR, we need to be precise.

Thank you.
