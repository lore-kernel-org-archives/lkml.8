Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA642C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4DB20722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCTFPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:15:44 -0400
Received: from baldur.buserror.net ([165.227.176.147]:45018 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTFPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 01:15:44 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1jF9tu-0000dq-Qb; Fri, 20 Mar 2020 00:08:55 -0500
Message-ID: <db764910fe2de8ae2d63c6adbb0b71d32c0e3886.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        christophe.leroy@c-s.fr, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com, keescook@chromium.org,
        kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, zhaohongjiang@huawei.com,
        dja@axtens.net
Date:   Fri, 20 Mar 2020 00:08:53 -0500
In-Reply-To: <20200306064033.3398-7-yanaijie@huawei.com>
References: <20200306064033.3398-1-yanaijie@huawei.com>
         <20200306064033.3398-7-yanaijie@huawei.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: yanaijie@huawei.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com, christophe.leroy@c-s.fr, benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com, keescook@chromium.org, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org, zhaohongjiang@huawei.com, dja@axtens.net
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v4 6/6] powerpc/fsl_booke/kaslr: rename
 kaslr-booke32.rst to kaslr-booke.rst and add 64bit part
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-06 at 14:40 +0800, Jason Yan wrote:
> @@ -38,5 +41,29 @@ bit of the entropy to decide the index of the 64M zone.
> Then we chose a
>  
>                                kernstart_virt_addr
>  
> +
> +KASLR for Freescale BookE64
> +---------------------------
> +
> +The implementation for Freescale BookE64 is similar as BookE32. One

similar to

> +difference is that Freescale BookE64 set up a TLB mapping of 1G during
> +booting. Another difference is that ppc64 needs the kernel to be
> +64K-aligned. So we can randomize the kernel in this 1G mapping and make
> +it 64K-aligned. This can save some code to creat another TLB map at early

create

-Scott


