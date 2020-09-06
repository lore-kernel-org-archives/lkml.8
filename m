Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4DCC433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 09:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F1C21582
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 09:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTZObnI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgIFJEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 05:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgIFJEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 05:04:52 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331CCC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 02:04:51 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o16so181791qkj.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=S5ZCTgSmUHX5bm9RQgYUX8IuUNCtRZ6XBPLd2Df4cvg=;
        b=cTZObnI0MO9MHtmnKwkraCnvZVN5sUwjwdJJPvvFwzzZxnD7eH1dEOZnt6VH9P11cc
         ZTclP6S8JAyKBRrqQNLVj7czVRRNdUa/yz0AKgis2Avsw5DpeRKpOh4jJBcMDmpr9mqY
         bwa26FJALXfLzeTkHRNdxiUMos41H1Jp42HZpVuzr1WZWha9vxAt2axZxjkYzdcU36r+
         uDy6O8OhGI3kBuHUeR6LpllL5S5DY3nJbOoNjZF5B3QJgD9fFe4NR+kFzeaZPz+u+UE7
         b/xxDUSI50ihfpCve4Ar8xCb6vB0d5j5CzdVoiBULBqQxgTl1YknbNR+KFhqzouUYX0s
         JPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=S5ZCTgSmUHX5bm9RQgYUX8IuUNCtRZ6XBPLd2Df4cvg=;
        b=eLjqwM5Hc3e4xiBm7CG3sq43juOJRQGUKNoyIOpeW+XS5Mo9ax81nGzoI0v3u63jnH
         9pqZeXk6MTplwPsQChxu6Hywocaz6j2FRfeUiIlNKeF/gPodKWt9cQlhRfQ7d2WdSnyC
         M+UhNJ5R9PYtRBFde1sLcGkjOlaVsFadIDMuM+43XCRB3kIkvKmZ55GV0g/qgvouJb/H
         3tua38/qeAMP+QiZ5Z6EiLhnGdd867TnV/hKqZk+ZfoM3wjFI8iYrmDMy/xuquUmewF9
         lUG0WvizT5+XE/M0jLTT+7XxgmLE9ER32WYBVhgrXXW6AXKGOOjn/vcl4kCzDf5/9yg2
         jB/g==
X-Gm-Message-State: AOAM531UFozio+0jEwY2UF+fv3De7UZTCD49YkHCS0BUMde43rK2pBPp
        H8uFnKowRRBcMfz29aXjNYZ5XdznzNlyGyxZTgvi6WYAjtA=
X-Google-Smtp-Source: ABdhPJyefc3fFlhNj/KEWk88ZPwJYDNAGB2N99FlozW8Xk4CLtMiqsaTo7R7kiiXJ8MCXsiwPuhasTAHk+/+Qmu8Eps=
X-Received: by 2002:a05:620a:69b:: with SMTP id f27mr14924758qkh.309.1599383088425;
 Sun, 06 Sep 2020 02:04:48 -0700 (PDT)
MIME-Version: 1.0
From:   Raj J Putari <jmaharaj2013@gmail.com>
Date:   Sun, 6 Sep 2020 02:04:37 -0700
Message-ID: <CADXzsihE-uEej44t1bK8SEKRoavXdY206C1esCk2cmxk6t_SBg@mail.gmail.com>
Subject: Description tag somewhere in the Linux Kernel
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I suggest the scheduler, you can tag each process and add its own description

the hard part is a good scripting language for it

i suggest something like this, but its really ugly

pitched it to my congressman and they told me to leave or they'll call
the cops =(

process->description = "<?KERNEL(#ATTACH_ID)>, <?FIND%SUBSYSTEM(STACK_ADDRESS";

and we have a set of functions to parse and organize the data

lets say theres a really bad hack attempt, and you'll get a ton of those

the firewall pages the scheduler and executes predefined code and acts
accordingly

i think this might disturb selinux so i guess decompile with ghammora
or whatever to see what they're doing.. dont hack the nsa, they're
violent, just call

well heres how the scripting language works

<? - start code
# - find function
%subfunction
thats all i can find

also if youre really getting hacked, setup a system of virtual
machines and setup a system to forward raw packets to that vm

hope i dont get trolled =(

well i cant find the scheduler on google, i plan on implemnting qlib
(https://github.com/unidef/qlib) as a module for free quantum
programming.. uhgggg inline assembly in quantum space *blows his
brains out*

jonathan maharaj
