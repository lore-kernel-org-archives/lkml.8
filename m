Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9C9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9046121556
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHR7pvxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgFRABn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgFRABm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:01:42 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D0C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 17:01:42 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id t9so2160638ybk.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 17:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7UPz9IB0wuR+ULFqjoeOn81m+kFdV9mf/EYc+fuqGI=;
        b=WHR7pvxYT/fclLn788v5XuVsyL1vB6rW1eD7ALXv19rL+XV6ejoQgIYAg1oSVDAmfB
         Jjri8MNNMAw3CHDnX8Dzet/q7pZhC2vVE+AszMyOe1nEqNfjfqR08U9DGr051iERPBur
         sDes9x877Ax5T5f5+CtTenbkmhI9UoN2LLcVK5OJzqgs2KtIOX9J6Hpmcxyp0/esnfN9
         mDYDVIidYIt/rE5F7vNl58cHbPqtTaShAYq+tCwdVfjIN9pFCsDkKnhE0OneFCkGbR+D
         gkMlf0D/pf8EfDvl45r4xM9u/k0w4wa/guPU0aXvDh+tSfeTQiJ5AXR8wPxKXfXHn4nW
         /ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7UPz9IB0wuR+ULFqjoeOn81m+kFdV9mf/EYc+fuqGI=;
        b=ZvYNxuhXVyY7Tw2cTT6nx5WKd7nu5R7+FwWV1EB8Ou9GIiU9o7s1idx/eyeJ66ecir
         wALd/mLCPDyv5+Lc87e4onZvczPTZ96+YIOWeO367SBrBs3eBWlUeT1p5ftWDG4UJEJ7
         5ykgP/lalhr1BnUt3N/Taf8UInH89q59IawSFsKJp8HUuPRkB4AuUdxwcFXNkJZO0H5H
         eJ1VxlQe4TEZGPt9MIiHUPNfYffAoiU1+tRXrwbdB9dPRfeRmhPMDOxexhCEGdYaw0gK
         SLYluOEQFSBEjFLgLv6OKmgWY4+6GGLWwGiiwgKG5RfxuyBZ/jOqzbIXX5ZTbs8aDFVG
         iWcg==
X-Gm-Message-State: AOAM5331IUEdq+gAY93GUlWTwsB2ytb/763OXi5P8yMI6w3xRksfSvK5
        mv2BEn+2Ov/JFj/D5iwPVhMzbq5ljueWdTrV5kfRlgy/
X-Google-Smtp-Source: ABdhPJxx2Psv8jjW1S0mhJDxqQoTkh7WJXb/f7KtAQbV8jWCveufSRp7uVjuXyd6/Tn3clPASVryOBL/Qi6oVXFmiIc=
X-Received: by 2002:a5b:cc9:: with SMTP id e9mr2244637ybr.287.1592438501718;
 Wed, 17 Jun 2020 17:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200617203732.2076611-1-atish.patra@wdc.com>
In-Reply-To: <20200617203732.2076611-1-atish.patra@wdc.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Wed, 17 Jun 2020 17:01:28 -0700
Message-ID: <CANN689EXQsH3C92fe=QHVEZasWmBiMXPoOB=bRLhK2CP-hdKqQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Acquire mmap lock before invoking walk_page_range
To:     Atish Patra <atish.patra@wdc.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 1:38 PM Atish Patra <atish.patra@wdc.com> wrote:
> As per walk_page_range documentation, mmap lock should be acquired by the
> caller before invoking walk_page_range. mmap_assert_locked gets triggered
> without that. The details can be found here.
>
> http://lists.infradead.org/pipermail/linux-riscv/2020-June/010335.html
>
> Fixes: 395a21ff859c(riscv: add ARCH_HAS_SET_DIRECT_MAP support)
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Thanks for the fix.

Reviewed-by: Michel Lespinasse <walken@google.com>
