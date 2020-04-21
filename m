Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2F8C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA89F206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587495811;
	bh=WjLrPEHayUeRDP9VzNdTgShqsYsV9FD0j5Ya14cu9tw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZaKYmNakLmyndrWFF+O8Jm4KREOXY4DuGM6hq1KlnC77iKQa2wt63C74GWgN/HOBm
	 ouxgg+5OOPfechhBpeky30hiVlp2cHXms+LXSzYficJPGNWl9YqT7VB6Bxr+/yaRCE
	 /rBx8lC4B4X5C1XvVxtza84bixXE5wAFdKYvJrP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDUTDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDUTDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:03:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033F9C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:03:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f18so9133727lja.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypgvWSUE3Hp+aq8UwpRBxeqBs2PJ/juR1hUTdDpXVsM=;
        b=hRM+woRxkymnWjkfxYhVHZTtkc/aEqCtO4EREIGDhuTdhHR3znpp8TJJX4VklGajh3
         J0Avw3mQ7ZFZqf0cuwRsGIKeyTctPKl+Duk4GutpgC9tn32LwAJz2OeTNyzT3gY2x5Pt
         n6IySZdsqG/2hL2dZvJP3mgokqxOD+I+D2LRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypgvWSUE3Hp+aq8UwpRBxeqBs2PJ/juR1hUTdDpXVsM=;
        b=tPJrFrXWOjwrhajakPfIQDU+We/bwd9NlzoIC4GuP2Xoy3s6/oH288AcqMn9IpwUus
         p+tELnLrpj4s8tCb8D3/lUNqmfcWrY/tQWltS8NdKP74c2CsnVdqVYO4lKoPXpfUZIOc
         SGdJsPGZvhavFwaQoeoJ9UZI4m4C2Gws2X1FhDwKZ6TjgiKvRkavPaE/9SXYATz6ltwt
         ua6zyxevc00kscNIcKgCUzYTOzRhtKDmgGuR7wmQLJ5YhjCvghjQo3vpOYtmYbfJSvsM
         tUu+EEO/Sx6nPi3xPfzUsk9j7aoTaDXlHdqwq/pzTrEMSAxaV8+Gw0rZpnMl5rymClg/
         Lcdw==
X-Gm-Message-State: AGi0Pub5vK/jQkCxGgRbUpuZHUD+WGk/0AbkEXlpaZV1L5YBdQYRGM01
        xvaLhv6eIYw5W4Lx6/FRTxsqP1dATRQ=
X-Google-Smtp-Source: APiQypIIp5McOWTdYFJy+IcyeOwZJPWV0lPlguiBRfGHmNrwWVnVVChAT3IPexBNWg+yTJuoW3wFdw==
X-Received: by 2002:a2e:8645:: with SMTP id i5mr13068164ljj.56.1587495807692;
        Tue, 21 Apr 2020 12:03:27 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id w24sm2777211lfe.58.2020.04.21.12.03.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 12:03:27 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id l19so12627767lje.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:03:26 -0700 (PDT)
X-Received: by 2002:a2e:1418:: with SMTP id u24mr14588814ljd.265.1587495806435;
 Tue, 21 Apr 2020 12:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiQsJu-ZFjt7+c9FVD5R40khtZiihrT+7O3UaVvHYz=HQ@mail.gmail.com>
 <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org>
In-Reply-To: <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Apr 2020 12:03:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
Message-ID: <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
Subject: Re: [BISECTED]: Kernel panic (was: Linux 5.7-rc2)
To:     Harald Arnesen <harald@skogtun.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 1:52 AM Harald Arnesen <harald@skogtun.org> wrote:
>
> Neither rc1 nor rc2 will boot on my laptop. The attached picture is all
> I have been able to capture.

I know you saw the reply about this probably being fixed by

  https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz/

but it would be lovely if you could actually verify that that series
of four patches does indeed fix it for you.

Your oops is on that divide instruction:

        freq_scale = div64_u64(acnt, mcnt);

and while we had a check for mcnt not being zero earlier, we did

        mcnt *= arch_max_freq_ratio;

after that check. I could see it becoming zero either due to an
overflow, or due to arch_max_freq_ratio being 0.

I think the first commit in that series is supposed to fix that
arch_max_freq_ratio being 0 case, but it still feels like the code
that does the divide is checking for zero in the wrong place...

                  Linus
