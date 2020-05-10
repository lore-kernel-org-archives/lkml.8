Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D86C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 17:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF028206D6
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 17:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSW6dX7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgEJRNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 13:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728360AbgEJRNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 13:13:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2BBC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 10:13:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h26so5469445lfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0PU0Sit1xVzizBuCfAb4eyKFOp6O3/xozVDhgWBKUI=;
        b=mSW6dX7sU9WzMquExUTs5lRnJU8G33pM7AlzK4+4fstLsU3pFVu1YI7BtD0xVrjzsG
         NAND5lEXyQIDNn8hh5t5vAwJWGG+8SBh6OIgt/3dWnw45be3OtcEgqleuRrxPVcdRFo+
         FZPQq9js9Esi1rdL6qhc4a056DpNYQtNijx2WxuK4iiyAYs2hb0JM20AJAK1XREO3iav
         7qvWbbK95ewa+EJUC+l4o2lbvVOwXyUtdWsxjCFrGsigJMWjOlcYx6niU+ukpMBcu5Lb
         nUDKGAvmcru0C2gOm3ngkf4chwIoa6L9Ag4BtkkOvA0g9F43Vf9XrLuhKZIOnKc/VTVD
         ERsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0PU0Sit1xVzizBuCfAb4eyKFOp6O3/xozVDhgWBKUI=;
        b=qG71B6lgZo3bpY6zw7B3TTtyZJD23JV748kXde7Oz0WhcTqiUw6iv4WYTBU0FfC7VX
         Ar2AelNShz7WsRw5BZVMZCyFrTw6vxOMKOfx1XhiUufX0CNXyZ/dnFhRiLTPO3SFGWZl
         xtPZEbRNAmu0MJil8bm9abGDGjJDpryzZFDH2cv6aW9uG2NiEWQo/VXUFo7mYQ/7Bmnf
         68C6NR51UTY3SDZn8IUbQIie2Ix5YbZbDNARaD4q7WXTxD9fUgaOM7eMMPHK1aJM7Mr3
         rc9mgFydYrHxleCCOGixxl29HuuQXtxvlQeLsnkuODGlcpS2sMqnfzFJ4YLR/zLvGt7c
         /Zag==
X-Gm-Message-State: AOAM531pUzmRfS2sNenl8kZG4JnqlORkB0WXbxrpcoTQ1PwvMSsd47Ki
        SBy+aEF59CQN2f9w9PPa+yCtMsdShUjaAvAK/l5mutEykI2Z
X-Google-Smtp-Source: ABdhPJwmZ4ZH/9gtqfbWFujLYwL85fv+j086CAJLvilSP28mhonT8qemqb/0puh0db+xvCYpRz+KFEN25n/BmTY44IU=
X-Received: by 2002:a05:6512:308e:: with SMTP id z14mr8598183lfd.29.1589130823318;
 Sun, 10 May 2020 10:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <CADa2P2UP1AtEmQYtyqUFKVNz8Rxii+-Zut3ibc5pMYnQB90-zw@mail.gmail.com>
 <32637993-b73f-c2cb-6823-590c1638b5a6@infradead.org>
In-Reply-To: <32637993-b73f-c2cb-6823-590c1638b5a6@infradead.org>
From:   Mahmood Naderan <mahmood.nt@gmail.com>
Date:   Sun, 10 May 2020 21:43:32 +0430
Message-ID: <CADa2P2UTMwwYPFLW+UM5FNBL+_8Pi_Am+saa+Y2ywpi0jPDvWw@mail.gmail.com>
Subject: Re: Using a custom LDFLAG for all objects and binaries
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Have you read Documentation/kbuild/makefiles.rst ?
>
>     LDFLAGS
>         Generic $(LD) options
>
>         Flags used for all invocations of the linker.


What I see is this in Documentation/kbuild/makefiles.txt

    LDFLAGS             Generic $(LD) options

        Flags used for all invocations of the linker.
        Often specifying the emulation is sufficient.

        Example:
                #arch/s390/Makefile
                LDFLAGS         := -m elf_s390
        Note: ldflags-y can be used to further customise
        the flags used. See chapter 3.7.



I have two questions then:
1- Can I use that as a bash variable? Like "LDFLAGS=--emit-relocs make"
or
2- Editing arch/x86/Makefile with
   KBUILD_LDFLAGS := -m --emit-relocs elf_$(UTS_MACHINE)

Thanks for your help.


Regards,
Mahmood
