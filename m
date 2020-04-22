Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C4CC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C1F20767
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EoF9qkrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgDVTfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726398AbgDVTfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 15:35:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8C8C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:35:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e6so1425390pjt.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XuD/ymlDAdY/vC6za/Lkm0V+RpPXcEmYHcLLMeL5WYM=;
        b=EoF9qkrREtgDvQsWraC9r76+dPLeZESi5INITQFE/cvW1utStfWtm2QDGu1Zt/8wqr
         NgZST5MDpVwH5qSh1VAQqzHZo5g94q+CkyDh/Ie84elMx5pnJMVrqNKYqTM6z9Dwn1OE
         d3ufsvhGbp4zXXK2+dTJ9Xf0J+zgjAZpckn2c4/1bdT7cj1E7voL6J1w72QWkn5vCPEp
         oZ+vLMLpiE56edaSaqMcSYRNks/mTBBCi0WB/b1FbuvFKTNTkPQmLgiR7vknxbz9DDex
         geioj1m8tuoMq7Z1j42KzW6A2FVWdzHsbT2GnkdtMyPzO5/Rv/txinSK8r/X+/HnnQdz
         MNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XuD/ymlDAdY/vC6za/Lkm0V+RpPXcEmYHcLLMeL5WYM=;
        b=Rs73rXrZQSk0Y010B67xgwlwcKbQfHSHWzLbOG08Z9lYm1Q654dgf5+NOsyS1vbvqr
         Fv5o3ab4TIEo33j8XOfT546IEpZqFRF1CcfRmf3bIXVhqqwB39kppAC3bsV0mI3UhEcP
         2DZorCyUMQUjrb3dTkuwx7C1kFs8VDWCGl6ewI568AcaRd1rxg9VTAHrvrzF2yhcBvex
         eYPLLaU44lLhPN+z+vbYkFbN+UUNIu0JUx4jSYokW1sxhiKc9Gv/0mMOS2h1Lzrh1nwW
         tYxubETkW2fvaRtFGfUDlEklphawRu4Z1DPN5EPu2fKC8AetXSIw4ZLEDWDFyZGk3mje
         zgDA==
X-Gm-Message-State: AGi0PuaYxhol77RUQdf80YNcC4TcxkuoQ5I80hcbmgT78v14Wyqdyy5V
        915hTNDaNaod7HntyHCB7RmRuA/4QAEwE9tUihfCZA==
X-Google-Smtp-Source: APiQypJq8+0Y3QtnLZ9pGqBA7cDbR3eGwp0cBiLurpefu/lk53YrHEhQZ+6lvTR3STNKSZD4iWyiSm5XTPgfDdWqxKs=
X-Received: by 2002:a17:90a:65c5:: with SMTP id i5mr372005pjs.18.1587584124023;
 Wed, 22 Apr 2020 12:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200416114256.226329-1-elver@google.com>
In-Reply-To: <20200416114256.226329-1-elver@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 22 Apr 2020 12:35:12 -0700
Message-ID: <CAFd5g46tezcWT7z6DFWBW=7604=_hNopuvkazE80sLOmJvcQbg@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add missing newline in summary message
To:     Marco Elver <elver@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 4:43 AM Marco Elver <elver@google.com> wrote:
>
> Add missing newline, as otherwise flushing of the final summary message
> to the console log can be delayed.
>
> Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
