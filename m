Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25165C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB1321D82
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foW1Md5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgIIMHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbgIIMBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:01:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75010C06179E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 05:01:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so3160278eja.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKqV5XSoH6x5apOh2Nzg4ObPZHKKEF8Qi7zC+PdttRs=;
        b=foW1Md5+PcY51Wfk/sk1BBTgjv6d/chmKaf0uEYrbBg0jd7Bvi6Fkhls4g0/gu296a
         UCEO8KqfQ7ZjID0nbU2267W+NAEMkWeHxYqdFLyZjeF/4lshOVmLeEadcabQL9vAcyBy
         1sxugjTRoJlpEioOX+JeP5pNiQ9hXysXYkB9xJ6xgK+cI4CKr3X/T0BMRREPcXfA1Ft8
         H2Nnmg/2ghq/ZYdkq9NpO8zSjVB78iNNI2mQVfptzeELeGy+t03jkU0hH2SLnILaThFo
         GZw4NXu2NengHu5frTpzbdKqMACUAt5KJM58ItWRHAlMGbpx3XRW2gU+G1rdU9QPkctd
         /zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKqV5XSoH6x5apOh2Nzg4ObPZHKKEF8Qi7zC+PdttRs=;
        b=k7Nan0vt1feoCe6ORqmxkbKBBOZErRRZkeJ8PnKkqgHIb76bjycqI3fi59j2d6qsfC
         XVEin/+EydBYrKt0rDuBL0Aa/J3vJuoW7tAQ9XVX18uPkSmyJiRawrf/RSwh/SjI735e
         XdwXCecXlWtM9CE7GUIwYA3/ePZMOaHn0IagZ8sbH071Gd5C9la9KmhLv9TRxjwzduxq
         4SlFNU8uPGluFAhwKHff3mc1mdlTuD9bbaaSn7lIwqO5B/KAZnXm6cOpZ0h+g0XqljfU
         Yk/Le80vKXHdotlSsVSA1xPK4gVsr75p9YYh8F2IBCl/G80chFJ0WsPJqDOv4IWRP6yH
         N0wA==
X-Gm-Message-State: AOAM530VlXQBYzt+SLFH2/eRnlGchASW2CgGOghwW9xRK2/oihFEJyz1
        vJ4+8Xp1l+HTgiXURcO85L3wfxS/vpic3LDlH5M=
X-Google-Smtp-Source: ABdhPJzBbr6B4ZQ9Naj8exihC3G1QjkWySYloBeInyig6sZdE4Ug9NrPIGKfHX4XIwFRG3ako1/JZYdHI9UcS1J3EAQ=
X-Received: by 2002:a17:906:4b18:: with SMTP id y24mr3123340eju.471.1599652859057;
 Wed, 09 Sep 2020 05:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200909112901.5002-1-weiyongjun1@huawei.com>
In-Reply-To: <20200909112901.5002-1-weiyongjun1@huawei.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Wed, 9 Sep 2020 15:00:42 +0300
Message-ID: <CAOJsxLH5tQzWaZcGJ15fMNNsguodNj-mTNci8nT02bxVt-TRNA@mail.gmail.com>
Subject: Re: [PATCH -next] riscv/mm/fault: fix old-style-declaration warning
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 9, 2020 at 2:20 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> gcc report build warning as follows:
>
> arch/riscv/mm/fault.c:81:1: warning:
>  'inline' is not at beginning of declaration [-Wold-style-declaration]
>    81 | static void inline vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
>       | ^~~~~~
>
> This commit fix it by moving 'inline' after 'static'.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks for the fix, but Palmer committed similar fix from me to for-next:

https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=6f36a9635082e1d6910bc7853d0c9fd12d7890b5

- Pekka
