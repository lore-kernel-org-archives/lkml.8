Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CC6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE94820838
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpQ2IByu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgHNW3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgHNW3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:29:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBCEC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:29:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 2so5053725pjx.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGUYTp73E8GMFqW/rsmEDltaWlYgY9ocHa8g62Q6xxQ=;
        b=IpQ2IByuLN+qZHcmz6Rp4PPhjPciiwBzN0lr3mpy495zjqQSngmqMWVI5/K7hmT6TQ
         tPOC7rPhbe0NolN5YoHISUBumH61UqmE7hkJO0AkWvM4hvG0o466JZ44hnFTPC4ivO+L
         QT9PSPTQWc4/z0m2DBOMULaZ9Iv+LuXX8W8jDmNOAr1WN/e4GyvwRnZk84mR+sUUCabx
         2Hw3sd0ioOodsTR5fI7TqwB1gIpO1sKxXalqh7YtfMhVC3qEq/aMoKu2Gw+Wg5kvyxRI
         KCwrHJV0RO4gqmFdbRw6x2r6WUfwRTiXllzcvYbt8joKEsyW7ivBJKWq2Jxq3qPK1ggq
         Xh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGUYTp73E8GMFqW/rsmEDltaWlYgY9ocHa8g62Q6xxQ=;
        b=acvajBi+GLHRZSCgbGmF/I4TlZ7NbI1g63+BRGerzCEC7DEGsC1eBP9o3BW1h65+kF
         h8tlq6lpCIUjA701ytg3rvjMkmDbUDZhqqFS4rJqtHkd2GeANkXNSaWMMp6pxpit59fj
         M6xm6op/UbhK0KORNfS/RpCvUIwah+G9JhDVZBEcKSR9JTPLo2z7K099mxX/0MbwukJW
         dLMtrnInRd8MVLPIXdDNtnSmwptKVkYB0XQlz0iq3zo1vmpzRCoKOKpKk80JOLbY8Ich
         e6d90KKZMEROHTKPsGRAj79+afPcd33ZFPnImgKqxxMHuEIY6cKM2CHXMVva/UrVVCru
         5mNg==
X-Gm-Message-State: AOAM533bEuS6ZXIV7ONTrb63AbjXgQgXAdykqkmCrNZcnmN2L/QMSZiP
        iZz0n9riFu3txVZzBDmXcfcE2fJLLrJ3eWDarisN+A==
X-Google-Smtp-Source: ABdhPJyCdYamwtBEVHRCr8s/s310Eap4ZI8Bt/8x3bdJyZaUAaeK9+gNbGV08ncqESbw4vcjgR31GJ0gJpzcb5gL+Jc=
X-Received: by 2002:a17:90a:fc98:: with SMTP id ci24mr3981435pjb.101.1597444185005;
 Fri, 14 Aug 2020 15:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200814212525.6118-1-john.ogness@linutronix.de> <20200814212525.6118-2-john.ogness@linutronix.de>
In-Reply-To: <20200814212525.6118-2-john.ogness@linutronix.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Aug 2020 15:29:33 -0700
Message-ID: <CAKwvOd=egq-9JqMPX-OET1h5Fc6WNdpRKrNJgGD=vQig3ES91w@mail.gmail.com>
Subject: Re: [PATCH 1/2][next] scripts/gdb: add utils.read_ulong()
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kieran Bingham <kbingham@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 2:25 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> Add a function for reading unsigned long values, which vary in size
> depending on the architecture.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

/me wonders if there's any non-ILP32 or LP64 ARCH='s supported by the kernel.

> ---
>
>  based on next-20200814
>
>  scripts/gdb/linux/utils.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
> index ea94221dbd39..ff7c1799d588 100644
> --- a/scripts/gdb/linux/utils.py
> +++ b/scripts/gdb/linux/utils.py
> @@ -123,6 +123,13 @@ def read_u64(buffer, offset):
>          return read_u32(buffer, offset + 4) + (read_u32(buffer, offset) << 32)
>
>
> +def read_ulong(buffer, offset):
> +    if get_long_type().sizeof == 8:
> +        return read_u64(buffer, offset)
> +    else:
> +        return read_u32(buffer, offset)
> +
> +
>  target_arch = None
>
>
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
