Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC432C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D572074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1eEVpGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgG0KBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0KBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:01:37 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B28DC061794;
        Mon, 27 Jul 2020 03:01:37 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id m200so4290928ybf.10;
        Mon, 27 Jul 2020 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0ovBpV1RCu/BA4nTaDoRsgP6/JwSLVZ6NKuTSDEoq2o=;
        b=E1eEVpGEJkFOHv/jqkFzsLLBeZstzNWOnkRuOgqZq3k7vgl9/Ijqj/NHFA/SBQMZJO
         Y5OwQaqHN56aElH0syOGrNz6hrxinVDdoiIx40CkrlNzdXZF+LOTL2Kw/XHgTflBaNs3
         s+SDsKy1h6DhAsl7AVa9QBZryXqrY7kxTLH1jWsyUnRFbQQyFGtpXyU2kkn02DvoxTUr
         EIRmh0xZkgIjxUFFLjuQpMcN/lNSu64f2XwZf0TqoQ+2+b0vfQxtGe+OR30rtc1OadC0
         eb8Ox+INKvauRuG7kuqzAKaaZc177gbuissG5WyDzbxBY1aD4g0CEDZ1xv5EqIm7nKLz
         xx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0ovBpV1RCu/BA4nTaDoRsgP6/JwSLVZ6NKuTSDEoq2o=;
        b=roXU5ZXqKLuEryFQ/Il5pYIMEKnKIN/EOzquosRyHRRcp3ZXV9R9KcoolDmwRR3eOR
         PskYogj4q1zg78Z4VANgyUlD52A1GFmwNvp9KLeQ4P9epxS55zZlbB6YE7SWcMfLU/cD
         +jvCQ1kFOv8Ot53HCIcypE2ihIB9FgGUjDd+hf9kTTIZ2tIr7kCLEdVnjOKv8V5LEkfH
         wi8AG/6JoZl22raNSKLPKImjInFD2xnUWNFx7IirKPhhTaA6hhyrhxCH/ojaNv69UsI5
         ZMCwWXoYZ6IzRgq9p/zNzF050/3jQ2p7MB0p95BmuK2nj8BwPJKZy1UYcHm/hSLm9GMq
         desw==
X-Gm-Message-State: AOAM531nTkU22fYHH9B2PezcXShMfmf5vm4OFJa5oNn0QOjLnzVVOLRk
        RFqiQf5E311JBqkxXSjtD0/aXlBYw4NYxMMxIW0=
X-Google-Smtp-Source: ABdhPJz2Z1EfUwootw8qs317nd/jj2jzAlI9c6sRGBnky/I0AJpP1/G4Jft3ZDAapmF2Mq/YqGV64nNWGGukhI/jh4w=
X-Received: by 2002:a25:bbd2:: with SMTP id c18mr31296332ybk.495.1595844096142;
 Mon, 27 Jul 2020 03:01:36 -0700 (PDT)
MIME-Version: 1.0
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Mon, 27 Jul 2020 18:00:59 +0800
Message-ID: <CAF12kFsOrFOQBrZv6qBbcQ971acEM0XxLWKqBJvEspoQ3UOHUQ@mail.gmail.com>
Subject: kunit compile failed on um
To:     brendanhiggins@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>, zhang.lyra@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan:
When I run kunit test in um , it failed on kernel 5.8-rc* while
succeeded  in v5.7 with same configuration. is this a bug?

Here is my operation:
 gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)

the kunitconfig:
Cixi.Geng:~/git-projects/torvals-linux$ cat .kunitconfig
CONFIG_KUNIT=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y

command:
Cixi.Geng:~/git-projects/torvals-linux$ ./tools/testing/kunit/kunit.py run

the Error log:
[17:51:14] Configuring KUnit Kernel ...
[17:51:14] Building KUnit Kernel ...
ERROR:root:b"make[1]:
\xe8\xbf\x9b\xe5\x85\xa5\xe7\x9b\xae\xe5\xbd\x95\xe2\x80\x9c/home/cixi.geng1/git-projects/torvals-linux/.kunit\xe2\x80\x9d\n/home/cixi.geng1/git-projects/torvals-linux/Makefile:551:
recipe for target 'outputmakefile' failed\nmake[1]:
\xe7\xa6\xbb\xe5\xbc\x80\xe7\x9b\xae\xe5\xbd\x95\xe2\x80\x9c/home/cixi.geng1/git-projects/torvals-linux/.kunit\xe2\x80\x9d\nMakefile:185:
recipe for target '__sub-make' failed\n"
