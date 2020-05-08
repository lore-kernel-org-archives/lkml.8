Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DBEC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183E12070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gpiccoli-net.20150623.gappssmtp.com header.i=@gpiccoli-net.20150623.gappssmtp.com header.b="bf4W7j1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgEHCR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgEHCR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:17:57 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEE1C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 19:17:57 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so115503qts.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 19:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q181yzRPrb4b19Hrbwu/9thGmuUl9/8sqVdS721JtdI=;
        b=bf4W7j1XqRzdw6xkGA8tp0VlOVCxMWbB+5gcI5x0cv6vhpfQlQbsx1lWrFsQFbOAET
         OiCBzQCpFH38gyWtn9ZHRhJPrcacz9KPTXhelGMveATMxSQHTAC6+frJ1nQFJwsQE+9R
         qzkfmp9k92ODps/zzm2KJEf+JTuPlokJ/NxFobH60O+RWfNcMFGBvjUnRzoNRViTa7Dv
         WuDLScVZzW6k3Fn2UBEMKGqc1H0vSMcx0/1rn+5ilFO8E1Cq4eYFGwlzigbuWXygvnNi
         R/Qs8RtfpEHLxY2L8N3uZ0nOhRNVab9CYgZBapTZ90S+sDyqqej5Saz4pYzCwGjd57gx
         1zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q181yzRPrb4b19Hrbwu/9thGmuUl9/8sqVdS721JtdI=;
        b=WD9BX4Jh8WalDxaOlXvf6fKeduPZsBBp5l4dvKp+s5yq1/C+dVaLmODcOnzbDPnZQA
         0pDZlbtM/3CKLPLuGN/qEFJoGdxibqt11jRG5kxkdYvcspHt8woLj60JtjlapJegoWMD
         NtWSiGVr75+c2vUpIEDzU6/oJItSODlrz5GoHKqDXypoqyhE6lmVgids3qUTHDjJveVC
         97Z5ABhtomKP+/PRXQKBImBtwF9WfNfqZxVbqzbSqcZLRmMgTilT22zdLBuF8454smqT
         ZE6BOYTbOQQZ/SzkqsvbZuYv0Ju1uSBaVgJGi1CkMelY7YgdgJshzTNhM6AUoVA+NCIj
         c5Nw==
X-Gm-Message-State: AGi0PubxbCUlIFapC9cX/LYOD/HSxfqOnPq/sz2+I31GwM+GWnTcPx4x
        R+cLRQlxeXr0yrCp5P6EUiqdfgPGPv/snEz6R8dMbg==
X-Google-Smtp-Source: APiQypJA/nTNKSOcz66mO4EnbxIFuBZdFfzznNIpAqzztxpk2iMe7jNp61vYGF5COXtBAeI8Y1COIQPYkQTSay/NioY=
X-Received: by 2002:aed:2ea2:: with SMTP id k31mr547064qtd.136.1588904276303;
 Thu, 07 May 2020 19:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200507214624.21911-1-gpiccoli@canonical.com> <20200507160618.43c2825e49dec1df8db30429@linux-foundation.org>
In-Reply-To: <20200507160618.43c2825e49dec1df8db30429@linux-foundation.org>
From:   "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Date:   Thu, 7 May 2020 23:17:19 -0300
Message-ID: <CALJn8nMwQfHdXAQHHqnWA7GxeAN43wG2W42uF6uaHQ--Z40xOw@mail.gmail.com>
Subject: Re: [PATCH] kernel/watchdog.c: convert {soft/hard}lockup boot
 parameters to sysctl aliases
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        keescook@chromium.org, yzaikin@google.com, mcgrof@kernel.org,
        vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 8:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> We have a lot of sysctls.  What is the motivation for converting these
> particular ones?

No stronger motivation than a regular clean-up - I just liked the
infrastructure provided by Vlastmil and thought in using it. I know we
have plenty of sysctls, but not all of them have identical/duplicate
boot params, so I went with the obvious ones, that I use more.
Cheers,

Guilherme
