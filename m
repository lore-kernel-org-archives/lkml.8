Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B10C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A8020719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajSmIzuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732509AbgDAR4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:56:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41735 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgDAR4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:56:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id d24so225844pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yI26ZhrOiIL8spNhsxWYK6f9t1xQ5Sm+6ZAEnI+a28A=;
        b=ajSmIzuvMD1shcgImPYx+zbZQUz/ByvNut7SSgj1Zj5VgFID/XYOllMEdyF9zUxNN4
         pSDx1qy16ZUYBGkRqOvP0lUS9ftL4vFF2I+Mk0sCMyBURt4a/PT3RcJzKnmDuBTVlrl1
         kbOb+x+QYpKku9YOpbaKJLVL8mjFzS0P87/GrHoNcd//AAm6SCh6eem+GQcWNf0x8q93
         YfEY4/dQuYGU35iS5WKlY3zpkIZFQXDkP9YmfMkUYDIJH7fh2e9/H8/mCPpvMxmS+LXz
         MgF/DZS7RFJIwuOjdUO+sw/9oI+hDqGSTMGWoVWtef0/8aEynS+VOwP/M8I1zhEZuXnG
         R8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yI26ZhrOiIL8spNhsxWYK6f9t1xQ5Sm+6ZAEnI+a28A=;
        b=Fus6NEQeWbA7zSCppeTIYj2Eb9dcWmD7Ypy8Au9Y9hUlut7VkUIUf1JMPCdc28Y7Bd
         P9idPrCM+eSxtG/0hChb8YPkjtyZNv5lHHEAJXlCXJvdECZDv2AX7Rt9usXbdn4WPTwI
         gA/FSGuP0/XFD3KyQFfJAK6Vaw4u36MvFZIyi5ZSlUNm19lJAk1NS/Hdal9KkrlV+0EC
         AtcNW0q+w4n+kwwMCoNequF+RX88JITTSwWdspAYR27qoTAqsgaEsd0TakqUWjmy8/Qc
         rh54yYCoN/2TnG7vdOHqFJ1NqChRcGwIIWnQfHJhWhY1CdwJdPbsvYkwhemoE4VUK7P1
         MawQ==
X-Gm-Message-State: ANhLgQ2T6qidCuH5AzhZbk3Y6C+XHPM+QmcIvKF3BoW5kgLZTVSyxcwo
        TumjTkkyKOh6yAlr93dMWhnWQ+NlrgGuzz3mLg0YrA==
X-Google-Smtp-Source: ADFU+vs+ipW1cSPPz7Aecs3H5dXxYGvmGY+jIwfNg5qKza98ak96RlV4UV94FcsKxYwubYuEFOUTtMzPOsmiBTcT3wQ=
X-Received: by 2002:a17:902:22e:: with SMTP id 43mr22426728plc.119.1585763807025;
 Wed, 01 Apr 2020 10:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <202004010505.30nygaXZ%lkp@intel.com>
In-Reply-To: <202004010505.30nygaXZ%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 1 Apr 2020 10:56:35 -0700
Message-ID: <CAKwvOdmaD1c94WFK_GTfm0Egt6=Ck8JcwqnYR2ibsxpvG+o2mw@mail.gmail.com>
Subject: Re: ld.lld: warning: lld uses blx instruction, no object with
 architecture supporting feature detected
To:     clang-built-linux <clang-built-linux@googlegroups.com>
Cc:     Dirk Mueller <dmueller@suse.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Philip Li <philip.li@intel.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 2:20 PM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   42595ce90b9d4a6b9d8c5a1ea78da4eeaf7e086a
> commit: e33a814e772cdc36436c8c188d8c42d019fda639 scripts/dtc: Remove redundant YYLOC global declaration
> date:   4 days ago
> config: arm-randconfig-a001-20200401 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 5227fa0c72ce55927cf4849160acb00442489937)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e33a814e772cdc36436c8c188d8c42d019fda639
>         # save the attached .config to linux build tree
>         COMPILER=clang make.cross ARCH=arm
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> ld.lld: warning: lld uses blx instruction, no object with architecture supporting feature detected

Apologies that the bot is repeatedly converging on this patch; it's an
artifact of us turning on LLD for the first time.  This error looks
new to me, seems it's a randconfig.  I've filed
https://github.com/ClangBuiltLinux/linux/issues/964 to follow up on
it.
-- 
Thanks,
~Nick Desaulniers
