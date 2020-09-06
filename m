Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3800DC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 02:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3942086A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 02:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELRE9Pz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgIFCSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 22:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgIFCSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 22:18:13 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0179AC061573
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 19:18:12 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so12144402ljg.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 19:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JdEr7JFS+a6fS1u7tJOC/cfmSODhMrg80KdXF9LDMpQ=;
        b=ELRE9Pz+/SWe5t3Fm1Fp9kkPikm4XFONxDCM3ctX1GcDCwx0ASgx0lP3wpzBwIaPlr
         SjLbrjECpSc0hOotuWXphZyCDda2i4kRqoC6Q2xlcVhlorYzQdbbfL5NrtVEwAtSLRVY
         Jm0EOgZRQZdTHCjQE8c4WB+yyBlTX7wxer8ZrS7PRhs1BxRdic2p2Bwx09ir3IDCz8YS
         QomIsTNOBSepP4M+8FA1H3i/JWYR6aDBSqj9SWjBvF4GRGr6KPc3Ndi1AR/bLSNGsetr
         dnwO3vGm6sgPB6tzWOQ10k7XXrtSZWZ2FeWlAkauxgIa83nu+xtdpcfTveCkwbOcy36f
         OtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JdEr7JFS+a6fS1u7tJOC/cfmSODhMrg80KdXF9LDMpQ=;
        b=AfLhTZcVUrvWU8z6EMIcHVZ3SEpffRfm12PM+yut4Y8UHs4OjjRcrnjUytSEHxcs/0
         uJJTJ9J/Eq2mXBE8hPj1nc6nD5opY9T1ODcdMFjRt/sST1q62JnQ3MK4DYpUAVfI8owd
         XiJnX6AeFBis3Ns47kU7CQp1GqgGScQe11JY8LhTcuDuc90EOUTu2bJKEMb+mnw556Dn
         xOBw7+x/1EjFxRHllP1CnoZFGKbmlcC5CeQPSv9vBx/erR2aZCBqHR6V4TsIltHACwuv
         WLJn+K6y4Z4qB2ns8or8RfPZl79UXntfAxD87bTCAeAhtBf1PrylmENbgdGQvooSBNJF
         fh4g==
X-Gm-Message-State: AOAM5311JE5m78/ykPWKiigK63UsShEtbm8PS2qszyfEChcmvwfKgikh
        HgaSWT1THXxWzYk0dE7Ja2QN04n1x3IDnttShXE=
X-Google-Smtp-Source: ABdhPJzUNT+ZZ13GPWHaRNIbDEWHJOpQLtz25rzO1CoVjdY8mtV+8esqYNwA3qszjX1sKw33vEEtVKoac6Yw0MswPrw=
X-Received: by 2002:a05:651c:2c9:: with SMTP id f9mr6904741ljo.257.1599358688242;
 Sat, 05 Sep 2020 19:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <1598995271-6755-1-git-send-email-jrdr.linux@gmail.com>
 <a3b36dfa-b7bb-e69b-95d5-e7d6dd7bda3f@nvidia.com> <CAFqt6zaB_wcrUzmOJ6kQWMqdcPrENyJO4FNc_UU5z-AQQh_e3w@mail.gmail.com>
 <4d63100c-fe60-57ad-2924-7b28dbd14c20@nvidia.com>
