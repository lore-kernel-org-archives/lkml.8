Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9039C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 04:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86868208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 04:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="j+bAChCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgHUEmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 00:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgHUEl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 00:41:58 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5D8C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 21:41:57 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so822294ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 21:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9O3MOiDp9rTX/OUCaY8nDp9xXXYuY9V/2TPMnqT2hvc=;
        b=j+bAChCZOvr8+x9F5KYZlfXGuG/C1Hty9S4BYamev2FciN/J4qfwUh4dL+o+jdFZQg
         4kUcC8qlulB4/ORHqo03FLFE93hwVr65vNgZZ6/QqnvkOt9ttQ9NrKUr/57jwZPrPTwl
         xhh3eFDqmRJPumperCORRHgWRLkBKUBDKt3PJnFWIG3d3GoZM/JD4sj+K0zEvlPHT/iR
         +6zGZc08nGgzMtQ9/prgqhPiWwOKCcdT11Dih2pEq7MQyc/XIXakovP+iN8KsLcCn6UG
         kBWkskSAb7rFa/qRjbZzfm5btwrXRxEn7/CvJ63BBELOCvD+xG+h1ZFFxg2Ajnoepv1u
         H0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9O3MOiDp9rTX/OUCaY8nDp9xXXYuY9V/2TPMnqT2hvc=;
        b=NjnuSMw+w3w+dNxIZUNuVQwRVOQK6N2SDAHNnNmxUKKHddbqgF7KoW9lTyypqrydMv
         8f5XFIet48jO7rGETjZcXhxOyTZjQoTwfvhgRS4f6pdnWWYSctr4UXkTnWqyqBxYIntz
         OGt77FRjSlhHxSqEs3NyBfKx+bYvoQXBPP9vg3x2k37LQ5g/VQTyz+REJ5sZLRKnXzY5
         ZBLDLm2SMP+5GrkuP/KlnxyG+3ClzSv6mbYoJiM1e7B5SlSXk2t+DpId5ta0Ys1ZfgJ+
         ztKyjwJMa5eLNfBSjXTaBsJrTXPaUb63YfmC3Xt5MUvIFx0XjMATordPgvC+FbZWtFVf
         mapg==
X-Gm-Message-State: AOAM533APt27AxCJCBqhb+sLRi4rdq2AvPqByKjCfzuF+If5AEKdUzF8
        FXzvZe8+t7+hj+1R4yVbD9qGDq+cQ4Q7iiOIpIy0fg==
X-Google-Smtp-Source: ABdhPJw/w+LamKsouBMDL2xI4/tj7QcllFiwGuBa2QAZ3bvSKuccD3wupsTKsCjZHsZ69ChH3iGyH/qk/jnxYf/CsEU=
X-Received: by 2002:a17:906:401b:: with SMTP id v27mr1146910ejj.300.1597984916441;
 Thu, 20 Aug 2020 21:41:56 -0700 (PDT)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Thu, 20 Aug 2020 21:41:45 -0700
Message-ID: <CAP045Aq8+h6Y6t7W2GR_jJER5ghaHTH0wP81V-iYHxrR0Lk2vw@mail.gmail.com>
Subject: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on a 64
 bit system
To:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     "Robert O'Callahan" <rocallahan@gmail.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the x86-64 5.9-rc1 TLS is completely broken in 32 bit tracees when
running under rr[0]. Booting the kernel with `nofsgsbase` fixes it and
I bisected to https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.8&id=673903495c85137791d5820d690229efe09c8f7b.

STR:
1. Build rr from source by
  a. git clone https://github.com/mozilla/rr
  b. mkdir rr/obj
  c. cd rr/obj
  d. cmake ..
  e. make -j16
2. Run the simple 32 bit tracee outside of rr with `./bin/simple_32`.
It should print a message and exit cleanly.
3. Run it under rr with `./bin/rr ./bin/simple_32`.

It should behave the same way, but with fsgsbase enabled it will
segfault. The `simple_32` binary is a simple "hello world" type
program but it does link to pthreads, so pre-main code attempts to
access TLS variables.

The interplay between 32 bit and 64 bit TLS is dark magic to me
unfortunately so this is all the useful information I have.

- Kyle

[0] https://rr-project.org/
