Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD188C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CB420772
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP+WpLxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgHKGvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgHKGvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:51:17 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2307C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:51:16 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a24so11295495oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSWklIV0NJkqa+0Z9KEPk/bUuO+WORhyM7guQm05mvI=;
        b=aP+WpLxtqr2hpgFbG8y+8cfzjhwv2iCJrd2NRiAFR9JUX6zm6kmbp+4XrEdDEerxWr
         TsMvSm5JGXUqdS+CHi/eh2VcKfCm8jQ4hg6QG6QL5HAN5/1YHDoIGdeTdLP9HQH3hQXf
         qJl6duBBQQ8hTjkNSS+JSXOydKZ47pZa5wH39N3GESrPX1GG4sSvQMyj+6ZP7L96KXOB
         phPKvmqfj5hDBFIhZvWuwIbr4rtCII51k4rer6EUx8+x3LLCEoIt8FAUrHp5NsxQBKWp
         37yqV1NHdEbyt4q2VFZTteGxdolu9CyFRm6arYa2o7/CgeR0DXByUHNDUt3WThohDjNx
         hUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSWklIV0NJkqa+0Z9KEPk/bUuO+WORhyM7guQm05mvI=;
        b=cctPxp9+QQQwEw6iXNunyK9ii8Igl0fkzYLl5szd88otQE1tzDfZbRVwFj09s2+rvJ
         uuBMvf5JojsThIJvZeoiI+aV/k/UgpadVoMlrJuDQVrJ+AdDkQs+1AuS0MOr/y9uxbVs
         A+tkoiZ/4snDGvciL1qAGbi5hZLYqlc9MtYL2EdsHMC8Ydu3B9rzv5N7FbLAtQveWz65
         tUJdg0ArJYZBtxbyxdhsn44rVlu1gq6DaPrlF8LUEI5KSYAWrlnxFjuMIChnxh4p5oR9
         Hfu2MFE5HNBhRE+N1tzbwDg4Ckf1ljjbFAWMwmQi1wbKL2Yft/V9enx4oUPv+0o3QV0c
         ITTA==
X-Gm-Message-State: AOAM531U/CY2r8O+aDVVaxkj0NL6dKFLOVfUkXlqi1JNw9l9YqY8EJUB
        hY7XSaCOuLYlXROUsUysDtx7C+5EP/5iLgd3QwM=
X-Google-Smtp-Source: ABdhPJwjn2ii6c8fbj7No/jA42GR90gSTQ+rcckd10d7X6zwkQod4Z4tEpgin0MmB1xX8qMDWQ/BWETIp58VEawHix4=
X-Received: by 2002:aca:f38b:: with SMTP id r133mr2414368oih.81.1597128676385;
 Mon, 10 Aug 2020 23:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200811022427.1363-1-wuyun.wu@huawei.com>
In-Reply-To: <20200811022427.1363-1-wuyun.wu@huawei.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Tue, 11 Aug 2020 09:50:59 +0300
Message-ID: <CAOJsxLGzh=U941A25NDHknD-vN4oxpsgPNT4NU_-3W5sdV5o1Q@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: fix missing ALLOC_SLOWPATH stat when bulk alloc
To:     wuyun.wu@huawei.com
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 5:25 AM <wuyun.wu@huawei.com> wrote:
>
> From: Abel Wu <wuyun.wu@huawei.com>
>
> The ALLOC_SLOWPATH statistics is missing in bulk allocation now.
> Fix it by doing statistics in alloc slow path.
>
> Signed-off-by: Abel Wu <wuyun.wu@huawei.com>

Reviewed-by: Pekka Enberg <penberg@kernel.org>
