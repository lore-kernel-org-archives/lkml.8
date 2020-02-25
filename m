Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5176AC35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AF021556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPhjHWWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgBYLy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:54:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44767 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgBYLy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:54:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so11766055otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 03:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBqfeZcpRIHjSMJmkcL+KGMw0iUXwGNGFcmuo3qETB4=;
        b=RPhjHWWqpPnyYD8gytcIKpGvtrZ60aPxevvkvbwXV2c/CQhJDm90XAXCp2ZYzn765O
         BRKZRI971z+Q8yOMrhKG5ljEUJnYVfMkMEpf/ud3ZaaqdC0X3hxjzFvOXmdZCc1sbNpa
         7vTCfGWVg7ZfbR1I+DNoB2EYpr/sDYggL1gwc+OOoo3T9+1jNxUHWxtu3UHNVJHzPdS4
         0hc8Usu9TrzkZ8CJq4trvKfIUeIOHIm7aw5PpM3WvQH44hc5v9axSAoTqO8zPoqyENv2
         vpYPITRtOFpKus3mfLAXbSLEORFf/++UhopSfRPOdPOnD92o0Qx57wHKq3MoLevy1/hT
         q/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBqfeZcpRIHjSMJmkcL+KGMw0iUXwGNGFcmuo3qETB4=;
        b=Iz9zuVfwMNrLYTuGngGLRUP1Ex4qRaTUeix9ptr6eXFSDpGYaxTmDvDQHoZHb72qDX
         mIZXeLclSVg/LiKsgioQB7E7HdOOKmfWZ7wDEKwJ+Igdmwxhou3ogbEkhWuhSvZS3j3X
         RvUstka8R6EB3GJePtGqVXJ61G2/srBqXus699oGsX7Q8xISlOzFWOV1JbJnyAbvK/P4
         RYtYNU7wz3XKRpkCvWbARGUJUzFA6Wv8YeC2UcMXaw/VEean/it2BaISB17uGNvSJOXD
         A7wNo39P//AKhiuc7sjnuakA4X6ThCsZnCI2l9M84FlpIx4RhT/dLvviP3+QNiwsUuhb
         aQHA==
X-Gm-Message-State: APjAAAWRZg3+kJ+IYong+LLvailf5MzFgu/sGgBVk59YLL65xuHminBq
        IdHLi0VSjq1V9SBlx5ecj4g58c+Gi+yBkg6TGc+YfPKY
X-Google-Smtp-Source: APXvYqwj5QZ4nVwoicybq/QMT35xCBOTZ0K4Wc044VPVf5J2evGgHYJBiRga/FpllgwOo4ufA4NlM4TBundQ3fJ7rS0=
X-Received: by 2002:a05:6830:612:: with SMTP id w18mr45345595oti.160.1582631668857;
 Tue, 25 Feb 2020 03:54:28 -0800 (PST)
MIME-Version: 1.0
References: <20200225112401.5151-1-ttayar@habana.ai>
In-Reply-To: <20200225112401.5151-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 25 Feb 2020 13:53:46 +0200
Message-ID: <CAFCwf11xWc3jZ-WFJeBXOPMrq=0AdYSVXbUg_djZ--s6J_KRew@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Remove unused parse_cnt variable
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 1:24 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> The "parse_cnt" variable is incremented while validating the CS chunks,
> but it is actually not being used.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/command_submission.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
> index 73ef0f9d758a..409276b6374d 100644
> --- a/drivers/misc/habanalabs/command_submission.c
> +++ b/drivers/misc/habanalabs/command_submission.c
> @@ -509,7 +509,7 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __user *chunks,
>         struct hl_cb *cb;
>         bool int_queues_only = true;
>         u32 size_to_copy;
> -       int rc, i, parse_cnt;
> +       int rc, i;
>
>         *cs_seq = ULLONG_MAX;
>
> @@ -549,7 +549,7 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __user *chunks,
>         hl_debugfs_add_cs(cs);
>
>         /* Validate ALL the CS chunks before submitting the CS */
> -       for (i = 0, parse_cnt = 0 ; i < num_chunks ; i++, parse_cnt++) {
> +       for (i = 0 ; i < num_chunks ; i++) {
>                 struct hl_cs_chunk *chunk = &cs_chunk_array[i];
>                 enum hl_queue_type queue_type;
>                 bool is_kernel_allocated_cb;
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Applied to -next
Thanks,
Oded
