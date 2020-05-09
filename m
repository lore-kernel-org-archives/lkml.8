Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A243CC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 15:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BCB208E4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 15:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JG+grHef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgEIPhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 11:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgEIPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 11:37:19 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A70C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 08:37:18 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g16so3409519qtp.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=rcivY61FjI8KZB+d1rBbrvH7RkDa2Uc4j8UGF0eae0Y=;
        b=JG+grHefh6HgG+HoX1rFmDt90/y3Ikvg28kVGgdyTr9sorkJyr5DUZaGAqskqMhVL3
         5NIq0QuQj+Du4dphPJH64v4hZL2u92XPhqb3UJnCwAp5L97OqduMn0g1mrEk3xD/DjxS
         N0iMYNPsx73zlAv6mfTV+YbVVC0yRw1IdEYanWV1TggD6vX3b6/y0X0KtUgTbQr4RX6y
         kKDa0L/o+4Wg0w6y33aN1PUOaCcbjDGMDsR0jkQfZwfWl+i/O9BKuEY4Hiqnuv1Ld17l
         7cC3UI1upj540CwbqQZEnOE0d6xsVWttI7A7LwzgMcFOn0OyAd5CEG6yMpEf67KzHFn8
         AWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=rcivY61FjI8KZB+d1rBbrvH7RkDa2Uc4j8UGF0eae0Y=;
        b=N9yuqhUIHwA+C36OTgM1cs7BJJhtfYF0abyzrAfiglCYWSNGJbzd7veQfAfZgBljO+
         hQjpZ8/KiIs7sNzTbU+WicQmEnPtDvb+VWaaQmjLoN2QGeQ7F17sdK2HPjfs5F6J+R27
         u+HuwCbzvOxzmwiarXVqRAxtWHG5emxREawKILmNM95YqOJPmY0PpZYAEGUobTuJ5qk1
         eT7v5yyUYbTm4+Ekf9aJGPMd9OjkFCIl+a0Cz7lEJfP+yR5ojKnU1pItOATXru2XK0Ww
         MJdjA+FZI+dR/ejs7dEWnHRIhTOuhnmwjm1xhhIywyBzG7dfP2HJ3xEnKS4HUZjP7DL2
         StBA==
X-Gm-Message-State: AGi0PubEXNqiqvPqNVrJu71ZaGQgJOmZowZYabaI5ltoYs650omOpSZj
        CrO/MotkafMHW/lXDHbkgZ32fwG6dXInpA==
X-Google-Smtp-Source: APiQypKQZtoOjdL6x8igHPSiWIXN0mgbo3DURqVymEKgCj3FYRUlu1Xh10DYyIYSpBYuw8EWrB3Q4w==
X-Received: by 2002:ac8:3733:: with SMTP id o48mr8387465qtb.149.1589038636813;
        Sat, 09 May 2020 08:37:16 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k127sm3766709qkb.35.2020.05.09.08.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 08:37:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: ioremap() called early from pnv_pci_init_ioda_phb()
Date:   Sat, 9 May 2020 11:37:15 -0400
Message-Id: <ABC2D7EE-2C59-4A96-A105-406F424A93AD@lca.pw>
References: <1589013450.02gfmpktnp.astroid@bobo.none>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
In-Reply-To: <1589013450.02gfmpktnp.astroid@bobo.none>
To:     Nicholas Piggin <npiggin@gmail.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 9, 2020, at 4:38 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
> Your patch to use early_ioremap is faulting? I wonder why?

Yes, I don=E2=80=99t know the reasons either. I suppose not many places in o=
ther parts of the kernel which keep using those addresses from early_ioremap=
() after system booted. Otherwise, we would see those leak warnings elsewher=
e.

Thus, we probably have to audit the code, and if still necessary, call early=
_ioremap() and then early_iounmap() followed by a ioremap() once slab alloca=
tor is available?=
