Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131DDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D914C20709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHtluWYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgESITy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgESITx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:19:53 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7046C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:19:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b190so6177565pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMgJTFIHLdVTsEOwo89+14p5As96jTIsFfJ3y0gKgXM=;
        b=PHtluWYj7cObY1dboEnE/sM1UD+QChDpcrn5Uy4M4dWGQtnLEQgICKMSBRUWpcjabz
         RuU3mYh5Db8Prk1n5DVi5+m0yguYYfpLiM8CV5blEvCswdl9KWSvUV41/WhgH3Bu3yWK
         fSBypWWXvs7fIqTLQjDjm5ayh/Cq06E5PXxsowx5qSWQZqYR0pzsZmsmt7tJqmJe/BVo
         ww2/c9IStx+jgh0NovzKVvXeI4kMqAd1EAOXfFed3/Y0vNs2UeRKvbN/PtpJcYgcoR6g
         pDiAsS+vWEdOj9vElWXQ1Py+BGiUzmPpi2j/S0xehyqruNU0BSpGOaY9vNusBTzSbqMz
         5bIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMgJTFIHLdVTsEOwo89+14p5As96jTIsFfJ3y0gKgXM=;
        b=JhTCzlzzl0Lgcck9xbmSResRRfOHYLHXnUZVEQTuiGh/gHf0Qb/7wusMUJwHtledRw
         L/vSpca/gFSppVkQL9m+8bACLpJqwyGeH3GIE16IsMnla17XfLtivZijeZHnrAdrjR1F
         TqSn/dE3IrTtyP3e6M7CMj22GoRDuTCNAeEMZZf+q+6wc/AKLnjcBml4JFx0nNrUlHrX
         /89EOql/EvJjwgfVqo7qQ3zHczTbhcua+t7bwYRiwjfZMLwBeGLI/Q8IQfquGyG4BJLs
         vL6liiGFrsoYg/J5nft43PXdM55+Yb0RJZzeneF5W2EYM9sNbLqKJnlhvSuKowy/HLcE
         4n4A==
X-Gm-Message-State: AOAM533lLPMuGsmPjfhbvJzD/F8hAAuwJCLySkVItDtvZQ3M/kh34Oxu
        hzraAG7IQKXuhPjhl6r7ykDpw0VBIVfCNZfSkj/Drqn0jyo=
X-Google-Smtp-Source: ABdhPJzACKbEIDKn7yii4DNYUXvPFp6Cp07d7deIky36aOgpPFrd588s4gmRXD5uDONQVpukkNdtGDQUr0ik/pLNDeE=
X-Received: by 2002:a63:1d4:: with SMTP id 203mr17977325pgb.74.1589876393074;
 Tue, 19 May 2020 01:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589844108.git.reinette.chatre@intel.com> <a953992d99a1930703cba1362a3005d517c4cb33.1589844108.git.reinette.chatre@intel.com>
In-Reply-To: <a953992d99a1930703cba1362a3005d517c4cb33.1589844108.git.reinette.chatre@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 May 2020 11:19:36 +0300
Message-ID: <CAHp75VduowRmxOw4CM0CivTE=W4oSVgj0H2gz1yP931Ki2=2Dw@mail.gmail.com>
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
>
> The user input to files in the resctrl filesystem are expected to be
> terminated with a newline. Testing the user input includes a test for
> the presence of a newline and then replacing the newline with NUL
> byte followed by comparison using strcmp().
>
> sysfs_streq() exists to test if strings are equal, treating both NUL and
> newline-then-NUL as equivalent string terminations. Even more,
> sysfs_match_string() exists to match a given string in an array using
> sysfs_streq().
>
> Replace existing strcmp() comparisons of strings that are terminated
> with a newline with more appropriate sysfs_streq() via the
> sysfs_match_string() API that can perform the match across the different
> mode strings that are already maintained in an array.

...

> Changes since V4:
> - Remove "mode" local variable from rdtgroup_mode_write(). This variable
>   was previously used to create shorter lines with the original strcmp()
>   code that was removed in patch 4/4.
> - Andy pointed out that the repeated assignment to rdtgrp->mode could be
>   replaced by a single assignment after all the checks. This was initially
>   rejected because it would let the "RDT_MODE_PSEUDO_LOCKED" assignment
>   slip through. Even so, Andy's feedback revealed that the new changes
>   unintentionally let a user's attempt at setting the mode to pseudo-locked
>   be silently ignored where it previously reported an error. Restore original
>   user space behavior by returning success when user attempts to change any
>   mode when it is already the current mode (including pseudo-locked) and
>   returning failure when user attempts to set the mode to pseudo-locked.
>   After this change it is possible to follow Andy's original suggestion
>   of using a single assignment. (Andy)

Glad we can do it!

...

> +       ret = sysfs_match_string(rdt_mode_str, buf);
> +       if (ret < 0) {
> +               rdt_last_cmd_puts("Unknown or unsupported mode\n");

> +               ret = -EINVAL;

This is redundant.

> +               goto out;
> +       }

-- 
With Best Regards,
Andy Shevchenko
