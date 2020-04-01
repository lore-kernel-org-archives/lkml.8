Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12802C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B0C20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585732321;
	bh=k0fRdZNTeifkd5a3ssDi06pxhejb//GbO1E62g+Bbas=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pkWJ4Whwu0UKf091dN8yDttFz5WXCPTNzu+Ej9xccEUav/koJiNuqUQlxH/KUnQPN
	 t2FtXRGSgkJcYo5ygEYkW1ixUkHcvNyhFrAjKK+T5mSgvjjYcPF9PN4xIiplmj2MeR
	 XIM5aW2XAoIsn1I1GCLdKgCX3Vr53GdygPgUOmfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbgDAJMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:12:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45510 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgDAJMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:12:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id l22so21514935oii.12;
        Wed, 01 Apr 2020 02:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VsX9b0jdMMwhXQFEGYuMkZY3E62lwQ5QItg3/i4As6Q=;
        b=EpRKCXChXu9cif7haQceMnd2PzbiyHPC3fQXaSIPqWrSgmjP88JDaQWD9NQl38raMC
         i6g1md6jQFkDta49p+M6xeGpbLcB8ujMneRY+/PSqDdlehApTJmLJyjnVfHtvf5g1cuh
         opHyhp8vJrlJ3ZbTS8xcyu4LyKyKTiKvKn/5ocy/pUgU261gKGbflEiB3ol2OJ4Tdz6e
         E5x0/QBIZaznM+9jbO8EoAIWHYPxs/buw7ytmKIbTAuQCYKKZu9dnEMeWuleLJgOcP9+
         61AZFmeubCE6ugyqEPfE3lULFqWYRU/8YMf84d0hPTUG1UymmztTKAC3JnlW8J3ekD11
         96ug==
X-Gm-Message-State: AGi0PuYWhsCYrP4BreqHRIi/yQcbogokJ9Hs2dZwoD7F6/E8h0gbmfRg
        dfEmvE+VgceIuf8yL18asYIjs4ppEEfAZoY1c4s=
X-Google-Smtp-Source: APiQypKrpq4tb9789zZJDu7T7+yaTKaY6/kJ++CLcob6KD8LhkHhVdPZfSlz/oWgweDjdFCz27e4l9LZYObq6oZAuUY=
X-Received: by 2002:aca:f07:: with SMTP id 7mr2015406oip.68.1585732319951;
 Wed, 01 Apr 2020 02:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200330085852.31328-1-jengelh@inai.de>
In-Reply-To: <20200330085852.31328-1-jengelh@inai.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Apr 2020 11:11:48 +0200
Message-ID: <CAJZ5v0iMJYG1ptdoeiHVo21NqhWBVPw691LJ5=3oRMA7OMQ91Q@mail.gmail.com>
Subject: Re: [PATCH] acpica: clear global_lock bits at FACS initialization
To:     Jan Engelhardt <jengelh@inai.de>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:58 AM Jan Engelhardt <jengelh@inai.de> wrote:
>
> When the firmware ROM supplies a FACS table with garbage, and the
> firmware code does not clear the global_lock field before booting to a
> loader/OS, the garbage bytes in that field (like 0xffffffff) can
> indicate that the lock is taken when it is not, thereby preventing
> obtaining said lock even though it is otherwise perfectly usable if
> the field were not prepopulated with garbage.
>
> Reset the lock to a known good state upon ACPI initialization.
>
> References: https://bugzilla.kernel.org/show_bug.cgi?id=206553
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>

Bob, Erik, please let me know if you want me to apply this directly or
you prefer to route it through the upstream.

> ---
>
>  drivers/acpi/acpica/tbutils.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
> index c5f0b8ec70cc..26bdbc585d7e 100644
> --- a/drivers/acpi/acpica/tbutils.c
> +++ b/drivers/acpi/acpica/tbutils.c
> @@ -56,6 +56,9 @@ acpi_status acpi_tb_initialize_facs(void)
>                                                                      &facs));
>                 acpi_gbl_FACS = facs;
>         }
> +       /* Clear potential garbage from the initial FACS table. */
> +       if (facs != NULL)
> +               facs->global_lock &= ~0x3;
>
>         /* If there is no FACS, just continue. There was already an error msg */
>
> --
> 2.26.0
>
