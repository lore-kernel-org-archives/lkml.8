Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C4FC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824192084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VtkzU6Cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgDUIGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgDUIGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:06:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90F0C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:06:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so2562364wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFrL7qqq+/w5oEV7z5+bEMvnta8f1PTq2HfSAlQHjL8=;
        b=VtkzU6Cwz50WlMChHtbCZ4913bjrfUyUNjnE3yWh6V5TSBKuzZljSFJkk3RxkYxQVc
         YvrDyf9rYaNG3nlR66jq4plgguH+c2MJzLfFIIjOJGP2H3Knj+QGWzfZ1mvWRVdwLGrQ
         yiKEvmDD8Oxuucw9gMD7Dwj7z567DNF9eONzR99XYIic7TsjdpOaLYQ42H+bPu2rJzqn
         bzXa1/OFMzjH9YGZ01EXsYLN9YL6MuQx++VDMTjrve039LgcYORJHI5TPa4+CABwQzk+
         oQ3FT7HVSu5BAI9EHtmBaFE8QCGwiQaY+yQYgVmC7mXf6bMWkXGMIJNvRUz39pntMdNE
         TWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFrL7qqq+/w5oEV7z5+bEMvnta8f1PTq2HfSAlQHjL8=;
        b=jjmgXVmPASSeJj3e30PI0UvihQVbIhtVnBtZwxHycQhsc1+CHpmjRUwKa2Yrn2nUt6
         BeAHzGm7Gbyf5HPirklNmleb28bCjYBRMreU2YNGBeEGFAXvdRc83d8/6i/ulNAYKMFl
         xMAZMA8qwbHQw8XlSnZ5w1wFJGRi0CBCP/lphISsBCpLxXdyjs8Nr/TUx4MzB73gdc9t
         pCbmBBVX9HVKG0GVqaj49nV1nQmdvjRFUslIhXMpmyQvW+HvFim+xuUhKaAJIowjjrrm
         t8cf7eOvgNGj3sKcM0dcynhqFVpbBggx8fHXAKKWvuxFTMLFQO0Asv4P1855XBsHsI0q
         yWrg==
X-Gm-Message-State: AGi0PuaUF4HPGyTMt/8U0pS+XHby/xt3uQnfj7iPOtOOklopU/xzZh1u
        jmOgWY5uxw7YwNgIK8NBIQ5z1mhCuIXXatSM+5bj3Q==
X-Google-Smtp-Source: APiQypIGD5hXn6Rf7B+EmEstKtX9N3KIuecs4//Vu9gR3U1CA0Tmqm0NvBrWK3DB/wLL8CFed6YY5TLu96jSW0TrlQc=
X-Received: by 2002:a1c:f312:: with SMTP id q18mr3522898wmq.175.1587456388218;
 Tue, 21 Apr 2020 01:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200419100848.63472-1-glider@google.com> <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
 <202004201540.01C8F82B@keescook>
In-Reply-To: <202004201540.01C8F82B@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 21 Apr 2020 10:06:16 +0200
Message-ID: <CAG_fn=XBn-kKWdoPFhnfOGTXBaMfeziPQJCrgE7KvteSwYLmnA@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in fill_thread_core_info()
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ewww. That's been there for 12 years. Did something change in
> regset_size() or regset->get()? Do you know what leaves the hole?

I don't think anything changed on the kernel side recently.
But I've made some changes to DMA handling recently, which made uninit
writes to the disk discoverable.
We don't use core dumping on syzbot (because the auto-generated
programs crash all the time), so it could be a very old bug that was
triggered in a non-standard setup.
