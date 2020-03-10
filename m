Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B42FC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6982920727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcY6+r9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgCJSW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:22:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33032 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCJSWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:22:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id r7so1370938wmg.0;
        Tue, 10 Mar 2020 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=it8trrpvdnE8lbVcVzCfYZFwTP46rg5Mn3zTzXxsjeM=;
        b=ZcY6+r9lGHH6YVxNBCPS7unM3w/wdoEHNuJ71U/vF05ttw9K9SkqdtJ5J5+GBlOHCZ
         A0Eaj+erJQeZCHHcY7+PHj7rWQ4UuSyg5mMkvJ6HUHXPug/G/SyboUufUQiVP8+7Y50c
         SJwlnU3oae7Qivyioj1HilauZHtN05XBAZAdri/5K5Lom/2yROdPpllIKi3XZpVJZytK
         nyfz9j6BBQAU/3fBLqVy79PtQlLw95krmvfaSTWgWigu+ieNgptCR2ZHVTXu6CNZNrdb
         ukWuKiF395XxApNiA99o6tRbjBQr/Xif+DJYQ1WIaTeDS8mDo/vEocp7Uq+wbAC0wVtT
         HS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=it8trrpvdnE8lbVcVzCfYZFwTP46rg5Mn3zTzXxsjeM=;
        b=TSmAc0pPxH4U4KATD9xWhNlIQyweKVd0Bz+Zx6vp0cWak7EYUzj1pfqR9X89OcDdRI
         rXM4CYy4Dfp5gicyZW+bJJwA465Xibx7CFXFa15iyhUmCyvbcn0B2rOpYpsw6SHo++HN
         Db+jei4MRR2IxSExEX94a0cRyD5ZJDCFgnRRSjf1DSPd5MNCqo9qLxxgWVi7dSk1faR4
         hhgfNUuKxPnBcw2hwYlznqY7FVr+DtdE0zhPCLN9kKOS4uPKWsOpE9mDRTYl70ybmfwv
         6OLFTFdv2/fiPu9OWI+LkzVB/CtD7klKgyU6p1z14Bl0gdUbue4hIG9qbmIwkN12E9lA
         Cg6w==
X-Gm-Message-State: ANhLgQ0m+y6PS93fT60gOMEMxlbavh93N+rnelcLlNe6+0KuxQEntNKV
        bM28/qaxN+laOmtZvTOkbmV91stgS3QejPZ8nUA=
X-Google-Smtp-Source: ADFU+vuaavQ/gdmX2nQpV4Okh+oEnBhU7kjTuQq61iGLQQf6sk078NhHyYEvUDxzNdSsf65AYb9N5pD0AtYGrhdKW94=
X-Received: by 2002:a1c:26c4:: with SMTP id m187mr3273269wmm.43.1583864573883;
 Tue, 10 Mar 2020 11:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200307060808.6nfyqnp2woq7d3cv@kili.mountain>
 <ba294b1d861142ca8f7b204356009dd0@bfs.de> <20200310090644.GA11583@kadam> <fabccce3c25444bbb5aa51f8c08e9865@bfs.de>
In-Reply-To: <fabccce3c25444bbb5aa51f8c08e9865@bfs.de>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Tue, 10 Mar 2020 18:22:42 +0000
Message-ID: <CAK+_RLk3D1VA6Rms1TGEFuEeO8JGxUaXfmWxznn+cHCG96TOTQ@mail.gmail.com>
Subject: Re: [PATCH] bfs: prevent underflow in bfs_find_entry()
To:     Walter Harms <wharms@bfs.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 10 Mar 2020 at 17:57, Walter Harms <wharms@bfs.de> wrote:
> that raises the question why is there a len paramter in the first place.
> Surely the writer can make sure that there is always a NUL terminated
> string, then it would be possible the use a simple strcmp() and the
> range check is useless and can be removed.
>
> seems a question for the maintainer.

Please have a look at, for example,
fs/ufs/dir.c:ufs_find_entry()/ufs_match() functions --- they do almost
the same thing as the ones in bfs. And, presumably, the line "int
namelen = qstr->len;" in ufs_find_entry() is causing the static
checker warning too, just like the one in bfs which Dan mentioned and
fixed. So, let's not over-complicate things (or make a mountain out of
a molehill) and accept Dan's patch as is.

Kind regards,
Tigran
