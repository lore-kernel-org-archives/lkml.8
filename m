Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCE8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3394D20829
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="pFd15NLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgEUQHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgEUQHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:07:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D93C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:07:23 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so6619691iow.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxBFsMmx8n9R2e5C1RT8PEj0LODZtQH68Aq7zJz2Edg=;
        b=pFd15NLinE1WqDgaOpWx2OED66tL+5EXs4pCEYPHvRKAxY5GB696t0HJGp7L+ZpUOs
         pwODl4lmr2JTGo/96Q61JeYXp5uYC/Y+phvZNbtzO7ud5/AItIoqEZ1wA6TQQS3p9psi
         G7TtDYPTj1HEAJn731CBVZjdhKPg3i6XfyNwwgmcdqdB7DsH+NcbimkJYYPebZrCaREp
         TDTL3Oi1dHBZObtlezJgDgAlAbwjkqphYAA4PuAzYtV8FplmLMa1MXN4+zJ2ZOcQWtvS
         XSXGf75kXkV17oX81DM7TA094Pv/9ONtHYpOC7FLjyBPrZYWx3idKcSkcld7U7Vpkwnx
         4WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxBFsMmx8n9R2e5C1RT8PEj0LODZtQH68Aq7zJz2Edg=;
        b=gsSRJXoZb4mjJbpYwplor/4a2rr+gdj2sUjz1UrR/1uw+MAAKs5BDaj8BdD9m02CVW
         tQAG0CcIeBB1c5hydN3mufgP2XLBzcjJhBuSt6WJZ/vurbgu/4PL/qFhNjvNmN9iPTAa
         JU1R6oJb+/Z3GZHBEs+Mr0i87WuiGd0KluRlIsqiElCAeuxTxw6AP1flv7sjkEezpA7b
         fgp/oumP/pf13++RwiaS/F8Fwke98Juc6MFYfxcuo21Ze4aXp6XzthrMV6Ahu0OQnF0F
         ZDx36l6IgLAn61uTwgTZQKt6eyQJ9znzT59G3iPJzLlAf2RS/Yd20o19Dv6q6cT+qtUt
         CgUw==
X-Gm-Message-State: AOAM530xtC+02DsQDo4wp5trd4keZAwxmd9dPmQiDX7tzcrPUJOJz37A
        K8RlI6ra5TPBHlAdha0jp3XbMEGBCjP3Vabis1Gklg==
X-Google-Smtp-Source: ABdhPJz71t3ROrdOggBJfNzsVoKRUnZjxPfccVeuDl4zar33TlmiT0+HZBA/QYPItDFw8rBAE2EI4Vu+One/6Wu4oBQ=
X-Received: by 2002:a5e:9807:: with SMTP id s7mr8476077ioj.27.1590077243097;
 Thu, 21 May 2020 09:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200521123835.70069-1-songmuchun@bytedance.com> <20200521152117.GC28818@bombadil.infradead.org>
In-Reply-To: <20200521152117.GC28818@bombadil.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 22 May 2020 00:06:46 +0800
Message-ID: <CAMZfGtVxPevhTy8LMpKUtkk1jX86doiPD0nOTRuKg25+8Vz=ag@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] files: Use rcu lock to get the file
 structures for better performance
To:     Matthew Wilcox <willy@infradead.org>
Cc:     adobriyan@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        ebiederm@xmission.com, bernd.edlinger@hotmail.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:21 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, May 21, 2020 at 08:38:35PM +0800, Muchun Song wrote:
> > There is another safe way to get the file structure without
> > holding the files->file_lock. That is rcu lock, and this way
> > has better performance. So use the rcu lock instead of the
> > files->file_lock.
>
> What makes you think this is safe?  Are you actually seeing contention
> on this spinlock?
>

I have read the doc which is in the Documentation/filesystems/files.txt.
If my understanding is correct, I think it is safe to use rcu lock.

Thanks.

-- 
Yours,
Muchun
