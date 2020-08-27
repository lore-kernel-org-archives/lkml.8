Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F53FC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C0D207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYzlD63H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgH0Jtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0Jtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:49:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE280C061264;
        Thu, 27 Aug 2020 02:49:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d26so6841606ejr.1;
        Thu, 27 Aug 2020 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=iNFyrfAX8/Dn97tnpLT6eU3mzRCVxFI29SHF2tFkwxs=;
        b=oYzlD63HjA4+DgXzN/1Ec87ehOgzdrOBe9xX47ITGPxUYdy+i0ojrGPm4cGks3PSNN
         HvGhEtGGNd6KePcpw1D2UWrBHxc0z/LuEJrhXT/lETucxjtAkxJ6YgNTpZTEOIMHnrOt
         v8NFwYQmtIAyVMt16KmBGv7XsAFMclfxvGb5Uo3IE5bT7bsiWPCBnQ+R+wY8478XLio3
         +2E2HrNgT/0kBwkNaNxUFJAOBL8oawX3FTVnvEPusCpqGXP+6/oh52SRyzJ5ngbpG0Il
         AtSxn7vV+6RjPbEZo0EmBcTJcFZuizUFOfda9FAVTPK8DlR/BDZsEmL9rm+TKjHEgspz
         ZRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=iNFyrfAX8/Dn97tnpLT6eU3mzRCVxFI29SHF2tFkwxs=;
        b=HFB91YbBn+5QX+3QjJWD2Z0bklyJrFB/bXTsTDnLrozfwjquFn8E9uMH0cKEQnsi/R
         WDQ7VYQTKEqabJkIY7mDJ6385636Vq0dMizPXWuvFyghGEdQEE5l2ir5h1Y3rlsQnLXD
         t3GtPbqFwWIwFUDbu3KiMrvObVGkpYI+/mFHFSJxNfvXQeCxrgOn1mhYym26m8Nq/uey
         XA+X1NXGy0nQ1skIwc+5ivTo9S2BcXE/fzkqDNLOGY+xv1+D3NImfG4NXjvNAdysCvcN
         cSl7EMoPxbXhc4mLv/2PAvC9yUL6Erd8LEKwlOp86Ihgk66nD/8GyfsHuMO69dcovfT3
         sc7g==
X-Gm-Message-State: AOAM53020OalnFkre8Uzlb6yshjLMVSwpV31Ig23npOFS7Jjjicosgmo
        +4IfmQ6Oh5O80ryRQKpdOHg=
X-Google-Smtp-Source: ABdhPJws8TUBrPbN9lQbtTHLNVjZCVt2cECt/XVnEfPGgUck2J+q/BX4fGva8KrSrGEPM6fODacOqw==
X-Received: by 2002:a17:906:3091:: with SMTP id 17mr3818701ejv.515.1598521773405;
        Thu, 27 Aug 2020 02:49:33 -0700 (PDT)
Received: from felia ([2001:16b8:2d0c:fc00:340b:71b8:4541:aa75])
        by smtp.gmail.com with ESMTPSA id d18sm1486506ejo.70.2020.08.27.02.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 02:49:32 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Thu, 27 Aug 2020 11:49:31 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Mrinal Pandey <mrinalmni@gmail.com>, skhan@linuxfoundation.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, keescook@chromium.org, re.emese@gmail.com,
        maennich@google.com, tglx@linutronix.de, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH] scripts: Add intended executable mode and SPDX license
In-Reply-To: <20200827094344.GA400189@kroah.com>
Message-ID: <alpine.DEB.2.21.2008271145370.25858@felia>
References: <20200827092405.b6hymjxufn2nvgml@mrinalpandey> <20200827094344.GA400189@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Aug 2020, Greg KH wrote:

> On Thu, Aug 27, 2020 at 02:54:05PM +0530, Mrinal Pandey wrote:
> > commit b72231eb7084 ("scripts: add spdxcheck.py self test") added the file
> > spdxcheck-test.sh to the repository without the executable flag and license
> > information.
> > 
> > commit eb8305aecb95 ("scripts: Coccinelle script for namespace
> > dependencies.") added the file nsdeps, commit 313dd1b62921 ("gcc-plugins:
> > Add the randstruct plugin") added the file gcc-plugins/gen-random-seed.sh
> > and commit 9b4ade226f74 ("xen: build infrastructure for generating
> > hypercall depending symbols") added the file xen-hypercalls.sh without the
> > executable bit.
> > 
> > Set to usual modes for these files and provide the SPDX license for
> > spdxcheck-test.sh. No functional changes.
> > 
> > Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
> > ---
> > applies cleanly on next-20200827
> > 
> > Kees, Matthias, Thomas, please ack this patch.
> > 
> > Andrew, please pick this minor non-urgent cleanup patch once the
> > mainainers ack.
> > 
> >  scripts/gcc-plugins/gen-random-seed.sh | 0
> >  scripts/nsdeps                         | 0
> >  scripts/spdxcheck-test.sh              | 1 +
> >  scripts/xen-hypercalls.sh              | 0
> >  4 files changed, 1 insertion(+)
> >  mode change 100644 => 100755 scripts/gcc-plugins/gen-random-seed.sh
> >  mode change 100644 => 100755 scripts/nsdeps
> >  mode change 100644 => 100755 scripts/spdxcheck-test.sh
> >  mode change 100644 => 100755 scripts/xen-hypercalls.sh
> 
> This does 2 different things in one patch, shouldn't this be 2 different
> patches?  One to change the permissions and one to add the SPDX line?
>

For me, this was one thing: minor cleanup; and taking one 
minor patch is easier than taking two, but you make the call. Then, the 
two or even three patches would also just travel through different trees, 
the spdx tree and Andrew's.

Lukas
