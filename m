Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F554C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF005207F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589841945;
	bh=XfKXHLG5c8FT5TY6LG4xidXysQtjuuuDl5PLygVDD40=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AsX3ZJHvnR8VEDT8Q3gWLfsSN3yW6Nms9yJ6dpGJ7J6vrUdPIF7EOPW2BHTzgAiD8
	 Y5a2GYLqKc7LAP9mryQHP19qW+eaAkOnZnNYEmEwkpPHoOKNTwtJAY4c2G0lTObisX
	 z0xYDxeEFRkWTlQyfP7oHvfxTTxjPAhaFHdTkD80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgERWpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgERWpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:45:45 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BC0E20835;
        Mon, 18 May 2020 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589841944;
        bh=XfKXHLG5c8FT5TY6LG4xidXysQtjuuuDl5PLygVDD40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MuYRIVnE2DSWmPBGMnbamr3O+0hGKf/Bl6uaT3DP33KA6mX7erCmwuZM4SPErtMHb
         zxDpCdpHA8MmBa7P7rwgae7w0JDs+Zut5EtNqu98rbtaXInvttquwHfTbTkclcI+mh
         XxaazHbyWsRzaLIcqOiaMU7j9d7Q9GhTa1pOkjDM=
Received: by mail-ot1-f42.google.com with SMTP id d7so3236313ote.6;
        Mon, 18 May 2020 15:45:44 -0700 (PDT)
X-Gm-Message-State: AOAM532jQF/55AgeFF7OH6BvyCnBTr7VDqQxqk07synKI88jPcuD20zU
        kSmaWwGFe5GIsoTyXdSLuQgXlB2+G+e9oaombQ==
X-Google-Smtp-Source: ABdhPJxu0m9gkVQut9aVGjgQQ2NUcWNLFiY9vQROeuhJMX4N1vLfpbLxBcLSs5y8YgBCBnxORqLdwX5yrdd7uW2Cynk=
X-Received: by 2002:a9d:5c8a:: with SMTP id a10mr9915859oti.129.1589841943759;
 Mon, 18 May 2020 15:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200515184434.8470-1-keescook@chromium.org> <20200515184434.8470-7-keescook@chromium.org>
In-Reply-To: <20200515184434.8470-7-keescook@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 18 May 2020 16:45:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLVgdUEP74nJOHOBD2abK=3YfCqX9GmL2iXdPNctcRdjw@mail.gmail.com>
Message-ID: <CAL_JsqLVgdUEP74nJOHOBD2abK=3YfCqX9GmL2iXdPNctcRdjw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] ramoops: Add max_reason optional field to ramoops
 DT node
To:     Kees Cook <keescook@chromium.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Mladek <pmladek@suse.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:44 PM Kees Cook <keescook@chromium.org> wrote:
>
> From: Pavel Tatashin <pasha.tatashin@soleen.com>

Subject still has 'max_reason'.

>
> Currently, it is possible to dump kmsges for panic, or oops.
> With max_reason it is possible to dump messages for other

And here.

> kmesg_dump events, for example reboot, halt, shutdown, kexec.
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Link: https://lore.kernel.org/lkml/20200506211523.15077-6-keescook@chromium.org/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  .../devicetree/bindings/reserved-memory/ramoops.txt | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> index 0eba562fe5c6..b7886fea368c 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> +++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> @@ -30,7 +30,7 @@ Optional properties:
>  - ecc-size: enables ECC support and specifies ECC buffer size in bytes
>    (defaults to 0: no ECC)
>
> -- record-size: maximum size in bytes of each dump done on oops/panic
> +- record-size: maximum size in bytes of each kmsg dump.
>    (defaults to 0: disabled)
>
>  - console-size: size in bytes of log buffer reserved for kernel messages
> @@ -45,7 +45,16 @@ Optional properties:
>  - unbuffered: if present, use unbuffered mappings to map the reserved region
>    (defaults to buffered mappings)
>
> -- no-dump-oops: if present, only dump panics (defaults to panics and oops)
> +- max-reason: if present, sets maximum type of kmsg dump reasons to store
> +  (defaults to 2: log Oopses and Panics). This can be set to INT_MAX to
> +  store all kmsg dumps. See include/linux/kmsg_dump.h KMSG_DUMP_* for other
> +  kmsg dump reason values. Setting this to 0 (KMSG_DUMP_UNDEF), means the
> +  reason filtering will be controlled by the printk.always_kmsg_dump boot
> +  param: if unset, it will be KMSG_DUMP_OOPS, otherwise KMSG_DUMP_MAX.
> +
> +- no-dump-oops: deprecated, use max_reason instead. If present, and
> +  max_reason is not specified, it is equivalent to max_reason = 1

And here (3 times).

> +  (KMSG_DUMP_PANIC).
>
>  - flags: if present, pass ramoops behavioral flags (defaults to 0,
>    see include/linux/pstore_ram.h RAMOOPS_FLAG_* for flag values).
> --
> 2.20.1
>
