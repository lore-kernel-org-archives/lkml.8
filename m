Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF99C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9EC21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz54Z+lU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgBYKNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:13:25 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40006 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbgBYKNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:13:25 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so1066274pjb.5;
        Tue, 25 Feb 2020 02:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12J4Dxh+XhShPnFqF0gVzP/G/+ksyPC2hCO7kPNDBLI=;
        b=Dz54Z+lUs9k0m+Luhfh7C1Fj9xaIpP14H9bxZCEpQXtiq/H0Z96EQVI9M9kpWLvwpm
         YQLBjkj3mCu4qHBXDq3YzF4Bk/R13jqVxazQKvaKFNtHoAR+npJhwlWFvueZNJrAOVqF
         M3I2khOhqvoNZro3JIcTvQ63SoLjOdIrrqvx3oRpB0sAXtSMwYwexkP+DAwi0mjtx9MQ
         egBRU3rLhacSn/3pfs7YE8alg6aywxsOQ1FCWshq5kpvNKy0flDx+EcxRN0XFzayFjqL
         tcgq+Srpg/bsU3cbmjYvdSNsB8DZ6vWw6TWgQGy4aOvvpV3b0LrTVm/DvDj/EET0KDCl
         633g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12J4Dxh+XhShPnFqF0gVzP/G/+ksyPC2hCO7kPNDBLI=;
        b=EolVeQmB+2vPySZaZSiJ2WjxsDjPDdbUEZIcS5AhSe9gZQcuSk6D0nSQJ7a2kAg/Go
         h6+SsMuGiaagmnXt/B0RVh2lico98i1yzp3WiexDFRzUx40UGIMo1GJXc/NSOWr4KgRg
         iZuAzdH9CopR7l/w19kiiTSYTYEYXGNu4il8SsKy8HNqUENiLDXvXBXZFU3Zr1rxDyMk
         Wu8lGgJnvjt0tyUwIqQ/GG9yJigCM3VJzQSzBFGnWAoa/OxPEkLlbEbxNntHvWKup3oi
         jCoRu/lb2ynpNjaSwyv72a9mKh22sv6nWCAYJtoPM1WPug0iGxu0+DRjZsngTTjY8L4S
         2dkA==
X-Gm-Message-State: APjAAAUqTZlQmU+nyQuBQO6PXue06MPufO83oLtc4jBMiRbT/SC2DR10
        FWGZOfLYNqR0t9H7Oa5GpdPhyTEsBb9ul6MgnNc=
X-Google-Smtp-Source: APXvYqyyPThktYRxMm92/qqFIrJhM0G2sMcptnG/lYcePqOC/5g38MfCgOLnn7TJPKPLFaSgzqN8wydbYuug39TYzvk=
X-Received: by 2002:a17:902:b598:: with SMTP id a24mr53059634pls.262.1582625604524;
 Tue, 25 Feb 2020 02:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20200220033335.106963-1-chenzhou10@huawei.com>
In-Reply-To: <20200220033335.106963-1-chenzhou10@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Feb 2020 12:13:16 +0200
Message-ID: <CAHp75Vf3Bsjj+0ebkxMatZfUGDJ=upOHBFHfOs_PDOnFTnRJYQ@mail.gmail.com>
Subject: Re: [PATCH -next] platform/x86: intel_pmc_core: fix build error
 without CONFIG_DEBUG_FS
To:     Chen Zhou <chenzhou10@huawei.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 5:40 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> If CONFIG_DEBUG_FS is n, build fails:
>
> drivers/platform/x86/intel_pmc_core.c: In function pmc_core_resume:
> drivers/platform/x86/intel_pmc_core.c:1327:3: error: implicit declaration of function pmc_core_slps0_display; did you mean pmc_core_is_pc10_failed? [-Werror=implicit-function-declaration]
>    pmc_core_slps0_display(pmcdev, dev, NULL);
>       ^~~~~~~~~~~~~~~~~~~~~~
>
> Function pmc_core_slps0_display() is responsible for displaying debug
> registers, which is under CONFIG_DEBUG_FS.
>
> Providing the static inline stub whenever CONFIG_DEBUG_FS is disabled
> to fix this. Function pmc_core_lpm_display() is the same.

Thank you for the patch, but I think it's not the right approach.
Basically we need to move those functions outside of #if
IS_ENABLED(CONFIG_DEBUG_FS).
(Move them upper).

Also I have noticed another issue in pmc_core_lpm_display(). It uses
tgl_lpm_maps directly. It shouldn't.

Cc: Gayatri.

Gayatri, care to fix?

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index f4a36fb..939f8e0 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -1117,6 +1117,20 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>         }
>  }
>  #else
> +static inline void pmc_core_slps0_display(struct pmc_dev *pmcdev,
> +                                          struct device *dev,
> +                                          struct seq_file *s)
> +{
> +}
> +
> +static inline void pmc_core_lpm_display(struct pmc_dev *pmcdev,
> +                                        struct device *dev,
> +                                        struct seq_file *s, u32 offset,
> +                                        const char *str,
> +                                        const struct pmc_bit_map **maps)
> +{
> +}
> +
>  static inline void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>  {
>  }
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
