Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF51C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EB52077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579207048;
	bh=mmtOnjvmqvnf92VIGdvdB9apuAhusTGGepQinA7Ap+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QJzcdvqyjfDG+MvmskOwV8AQ/pOp+rs+IBxIATPAJ+FOGQWBKmjxxe3IZ6vhJUtkX
	 zEch2+ccMjcb/veLY4o5b+Qt9FYpn40a7CoPOaOHOqDN1zt5SuPzyDAhtMR8ViX1Db
	 jtsx6QcMErqL5scIxHJ0GiVipHWmaMMR3TxwtPdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbgAPUh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:37:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36478 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgAPUh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 15:37:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so20124570oic.3;
        Thu, 16 Jan 2020 12:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzWrcINvZxQSS9EFoJ8JAh0Ay/OFSJ2Xnh3lSR9maO8=;
        b=LmnV1FaEkLTu1xywbj6yHsDT76EYg+7Q1DFseRK3v1g3eQA6DKZdwFMTJ4x+0svKzK
         zWke3D9TZYo7+ZF/atprr5jrsAOL5dbZHrf1y610GCEUC4Cy3qNQs4+IuDpISNCkgJy1
         zhVi9iQV+Hh9VrsmjIFD8heoBDP4gKY4fCncqRX3X6zXjKadh98OsaZNRKHn2CQDDRAT
         5jAN3SOBqdsY7A8NwKz1907kY8aRiC59WIOFNlSQ5e1fntFyk9XZF+eTRuRoYRSUetVP
         zqgs2v0T7k67qmDTEBwDebYsKphBTGhxWSWPGX9d9eYpP/jIXTBTjGJLXmYl6v43DMBn
         /MgA==
X-Gm-Message-State: APjAAAXNRw3PQuq1lR1RJrjTFocm26xhFDT5Mc/yzoidhapWd0xIi5t8
        A6DTiFqcyANhxeoy7cHedTLllZ8gbD4vXnCJ4Flybw==
X-Google-Smtp-Source: APXvYqwevY8vXym4/KmtJM9N/WrO3KvTg89GKTAbO5hB2oqV0y7TrCsouYiIwEBhP6IfYgqRT+pKItiYHeGjHQfeRgY=
X-Received: by 2002:aca:cd92:: with SMTP id d140mr776903oig.68.1579207046782;
 Thu, 16 Jan 2020 12:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20200116175758.88396-1-colin.king@canonical.com>
In-Reply-To: <20200116175758.88396-1-colin.king@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Jan 2020 21:37:16 +0100
Message-ID: <CAJZ5v0hpn2mdp88B46xaaVPkHSPESadJd3A4ZwijHAW5nOidwg@mail.gmail.com>
Subject: Re: [PATCH][next] driver core: platform: fix u32 greater or equal to
 zero comparison
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Simon Schwartz <kern.simon@theschwartz.xyz>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 6:58 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the check that a u32 variable i is >= 0 is always true because
> the unsigned variable will never be negative, causing the loop to run
> forever.  Fix this by changing the pre-decrement check to a zero check on
> i followed by a decrement of i.
>
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 39cc539f90d0 ("driver core: platform: Prevent resouce overflow from causing infinite loops")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 864b53b3d598..7fa654f1288b 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -571,7 +571,7 @@ int platform_device_add(struct platform_device *pdev)
>                 pdev->id = PLATFORM_DEVID_AUTO;
>         }
>
> -       while (--i >= 0) {
> +       while (i--) {
>                 struct resource *r = &pdev->resource[i];
>                 if (r->parent)
>                         release_resource(r);
> --
> 2.24.0
>
