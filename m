Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047CDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CE024655
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rp1GPfDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAWMbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:31:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44068 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWMby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:31:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so1303347pgl.11;
        Thu, 23 Jan 2020 04:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mALYq/4B8QcZuONsnvpCBnkZlfTpOKAuDKOOHArR8vU=;
        b=rp1GPfDEfMxU6fnJc1HVBDZtNCd7Z0sTR8WhNP/gD6Mr0YoLi23eUvi9JTsFZCHYc6
         JWHtAZU4aYcPd1wGWFFznYVWygcK3JhUtHWz2Nf34BVrVZ49EdTQVC3RoTbt/XPiWvV7
         kQGuhGSF2WTrw3b9IeeKbRUDiZBydMuM3r4lNh4dqVYkslolXZwDMVc23PRAH2Zcddns
         b8v9lMbx/Nt39bzON1iU/iP76hiIqzpkXOMMTNIpgZ4N5GYxJ3GYwcebplyF+aMgh/+v
         WFRYG8V3IqbopWVW7bUkLsd9qrrWp6pXUcttcGdpFoI8PB6IXIoQUXeThhV47er8zLOR
         aKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mALYq/4B8QcZuONsnvpCBnkZlfTpOKAuDKOOHArR8vU=;
        b=Tg+QIlcSFdPcepWkkJDr7MfuWAKPWwukH0pdhFRLcbGZcKq3zxAI+ILGpxy9O9n67B
         upDiMeq92o8btAtkmvqhtvua5+KMlKufoJqdfM2Rq+pL5TjjRRdy/PowSbldHGqu/jm1
         aZ9a5ym0RcE2FBUDf8aR1mtIlZVcMxPwb/LsqM5CMxkYw56KXAXtCrUq23SltqguT0S/
         20P/hQXK/bI1n12k0/hcptroygNJsTgLlr6G382qydsFuuWtkvuV7uReOa75NZ9yPLJE
         WJSHf270U8TSAqqp5vWlhxVNIsFzKqUrs459Vsl4rUHR2QGDX1cMIhP+D9ANTliVn6cu
         pF1g==
X-Gm-Message-State: APjAAAXCda4MbCXmg/Jx6Fwn2WCVk6imq6FU7vwhbiHeQqSh+jU7/l5h
        lbjInAyQzV5syI6zJ9ntHw68Mux/jti5zKbG+Bx5sd0QdUeRwA==
X-Google-Smtp-Source: APXvYqycZLlXd5CX5Mr8IJQEk10buLH5J4PWwb3ZVLbSxSN9G1zNw9zZDHofVvV1hMH+PlC+XAYcg8OivqZhp3Fs8MQ=
X-Received: by 2002:a63:941:: with SMTP id 62mr3879440pgj.203.1579782713786;
 Thu, 23 Jan 2020 04:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20200122162813.26070-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20200122162813.26070-1-mika.westerberg@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jan 2020 14:31:45 +0200
Message-ID: <CAHp75VfEA3gpAceLjhjDKZQSE6O7tQ0g9nnyyDiReSevjhZruw@mail.gmail.com>
Subject: Re: [PATCH 00/10] platform/x86: intel_scu_ipc: A fix and cleanups
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 6:28 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> As suggested by Greg in the discussion around my SCU/PMC IPC rework series [1],
> I split the cleanups touching intel_scu_ipc driver in a separate series
> that can be applied independly.
>
> The first patch fixes interrupt support to work in Intel Merrifield. The
> rest of the patches are cleanups mostly removing code that is not used
> anywhere.
>

Pushed to my review and testing queue, thanks!

> [1] https://lkml.org/lkml/2020/1/21/678
>
> Mika Westerberg (10):
>   platform/x86: intel_scu_ipc: Fix interrupt support
>   platform/x86: intel_scu_ipc: Add constants for register offsets
>   platform/x86: intel_scu_ipc: Remove Lincroft support
>   platform/x86: intel_scu_ipc: Drop intel_scu_ipc_i2c_cntrl()
>   platform/x86: intel_scu_ipc: Sleeping is fine when polling
>   platform/x86: intel_scu_ipc: Drop unused prototype intel_scu_ipc_fw_update()
>   platform/x86: intel_scu_ipc: Drop unused macros
>   platform/x86: intel_scu_ipc: Drop intel_scu_ipc_io[read|write][8|16]()
>   platform/x86: intel_scu_ipc: Drop intel_scu_ipc_raw_command()
>   platform/x86: intel_scu_ipc: Reformat kernel-doc comments of exported functions
>
>  arch/x86/include/asm/intel_scu_ipc.h |  20 --
>  drivers/platform/x86/intel_scu_ipc.c | 414 ++++++---------------------
>  2 files changed, 91 insertions(+), 343 deletions(-)
>
> --
> 2.24.1
>


-- 
With Best Regards,
Andy Shevchenko
