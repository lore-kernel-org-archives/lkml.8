Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFD2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C532077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPpnXooY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgFANzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFANzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:55:23 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CCFC05BD43;
        Mon,  1 Jun 2020 06:55:23 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c185so9057087qke.7;
        Mon, 01 Jun 2020 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MTId0Os/yg4rhbm+EeuQBxt1UqEtEawNrCHYfpmyKkg=;
        b=kPpnXooYOT5d3nyDjaUTERRVJecKZ9IDmbZOQM+PJDrfGewsccmuewYh7EAISztcx/
         zOvbNr05Jr9ns5O7gh+Fmrdt6npj/dKdHjgFu2f1X3Gx7QSHCEI7XDGjsVK6Bk7g+vML
         uoR7TQ3xsf+TU1vXcE9oO7gcRsh+b6/fqxfzjgeszbmBybw0TPP0DUZ3WYypaBtXG+7u
         SyHJO6WW9Esr6mB/xzNfU3qXPqhCp6MR96r6RyhmPezDsAL2r+Fwz0VeKH7aZnP5Ql35
         u3T2gi9WgcT6f/6uF9g+gWMBx9+LPFZsTqmTd4uKSrixbLQpn34N1wJ5z/GK8b9lqAa+
         XrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MTId0Os/yg4rhbm+EeuQBxt1UqEtEawNrCHYfpmyKkg=;
        b=hAiIwOJZ62Off1VSL4XHqt3QhAA8aHpBMJf0NtgSSXou2yHtGxgQhiYu8cAyfh0lDo
         OVSUQr7IbR4Fj74MTLTwJhGax+XAEjj0GCPb/OM6DZ+z0AnWb3QHF5dK+kP7dcohUvvg
         Zau/z6z0E7dlSHMXYLEj3JpXEguYCs/TIXNn++kisk7eJ+BD481lcEsdD045JNHBFsIs
         AP5j+Qizgk0wi7SRIHI1lBpA7oaG8vfognL2wGRppf0HJ10BGu+HSJe4D7rP4ciIEOLF
         Nw8ZJl+05yEJmEyhhSDUigCKsS6nBMTfgIRPqe+7Zg0UD67t+NP2pE33fLS7Z7ENJiog
         lP0A==
X-Gm-Message-State: AOAM533VCPFGLSbYmLBMrUt5B3VhIWKalrGnNyRvAxyYStXfCXA5fOiL
        wvARtz3MId0ja1Z8ChGCU+Cq3Btfh1objQk+BWfCSPhC
X-Google-Smtp-Source: ABdhPJwkz7qkU5U9ZiQYP0Xlzql09Al1JdsPf0KW7zuxSuK/rW69hHCI63snVLovh3Grc3c2FJ9tMHXzDwzFiP2fG7o=
X-Received: by 2002:a37:a847:: with SMTP id r68mr21084003qke.45.1591019722322;
 Mon, 01 Jun 2020 06:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <2bec05b7-78d3-fa36-134a-efbe977933e3@web.de> <45e2cd69-93ec-a0b9-b2a6-d170eee44055@huawei.com>
In-Reply-To: <45e2cd69-93ec-a0b9-b2a6-d170eee44055@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 1 Jun 2020 15:55:10 +0200
Message-ID: <CAFLxGvxGqes3By2Qg6nouo8Eg-c--=fmvyS6pq1xgMC+JKAmpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ubifs: Fix potential memory leaks while iterating entries
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Zhang <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 3:46 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote=
:
>
> =E5=9C=A8 2020/6/1 20:00, Markus Elfring =E5=86=99=E9=81=93:
> >> Fix some potential memory leaks in error handling branches while
> >> iterating xattr entries.
> > Such information is useful.
> >
> >
> >> For example, function ubifs_tnc_remove_ino()
> >> forgets to free pxent if it exists. Similar problems also exist in
> >> ubifs_purge_xattrs(), ubifs_add_orphan() and ubifs_jnl_write_inode().
> > Can an other wording variant be a bit nicer?
> Thanks for reminding, I will improve this description.

The description is fine. No need to resend. Patch will be queued after
the merge window.
Thanks for fixing these issues!

--=20
Thanks,
//richard
