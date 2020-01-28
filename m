Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26682C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE64207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr1Eugxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgA1VUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:20:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33704 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgA1VUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:20:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so17806466wrq.0;
        Tue, 28 Jan 2020 13:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zI+cNUNLF3kaXSaB95jriRVjzozM0k40b3VUnBQ2hL4=;
        b=cr1Eugxz1jDRTs5xXm0mdslOFP/LW6r93aHJoQ549mVFWqHrC7WNncFStX/6Q9ce9v
         nz/ilbtGXaVqmwnuUOtPzEEhhnZbi3G+ArTMvX9t3TNlebra7xCRIRaoIySvpHIHToPn
         ZIniEsnYZOL+8NM4M6/QoQ7Yn43VBVyPuanKM45xtbmRasmAHJluexqc8RsEXCiIJ2Y5
         ULKgK92O+HRsoauqf+y8qkpWo0+kSEedvad0oMmKLIq8QKCz2+K4HunTYzUN4LPIveRF
         yFnleba3CQRXqMwll04l9z6s5L9y3Xgoqx8P/n6lFGMEIWPn1inGG3AfqJtGjWK0k+K2
         q6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zI+cNUNLF3kaXSaB95jriRVjzozM0k40b3VUnBQ2hL4=;
        b=gedW94dCJU+2a0/7HDXn16HWENtZUHvyApJ2/Ydd4agQafEfcqug7BENFNJ9PcOVa8
         LNkg2P4G84KgWzxBLFMFikTlGACe43z3gCxJVBNOhFfoAY3t2VpAMrVxDArJUFqwPjZN
         G986DsGB8SElwpFfgAfZLZUrDYMynvsbo+AXVrIpncdW/8UOzyGqnofDDNYzPo6Uh6Ct
         rUCc5yzWCOx0SXxWgn5KyvwSJ2eBm4v2iqAsmROZvq69K94iosaj7656M2vIoMT2VboF
         /QFuBkZ1eF8smFj9eluVguMwzLpO+7w+2UTM77xjRnYFx9roN/3dvLG/ycJsxPy/Dmf2
         6WYw==
X-Gm-Message-State: APjAAAVe3WYKf2agc8uMbcbof+5wF825cDBU4CupHi3/DuSsuilv8ALk
        a6ojWrWjLx+qacwIUOh3mb38mH1E32YG2b9oekI=
X-Google-Smtp-Source: APXvYqzxeqjTVGWhGxKoLAamd10Qlofs6anWK7unOqW4V0Q59Aa6fL+sO2cRfdjqYiyhrmbqNf2yQCOAN4GC6qOHll4=
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr30178824wrp.111.1580246408308;
 Tue, 28 Jan 2020 13:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20200128112827.43682-1-colin.king@canonical.com>
In-Reply-To: <20200128112827.43682-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 28 Jan 2020 16:19:56 -0500
Message-ID: <CADnq5_O=W6TFFCGZsdvtuLPijanxX4vdkdmedh2OxZauG6M58w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix spelling mistake link_integiry_check
 -> link_integrity_check
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 6:28 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake on the struct field name link_integiry_check,
> fix this by renaming it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h           | 2 +-
>  .../gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c    | 8 ++++----
>  .../gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c   | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> index f98d3d9ecb6d..af78e4f1be68 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> @@ -63,7 +63,7 @@ struct mod_hdcp_transition_input_hdcp1 {
>         uint8_t hdcp_capable_dp;
>         uint8_t binfo_read_dp;
>         uint8_t r0p_available_dp;
> -       uint8_t link_integiry_check;
> +       uint8_t link_integrity_check;
>         uint8_t reauth_request_check;
>         uint8_t stream_encryption_dp;
>  };
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> index 04845e43df15..37670db64855 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> @@ -283,8 +283,8 @@ static enum mod_hdcp_status wait_for_ready(struct mod_hdcp *hdcp,
>                                 hdcp, "bstatus_read"))
>                         goto out;
>                 if (!mod_hdcp_execute_and_set(check_link_integrity_dp,
> -                               &input->link_integiry_check, &status,
> -                               hdcp, "link_integiry_check"))
> +                               &input->link_integrity_check, &status,
> +                               hdcp, "link_integrity_check"))
>                         goto out;
>                 if (!mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
>                                 &input->reauth_request_check, &status,
> @@ -431,8 +431,8 @@ static enum mod_hdcp_status authenticated_dp(struct mod_hdcp *hdcp,
>                         hdcp, "bstatus_read"))
>                 goto out;
>         if (!mod_hdcp_execute_and_set(check_link_integrity_dp,
> -                       &input->link_integiry_check, &status,
> -                       hdcp, "link_integiry_check"))
> +                       &input->link_integrity_check, &status,
> +                       hdcp, "link_integrity_check"))
>                 goto out;
>         if (!mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
>                         &input->reauth_request_check, &status,
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
> index 21ebc62bb9d9..76edcbe51f71 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
> @@ -241,7 +241,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
>                 }
>                 break;
>         case D1_A4_AUTHENTICATED:
> -               if (input->link_integiry_check != PASS ||
> +               if (input->link_integrity_check != PASS ||
>                                 input->reauth_request_check != PASS) {
>                         /* 1A-07: restart hdcp on a link integrity failure */
>                         fail_and_restart_in_ms(0, &status, output);
> @@ -249,7 +249,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
>                 }
>                 break;
>         case D1_A6_WAIT_FOR_READY:
> -               if (input->link_integiry_check == FAIL ||
> +               if (input->link_integrity_check == FAIL ||
>                                 input->reauth_request_check == FAIL) {
>                         fail_and_restart_in_ms(0, &status, output);
>                         break;
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
