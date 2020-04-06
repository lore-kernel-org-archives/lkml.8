Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CC1C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3355B221E8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tc47wP7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgDFMtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:49:15 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38365 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgDFMtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:49:15 -0400
Received: by mail-oi1-f196.google.com with SMTP id w2so12932732oic.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 05:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fFB4VdA84Kugwzr7cseBJwu0dBCE6rHh8pgVv8EEcS0=;
        b=tc47wP7v2iRxBHrC4XRQCCKeCh3hWP45Nin6JzgR3+4GyevHAWChQgDAKOfMtyjmK9
         VOsVxkgLbMbW58sh4UpBrQRTKFdFnniHrU/yt309hGVa0gub/FsysLJMwD1xquCmQRGA
         xiHuAJuoFhQl7veK5j9wCnk3W9bbPkO2EXrmvpEJSXzypOIDJPVQDKErZodbebvt726B
         h8M5jUCKjLQUotXM4U7CGxB8CF+Vx3RWNrL/KOonulMVcijs/zR52xudTFNRPq0WJyy6
         X/MOFAgZizYVSLrK6cSA4ll9AK3iZJc5H8yorq0nmHOZcnLLK/IpwO+eBBCCzUTL8+kV
         EN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFB4VdA84Kugwzr7cseBJwu0dBCE6rHh8pgVv8EEcS0=;
        b=RdAxd3+HhT0k5cGoFGh09c8OXVFbOkprbvJrf/RS2QSSaxUUv1wyGzR0lJK22Z6FDn
         1lV7vWkpOqhope284XxBjZTzpqLGd3YJCjXLcjrO5KHvl3IT3mahRvP+bP9ut/kVckwy
         l+Rv9z7+jW8301McFct5WeLa6DPwbeI9GLxlL3ccTotd7coCttPkhnDZi5h7VAt+X5L6
         JwLe/9KpwKF3OdH3qNlSfEEM9AhvUkuTWadk98W6Sa0nooTUzta+0XyAemFprPsYbzI4
         d5QJUdDRPzksVSTZhvV1NFAjWfTbovXanms1PtPvMST7M5yp/PVGNNOTrxIKeKbNPPLt
         OpTA==
X-Gm-Message-State: AGi0Pua0xOPDXwIHEK1ZUS47nSsZYMj+4Dz7Q1KOPDVjwx1m4tMmZCWP
        pIRptnm7PRKJpCvbV9yomomGY+PtmNZSwpf1pC0=
X-Google-Smtp-Source: APiQypK+8VytYADNh4P+zG7WCNGv9WUis8t/SIv0S1IzfcExS1VnQzKmLTrz8eNCcJ0u1hURK/PclnoAZK+H2zmiSR4=
X-Received: by 2002:aca:3196:: with SMTP id x144mr12841366oix.77.1586177354089;
 Mon, 06 Apr 2020 05:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200404125845.1381080-1-gch981213@gmail.com> <CAJsYDVLA3fgjBGdStkiZeqEv8q2j2sUdDzgj3QdahB=tvyYJWg@mail.gmail.com>
 <CAOX2RU7ZU0Jj71YCAoP=qaqUomaHKTi=XMV8wGvwRg_fYpfoMg@mail.gmail.com>
In-Reply-To: <CAOX2RU7ZU0Jj71YCAoP=qaqUomaHKTi=XMV8wGvwRg_fYpfoMg@mail.gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Mon, 6 Apr 2020 20:49:02 +0800
Message-ID: <CAJsYDVJbczAST7HPtkPAtQXhm+RdZFyAJz4XVjwkNMPDdMnDyQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "mtd: spi-nor: Add 4B_OPCODES flag to w25q256"
To:     Robert Marko <robimarko@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000be6f7405a29eb139"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000be6f7405a29eb139
Content-Type: text/plain; charset="UTF-8"

Hi!

On Mon, Apr 6, 2020 at 8:23 PM Robert Marko <robimarko@gmail.com> wrote:
>
> It appears that W25Q256JV has an SFDP table and in it advertises 3B or 4B modes.
> >
> > [    1.957903] spi_qup 78b5000.spi: IN:block:16, fifo:64, OUT:block:16, fifo:64
> > [    1.962185] SFDP advertises 3B or 4B
> > [    1.977393] spi-nor spi0.0: w25q256 (32768 Kbytes)
> >
> I have used the attached patch to check what does the SFDP DWORD 1 advertises.
> If FV version has or does not advertise 4B support than that can be
> used to differentiate them.

My old w25q256fv spits all 0xFF to 0x5a read sfdp instruction.
I've asked someone with a newer w25q256fv to dump the entire SFDP
for me and it's in the attachment. You could do a comparison between
w25q256jv with this dump.

> Can you apply this patch and check what the FV version advertises as I
> don't have a device using that revision.
> FV version also should have SFDP as datasheet for it clearly advertises is.

I've checked the sfdp dump in the attachment and it's also advertising
3B or 4B in 1st BFPT dword.

-- 
Regards,
Chuanhong Guo

--000000000000be6f7405a29eb139
Content-Type: application/octet-stream; name="sfdp-w25q256fvem-wson8.bin"
Content-Disposition: attachment; filename="sfdp-w25q256fvem-wson8.bin"
Content-Transfer-Encoding: base64
Content-ID: <f_k8ogxpxp0>
X-Attachment-Id: f_k8ogxpxp0

U0ZEUAABAP8AAAEJgAAA////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
///////////////////lIPP/////D0TrCGsIO0K7/v//////AAD//yHrDCAPUhDYAAD/////////
////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////w==
--000000000000be6f7405a29eb139--
