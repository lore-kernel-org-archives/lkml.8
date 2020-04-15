Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C290C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B202087E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkEeBnsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392492AbgDOBUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 21:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392479AbgDOBUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:20:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DD1C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 18:20:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b8so788069pfp.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 18:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TrrpbbPwJAr8kyteNcvoZB2BPcqO+NKCa20U7yB2R10=;
        b=dkEeBnshSPERc7o2ljrwrCS5c3w6V5JeyZ1SWZ4bxSJHqp+RtYf69d2Or1PLlJUTHd
         IYW4G2DzmVjU6Pc8mVbOP5o/3yseehMtOB5C7jM5I9zYshJu2ML471uRB4XjnFClN6j7
         FLE8lC+sY1gC/UF7YGOKOwjtc6mNn9zuRiAwmkUSxU91t+DZtQ9dZ6BhnOCvSOHvL+f9
         5RmUZzyubiTyhvua6LZxOQNZddWmU67Flw8q7JSUgnb5cbzXhpGRSdDVACCrtN+1E2/j
         e0U+YUn9M74i51At0N7WCsFJS2CDC1rxpgjCdoEkCSM/iN8W/990KuSOn69xYz/DGoy2
         kHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrrpbbPwJAr8kyteNcvoZB2BPcqO+NKCa20U7yB2R10=;
        b=NMJSvWv8HpqIs53YSu/B9AOdEK7+Y+W/HyFGuxqyEzr/o1Egh361t/EqwVGSrDJmxB
         CnirU5WiethUDEm1mAv1If1wozuJF336SHvtvUg2M3NM3IPEdbKrslYqwP5XQFngUKXJ
         qNQdM8b7hejdfOr9msH+zbhtcZM1BbI4NGVMyhzg5U+ZixmXh3TgdVIj2mLIqT3pAKfO
         Ac77g8Ryv4coiRLZn79KtpHv3vEMnDvzB2vRn1Krmdbkpff7XdXVaQIMPQFmLgzdDu0s
         9dfERbdO3Q6OtlCWYeKL4n5CWBL7QXTZTWOYB4vVH6/YjTXTMXiXPGOVugVKZdOhkiw1
         lypg==
X-Gm-Message-State: AGi0PuZn7ZgsZ1Y++0m+Uoym1CUyQpkP3fvIHGOfBKIY/dxgAqligV44
        rJPICosAa5vE4n+FBLPGRR753RvC16H1mzF5PKck5g==
X-Google-Smtp-Source: APiQypL1f0xDNqRsCbQhV1fCyIUtHEZERlcQ2pLpCcqFT9UQ8H0t8GsJ2OLer+AH91XIVyPKPZIwVMglEhr6RZ5xgQo=
X-Received: by 2002:a63:cc0c:: with SMTP id x12mr25910799pgf.0.1586913601923;
 Tue, 14 Apr 2020 18:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200414195638.156123-1-gbiv@google.com> <20200414170006.10f70d361bfd085f3e846939@linux-foundation.org>
In-Reply-To: <20200414170006.10f70d361bfd085f3e846939@linux-foundation.org>
From:   George Burgess <gbiv@google.com>
Date:   Tue, 14 Apr 2020 18:19:25 -0700
Message-ID: <CA+rzOEmBYOBKUHYZNn3yvaFz00-tsmYKurQjTMY1-Vye_GLfEA@mail.gmail.com>
Subject: Re: [PATCH] tools/build: tweak unused value workaround
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 5:00 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> What does "disabled by default" mean?  Presumably it should now be
> enabled, but I don't think this disabling happens in the mainline
> kernel tree?

Disabled when `perf` does its configure-ish checks. Concretely,

```
~/linux/tools/perf $ make V=1 VF=1 CC=$clang -f Makefile.perf notarget \
    |& grep 'Auto-detecting\|sync-compare-and-swap'
Auto-detecting system features:
...         sync-compare-and-swap: [ OFF ]
```
