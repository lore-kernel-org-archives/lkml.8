Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA4EC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC2020578
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SthwgJj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgHaFpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 01:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaFpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 01:45:31 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F74DC061573;
        Sun, 30 Aug 2020 22:45:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h4so5264711ejj.0;
        Sun, 30 Aug 2020 22:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QpctQpS39czKh39FA3DsibwWwLFrQ9w8q7Ndiy8iuZ4=;
        b=SthwgJj9Az/3r32xLQsxuUe6T0MewJhKyV/Hco3TxmWIHJj4DepBs8La5TxnUWFCCG
         YDn3y6jKbzNdsEUab+UBYdjdvbPZomqG13t6p8nzlelUtTXVQS1uaGXb80OBXi+4Au46
         1L99scYJ1+LtDsC0z9eqriy6BlmgGSmz/z5KSiSQjMTS1UULHACE/5DaJ3g3oP9V0tn+
         C3kyRGQK3bTbPAdNgXOpiaUidK5MERG8Tl2BHWeof41BecEt9Tnk+4OqBnN8F5QmevL6
         pOXpVep53mhoYUJxxhX6fNo279JakvMOSGWcnagCYOiR+6vNOpVVBtpi5yRoxBjyL1K6
         bkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QpctQpS39czKh39FA3DsibwWwLFrQ9w8q7Ndiy8iuZ4=;
        b=DfyCEZBmZd1TDetIO1sVrA5OZT+mOWhUXJ18s1AGvL8x9CUOjoY1uGkFFV8hmVPxTa
         bnFBcs9gPgweX9h2Swa/4fTYd1FuPI19zHVHWX9vwSHs0kVvkcV9C9FQ9PbXkkKlFhbh
         Tx48+q64+tsePiCLp7Wv3XTotKUPH58+cnST2qV188aBZdSbQIpjVsJ5quohSogfgfDH
         KcyWe4Q9YHw8RZSHXda06bR+wumb8lBQ1XOQ6T6QrOLFKaGUQdtakq4LnQ14fb7PqPKb
         xBpnZfJS4vp3BwUX1XyQ5arCes+N2+BgsTthJU+npbfyAKC9F4Cp858omgPnwkUy9JOi
         ncPg==
X-Gm-Message-State: AOAM530Dx2ld/eJmJ7f8kQN+XDJa8kIZTIeuVva5Ib40sSy5zWwUu4/+
        qvbduzEusld9/+yR+ptflUI=
X-Google-Smtp-Source: ABdhPJww5C52aNdNrjE6lwcruAeSoi0YPmIcXls0hV/emdb9wLo+Twlo+eLLVBqIT1XjQOuheM96mQ==
X-Received: by 2002:a17:907:270d:: with SMTP id w13mr10151624ejk.191.1598852727702;
        Sun, 30 Aug 2020 22:45:27 -0700 (PDT)
Received: from felia ([2001:16b8:2de1:2200:9c37:36bb:80e7:91d])
        by smtp.gmail.com with ESMTPSA id t16sm7073952eju.125.2020.08.30.22.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 22:45:27 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 31 Aug 2020 07:45:25 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Andrew Morton <akpm@linux-foundation.org>, keescook@chromium.org
cc:     Mrinal Pandey <mrinalmni@gmail.com>, skhan@linuxfoundation.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, re.emese@gmail.com, maennich@google.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH] scripts: Add intended executable mode and SPDX license
In-Reply-To: <20200830174409.c24c3f67addcce0cea9a9d4c@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.2008310714560.8556@felia>
References: <20200827092405.b6hymjxufn2nvgml@mrinalpandey> <20200830174409.c24c3f67addcce0cea9a9d4c@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 Aug 2020, Andrew Morton wrote:

> On Thu, 27 Aug 2020 14:54:05 +0530 Mrinal Pandey <mrinalmni@gmail.com> wrote:
> 
> > commit b72231eb7084 ("scripts: add spdxcheck.py self test") added the file
> > spdxcheck-test.sh to the repository without the executable flag and license
> > information.
> 
> The x bit shouldn't matter.
> 
> If someone downloads and applies patch-5.9.xz (which is a supported way
> of obtaining a kernel) then patch(1) will erase the x bit anyway.
>

Andrew, Kees,

thanks for the feedback.

As his mentor, I see two valuable tasks for Mrinal to work on:

1. Document this knowledge how scripts should be called, not relying on 
the executable bit, probably best somewhere here:
./Documentation/kbuild/makefiles.rst, a new section on using dedicated 
scripts in chapter 3 ("The  kbuild files").

https://www.kernel.org/doc/html/latest/kbuild/makefiles.html#the-kbuild-files

2. Determine if there are places in the build Makefiles that do rely on 
the executable bit and fix those script invocations. (Kees' idea of remove 
all executable bits and see...)


Lukas
