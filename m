Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD92C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056B52064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+N8DYXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgBQIpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:45:30 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42704 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgBQIp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:45:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so19708768edv.9;
        Mon, 17 Feb 2020 00:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7z9lWZoTpRLS6tWSDiTEqNHH5BeJFbEKLuF0FSjsVA=;
        b=b+N8DYXACDwaKqUSZF4zpVfJ+Z1ABA7Dm/8fNDEOaKO8s3c5qZP2/lR2loKaFrE3K8
         stJZWBVp5Fbhaj23DWFCid9Ko18PTnAO548NzWnWTd5NlzmCMuOkH/a7MFq/LeV3P1nr
         HiW5edhIXwKCqLBszDrE/Gp/AGjPhyEpPcYnANKJJYEIDAXJKOqCe7Qn9fgAXLrmZuGT
         X6wIeRi73bcouK7c3h5I+eJTR4TECTXZXpwqbT5/PbRCvVhvnnmgM40JtkgBDkiz7NY2
         DT6I7iFQB6rzJXOHk0Fgh0qudOGnOmzNmU1bqJRYK+M1aR3UAYhqxCHNkPW/YMsUO117
         c9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7z9lWZoTpRLS6tWSDiTEqNHH5BeJFbEKLuF0FSjsVA=;
        b=QmohOuPSUpO5kwhaSVKZmskjGYSJbPkhALPn1oAu9wwq8+PZ//+eoMV2Ud7M6Q3Tlq
         zz+RdJOBjKZX+pO1ApkhtsnyR386gMaTr0/zyUGWH8iPOy70XQ1U99iOdcYs2/inniW6
         rnS70A2kz7Q7jlRn8s2kmumDTlV1UCey1Px1Z8VYgFuQXDrXfwux6E/reu6xiqGmmhxJ
         78yot946u3UGKpp+tH40a4BSuQJtfxApgQEv4/yalq+smPnNRLthvAN/QGChHhSr4y5Z
         tv93PbU76p7jp0x06n7u0jPMvj5fPqvxtio61feABwgUhPwP3tzuJf13gTo9hEVFbjim
         pztw==
X-Gm-Message-State: APjAAAUEzxqDOtqR3YKbOvl6SEgDADEB/LZESMsiYueoQv3GhKX9R6Y/
        JCB+chokYOPBrGYg2s8zf2bKqwui/WdrQZdYhPSd0Q/j
X-Google-Smtp-Source: APXvYqxcq60rleS1PQPjozYZvzbchOMiJjEiB6k9xv2Cz1glvpkWV15Nz1lH6qhBa7YmAb5mQi5PVzHyCdtOS0FO+FY=
X-Received: by 2002:a05:6402:b0f:: with SMTP id bm15mr12863595edb.235.1581929127615;
 Mon, 17 Feb 2020 00:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20200217081558.10266-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200217081558.10266-1-lukas.bulwahn@gmail.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 17 Feb 2020 11:45:17 +0300
Message-ID: <CADxRZqwGBi=4A224mG0cPgONdNitnvi3LFD_KQckxdYSXzgBGg@mail.gmail.com>
Subject: Re: [PATCH] tty/serial: cleanup after ioc*_serial driver removal
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Pat Gefre <pfg@sgi.com>, Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:16 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 9c860e4cf708 ("tty/serial: remove the ioc3_serial driver") and
> commit a017ef17cfd8 ("tty/serial: remove the ioc4_serial driver") removed
> the ioc{3,4}_serial driver, but missed some files.
>
> Fortunately, ./scripts/get_maintainer.pl --self-test complains:
>
>   warning: no file matches F: drivers/tty/serial/ioc?_serial.c
>
> The driver is gone, so remove the other obsolete files and maintainer
> entry as well.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Christoph, please ack. Tony, please pick this patch.
> applies cleanly on 5.6-rc2 and next-20200217
> only sanity-grep for filenames and make htmldocs, no compile testing
>
>  Documentation/ia64/index.rst  |   1 -
>  Documentation/ia64/serial.rst | 165 ----------------------------------
>  MAINTAINERS                   |   8 --
>  include/linux/ioc3.h          |  93 -------------------
>  4 files changed, 267 deletions(-)
>  delete mode 100644 Documentation/ia64/serial.rst

Can you please at leat leave in tree serial.rst since it has generic
nature and not describing only ioc3_serial driver? Does ioc3_serial
the only serial driver available under ia64 ? Or can we please not to
loose some docs? Or do we have a more common serial driver description
somewhere which has info on ia64 serial driver/ports ?

Thanks.
