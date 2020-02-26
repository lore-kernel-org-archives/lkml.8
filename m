Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47400C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12120222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFfWmgW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgBZIdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:33:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42022 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgBZIdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:33:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id h8so944249pgs.9;
        Wed, 26 Feb 2020 00:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqlxF81Ri1fm02o+lsTCsP4GTUvxZgWE/G6mwZn7NMg=;
        b=OFfWmgW/gYHRAZpBGxkDWL0DtZcua2+xHMA15CCD9P1f899OfOItFHWzBT0bVm10sv
         nGvy+baVNbXyP/if3rC3KlukKmlFEavseT/069nLGmeHSxbJM8QVFUCnDqvhOkQADZIj
         uVtkHadsa5YelUuxNRxDDT8u1pT3qIyBQXfstFeq8tWcQoPtIFBviho4E8cj9NlhvaXa
         5g51dV1hHmsRrHGQr1P/cjYm04Xk7EblzsD/swLpUEqu6+nNWo/zU59m/Vu075NN3l6t
         JHAG1eiqOAUW8WMdMAZj7TiW2OwPYkjkyFZMxxCJYwHyKpsmnDKSzmBYx4T6VXu+9389
         AiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqlxF81Ri1fm02o+lsTCsP4GTUvxZgWE/G6mwZn7NMg=;
        b=eKjaUDQjFowJEOw5M1OUekR1MmyNAN3jPVwmDJCZwqQ4XR3O6og86dPob12qyIlJhc
         1qst3irNfc5yGIxc8xukOJbuNnsPkRNdSHpBAgMNrCBJaxki2H5nqr3cy34LUn3rMokO
         X4jhRVbeaaJZEM8YM2bKuKtFFk+Hc74qPUAPntZ0DgelDzhNK8tX4cGb4pYvI2ZH7Lg/
         R0HInPK55aKzOaUpZM0Kw7ar1Kjiyetcx3cU0BcuGYUFsrzhfRtyTNE3rY5cdwA3GEyw
         pLzV8ZA79RqD/FiWzB640WNd2aWofeWJXLa8HNvQrbmePe4mrFZd5B2BzIZ9lfF8Pe/1
         t5Pg==
X-Gm-Message-State: APjAAAXEOy/BuvX3Zt1lJgJd0cyH9aX/ODGsfDzIC2JgrOYoISgCmavK
        Bsa1oq5U0tYr34s/3APGM3dz6S5P2y3LHXSchIM=
X-Google-Smtp-Source: APXvYqxSrK38j0pUinifgPK5b5g707sn/C8uL7DptCzOZtLnjxvEKjEPsB3FOBFYIx3TUnX4UMm3w1N77GYYH6ltC7A=
X-Received: by 2002:a62:1a09:: with SMTP id a9mr3201886pfa.64.1582706000275;
 Wed, 26 Feb 2020 00:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20200220033335.106963-1-chenzhou10@huawei.com>
 <CAHp75Vf3Bsjj+0ebkxMatZfUGDJ=upOHBFHfOs_PDOnFTnRJYQ@mail.gmail.com>
 <BN8PR11MB362069564569B69E42C00086F2ED0@BN8PR11MB3620.namprd11.prod.outlook.com>
 <BYAPR11MB3624FB3A1FC8F5C43D8F6DC4F2EA0@BYAPR11MB3624.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3624FB3A1FC8F5C43D8F6DC4F2EA0@BYAPR11MB3624.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Feb 2020 10:33:08 +0200
Message-ID: <CAHp75VfkZyuu8QZ-Kc+9-yZkD_OUGxzBiXQDAQQ0oKxrJ_KR_w@mail.gmail.com>
Subject: Re: [PATCH -next] platform/x86: intel_pmc_core: fix build error
 without CONFIG_DEBUG_FS
