Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D2EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC6C2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gat37HHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgCLOPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:15:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41635 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgCLOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:15:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14so7692277wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mrvIFthQhStRb0h9X0TVjnYAU7Y95l7BE/07Zs0KkmU=;
        b=Gat37HHk/IR5hOfp8StNrofQQOmpXRH6pEZ8csCcEb6VJBlyWEH/itLo+6rzB1x332
         4T0hPPvhhrsd4lpchwum7yLB3GYsA83Rge2B0luyRVmm7x3C9IWWlbwJSLx4J/IkCtWc
         3iq+9xvke8xefc2SiwEL5Zl86LRavFa8gCyUsBjsOLjrkbKK3+9GQJpDm9Sfo7Jyr8XS
         SjDczFadOF1FBblnHcM17/mvIME59SYg+fLvaow0pXNJh9aDETNsvVlH1MiFrSRBMF0G
         /yfpt4xMtixGAWXt9hjEzabm8ll+f31vjx6y9In21gFro8zXcB0/4ZrG8lHgnI4/vmjo
         CINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mrvIFthQhStRb0h9X0TVjnYAU7Y95l7BE/07Zs0KkmU=;
        b=hGsiypXgI4UceqHgz042gxfVvcfRS5qTBAXkI/EeT+SZh8wZPe1bXxVTLCScESa+Ff
         8LzD8FYd+54xjmpHiEiptm4CIdzUREiDp3xILbS6VDlWb3/5yK/vg8u/xmbMnhtygS14
         LtwgYdw4IgD5s8GIoIxUwIzwuFRFiq0HYad8mUOLjSYZwMsWNPdWYIzrXWUApymMNflx
         cCKOtDbZwEt7jXZTdz9oCG9jGfLEqf/xgq3w+zT9QCIQnYrIwGJMC7i5PJYCWhdyp0gw
         2Pa6v9uDgpF0YJ3v9BlC/AUDb0EECULquZK3dZ7YZwsuQ/GlYZyITTePm8JUZ9mIH9k/
         +bQg==
X-Gm-Message-State: ANhLgQ1ub+9wcmWg0HsJDngJjCbMfUCvSRM85pVGDCFWhzRpZLIoqBJk
        H6nRcB6ybtTFKd6cXQ/y6F268JCFCmqjl+Ah84vgCA==
X-Google-Smtp-Source: ADFU+vunbIhUB+upr9tvSXIUy5Rsh6w6Y/X84qlyHVsfayqsdBwr5bi936oAu3SpuUu2YFjWpTDxR6kp0SMteWKw1ns=
X-Received: by 2002:adf:f74b:: with SMTP id z11mr11805645wrp.124.1584022535408;
 Thu, 12 Mar 2020 07:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <6c252c3d-5d0a-2a2f-4b8c-60d7622d1146@infradead.org>
In-Reply-To: <6c252c3d-5d0a-2a2f-4b8c-60d7622d1146@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 12 Mar 2020 10:15:23 -0400
Message-ID: <CADnq5_PcQW=qf4fNx7v7Q4coLAMr755ykx+YfoxoYchHxivk3Q@mail.gmail.com>
Subject: Re: [PATCH] drm: amd/acp: fix broken menu structure
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Thu, Mar 12, 2020 at 4:09 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix the Kconfig dependencies so that the menu is presented
> correctly by adding a dependency on DRM_AMDGPU to the "menu"
> Kconfig statement.  This makes a continuous dependency on
> DRM_AMDGPU in the DRM AMD menus and eliminates a broken menu
> structure.
>
> Fixes: a8fe58cec351 ("drm/amd: add ACP driver support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
> Cc: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/acp/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next.orig/drivers/gpu/drm/amd/acp/Kconfig
> +++ linux-next/drivers/gpu/drm/amd/acp/Kconfig
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: MIT
>  menu "ACP (Audio CoProcessor) Configuration"
> +       depends on DRM_AMDGPU
>
>  config DRM_AMD_ACP
>         bool "Enable AMD Audio CoProcessor IP support"
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
