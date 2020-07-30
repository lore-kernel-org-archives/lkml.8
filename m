Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E19FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CA7207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHTugddu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgG3KwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3KwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:52:18 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BC4C061794;
        Thu, 30 Jul 2020 03:52:18 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u24so13485962oiv.7;
        Thu, 30 Jul 2020 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNYEj+ir7vkauxqeAiYak/tzOfoiA2fPuKRUqhHdGaw=;
        b=KHTugdduV+gozX0CGgVbo7+Sv0H+Sz0HZwmN63vGlX8DzYj7IVB7xTvyTlG2QK3I3F
         qwlC63B82LAsMtM7QttFok2KN0iPOWUnY6hYOfkZWO3+jJxKeby4lMam5dI/Ib2wIlKP
         Ic7e9E8tV1vvD52KXiDvwd3m50BF4gMa89c32BIAKC378XnPZy3YE0GDdOEjyPYKEBRU
         8i/3O/EUTvcZM4Dgobj+lG2V5Pi1qTYxJmvcNsLxs776TuuhpHb/Rt7aIi/FUzK4OtDW
         djuatrO/RWJXymo8FXqNBToUlfv5T6tjlQq+lKkkTfQbBpApvRx4W2qj6wQzclSWJ9gz
         lqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNYEj+ir7vkauxqeAiYak/tzOfoiA2fPuKRUqhHdGaw=;
        b=MTqhNfM9ObRdwDgY/cb7S98bz2rD1Lfjl9JtMYDtIFb/UkNbJtF2nkcw0+btwMpBkB
         3yr1/J/ix75cYHzJDJXItE4zdZnIB4jg6ktkdzK5LHhpudUCLWAHPUnoQK6zmx6iJvSN
         zHF+Wq2ciA6U/aGTmIrc1qWSyRsS9Dc3RdfGKqeJocktTAFM8Iv5dVfUJ16Jo98Mhzqe
         NJuCzqVDV3asD2C7X46jeEgWrlunPGWBLz61K9b0RCDoJm5KsOLV+HGkiJeQBMuqZdtl
         5R0ftd5x3XniSVN9K29EFERhDXm0dPUktFYpPnzbtRAvrBSoLbKY1zOXbDqE468KOqLp
         2nzA==
X-Gm-Message-State: AOAM531NiducGUeFBYRXrmLhU1WXUt0MV+Nc4Kgyvq8Tj4LsDHzCm0hh
        1LjGyjXGszmf4gTu1OWZd3WLBmCGT0aGApFnH8E=
X-Google-Smtp-Source: ABdhPJz/DNASJIWM9St9//aoXBaa7gBMkymwQUa+q4El23qgVzk8EMreSGHs4uEPn3YzL5S2wdcbMDPmmkNy182EdX8=
X-Received: by 2002:a05:6808:b03:: with SMTP id s3mr792598oij.154.1596106337464;
 Thu, 30 Jul 2020 03:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200730082022.5557-1-colin.king@canonical.com>
In-Reply-To: <20200730082022.5557-1-colin.king@canonical.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 30 Jul 2020 13:51:48 +0300
Message-ID: <CAFCwf101gsf3GK6f_ggNgPeKTFXEDdCYz-LugNq5mY342zc2Hw@mail.gmail.com>
Subject: Re: [PATCH][next] habanalabs: fix incorrect check on failed workqueue create
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tomer Tayar <ttayar@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        kernel-janitors@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:20 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The null check on a failed workqueue create is currently null checking
> hdev->cq_wq rather than the pointer hdev->cq_wq[i] and so the test
> will never be true on a failed workqueue create. Fix this by checking
> hdev->cq_wq[i].
>
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 5574cb2194b1 ("habanalabs: Assign each CQ with its own work queue")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/misc/habanalabs/common/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
> index be16b75bdfdb..35214a186913 100644
> --- a/drivers/misc/habanalabs/common/device.c
> +++ b/drivers/misc/habanalabs/common/device.c
> @@ -288,7 +288,7 @@ static int device_early_init(struct hl_device *hdev)
>         for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++) {
>                 snprintf(workq_name, 32, "hl-free-jobs-%u", i);
>                 hdev->cq_wq[i] = create_singlethread_workqueue(workq_name);
> -               if (hdev->cq_wq == NULL) {
> +               if (hdev->cq_wq[i] == NULL) {
>                         dev_err(hdev->dev, "Failed to allocate CQ workqueue\n");
>                         rc = -ENOMEM;
>                         goto free_cq_wq;
> --
> 2.27.0
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>

Greg, can you please apply it directly to the char-misc-next branch ?
I don't want to send a pull request for 1 patch.

Thanks,
Oded
