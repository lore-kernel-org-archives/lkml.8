Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FD6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE4820709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KChMZpAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgESI2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgESI2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:28:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C4CC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:28:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k22so5305092pls.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1yElP3WZvkNT4A/b0/LN0EmVCUORVyx35/LFAnrqMNg=;
        b=KChMZpAbq7iBCVNh6mKbP+UTpBtTRi1T88Z2sdPGjDdaCc5AQClgFKUimqlhXrHhRw
         nlxPxjNNOXRLkrFJjuEIWeNohqrtoMcH7AvL55ahsqwvE9skyWVCdvlB/aZsLNWCDpnL
         YN0omPPjN0EToOjfEiT/83e8DvkPdd0bK8/Sh9VJ8kmkcn49j+NJkyY/BhylulZfe4du
         uks13RSmWY0qfz6l55WOYRUghkw0cHvBL/ojc6IRbXuR1pw0WtqRBh/dVP8x3pNY2eIN
         S77RARGlNzIK8/UAnTMYtuosIMF+E5mHuksEkjju+zvqvUd85C95YuQZHJ4V+TosAEXs
         Lhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yElP3WZvkNT4A/b0/LN0EmVCUORVyx35/LFAnrqMNg=;
        b=cn95oWlgjG8B/aoTfhyVDsKADGRFVX3ZJeS0QYDB+5/tD4v+hifEbmzESjKt7KoOR1
         i63Hc0zeJyKZ/vEfX7S9exr7GTpti620NaiJ/TdyIvvIxu30XuCO32t4fsS3l1rE3tYb
         TETMkEjvDafpJO7emHXs3hPm5aWUNfmldMrqPNp1cKD+UTH3I9VUZoQ0jYu9G3NllOGH
         h7ThDVHKXr1aSAEM0r4wuKac+gLWPODiTtIqkNxqSBN7U+nYG7BUPpX6HR+Ar/5X7Tt0
         9tn+effoKsdFxHxyf0xp3U7XQ3WOWwfFqaPvhd7xX5L9sZ0vfQSOPR6bfzohwL7j1FZq
         TmBA==
X-Gm-Message-State: AOAM531YF7ACj2JHa9JWasffUP7QXWSklsNSSGrrsAKr1gXVHvQC+oWG
        NisuiIcYU2K7cNqg9wLkkLQe5UW04osgV11gvqc=
X-Google-Smtp-Source: ABdhPJw9WxVstlAn8t4YSaKkGjMkAw9yPUJ9x/iGdyAJfZtSPzZ7wnEkH4QWnf8Iv5eV0h67DFsv6qH3TfDC2PhUry4=
X-Received: by 2002:a17:90b:3651:: with SMTP id nh17mr3964026pjb.228.1589876918733;
 Tue, 19 May 2020 01:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589844108.git.reinette.chatre@intel.com> <a953992d99a1930703cba1362a3005d517c4cb33.1589844108.git.reinette.chatre@intel.com>
In-Reply-To: <a953992d99a1930703cba1362a3005d517c4cb33.1589844108.git.reinette.chatre@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 May 2020 11:28:21 +0300
Message-ID: <CAHp75Vc_VA-2UNJh7epe+oQEiU3WBedomLbAVTD_L4_ocvt8Dw@mail.gmail.com>
Subject: Re: [PATCH V5 4/4] x86/resctrl: Use appropriate API for strings
 terminated by newline
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, kuo-lang.tseng@intel.com,
        ravi.v.shankar@intel.com, Ingo Molnar <mingo@redhat.com>,
        Babu Moger <babu.moger@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 2:50 AM Reinette Chatre
<reinette.chatre@intel.com> wrote:

...

> +       ret = sysfs_match_string(rdt_mode_str, buf);
> +       if (ret < 0) {
> +               rdt_last_cmd_puts("Unknown or unsupported mode\n");
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       user_m = ret;

> +       } else if (user_m == RDT_MODE_PSEUDO_LOCKED) {
>                 rdt_last_cmd_puts("Unknown or unsupported mode\n");
>                 ret = -EINVAL;
> +               goto out;
>         }

Can't we unify latter with a former like

  if (ret == RDT_MODE_PSEUDO_LOCKED)
    ret = -EINVAL;
  if (ret < 0) {
      rdt_last_cmd_puts("Unknown or unsupported mode\n");
      goto out;
  }

?

Or closer to initial like

  if (ret < 0 || ret == RDT_MODE_PSEUDO_LOCKED) {
    rdt_last_cmd_puts("Unknown or unsupported mode\n");
    ret = -EINVAL;
    goto out;
  }

-- 
With Best Regards,
Andy Shevchenko
