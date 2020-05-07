Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BD7C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7DE2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2346PGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgEGNuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726521AbgEGNuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:50:00 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E909DC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 06:49:59 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id r14so2941800ybm.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 06:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmR99xx+Yesm6oorgLPy7gPshtSDq8wvp8OCFeJfg9c=;
        b=e2346PGDvrAMzUO2Mv86gFcgr729Ua8DFn3nGE4JDikbENkM6tT559dmqxIbt0UUTm
         hdoTkstFceX+NH9kO5ZGH/Ho4VsjAV3Nhrr4h9wZnztBpuISSGImg27AgICD+D4IKoSK
         ro5WFuh7ssWcEXH+dL8zYlG/k8XW/7gSHrNeyGgcuy2g/7LiQau37jTLz3hhbEK8BQ9W
         Ghxo54dMjeYBAG1BKRjC2/63ZCIrkuaHQ9PR6GAf7cgniEZ7HMYbEgvtHGp3f3UYwPRj
         QK1rCytsf4HMLSf7luqvIPBWLSDGoX1xMaaQBSb7XIOks2Z/JmXc6Lue2+7EjSTpc4W2
         nl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmR99xx+Yesm6oorgLPy7gPshtSDq8wvp8OCFeJfg9c=;
        b=VO1e1r5XQlpecSvhap3pEyOlcmlRnCzs7SSdtmNGsmtjG3De8OOcqllKAry+YhZTB2
         So4JNUeEw6KPxdw3b2a/LdoJEJK+y9w7i0tgf8xc5vntJOQ4LPkYzy0klu9UufebQkc1
         UQvsBfWdCl+O+HYitwRm+gtWpvXAEzIC1IVTI7FQWksNPsskZywsZXzdQxw6y3cBUlDq
         Q2bM+jX9d+e+VcC+0AtGUBgyHuXxjre+tvUGwE6Xp4026ThwNxqm5CAkB+4E1ddR1+1L
         gKO56FuCFJP6RmXndFPHN4I5YOrjIKlKq4uEBlAhaRbHMh2aXUYNzgeBzcsFT+mWX9Bo
         msJw==
X-Gm-Message-State: AGi0PubrtzCP/zjIwrqLCBR62VuRNeLCu3nvkZs3762y29mijz9dFD75
        59ahWSBJpgaoH+3q1/0+ZKNXtjC0Uwarrh7XWIGDdw==
X-Google-Smtp-Source: APiQypLlJOWtkmwdaWITNck8f5md4q8BhjXx4Z8R7bfcHESuPPrXnBHYT7/OO3pZmn63Xy6S5NhzTEqO/S7CJJgevM4=
X-Received: by 2002:a25:1484:: with SMTP id 126mr22422004ybu.380.1588859398853;
 Thu, 07 May 2020 06:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200116.042722.153124126288244814.davem@davemloft.net>
 <930faaff-4d18-452d-2e44-ef05b65dc858@gmail.com> <1b3aaddf-22f5-1846-90f1-42e68583c1e4@gmail.com>
 <430496fc-9f26-8cb4-91d8-505fda9af230@hisilicon.com> <20200117123253.GC14879@hirez.programming.kicks-ass.net>
 <7e6c6202-24bb-a532-adde-d53dd6fb14c3@gmail.com> <20200117180324.GA2623847@rani.riverdale.lan>
 <94573cea-a833-9b48-6581-8cc5cdd19b89@gmail.com> <20200117183800.GA2649345@rani.riverdale.lan>
 <45224c36-9941-aae5-aca4-e2c8e3723355@gmail.com> <20200120081858.GI14879@hirez.programming.kicks-ass.net>
 <39ddacf9-adbe-c3f5-45a8-9c5280ef11bb@hisilicon.com>
In-Reply-To: <39ddacf9-adbe-c3f5-45a8-9c5280ef11bb@hisilicon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 May 2020 06:49:46 -0700
Message-ID: <CANn89iLiCh-LDw9WsB=3Wm=V-Ey80JRrC8yf8fsy=vbVc9FuPQ@mail.gmail.com>
Subject: Re: [PATCH] net: optimize cmpxchg in ip_idents_reserve
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, jinyuqi@huawei.com,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        guoyang2@huawei.com, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 2:12 AM Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
>
> Hi Peter/Eric,
>
> Shall we use atomic_add_return() unconditionally and add some comments? Or I missed
> something.
>


Yes. A big fat comment, because I do not want yet another bogus
complaint from someone playing with a buggy UBSAN.
