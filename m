Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA654C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF73021775
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1NQnvn8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbgDAIsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:48:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37323 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgDAIsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:48:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id de14so28676456edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 01:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AtwLbCqmqvz42BIBfrvBd67JNfGvzVf9CtVg6xG0MDo=;
        b=1NQnvn8mdX9DuQU55yHb6kM7GOE2cZXTLfXFTFxLhUegcVz4S1+s3ZBa57yNaFgaL3
         Of91mzhfbjU3BHyMXm/x0yEhWTDO4TAOYRaNkO6T/LWY+pOTfeJwuvMM0Q/2Rk8OpA6d
         zFut98XrtA7J3P7P5yZ9wWZX1Gipxb4iC8phf5nmrtY6ZT+vPhTZtKBXAjVkEzVudyB2
         Hwz+whcmlJFAQ+A7PQcCxI9lhP5nffN9YpWYUM+Yg9pko1uKyCswbkhh+OOE189UCQGC
         mCDxtwyiXRmrVvL9V5gXcvmE1Qs1WIfL7JJwQvOCX/zR4/bV+SuAmYsH06eTMp1FGEL9
         05GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AtwLbCqmqvz42BIBfrvBd67JNfGvzVf9CtVg6xG0MDo=;
        b=X2wn5sKAoA6lIKn+D1cdYq8Z+UOTj8gGWhVsjaIYvvX8s+yjHi2gS8gtcHUwyNM2gF
         HEMIpfjbd9tDjD8gCmXuKuIcaT/BwiOSoZ24bxJCmT/dMbCSZ7w3A2xNrc/ju8rtU79Y
         xAZNoCE1uQTsJzYm+hank3pcDGTv8hqL2iMXunS0hv4BqwRjGGrwuaC0gOP5LI3gpKyk
         pKdv6bN6wnJbeYIcEEEYetK277DgoQSRxMIQm2dA5p7XHvWZiKbIzgUX1X01Pe/htmRN
         Vb1cQJma4oYK+0n9S+4kdp54cdGOYkP+7c94Ehjac2pVQXuxDFehc9MKY97B7yWAvaV8
         7zyQ==
X-Gm-Message-State: ANhLgQ1Lllblm6hfcVfW6FdRPC7f6jRfZfSDT4NhvWy6byfcF/IkLP4d
        I4+Z22PIQdyuqhqHkJga8VIqTV00aGhbt0xB3ADqVQ==
X-Google-Smtp-Source: ADFU+vuJwhmchfCPkTtH5Ynz0giXt5bXNBUEx5wVctahGqCgUow/QrKV4szBeXwU2Z8TB249fauEQ8jxV+fGCd1JPZA=
X-Received: by 2002:a05:6402:1c8b:: with SMTP id cy11mr7881800edb.102.1585730894443;
 Wed, 01 Apr 2020 01:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-2-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-2-alastair@d-silva.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Apr 2020 01:48:03 -0700
Message-ID: <CAPcyv4hX9RTWKSLB8OcYY6MK-z5u5WWSaYSGa-8oqPbWU7st8w@mail.gmail.com>
Subject: Re: [PATCH v4 01/25] powerpc/powernv: Add OPAL calls for LPC memory alloc/release
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
> Add OPAL calls for LPC memory alloc/release
>

This seems to be referencing an existing api definition, can you
include a pointer to the spec in case someone wanted to understand
what these routines do? I suspect this is not allocating memory in the
traditional sense as much as it's allocating physical address space
for a device to be mapped?


> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/opal-api.h        | 2 ++
>  arch/powerpc/include/asm/opal.h            | 2 ++
>  arch/powerpc/platforms/powernv/opal-call.c | 2 ++
>  3 files changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index c1f25a760eb1..9298e603001b 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -208,6 +208,8 @@
>  #define OPAL_HANDLE_HMI2                       166
>  #define        OPAL_NX_COPROC_INIT                     167
>  #define OPAL_XIVE_GET_VP_STATE                 170
> +#define OPAL_NPU_MEM_ALLOC                     171
> +#define OPAL_NPU_MEM_RELEASE                   172
>  #define OPAL_MPIPL_UPDATE                      173
>  #define OPAL_MPIPL_REGISTER_TAG                        174
>  #define OPAL_MPIPL_QUERY_TAG                   175
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 9986ac34b8e2..301fea46c7ca 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -39,6 +39,8 @@ int64_t opal_npu_spa_clear_cache(uint64_t phb_id, uint32_t bdfn,
>                                 uint64_t PE_handle);
>  int64_t opal_npu_tl_set(uint64_t phb_id, uint32_t bdfn, long cap,
>                         uint64_t rate_phys, uint32_t size);
> +int64_t opal_npu_mem_alloc(u64 phb_id, u32 bdfn, u64 size, __be64 *bar);
> +int64_t opal_npu_mem_release(u64 phb_id, u32 bdfn);
>
>  int64_t opal_console_write(int64_t term_number, __be64 *length,
>                            const uint8_t *buffer);
> diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
> index 5cd0f52d258f..f26e58b72c04 100644
> --- a/arch/powerpc/platforms/powernv/opal-call.c
> +++ b/arch/powerpc/platforms/powernv/opal-call.c
> @@ -287,6 +287,8 @@ OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,             OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
>  OPAL_CALL(opal_sensor_read_u64,                        OPAL_SENSOR_READ_U64);
>  OPAL_CALL(opal_sensor_group_enable,            OPAL_SENSOR_GROUP_ENABLE);
>  OPAL_CALL(opal_nx_coproc_init,                 OPAL_NX_COPROC_INIT);
> +OPAL_CALL(opal_npu_mem_alloc,                  OPAL_NPU_MEM_ALLOC);
> +OPAL_CALL(opal_npu_mem_release,                        OPAL_NPU_MEM_RELEASE);
>  OPAL_CALL(opal_mpipl_update,                   OPAL_MPIPL_UPDATE);
>  OPAL_CALL(opal_mpipl_register_tag,             OPAL_MPIPL_REGISTER_TAG);
>  OPAL_CALL(opal_mpipl_query_tag,                        OPAL_MPIPL_QUERY_TAG);
> --
> 2.24.1
>