To:     "Kammela, Gayatri" <gayatri.kammela@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Chen Zhou <chenzhou10@huawei.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 3:56 AM Kammela, Gayatri
<gayatri.kammela@intel.com> wrote:
> > -----Original Message-----
> > From: Kammela, Gayatri
> > Sent: Tuesday, February 25, 2020 9:11 AM
> > To: Andy Shevchenko <andy.shevchenko@gmail.com>; Chen Zhou
> > <chenzhou10@huawei.com>
> > Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>; Somayaji,
> > Vishwanath <vishwanath.somayaji@intel.com>; Darren Hart
> > <dvhart@infradead.org>; Andy Shevchenko <andy@infradead.org>;
> > Platform Driver <platform-driver-x86@vger.kernel.org>; Linux Kernel Mailing
> > List <linux-kernel@vger.kernel.org>
> > Subject: RE: [PATCH -next] platform/x86: intel_pmc_core: fix build error
> > without CONFIG_DEBUG_FS
> >
> > > -----Original Message-----
> > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Sent: Tuesday, February 25, 2020 2:13 AM
> > > To: Chen Zhou <chenzhou10@huawei.com>; Kammela, Gayatri
> > > <gayatri.kammela@intel.com>
> > > Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>; Somayaji,
> > > Vishwanath <vishwanath.somayaji@intel.com>; Darren Hart
> > > <dvhart@infradead.org>; Andy Shevchenko <andy@infradead.org>;
> > Platform
> > > Driver <platform-driver-x86@vger.kernel.org>; Linux Kernel Mailing
> > > List <linux-kernel@vger.kernel.org>
> > > Subject: Re: [PATCH -next] platform/x86: intel_pmc_core: fix build
> > > error without CONFIG_DEBUG_FS
> > >
> > > On Thu, Feb 20, 2020 at 5:40 AM Chen Zhou <chenzhou10@huawei.com>
> > > wrote:
> > > >
> > > > If CONFIG_DEBUG_FS is n, build fails:
> > > >
> > > > drivers/platform/x86/intel_pmc_core.c: In function pmc_core_resume:
> > > > drivers/platform/x86/intel_pmc_core.c:1327:3: error: implicit
> > > > declaration
> > > of function pmc_core_slps0_display; did you mean
> > > pmc_core_is_pc10_failed? [-Werror=implicit-function-declaration]
> > > >    pmc_core_slps0_display(pmcdev, dev, NULL);
> > > >       ^~~~~~~~~~~~~~~~~~~~~~
> > > >
> > > > Function pmc_core_slps0_display() is responsible for displaying
> > > > debug registers, which is under CONFIG_DEBUG_FS.
> > > >
> > > > Providing the static inline stub whenever CONFIG_DEBUG_FS is
> > > > disabled to fix this. Function pmc_core_lpm_display() is the same.
> > >
> > > Thank you for the patch, but I think it's not the right approach.
> > > Basically we need to move those functions outside of #if
> > > IS_ENABLED(CONFIG_DEBUG_FS).
> > > (Move them upper).
> > Agreed
> > >
> > > Also I have noticed another issue in pmc_core_lpm_display(). It uses
> > > tgl_lpm_maps directly. It shouldn't.
> > >
> > > Cc: Gayatri.
> > >
> > > Gayatri, care to fix?
> > Hi Andy, caught this bug in our internal regression too. I will send the patch
> > shortly. Thanks!
>
> Update: Andy, I have 4 small fixes for the patch series merged in for-next branch.

I don't see it in the mailing list.
Please check if you send them correctly.

There are more bug reports coming. We must fix this ASAP.

>  I am wondering if I should send the fixup patches or if you drop the patch series from for-next branch, I can send out the new version that includes all these fixes. Please suggest. Thanks!
>
> > >
> > > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > > Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> > > > ---
> > > >  drivers/platform/x86/intel_pmc_core.c | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > >
> > > > diff --git a/drivers/platform/x86/intel_pmc_core.c
> > > > b/drivers/platform/x86/intel_pmc_core.c
> > > > index f4a36fb..939f8e0 100644
> > > > --- a/drivers/platform/x86/intel_pmc_core.c
> > > > +++ b/drivers/platform/x86/intel_pmc_core.c
> > > > @@ -1117,6 +1117,20 @@ static void pmc_core_dbgfs_register(struct
> > > pmc_dev *pmcdev)
> > > >         }
> > > >  }
> > > >  #else
> > > > +static inline void pmc_core_slps0_display(struct pmc_dev *pmcdev,
> > > > +                                          struct device *dev,
> > > > +                                          struct seq_file *s) { }
> > > > +
> > > > +static inline void pmc_core_lpm_display(struct pmc_dev *pmcdev,
> > > > +                                        struct device *dev,
> > > > +                                        struct seq_file *s, u32 offset,
> > > > +                                        const char *str,
> > > > +                                        const struct pmc_bit_map
> > > > +**maps) { }
> > > > +
> > > >  static inline void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
> > > > { }
> > > > --
> > > > 2.7.4
> > > >
> > >
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko



--
With Best Regards,
Andy Shevchenko
