Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B67FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04872077D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="k/NC3Syq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgFETta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgFETt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 15:49:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CEAC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 12:49:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o15so11352057ejm.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXc03rxQsyL+YifD2Y2tm+lwPD0QRqJ3ku4DKVZ1zc8=;
        b=k/NC3SyqbrnTugxOywTK0FoQRYbykja1Y9Z/Y+Oh0Xayiz4ABW5+oz0RQY8qd5omkK
         MI/zKIbCDsftNm5RInDUsWRSWwbzOvpk89S3IqVCZq2aIcbteePU9QhAlYiox4BD40Uz
         VIGF5ixopOwU4zSKVgOI+DQwI3T3Qin7bxZP7fA64XNH+/QhSfMQGS/0IbGeKvfBHljV
         bvU87+Ogx+1N7HpejbxT9TBt3Opl0zmBmfDr2mzq2irNdnenJ9YOZxKM68IlSopCchb5
         9wbk59DZLIubfgH2ZuHMb5xfhOhcaZmZVUWwrvG6xKXPZo3CLQDgUIOKR4D0enM/jwqF
         IumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXc03rxQsyL+YifD2Y2tm+lwPD0QRqJ3ku4DKVZ1zc8=;
        b=KQvug2CfLQ1SQwKorW+sMMMfCq8Fy848eSTVtisZarDQY5o6s7iB8QbmgJDnRePred
         r0r8xIgh2/UgLC+6xrbPJuCbAXeh9x05gW70ZVNaSSQnSIU/532sUhwmmHsJeeD5pOop
         aLgCQj5W7Np9D4AgyS9GgErTbfSGuQFOYVIm29JKoRWkTVpitcbsr3dsa4H6DPkb31Fo
         cDJjP6yof/D1KCKlA2V2lhQEfIWbx7IuHX5MRcBuCr9Q+GG6QPDFNjZh10CnPnumgWkJ
         iHaQwk3uz7oiiIxh7Qi1sq2e3rLNq1jQwAiLz8OITgkxsl7Kyp4TyVDJYYK9qXYi37uG
         l4NQ==
X-Gm-Message-State: AOAM5330mwDde3WMChS3OiLmFoz3IUfiC8DijR6EiaYXWYEFw4dXlNHM
        Vv0ay9hNpVDUPnMEu2CPf0jk3WAqsRWIOElyK7W0Yw==
X-Google-Smtp-Source: ABdhPJxuZwIa9IoVTuMhbnwTzDt4nAJOGfVaSR8B92lGhn2YN8cJwIHX7v31rQdpN8V9SGgR1+Mc3WTf01eoOyhXsTA=
X-Received: by 2002:a17:906:22d0:: with SMTP id q16mr10033033eja.455.1591386567943;
 Fri, 05 Jun 2020 12:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200604234136.253703-1-vaibhav@linux.ibm.com>
 <20200604234136.253703-5-vaibhav@linux.ibm.com> <20200605171313.GO1505637@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200605171313.GO1505637@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 5 Jun 2020 12:49:16 -0700
Message-ID: <CAPcyv4g2x7LV3ARRj-RBS1K84WNayr9oDcupzPQ1gtK1A_e+aQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] powerpc/papr_scm: Improve error logging and
 handling papr_scm_ndctl()
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 10:13 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, Jun 05, 2020 at 05:11:34AM +0530, Vaibhav Jain wrote:
> > Since papr_scm_ndctl() can be called from outside papr_scm, its
> > exposed to the possibility of receiving NULL as value of 'cmd_rc'
> > argument. This patch updates papr_scm_ndctl() to protect against such
> > possibility by assigning it pointer to a local variable in case cmd_rc
> > == NULL.
> >
> > Finally the patch also updates the 'default' clause of the switch-case
> > block removing a 'return' statement thereby ensuring that value of
> > 'cmd_rc' is always logged when papr_scm_ndctl() returns.
> >
> > Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > ---
> > Changelog:
> >
> > v9..v10
> > * New patch in the series
>
> Thanks for making this a separate patch it is easier to see what is going on
> here.
>
> > ---
> >  arch/powerpc/platforms/pseries/papr_scm.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> > index 0c091622b15e..6512fe6a2874 100644
> > --- a/arch/powerpc/platforms/pseries/papr_scm.c
> > +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> > @@ -355,11 +355,16 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
> >  {
> >       struct nd_cmd_get_config_size *get_size_hdr;
> >       struct papr_scm_priv *p;
> > +     int rc;
> >
> >       /* Only dimm-specific calls are supported atm */
> >       if (!nvdimm)
> >               return -EINVAL;
> >
> > +     /* Use a local variable in case cmd_rc pointer is NULL */
> > +     if (!cmd_rc)
> > +             cmd_rc = &rc;
> > +
>
> This protects you from the NULL.  However...
>
> >       p = nvdimm_provider_data(nvdimm);
> >
> >       switch (cmd) {
> > @@ -381,12 +386,13 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
> >               break;
> >
> >       default:
> > -             return -EINVAL;
> > +             dev_dbg(&p->pdev->dev, "Unknown command = %d\n", cmd);
> > +             *cmd_rc = -EINVAL;
>
> ... I think you are conflating rc and cmd_rc...
>
> >       }
> >
> >       dev_dbg(&p->pdev->dev, "returned with cmd_rc = %d\n", *cmd_rc);
> >
> > -     return 0;
> > +     return *cmd_rc;
>
> ... this changes the behavior of the current commands.  Now if the underlying
> papr_scm_meta_[get|set]() fails you return that failure as rc rather than 0.
>
> Is that ok?

The expectation is that rc is "did the command get sent to the device,
or did it fail for 'transport' reasons". The role of cmd_rc is to
translate the specific status response of the command into a common
error code. The expectations are:

rc < 0: Error code, Linux terminated the ioctl before talking to hardware

rc == 0: Linux successfully submitted the command to hardware, cmd_rc
is valid for command specific response

rc > 0: Linux successfully submitted the command, but detected that
only a subset of the data was accepted for "write"-style commands, or
that only subset of data was returned for "read"-style commands. I.e.
short-write / short-read semantics. cmd_rc is valid in this case and
its up to userspace to determine if a short transfer is an error or
not.

> Also 'logging cmd_rc' in the invalid cmd case does not seem quite right unless
> you really want rc to be cmd_rc.
>
> The architecture is designed to separate errors which occur in the kernel vs
> errors in the firmware/dimm.  Are they always the same?  The current code
> differentiates them.

Yeah, they're distinct, transport vs end-point / command-specific
status returns.
