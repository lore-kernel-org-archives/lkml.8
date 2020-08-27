Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB50BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4512087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598548522;
	bh=7d2vVl33g5UiCVJFnwcetkTwUUvUDdqtExNCsvMtVQA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NdUrBzMSKr7M+TglxyV8Ji+ILi4UoMAdOfSudvng7VjoW/PBLZVgirMwNXma2uqIF
	 gJaWXF46+sWjr/BQmkcDYmqsuXqosiHfirJhta59E9CjKjhAEn9LRysW4KevbTNbtj
	 AIN2x6ffnVlq/nFa5TrSXAFDo6i+sq3mqSh3YtdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgH0RPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgH0RPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:15:20 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E11C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:15:19 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so7267516ljc.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w12LsIONkHiHf1X1dg76GDH+j4flCrQShoTv3VRea1g=;
        b=FdZoS6ucloJ1uweiQFAH2mrrb+1/WJBlhrsgmvjk19P/b7Ljnx16lLT1HpN5JdRdK/
         VrIposFwDAzSuhpYHAVCY+a36L22FJOs6M80hsOnr+RV/TTWtSX6z4ynWZHSRLazKMjY
         vgE93opHLT4CMsYZMN/zJ22KJnlkKof0ZS/+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w12LsIONkHiHf1X1dg76GDH+j4flCrQShoTv3VRea1g=;
        b=U5YxUtV/goR3Yh0Cek+0FcCwT6SnzfH3E5+CmYtp+0X8QULvTVdLUZ/KwrKAh3/0Z8
         raDJkPT0UrcIOG7WRZtKdeWjVTenFvfI3ZMyLcu8aE/7Ju8vuLMuPBAJQRsrM+H/TbsT
         eSNXYt/RR8WFb7vB6vq8rGql/+hzJTYXO6mV5G8v69K3wQ+SXxboDyTTWIBapBfVW8N2
         LcDL+h2jMooyE+KaS8Cr8AHV68VAVKpLuW9xFGd44g36TZMOlziM25Ef2QCQSUw/v/VX
         SZx8jtf/4+CuzK2iEHYENmDt8kqlZdi4GljkmbD1MgrTsQ8F6ryTwVE9Y1/yrdzcaSsr
         zk+g==
X-Gm-Message-State: AOAM530VIO97sv7wbF87e1s7I/g3z6y4GKJc3um2Gd6k9Ri6rKg1Qkvu
        rUT2E+Ua1nYS1TD4BZWxArs/LVJXi4yDeg==
X-Google-Smtp-Source: ABdhPJxyYu1o/1OPCrPCUySeK2FwElcZysl8QCwsIefyaWEHYej6rx2abbG8dZ5bSzXDr38mUzbhZA==
X-Received: by 2002:a05:651c:555:: with SMTP id q21mr9589151ljp.6.1598548518080;
        Thu, 27 Aug 2020 10:15:18 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id w11sm651015lff.62.2020.08.27.10.15.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 10:15:17 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 12so3324091lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:15:16 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr10296558lfo.31.1598548516405;
 Thu, 27 Aug 2020 10:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200827114932.3572699-1-jannh@google.com>
In-Reply-To: <20200827114932.3572699-1-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 10:15:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2p84Md0dP53NxgBAZcy+x9+fxnQQg9kD4LzZDkYCfXA@mail.gmail.com>
Message-ID: <CAHk-=wj2p84Md0dP53NxgBAZcy+x9+fxnQQg9kD4LzZDkYCfXA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Fix ELF / FDPIC ELF core dumping, and use
 mmap_lock properly in there
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 4:49 AM Jann Horn <jannh@google.com> wrote:
>
>  13 files changed, 346 insertions(+), 498 deletions(-)

Me likey. I had one comment, but I don't think it really matters for
this series. So ack to all of these as far as I'm concerned.

Does anybody else see any problems?

           Linus
