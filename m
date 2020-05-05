Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38154C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10BDB20661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0TGtVIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgEEOIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727857AbgEEOIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:08:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7E7C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:08:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so1173021pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F/B9MSZGaJ58+mVfmNmjkyPrZwGf3ULvwrE6DesvvNs=;
        b=a0TGtVIVyVPrrxoWbUwt/w3WVN1cB4NC+NmnlI22bHP8QQ90E6xAh39JlJ8cOybED/
         bgeWqV6+dOL9MhrRN2Q4B/hCAI5bA7sn1WY6blte5ipfvs42DIpH8wWEaz7o0cIB2hNy
         6UfSIyJL1Fm8r1Mm6+T8H/yldr4fj5T8YkopzdIpCy9xHy7kv/GgJPTyghxMkttN8a40
         FZTC2KaYFg6pRBmiPIeUfdRx+3sYab7FIUcNIve4mUP0JjocFP22CYbSzEtSJhQabnym
         x/ed5ASHczcvdnUvS7USc0nqT+kzt4tP4onetnrIL0fSX9iclMlmcpyf//WbLaB+cOXv
         M2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F/B9MSZGaJ58+mVfmNmjkyPrZwGf3ULvwrE6DesvvNs=;
        b=o/O+Tg1AUI8ZMsfMN+/NfCG4Ki0CtyFkxyq/+B7v+/eEqsD2RHQ5OYh+polWR4JSJT
         6b4drVXocSG56FddmDmnA+XqU8C1F7iqWmmb3Aj6Nj8xDCr3ggF79nSKci5ZBGLtE0UZ
         gxhTVfHFYUNu8fchPGIiV3wG+nC051RiDOMBEr/6dVsoMWvzPHc9J1G2rDGosm2gkv+6
         DNofZYYM4ldbHB9aFAABdm5a4xXzRdqW324uzTs+PW8CBgEIb4IkzPOLlkwH4Z5hgTE3
         XftG3c8A4UCiYSwmvjPl7pwKjUkzCLh8RP4ow4qaCSQx9qSL1unZ4qsjrUMh4PFLvdnb
         /9NQ==
X-Gm-Message-State: AGi0PuYG1ag1fxLMUnZXTVLZADi0LVWcSG+mRysshBRxf2uI9xwVFjhz
        E6MSSQPGRAP3mnBQnPxo7K//ZADrbS9zR9KJnNQ=
X-Google-Smtp-Source: APiQypKEP1zoFtaojmPTuekEC61mamzn9SMHBE1x1cxNcbpv22NJMXPuIGR8Q47/RoXCKr4KSgetGjrdxGFYQt3x88Q=
X-Received: by 2002:a17:90a:fa81:: with SMTP id cu1mr3332209pjb.25.1588687709819;
 Tue, 05 May 2020 07:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200505135513.65265-1-arnd@arndb.de>
In-Reply-To: <20200505135513.65265-1-arnd@arndb.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 May 2020 17:08:23 +0300
Message-ID: <CAHp75VfmvXotH+NRt_YnNQW8O38Gas+ZfLH00jfhytM8w7ka3w@mail.gmail.com>
Subject: Re: [PATCH] bitops: avoid clang shift-count-overflow warnings
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 4:58 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Clang normally does not warn about certain issues in inline functions when
> it only happens in an eliminated code path. However if something else
> goes wrong, it does tend to complain about the definition of hweight_long()
> on 32-bit targets:

Shouldn't it be fixed in CLang?

> include/linux/bitops.h:75:41: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>         return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
>                                                ^~~~~~~~~~~~

sizeof(w) is compile-time constant. It can easily drop the second part
without even looking at it.

> Adding an explicit cast to __u64 avoids that warning and makes it easier
> to read other output.

Looks like papering over the real issue.

-- 
With Best Regards,
Andy Shevchenko
