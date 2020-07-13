Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BE5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AF52075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pE+HnI7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgGMUXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgGMUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 16:23:46 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A69C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 13:23:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z3so6503191pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gT9y8osCKgopQJB+AOp0exwXmR/r8cpSLVU5w9SmVXI=;
        b=pE+HnI7Y/IixvhlxEG/b7jBk+/6VPSjXYWW9O498IbR//4TBUmoY6+U6uSn/6PMyIP
         SKO/HENpc6M7AGrnra0mSc1aDtFumhcl77sZu3K2BAAtbEFLO0qV86XCQXGMgIdVCGFN
         BmkL3HW2YtSWnjWEppQOCkIqolTCsp/+jBYHXVAaR/WpokutN552++GJQf0nXQ8Yg+lJ
         1rAXB2Qsea8ctuTPuPsHf9CEn0v8TXUjPkPdPEANkRFZsI3TY6w9nzxnAsRAsrtLNavS
         VBcZTdGhsYOdILwCciFtJW9y/zkrwodjYr2n4oG2bQH7ieMrx0MqYU0PaG3/9RItQYw7
         PLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gT9y8osCKgopQJB+AOp0exwXmR/r8cpSLVU5w9SmVXI=;
        b=hEPdRQC77Osyh1zEIJiCdjk3/8J+zMGzDPRHGlPtoLZc+KxxshVb+ioW5GasR+7tT0
         Fly6Bt3Fv44HWxwwvAHe1J9UVD61fhWdox+puNg1HNtG68+m0FNclMfPDVACgVEtGUqv
         kOx53YcqxJY8Gn6B7RuNcHWaKcXHE8DmzRLCO751zGDsSya6Vp669G1TmV/CAiNVmW/0
         ovE1NNxQQo0YqSDaDXq/C4VjUXeYhvJTIc7ysPpd/xUCsH3Rcoqj8yiw2WvS1dDIyTh9
         DH2/iIUhOmy9P0ZAOxMv1E33kxfhKsGIVRP5srDleqAcrS3iaFoVm4mj5VVvH4+LZXSa
         GGhA==
X-Gm-Message-State: AOAM532WgD6JqUjYGfBeWldMui1kl3uSkhoTBm7VroHA30L1vAluWSHP
        0tPyIl/kOJQ40NAVkk7zzFDFycXQK2J64fPqe/ErNh0e
X-Google-Smtp-Source: ABdhPJx7zopYesWbx7SfJo23Kt+yttRejCeCTLA2Sng/3OxY+uwc2KAhg1xhXZVQ6865YlJmgJE96apBNLjvumQBzo4=
X-Received: by 2002:a62:86cc:: with SMTP id x195mr1366007pfd.39.1594671825670;
 Mon, 13 Jul 2020 13:23:45 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Jul 2020 13:23:33 -0700
Message-ID: <CAKwvOdke5KOS7KLBpDF8DsE=eo7T9ZTvKZBToMuLyVX6LViL1A@mail.gmail.com>
Subject: clang-tidy and clang-format at plumbers?
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Joe Perches <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel and Joe,
I was curious if either of you plan on attending Linux plumbers conf this year?

I'm trying to organize an LLVM micro conference, and though it might
be of interest to hold a session on clang-format and also clang-tidy.
WDYT?
-- 
Thanks,
~Nick Desaulniers
