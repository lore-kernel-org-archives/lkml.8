Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD411C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0352100A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592521210;
	bh=3DTLftlJt9ZxiQeVIqHIUgQIlWAIxhhOUrdqiwYWxaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jwqopWxPLYN8ZW4tB2h26OlYCbHUVgCCFAHusyMaiQejvMH/xZoBncCNkGHQUqLA1
	 GSw/854OiKzzjJzARKuDfX+TQjn9blfjkQ0HMBVUHpYxrye3c4dtBeotCLg1cWccp1
	 mTeQpdrHezFmQgCcbodago0Vi5CfzmSrYwNy2i9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgFRXAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbgFRXAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:00:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BDDC0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:00:05 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i27so9243528ljb.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPOiXGmVSJpnt+xtTiccAHXdSsoJkhvb/Wx3zcpBM1U=;
        b=PpDfYxcfStgK5uFhhyAFqUOqliV/bM94+itgR4KusvVnQbmktflqDFig8LU+VmfT8U
         Wp9ysSIcGje8X8t9l5wJHf1wL+pR3P1TqV9pMqozOt4rhHL1M31E1MehT9W8Vtcn4aBE
         eyTJqLmTx6caiIk7i8ez/5cGcDUmrpdauZssg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPOiXGmVSJpnt+xtTiccAHXdSsoJkhvb/Wx3zcpBM1U=;
        b=NEx6hDYPc6vQ2q6O1i22UNlDY2NcQjDLGR9b4VYRqBdUKKAgShcCWiIZvSqQavwjg2
         zTbzz/x96JCACrc+qNCDC1fowuw7JTygER/3OhU94i7IjJ/g57GOTe+TWS4h5AGlS4RG
         bg6CGt0MC4eo4sx3LPsCK4wuNuBDD6eL1hQv+b4AiS4IYclspjfR3lXikHnzTiGh4H3R
         2cB+znQfzpbUdlyOiYQ+04c0mk+nRG33fP9S6yaefVw4XWPr6Z62sKEw3dwbkA62ucVE
         cTKA4a41j867Jrx6qMzM8g1YGpm2c6uMsJzmUnYYbFgodwDfoaLlAM56/eA7KIvhjLHl
         o9lQ==
X-Gm-Message-State: AOAM531jaJc1M7BVzCtE7mJHwVkttSikLJYkb7uyBLhmbVUG/vjyINMo
        zxEzQOhLIq8GQ1wcd3iLMTYAJ5NDt2o=
X-Google-Smtp-Source: ABdhPJx9iKz/yMpTsyfWHYY4uq4IzOniIHtd9beUepIoxrTgGU09Z6KCQi+1v096PlDxIT3j6zaLRw==
X-Received: by 2002:a2e:9557:: with SMTP id t23mr292661ljh.355.1592521203408;
        Thu, 18 Jun 2020 16:00:03 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id k1sm1011001lja.27.2020.06.18.16.00.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 16:00:01 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 9so9276125ljv.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:00:00 -0700 (PDT)
X-Received: by 2002:a2e:8991:: with SMTP id c17mr275545lji.421.1592521200490;
 Thu, 18 Jun 2020 16:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200615221607.7764-1-peterx@redhat.com> <20200615221607.7764-8-peterx@redhat.com>
 <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
 <20200617154925.GC76766@xz-x1> <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
 <20200617195807.GH76766@xz-x1> <CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com>
 <20200618143801.GK76766@xz-x1> <CAHk-=whFEZbTJZaNwEkyevUV2aqRwbeVmtp6hhk1sK2mW4vaGA@mail.gmail.com>
 <20200618212430.GO76766@xz-x1> <20200618222834.GP76766@xz-x1>
In-Reply-To: <20200618222834.GP76766@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Jun 2020 15:59:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikLPYrSty_XWQU17zvFZ+seUGOzmcuqcTzgBuKeK_LSQ@mail.gmail.com>
Message-ID: <CAHk-=wikLPYrSty_XWQU17zvFZ+seUGOzmcuqcTzgBuKeK_LSQ@mail.gmail.com>
Subject: Re: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
To:     Peter Xu <peterx@redhat.com>
Cc:     Guo Ren <guoren@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 3:28 PM Peter Xu <peterx@redhat.com> wrote:
>
> > >         if (regs)
> > >                 perf_sw_event(event_type, 1, regs, address);
>
> Sadly, this line seems to fail the compilation:

Yeah, I should have known that. We require a constant event ID,
because it uses the magical static keys.

So never mind. The perf_sw_event() calls can't be shared for two different ID's.

           Linus
