Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659B6C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387C8206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsDN/Bpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390206AbgDCH2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:28:12 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37932 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390148AbgDCH2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:28:12 -0400
Received: by mail-pj1-f65.google.com with SMTP id m15so2580184pje.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 00:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6xA72lHVl9EIWydmT2HCM9hVI3X0nsxCE+L3BzBiuA=;
        b=IsDN/BpytTrEjR0MRumu4g48SO1glJVRzJ6I9Gm/wNlFOOzOFdN9vAtVGO+4G8EIWx
         mZReRbrDrusrP6vEQ8HXeDPVCqd73O8lS252yW9GESmwKk79+8ctXSHZizzllrNkuFUF
         ynEUlfqdpAEp3jBpQGJrRZROSIPycXgABg5/68CI6mR7y+JRz5A0hsQUYbatvA6soRKh
         oxGCFEAE5spvNpxE5sjsVcyrcpE8v/bgU+4EgK7uKCHMqwfw9wXO5bIoTqFaSzIdVuMj
         lk+LBg67mWXp8iWtayxTJ4F14uVe3I/YbFTIY6war6r2Y7nejlT0SdXt9m9CVemBeBMV
         O7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6xA72lHVl9EIWydmT2HCM9hVI3X0nsxCE+L3BzBiuA=;
        b=BVXdivoQhknv7b2wiKX4ng1NJlV4lLEuuOA3G82vnzFCc8edCh5o0pFqq4wkc298n3
         PQ6WMC0MxByHd5g/TMneJ26qUAA+nQ4qWXeoq2ZwWmjokpv7QFXGLBoR9BdxvcwY7Mr/
         nxKxP1kpfXRB1NoLfKITsGwHFj5vrgD4Pvh+KIEwkmJE5a1EYbIS+oCLmXpOJYmZkO19
         ZxAdkhCGWkebztpHlwfsQXLVFvZ2JB2/w14rEYJemQviAxOV+oNdPkUJX3dy3emI/2M1
         BGiJoXPUWuqXjDyoORln90PhNdvKS++tpUieB/1zBDRMh1Tx9M0krVuuXgmvBzaogugd
         4WCw==
X-Gm-Message-State: AGi0PubhMi7tVIyE2o58BMmmo0n8KeCvP2WkNqTT1XnjWzMuRmi+67aQ
        Y0UmHPWhMwjLtyAFKVzNV0P0f5tem5cFqR2SpyE=
X-Google-Smtp-Source: APiQypJROKA1x6WiGOV/+0fQJloLq7C8MnFcUzuzyp1QCAsXHR7K5mEad85CUuEJCbnHkcroGL+n4ZBvfznSXHHWK80=
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr8339765pjn.8.1585898891021;
 Fri, 03 Apr 2020 00:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585765499.git.reinette.chatre@intel.com>
 <2a51c327497738ad7012e4f185046c530dba4594.1585765499.git.reinette.chatre@intel.com>
 <20200402130625.GA1922688@smile.fi.intel.com> <720ab442-3e2e-bd6d-d35c-5cc5de1d9824@intel.com>
In-Reply-To: <720ab442-3e2e-bd6d-d35c-5cc5de1d9824@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Apr 2020 10:27:59 +0300
Message-ID: <CAHp75VdoVxDaBYtiH8D_0DLKcwP7AAS2M7XoyrDj7LAv8cOoDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/resctrl: Use appropriate API for strings
 terminated by newline
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, kuo-lang.tseng@intel.com,
        Ingo Molnar <mingo@redhat.com>, babu.moger@amd.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 12:54 AM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 4/2/2020 6:06 AM, Andy Shevchenko wrote:
> > On Wed, Apr 01, 2020 at 11:30:48AM -0700, Reinette Chatre wrote:

...

> >> @@ -1412,11 +1412,11 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
> >>      struct rdtgroup *rdtgrp;
> >>      enum rdtgrp_mode mode;
> >>      int ret = 0;
> >> +    int user_m;
> >>
>
> >
> > ...and forgot to mention this...
> >
> >       int user_m;
> >       int ret;
> >
>
> >
> >>      /* Valid input requires a trailing newline */
> >>      if (nbytes == 0 || buf[nbytes - 1] != '\n')
> >>              return -EINVAL;
> >> -    buf[nbytes - 1] = '\0';
> >
> > The above test is not needed and comment now is misleading.
> > WRT nbytes I believe that kernel fs code checks for that.

This module provides it's own kernfs_ops...

> If nbytes is 0 it is still passed to this function. You are correct that
> those tests are not needed though (if nbytes is 0 then
> sysfs_match_string() will not find a match and return EINVAL via that path).
>
> Thank you for catching this. I'll remove those unnecessary checks.

...which means that nbytes == 0 is a valid check. Please keep it
there. It will protect from unnecessary locking and loading CPU for
nothing.

-- 
With Best Regards,
Andy Shevchenko
