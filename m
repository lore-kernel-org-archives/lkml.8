Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45102C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B19C20784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Y3vyS0+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbgDAU1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:27:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38492 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732441AbgDAU1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:27:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id e5so1492817edq.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 13:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6qcM856obImsvuT5rUIEhvwVnK1DhMJt2Id7uvyK5Q=;
        b=Y3vyS0+7xmMlD2o1DE1joAP9And7I2d2qjY0yOuvGnXvyW98YWzWm7aa6SSnMW9fGv
         xmbCsUf8tHEs1igbgJL3MR2/QQ9CQsbFnA6iygRiBg0Wr89wbN2oYs93y2m0+MLBc9j0
         XZRVztiCpXL+RZE2oEq1MFt12hQvmpIntSCzUl1th3RBpoByO2/Fu41HxaGtFIdOelv6
         Z8TUAwfBiHAzT9ov8b0OI473ujkzD9NlE3o2pCzmz/Z3D+q+HTGIcrnaSwtBrsELjwyT
         RifPDZRqTf60vamEdkpnnVKHQZJPAHKj5NeFxs8bRaNtVcgXRIYIiN2JEGUUS+w9tUY6
         z8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6qcM856obImsvuT5rUIEhvwVnK1DhMJt2Id7uvyK5Q=;
        b=ZkeTFbp2CS7SqjyFcLIFzhw1rV/0PmpOzc3htNjWRxC4Xy7R4RjHPMDy9R6SaB08Mf
         Yg78JvnamTW76OY/9MdBBX7+F3zE4Xv5AF1A8wnaChdmTPbWZpGrWunt5mhXnalBmm1/
         Ve8vEDBHitY5JanxqCa9YY2TVziXKEGXDCHsnYEXXLaUKwsoh71ASV8lIzbDrgq+PKKE
         NBMrNLv21mEW6/0nfqDWZ26pusrQYY7ICTa/vsGxcNpzsF9RmNHU2Ul24qVuuDoQZ6OZ
         XrAaOKjnGa0nEwWbgt1TPvu2hUXShqp2dUKC18pC6QV26TccCDZXVNuY3/CumjNn6hcV
         kW3Q==
X-Gm-Message-State: ANhLgQ0BB8RpsVkbV7hz0GlXUVT52QsGHxkL+F8oyTQIA3ItMLaibcHy
        MSM4ShejMYHWJtINLvL+LZj/DPuI4MqJ5pP5XaNrnA==
X-Google-Smtp-Source: ADFU+vutl2hEQYOr7JEC/ZbBRPxrkS/63YVcKf/26iigKS0Nr226Yo7GAz0hCmuAa+otNRau6Kiz522Hbv7xnLvn8gw=
X-Received: by 2002:a50:d847:: with SMTP id v7mr22275521edj.154.1585772826833;
 Wed, 01 Apr 2020 13:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-12-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-12-alastair@d-silva.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Apr 2020 13:26:55 -0700
Message-ID: <CAPcyv4gnU8t12V-mYXyxjb2+siej10xY-UVbxHxtCd8=28Yc6g@mail.gmail.com>
Subject: Re: [PATCH v4 11/25] powerpc: Enable the OpenCAPI Persistent Memory
 driver for powernv_defconfig
To:     "Alastair D'Silva" <alastair@d-silva.org>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> This patch enables the OpenCAPI Persistent Memory driver, as well
> as DAX support, for the 'powernv' defconfig.
>
> DAX is not a strict requirement for the functioning of the driver, but it
> is likely that a user will want to create a DAX device on top of their
> persistent memory device.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  arch/powerpc/configs/powernv_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> index 71749377d164..921d77bbd3d2 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -348,3 +348,8 @@ CONFIG_KVM_BOOK3S_64=m
>  CONFIG_KVM_BOOK3S_64_HV=m
>  CONFIG_VHOST_NET=m
>  CONFIG_PRINTK_TIME=y
> +CONFIG_ZONE_DEVICE=y
> +CONFIG_OCXL_PMEM=m
> +CONFIG_DEV_DAX=m
> +CONFIG_DEV_DAX_PMEM=m
> +CONFIG_FS_DAX=y

These options have dependencies. I think it would better to implement
a top-level configuration question called something like
PERSISTENT_MEMORY_ALL that goes and selects all the bus providers and
infrastructure and lets other defaults follow along. For example,
CONFIG_DEV_DAX could grow a "default LIBNVDIMM" and then
CONFIG_DEV_DAX_PMEM would default on as well. If
CONFIG_PERSISTENT_MEMORY_ALL selected all the bus providers and
ZONE_DEVICE then the Kconfig system could prompt you to where the
dependencies are not satisfied.
