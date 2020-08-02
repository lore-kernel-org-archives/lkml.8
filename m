Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBC0C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 21:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9144620738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 21:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8eqM5/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHBVCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 17:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHBVCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 17:02:02 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC895C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 14:02:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o22so26660692qtt.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 14:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzYzoaIUwT8rgDkx5dGq6re7hM/XmMRk4/fJO3pnsgo=;
        b=b8eqM5/l7VBGoFIufYZLynFItbPvw1ZibLa1rccXyQRR8npgWu2glJSNAnLH/mcMEg
         z3R0EnTyUytLO83xvrF2GyFSgELCfxyexnEI4FDLJ3BfxpuyGAsiOuGZwa7w8+n68NVI
         R2ZvtgTH1BkX0g63PnBvuNvA9GJ4dPSk9ASKxCHcO+IrD7ygtbcG5Zd6jv3qo1cUZmCz
         tXuu6P2yQeIXIyXjo3S5wG1c9iPJp4H69QGN23XIV8zXjjIOstI65X+oTdHlTbOV6aUj
         QhiWo+1TVENPSsynRc7qlpxcNWkSHsmeYBITuVppo6F5YNP8MSkFGGPgeSbyIH8jPV1t
         vPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzYzoaIUwT8rgDkx5dGq6re7hM/XmMRk4/fJO3pnsgo=;
        b=RQB/IeqUc74PpkS3UD9m92wICZOJJZNgF/hofbU6FSSRU6iO1krrTi16WQCDG7j9D8
         BCPMS/zkZW6uFiQzHwyq9pI5jVmN9G5wQKQCDXJv+HHdQrkN0pSeXzSFzb26WX1kh8IU
         UBayE/JK1RDn8O1RTEUZrc84013JYjintEM8cwnvMka/IiJ05FIhfIDs3Tnhmw+0VjBa
         96THzBKQj87xZuUBrIQF3R6JfTXOBhwhTI1lBXtsklyrBP58BaDAzUAUqc3nAJUbDOsv
         8dKACP+ep7TKaQjM3wTfnyRk11CSANc6Blk9UL0Bdc/NmK8d8oW++eOvnoPQr1Lxp7k0
         0nnA==
X-Gm-Message-State: AOAM5322OpFfDCmEqftbtR7+I7N+jo++mwN/arRQMmuSEXwU0iVFzPHl
        lfPFmKtuYXZoAZudWHRObIZInfxvCYZUcFzoivU=
X-Google-Smtp-Source: ABdhPJzUtfPxR4VHmetkBGgWot/RDpn/DTt/HFmHxZ47CKslwdouhRRlRjunN3hVOPupmYnVBpxHu5liDjXJf1rf6J8=
X-Received: by 2002:ac8:6a07:: with SMTP id t7mr13747833qtr.1.1596402121057;
 Sun, 02 Aug 2020 14:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200719003208.21200-1-rdunlap@infradead.org>
In-Reply-To: <20200719003208.21200-1-rdunlap@infradead.org>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 2 Aug 2020 23:01:49 +0200
Message-ID: <CAFLxGvxZYMv0nnAah4-TdnOy69Q=QyX6oLXismg_qtxUEoDUtg@mail.gmail.com>
Subject: Re: [PATCH] MTD: mtd-abi.h: drop a duplicated word
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 2:35 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Drop the repeated word "mode" in a comment.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> ---
>  include/uapi/mtd/mtd-abi.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both mtd patches applied, thanks!

-- 
Thanks,
//richard