In-Reply-To: <4d63100c-fe60-57ad-2924-7b28dbd14c20@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 6 Sep 2020 07:47:56 +0530
Message-ID: <CAFqt6zZ81MwsFUGgfOBG57p=4wfW=5k2RUUub3xgmKNa2cnpzA@mail.gmail.com>
Subject: Re: [linux-next PATCH v4] drivers/virt/fsl_hypervisor: Fix error
 handling path
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, timur@freescale.com,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 5, 2020 at 6:51 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 9/4/20 6:16 PM, Souptick Joarder wrote:
> > Hi Andrew,
> >
> > On Wed, Sep 2, 2020 at 3:00 AM John Hubbard <jhubbard@nvidia.com> wrote:
> >>
> >> On 9/1/20 2:21 PM, Souptick Joarder wrote:
> >>> First, when memory allocation for sg_list_unaligned failed, there
> >>> is a bug of calling put_pages() as we haven't pinned any pages.
> >>>
> >>> Second, if get_user_pages_fast() failed we should unpin num_pinned
> >>> pages.
> >>>
> >>> This will address both.
> >>>
> >>> As part of these changes, minor update in documentation.
> >>>
> >>> Fixes: 6db7199407ca ("drivers/virt: introduce Freescale hypervisor
> >>> management driver")
> >>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> >>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> >>> ---
> >>
> >> This looks good to me.
> >
> > Can you please take this patch through the mm tree ?
> >
>
> Is there a problem with sending it through it's normal tree? It would probably
> get better testing coverage there.

scripts/get_maintainer.pl is showing only general lkml list and few
commit signer.
I didn't receive any feedback from anyone except you & Dan in more
than 12+ weeks
and mail bounced back from actual author  Timur Tabi.

As it is more than 12 weeks, I requested Andrew to take it through mm tree.

Note -

While running ./scripts/get_maintainer.pl, I observed one issue. Everytime I run
the script, list is getting changed. Is it an expected behaviour ?

Below is the details ->

jordon@jordon-HP-15-Notebook-PC:~/Documents/virt/linux-next$
./scripts/get_maintainer.pl
0001-drivers-virt-fsl_hypervisor-Fix-error-handling-path.patch
Bjorn Andersson <bjorn.andersson@linaro.org> (commit_signer:1/1=100%)
Daniel Vetter <daniel.vetter@ffwll.ch> (commit_signer:1/1=100%)
Dan Williams <dan.j.williams@intel.com> (commit_signer:1/1=100%)
"Darren Hart (VMware)" <dvhart@infradead.org> (commit_signer:1/1=100%)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:1/1=100%)
Arnd Bergmann <arnd@arndb.de>
(authored:1/1=100%,added_lines:1/1=100%,removed_lines:1/1=100%,blamed_fixes:1/1=100%)
Timur Tabi <timur@freescale.com> (blamed_fixes:1/1=100%)
Kumar Gala <galak@kernel.crashing.org> (blamed_fixes:1/1=100%)
linux-kernel@vger.kernel.org (open list)


jordon@jordon-HP-15-Notebook-PC:~/Documents/virt/linux-next$
./scripts/get_maintainer.pl
0001-drivers-virt-fsl_hypervisor-Fix-error-handling-path.patch
Bjorn Andersson <bjorn.andersson@linaro.org> (commit_signer:1/1=100%)
Daniel Vetter <daniel.vetter@ffwll.ch> (commit_signer:1/1=100%)
Dan Williams <dan.j.williams@intel.com> (commit_signer:1/1=100%)
"Darren Hart (VMware)" <dvhart@infradead.org> (commit_signer:1/1=100%)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:1/1=100%)
Arnd Bergmann <arnd@arndb.de>
(authored:1/1=100%,added_lines:1/1=100%,removed_lines:1/1=100%,blamed_fixes:1/1=100%)
Timur Tabi <timur@freescale.com> (blamed_fixes:1/1=100%)
Kumar Gala <galak@kernel.crashing.org> (blamed_fixes:1/1=100%)
linux-kernel@vger.kernel.org (open list)


jordon@jordon-HP-15-Notebook-PC:~/Documents/virt/linux-next$
./scripts/get_maintainer.pl
0001-drivers-virt-fsl_hypervisor-Fix-error-handling-path.patch
Bjorn Andersson <bjorn.andersson@linaro.org> (commit_signer:1/1=100%)
Daniel Vetter <daniel.vetter@ffwll.ch> (commit_signer:1/1=100%)
Dan Williams <dan.j.williams@intel.com> (commit_signer:1/1=100%)
"Darren Hart (VMware)" <dvhart@infradead.org> (commit_signer:1/1=100%)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:1/1=100%)
Arnd Bergmann <arnd@arndb.de>
(authored:1/1=100%,added_lines:1/1=100%,removed_lines:1/1=100%,blamed_fixes:1/1=100%)
Timur Tabi <timur@freescale.com> (blamed_fixes:1/1=100%)
Kumar Gala <galak@kernel.crashing.org> (blamed_fixes:1/1=100%)
linux-kernel@vger.kernel.org (open list)


>
>
> thanks,
> --
> John Hubbard
> NVIDIA
