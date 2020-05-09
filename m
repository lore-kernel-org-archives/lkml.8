Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756FBC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496B12184D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4PmmSPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgEIILv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgEIILu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:11:50 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725C6C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 01:11:49 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id m5so3626328ilj.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=trcL6JL/P6z4vCS3d8TLuc4KmkB3M51YoritqIkziPk=;
        b=Y4PmmSPdrqGZ9O/9z6M1BAClnjDC+wdjebUzwpC5fqMXzZYsNdW+jA1kUHbxbimLGc
         /mmI2EA72uT5ihkSTK2kuTqHj2x1+e1v/a4TpW12wq022tFZEyVJOJOn+45xFoyZvGwB
         YxJG4EZ5l7m5NEQyA6gu8GjgtWPhpi6dUm0V8JIuLM4mfs8vHdoqVr27OTCiinlxu2kC
         HIZXznUP4vbfD1HXnVh4/XkWFHjrO1UFdc0yBC7U2UEIIx8yk+99ve4PhVtDG2qRyX41
         ZZqSJzBY37qlaSMcLkKy1g2xS1xSIjqErA0/BU92BelEHTjchkhQwastD5fZK5bhcYmz
         n5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=trcL6JL/P6z4vCS3d8TLuc4KmkB3M51YoritqIkziPk=;
        b=bmZE2ocwfzdVzZRBx3E95Ug8UAbSuFDqyljuwSLfBy8EhfO4ZUM3hCpURVW2BqVydJ
         xYwFYsBZGeGVhIO/VItPBQAowZKFbUnpfd5SHYt0YO8dA0/fS1w49jpzzjo5nd31wt2b
         7DooiV2Xm34LG0RJWi594EAodeVn4Fb6/KA9ItvreN/stfbFu5YxeisF0GFUN9zgpA7f
         MhMlAqoDKBbYhmom7zqGNjtaWfkeBm8g6mWGfcQVdl+fndkb0BbrWJZepYE+K9u1PaPg
         cYNdIDppSlnZNE+G9zU7lkc2Iscg1Y/4gIdvlXnDie/MjdTW97M+kh2zmyBjIJM3rCHN
         hTLg==
X-Gm-Message-State: AGi0PubjRzoVMS1becRDhVV0rO95z3/hbgUnTn/cyCR/MMXCbdddP/wi
        GpspYPstAxeVh/qX3SeiujOzRJ0QZNTsGawiYxg=
X-Google-Smtp-Source: APiQypJEGGvidYhz7vaJLXabTC/HGWu94b/4ibiIxw1/gsZvZ2NKsP9SXVH45+MFpy+V6NB4mvbM7/gSZjyNNEJO5mQ=
X-Received: by 2002:a92:7c01:: with SMTP id x1mr6540061ilc.122.1589011908683;
 Sat, 09 May 2020 01:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <B183CDAA-DA88-4760-9C1B-F73A8F7840E7@lca.pw>
In-Reply-To: <B183CDAA-DA88-4760-9C1B-F73A8F7840E7@lca.pw>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Sat, 9 May 2020 18:11:37 +1000
Message-ID: <CAOSf1CFNp6+k_y_87r7p2e8cKfX0rK-9wBxeR+K0e0y8R0_TNg@mail.gmail.com>
Subject: Re: ioremap() called early from pnv_pci_init_ioda_phb()
To:     Qian Cai <cai@lca.pw>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 12:41 AM Qian Cai <cai@lca.pw> wrote:
>
>  Booting POWER9 PowerNV has this message,
>
> "ioremap() called early from pnv_pci_init_ioda_phb+0x420/0xdfc. Use early=
_ioremap() instead=E2=80=9D
>
> but use the patch below will result in leaks because it will never call e=
arly_iounmap() anywhere. However, it looks me it was by design that phb->re=
gs mapping would be there forever where it would be used in pnv_ioda_get_in=
val_reg(), so is just that check_early_ioremap_leak() initcall too strong?

The warning there is junk. The PHBs are setup at boot and never torn
down so we're not "leaking" the mapping. It's supposed to be there for
the lifetime of the kernel.

That said, we could probably move the PCI setup to a point later in
boot where the normal ioremap can be be used. We would have to check
for initcalls which depend on the PHBs being setup and delay those too
though.

Oliver
