Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1545BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED91208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aeIWvzPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgEHXFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 19:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgEHXFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 19:05:03 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E141C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 16:05:03 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q7so3577585qkf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PiUVa5mVO89jeXQmai25H32mWUhzjICjk7pOMJIJk4M=;
        b=aeIWvzPXDXfpoIWJD4RSKGQirPc8lgF0hCA7z+WnsTXlqRhUtPwt4ABFjTPGSQ4MmW
         co9aA/P0GUUUWqi2b2tLG/UGKjI5T4MsFL7wOEefM5SJJFRdXctIb9yoofcvfMBAhpvX
         J/QuNRxp4qHlOOtTwNwjrBQweLSXxjbnyo68o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PiUVa5mVO89jeXQmai25H32mWUhzjICjk7pOMJIJk4M=;
        b=NGPf986hnNGEv+ZcbIO5QlrEGRbqqu8hMr1nftftpHt58hJhfpH9HzFqWw9oVwcbjw
         J1rr9g+U2rUqHUxYE+s4DwI7/vkAasLjEa7tDniW/DRJMK59m251TKDD/YmcunVf1lFr
         rmS+pd4ndA5NSkx3WT4K0lLHP6J9Q5aGeuOHQoFOwn6Q3v+GncgkP+0uP7rHCkJr7TWm
         7QKbr+bPjNPVzRCkhupVBxq8p+BxUAc+WL7NARNSX8NWdC7w/vkqJMVhm4F0iBPzj/4+
         SHWYLVyPp1DnfrtfVI6uYp7JU3BKcLigfO+d8UkMaoWB4v5G55qcZx3Xb60Icw+EKOxP
         ao4A==
X-Gm-Message-State: AGi0Puaat2xYvKTG0MwdOYS4meVbHkpQkHvp2PL86VAwYQCzZpe8DeH6
        U+B1UW0q2CSAosvU40SHMh10hcJUK0DrD1TdufIwmQ==
X-Google-Smtp-Source: APiQypKgAkoL81J9siZ6ExsdQxNJg8FR8V54RCPQtvmozJqNCBpzRhfXUIlX/5mNKADU/Vf82qndSg3c1Brdxm5ukPo=
X-Received: by 2002:a05:620a:4f0:: with SMTP id b16mr5114221qkh.165.1588979101996;
 Fri, 08 May 2020 16:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200508225301.484094-1-colin.king@canonical.com>
In-Reply-To: <20200508225301.484094-1-colin.king@canonical.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Fri, 8 May 2020 16:04:50 -0700
Message-ID: <CACKFLinpQFupdmq63RH527sDrAj4nrV4vcR+eDy5zh4KqLh8Dg@mail.gmail.com>
Subject: Re: [PATCH] net: tg3: tidy up loop, remove need to compute off with a multiply
To:     Colin King <colin.king@canonical.com>
Cc:     Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 3:53 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the value for 'off' is computed using a multiplication and
> a couple of statements later off is being incremented by len and
> this value is never read.  Clean up the code by removing the
> multiplication and just increment off by len on each iteration. Also
> use len instead of TG3_OCIR_LEN.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index ff98a82b7bc4..9dd9bd506bcc 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -10798,16 +10798,14 @@ static int tg3_init_hw(struct tg3 *tp, bool reset_phy)
>  static void tg3_sd_scan_scratchpad(struct tg3 *tp, struct tg3_ocir *ocir)
>  {
>         int i;
> +       u32 off, len = TG3_OCIR_LEN;

Please use reverse X-mas tree style variable declarations.  Other than
that, it looks good.

Thanks.

>
> -       for (i = 0; i < TG3_SD_NUM_RECS; i++, ocir++) {
> -               u32 off = i * TG3_OCIR_LEN, len = TG3_OCIR_LEN;
> -
> +       for (i = 0, off = 0; i < TG3_SD_NUM_RECS; i++, ocir++, off += len) {
>                 tg3_ape_scratchpad_read(tp, (u32 *) ocir, off, len);
> -               off += len;
>
>                 if (ocir->signature != TG3_OCIR_SIG_MAGIC ||
>                     !(ocir->version_flags & TG3_OCIR_FLAG_ACTIVE))
> -                       memset(ocir, 0, TG3_OCIR_LEN);
> +                       memset(ocir, 0, len);
>         }
>  }
>
> --
> 2.25.1
>
