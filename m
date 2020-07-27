Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A89C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE4E2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595850563;
	bh=AP8qQis0mm9kaqZRRNwDPioe7x3P6w6WMGgquzMgdJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SuwqbbRhXBYordpYhIJ/wxTy5GR0pzKKjVsDU2hnQTDxCOstkTsZeEtD79DWRHNJF
	 9N05GIBH7SkukqXLWNpJ2K3RqdUsDD3T/1Z86ofHwJfW7/lWJBjx0E0GXidcYb+oZ+
	 jTMLQgi8igEKbPJUvyCb6XCRqnbM0sCxffiHfUyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgG0LtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgG0LtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:49:22 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C857D2074F;
        Mon, 27 Jul 2020 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595850562;
        bh=AP8qQis0mm9kaqZRRNwDPioe7x3P6w6WMGgquzMgdJk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wBJ+TaJaoAWCitlegwqY4aSQWrI1IL2hO0Z9FBEJWbMn6/b4asehZypWLMxPJygjp
         gsNIlnNYt3NiijmvRTVep2Wp0v5iqcAfDv9ZQUZ55ahk3GyKh03keYB7m4vYlsiw0i
         /+6K98xWldd4c7HSmbndUHXDi8EqY+VuRZahFFH4=
Received: by mail-lf1-f50.google.com with SMTP id 140so8836508lfi.5;
        Mon, 27 Jul 2020 04:49:21 -0700 (PDT)
X-Gm-Message-State: AOAM533XoBcDB2pe18x+UtOrj10zRVXdh2s+o85jKH4goOPR11lKKI1R
        JusjLuJuPhVEeXOGaxrQpUaXlTxoYof/hYn5Yu0=
X-Google-Smtp-Source: ABdhPJzF9ksBLcDaFH7InKBJ6D2AjvYVzzXFLPKUYrij9YkRoYcS3582wzerTkvg4RKeanCee4bQcMwaB6qCppwKFz8=
X-Received: by 2002:ac2:5548:: with SMTP id l8mr5573404lfk.39.1595850560136;
 Mon, 27 Jul 2020 04:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200727213641.3491e3d1@canb.auug.org.au>
In-Reply-To: <20200727213641.3491e3d1@canb.auug.org.au>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 27 Jul 2020 13:49:08 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdPVEB7V3Kvz5rrVu9DUULWGZ-ne804NJSB+QtB=6C30w@mail.gmail.com>
Message-ID: <CAJKOXPdPVEB7V3Kvz5rrVu9DUULWGZ-ne804NJSB+QtB=6C30w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drivers-memory tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 at 13:36, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the drivers-memory tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/memory/omap-gpmc.c:36:10: fatal error: asm/mach-types.h: No such file or directory
>    36 | #include <asm/mach-types.h>
>       |          ^~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   99b42df9d57e ("memory: Enable compile testing for most of the drivers")
>
> I have reverted that commit for today.

Yes, I applied the patch too early, without all dependencies fixing
compile testing. I will drop the commit from the tree soon.

Best Regards,
Krzysztof
