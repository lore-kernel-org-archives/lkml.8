Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BB4C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9A52067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eTGxhfXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCLUbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:31:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33950 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLUbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:31:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id 59so5584414qtb.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OSLhuIxEpdiu4IChuu+kUY7XbNTQNzxVu0kBYJHewI0=;
        b=eTGxhfXPoIRX+zZNKelilanBP2pQAgyeLUeHUq4AebBDBvuoAcOqcvK6/rL1VkDS3T
         KmZ2HJV92jzkFplHPBuV9azhiNjpj45MVNZ1V8lApj0Bd5r/q6wUmH65V3uUl5ZpIiSJ
         fdJ89S2UTfx4MI4020mmrVTAnmsWaDBO/g/so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OSLhuIxEpdiu4IChuu+kUY7XbNTQNzxVu0kBYJHewI0=;
        b=Ifj99vN2o8bCRlsiRjr9hA8u7fMwoNPPSKf8/mGS0GHFKlqCgpbLCATrlFqIv34Yr/
         qnrF5bGto2vfVRHgGp/v3BO8V/rNgpnk9yYEIh9GoF8EE4M//t8ocbv9FAEYDzn822Gj
         dGS4gHTM8nUNFeVmZvMTO0BqG9mzzxJSqlcPDGLuTHUS9wd8wgEwffPwaU7e71BouIBF
         DvQZ567AGomsUZ7FcuZHbhwJRGOrS5bj1Rirxfeq6QL+FCJRwYv3wzxjOn5a+h7GPvE6
         r54fZuOQ66eNkuo7+wGKQFfwE+SfhbFMfw6XV8ihn+aVm4W4COtNh13GXsQAyUa0XG37
         tQeg==
X-Gm-Message-State: ANhLgQ1VcDQIw4gk+Mys2qIYJA1tRRTk4u3DrFpthfmYQCAz5XFsZOBa
        /akQtd9HLlV1zpAK7Gllo6ZAMf7GyD8=
X-Google-Smtp-Source: ADFU+vs++B09wYiUUBJWJMfgOxpBubF9YRvRzu7xSDScJ9WfdzHHFVttcTUN5d3JegI63rA2Ns4NBg==
X-Received: by 2002:ac8:4906:: with SMTP id e6mr9221409qtq.178.1584045108459;
        Thu, 12 Mar 2020 13:31:48 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id d72sm7593894qkc.88.2020.03.12.13.31.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 13:31:47 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id f3so8649337qkh.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 13:31:47 -0700 (PDT)
X-Received: by 2002:a37:a543:: with SMTP id o64mr8063320qke.460.1584045106987;
 Thu, 12 Mar 2020 13:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200304002137.83630-1-rajatja@google.com>
In-Reply-To: <20200304002137.83630-1-rajatja@google.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Thu, 12 Mar 2020 13:31:35 -0700
X-Gmail-Original-Message-ID: <CA+jURcsGvKbQi0bUs1BtAa7RC0NmtKBS=qtEzYWv=pUBqenmgQ@mail.gmail.com>
Message-ID: <CA+jURcsGvKbQi0bUs1BtAa7RC0NmtKBS=qtEzYWv=pUBqenmgQ@mail.gmail.com>
Subject: Re: [PATCH v2] Input: Allocate keycode for SNIP key
To:     Rajat Jain <rajatja@google.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 at 16:21, Rajat Jain <rajatja@google.com> wrote:
>
> New chromeos keyboards have a "snip" key that is basically a selective
> screenshot (allows a user to select an area of screen to be copied).
> Allocate a keyvode for it.
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

It's not very obvious to me what KEY_SNIP represents, without the
comment above. Maybe you could call it something like
KEY_SELECTIVE_SCREENSHOT, so that its purpose is more apparent to
someone seeing it in use.

Harry Cutts
Chrome OS Touch/Input team

>  /*
>   * Some keyboards have keys which do not have a defined meaning, these keys
>   * are intended to be programmed / bound to macros by the user. For most
> --
> 2.25.0.265.gbab2e86ba0-goog
>
