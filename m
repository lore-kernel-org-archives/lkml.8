Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1ACC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0503F206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QayA64qN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCLTd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:33:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38611 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgCLTd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:33:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so7890504ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CzwX3JhIDPjn8Zf/b6fbGBesCy+eZsCppQlTq8HkhYg=;
        b=QayA64qNRNU0xH2o43FSdFi17MC1VTw0kY/pBfJsjBmYlPISlqtpekl7jTiNx8x3hE
         55R1wq+qpLpzNqeLXWdpY4gPPcyBEye7AGwxG4Zcve0CY2L+DGtVnKF2YybmxaNT8duv
         nD+1885Owz9j04pPDu+yUhYEBwyunOV0Gi5q9OTwgv85DHsGANsNhsxHwrfMr8eNx51w
         dVnp3JT2f0h0SZ3YoyMKSFItFngKk7Kuw+LW0E99wFWjzdBkZANK7SRPC9H55F7CwCoa
         plU3fXfEhKh/AKwk8wn9KIFAWEEg4ICZxnRlYQC7RlNxzpNjjE+R0SHcq0ODuhPunjkP
         FKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CzwX3JhIDPjn8Zf/b6fbGBesCy+eZsCppQlTq8HkhYg=;
        b=RnBpFUpNAwIrFGAbB0IKZVLyiCZM/a3dXsWblhaSqVeh/AAGM+zIW+jew+i7oi2QMb
         jdeBZZanN7WEuTou3SXRdaBmy7qHa3VOZkShTlEWEcVgzh0QHs7nEKgdS6y6S8ZWmcoQ
         LfZ6rB0u9Wl0Amu5dR/JfoLgJjKhhAXD6fxzksd83fSaLBhGsgcBysbEqKm9ItQKoQtd
         k1FW5jZtWr1x4ocNy1SsgdQQxhMuOehHorxrY7o4oO9jvZ05F2psJjGnFrPZApZ7X9z/
         sId50jrDV3xbyC0gu0ALinjhWTA4fhMOv9byuultpb5hTsKht7Kdjo+tmtZebTLZqpmf
         pvSQ==
X-Gm-Message-State: ANhLgQ0nOLRsmkD3MrmZ0f/29bvs235FQQkbTgTbepiGTpfZA7GWMVaT
        a3Kqf4cM20uywtGJ666Nm0Xvj0cIUJobCQLw8g+rDQ==
X-Google-Smtp-Source: ADFU+vsyPcIWcQDYaioXlz7FWZjzsE68UJXRIDHTYfF+ewOuSZoHHX7h5fQh44mivCxhpzdWLwkm0r/7qTrNw5LJPsM=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr5766672ljp.66.1584041602698;
 Thu, 12 Mar 2020 12:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200304002137.83630-1-rajatja@google.com>
In-Reply-To: <20200304002137.83630-1-rajatja@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 12 Mar 2020 12:32:46 -0700
Message-ID: <CACK8Z6FNmZFW9c=1tY4Q4rn4ZyUu--CUTuLk0SHZsuYb1-H7Og@mail.gmail.com>
Subject: Re: [PATCH v2] Input: Allocate keycode for SNIP key
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,


On Tue, Mar 3, 2020 at 4:21 PM Rajat Jain <rajatja@google.com> wrote:
>
> New chromeos keyboards have a "snip" key that is basically a selective
> screenshot (allows a user to select an area of screen to be copied).
> Allocate a keyvode for it.

Any comments on this patch?

Thanks & Best Regards,

Rajat

>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> V2: Drop patch [1/2] and instead rebase this on top of Linus' tree.
>
>  include/uapi/linux/input-event-codes.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 0f1db1cccc3fd..08c8572891efb 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -652,6 +652,9 @@
>  /* Electronic privacy screen control */
>  #define KEY_PRIVACY_SCREEN_TOGGLE      0x279
>
> +/* Selective Screenshot */
> +#define KEY_SNIP                        0x280
> +
>  /*
>   * Some keyboards have keys which do not have a defined meaning, these keys
>   * are intended to be programmed / bound to macros by the user. For most
> --
> 2.25.0.265.gbab2e86ba0-goog
>
