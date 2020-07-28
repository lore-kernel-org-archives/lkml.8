Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B02C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657DA206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhfgIFjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbgG1Ofa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbgG1Of3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:35:29 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1143DC0619D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:35:29 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g19so8880175ioh.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wE63hykpdOWCKf+hJ+uo4tJ4NmzeI9PTAqJH7wvSMlc=;
        b=LhfgIFjPN1Zt6pM27TDwc0D9sQ3LgHFulpPO2SX5S88mG/mDfs8otJIYAkvnkswxld
         9pGQRB5MX9+c/pNc/D2jvjcUfkcaX+O+bWMi/ZdZWSGCZgEcirUgpaGCBHTTFwLDeXxm
         blFwenzn7yqD2djWtvbrpRZs6R2NA61KUwTMx0D/r9/j+IuKq9D9CivCPsM5HlRumsun
         8SeaeatA922UsvA+t5ljvF60Q6rxHuH9aAmjAJ5nqq0yc8rdtO4PxA+a9Y5/pkBdStPf
         L/JGt34i7DNkTsg+8boIo3khF5Q26aC+wBgUC+PHLlS8m0uSQi46IDgH+/15eUls3L+F
         tp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wE63hykpdOWCKf+hJ+uo4tJ4NmzeI9PTAqJH7wvSMlc=;
        b=jOZZCOjYAvAGudtQCeqhcerhWg+kBe4b/eNN4qbXFTQcSk6o1nUBfoVUGxtVu1WEmA
         jxSyY70EvqPnZzLTp9Nss2+y/NBir17laJyLfKwJUwxwi+z59FxAbzeo68+Jmyu4SJ6Z
         ULIyb9I3u6m2XlBrqiAaUL+hpg7by3siY9aNxcDL8vrEt+jkPCri6GZCqNOSJNCkXzIw
         xZe2Yu6nolxGRz8bcmWJzlJI9MOEttq9F8k/hvud9r/c7EhzZIpoGMKL0//k0/MdbOf3
         xv/fXD9+xAenQn5/sS+8RTCAkEKlOGxIijXUk9jM2lV252sUAzhQBnccvBM1efZp+jMI
         YNMg==
X-Gm-Message-State: AOAM530yg9UPGTKBiONOnBdlp4eybTRP88Dftw2FEz2sMxxg0qUPqQZY
        0gddm30S2pT2uj8wvvjvvyUuFwZ9TosLedDdt9fPug==
X-Google-Smtp-Source: ABdhPJy2WEagQVK01W1PoJL3TtsswctQA4jC85OF1eYxNmME8rZTNY5/2CM7uNz/FDIzfpS1C5VvpAW+f52j5jGXddQ=
X-Received: by 2002:a05:6638:134a:: with SMTP id u10mr6463616jad.35.1595946928305;
 Tue, 28 Jul 2020 07:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200727134914.312934924@linuxfoundation.org> <CA+G9fYvBRONMYwX36Hcju4JA5TwstkT2Afyuy2DB1zQcBcc1CA@mail.gmail.com>
 <CAMZfGtVV-u7K+Z0vFLkoKv1UOTfk=a9+r_6G4PYfGLywwnkm3Q@mail.gmail.com>
In-Reply-To: <CAMZfGtVV-u7K+Z0vFLkoKv1UOTfk=a9+r_6G4PYfGLywwnkm3Q@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 28 Jul 2020 20:05:16 +0530
Message-ID: <CA+G9fYs__nNa-090Cm8j_EPYGRfh+y+VTX3ZqR_W1Jcu2suNEQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4.19 00/86] 4.19.135-rc1 review
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-mm <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, lkft-triage@lists.linaro.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 at 18:33, Muchun Song <songmuchun@bytedance.com> wrote:
>
> Thanks for your test. I have reviewed the patch:
>
> [PATCH 4.19 76/86] mm: memcg/slab: fix memory leak at non-root
> kmem_cache destroy
>
> There is a backport problem and I have pointed out the problem in that email.

Thanks for your suggestions on the other email thread.
I have made changes as you said and boot test pass on x86 now.

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9c5eb4b08fc3..65bc49f19504 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -842,9 +842,7 @@ static int shutdown_memcg_caches(struct kmem_cache *s)

 static void memcg_set_kmem_cache_dying(struct kmem_cache *s)
 {
-       mutex_lock(&slab_mutex);
        s->memcg_params.dying = true;
-       mutex_unlock(&slab_mutex);
 }

 static void flush_memcg_workqueue(struct kmem_cache *s)

- Naresh
