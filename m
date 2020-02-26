Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA8FC4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1181D20714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhHkl+Qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgBZIPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:15:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29339 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727314AbgBZIPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582704902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WFgUQiNzkzgN6VquyalFIhDC0rlucVistzhUDzvUUjA=;
        b=OhHkl+Qjrrdu9B+dzQGlvFHCpxFb/xr34d+cN7ZiOjLS0t+8YFLbJfUvXzTPxUDhNeXz/j
        J3au3XU/vuk0hIbf0JwlEnlzD32U6+v3PYCvN/NAz7Jz6ZPvt5yD61clL4onKyYx4PZq61
        Ythu4Jwp4uuN3KmuxEUKbajVSWfKxQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-OOn8uuyqPlm_O9Mx6ZgGOw-1; Wed, 26 Feb 2020 03:14:58 -0500
X-MC-Unique: OOn8uuyqPlm_O9Mx6ZgGOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 492B51882CD2;
        Wed, 26 Feb 2020 08:14:53 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A2FF90514;
        Wed, 26 Feb 2020 08:14:50 +0000 (UTC)
Date:   Wed, 26 Feb 2020 16:14:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
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
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 04/27] ocxl: Remove unnecessary externs
Message-ID: <20200226081447.GH4937@MiWiFi-R3L-srv>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-5-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221032720.33893-5-alastair@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/20 at 02:26pm, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Function declarations don't need externs, remove the existing ones
> so they are consistent with newer code
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  arch/powerpc/include/asm/pnv-ocxl.h | 32 ++++++++++++++---------------
>  include/misc/ocxl.h                 |  6 +++---
>  2 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
> index 0b2a6707e555..b23c99bc0c84 100644
> --- a/arch/powerpc/include/asm/pnv-ocxl.h
> +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> @@ -9,29 +9,27 @@
>  #define PNV_OCXL_TL_BITS_PER_RATE       4
>  #define PNV_OCXL_TL_RATE_BUF_SIZE       ((PNV_OCXL_TL_MAX_TEMPLATE+1) * PNV_OCXL_TL_BITS_PER_RATE / 8)
>  
> -extern int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16 *enabled,
> -			u16 *supported);

It works w or w/o extern when declare functions. Searching 'extern'
under include can find so many functions with 'extern' adding. Do we
have a explicit standard if we should add or remove 'exter' in function
declaration?

I have no objection to this patch, just want to make clear so that I can
handle it w/o confusion.

Thanks
Baoquan

