Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6E7C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F572072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="keDETmcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgICM2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 08:28:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60812 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgICM0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:26:40 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083CQTM5033898;
        Thu, 3 Sep 2020 07:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599135989;
        bh=C49cVGMfysASvBZN8YfOnPiHqifti4v0fpFLtpuvDFo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=keDETmcGnT3787siHhYTvjmFIuGTIwrvkyy99J2Nzz5opdLU/qfvdMgdttMdj1C+B
         J9iL3nvcFRw084oHqm/2EXmCra4YBrRsF/65ylCQZxrtFOd1XPyTRajpWxZwtRbQx4
         Fa8Y7QldEhSsm7TcFZ8OdXXh3xR8jQeleVJ/RB4o=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 083CQTZf106490
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Sep 2020 07:26:29 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 07:26:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 07:26:28 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083CQOpb038856;
        Thu, 3 Sep 2020 07:26:26 -0500
Subject: Re: drivers/irqchip/irq-ti-sci-intr.c:148
 ti_sci_intr_alloc_parent_irq() warn: impossible condition '(p_hwirq < 0) =>
 (0-u16max < 0)'
To:     Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@lists.01.org>
CC:     <lkp@intel.com>, Dan Carpenter <error27@gmail.com>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
References: <20200903122159.GE8299@kadam>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <ed83e54c-1216-5c02-6f1f-a3c94e67bb68@ti.com>
Date:   Thu, 3 Sep 2020 17:56:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200903122159.GE8299@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 03/09/20 5:51 pm, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   fc3abb53250a90ba2150eebd182137c136f4d25a
> commit: a5b659bd4bc7518a8e45fda5256c5e5e8d3b7c49 irqchip/ti-sci-intr: Add support for INTR being a parent to INTR
> config: arm64-randconfig-m031-20200902 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/irqchip/irq-ti-sci-intr.c:148 ti_sci_intr_alloc_parent_irq() warn: impossible condition '(p_hwirq < 0) => (0-u16max < 0)'
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a5b659bd4bc7518a8e45fda5256c5e5e8d3b7c49
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git fetch --no-tags linus master
> git checkout a5b659bd4bc7518a8e45fda5256c5e5e8d3b7c49
> vim +148 drivers/irqchip/irq-ti-sci-intr.c
> 
> a5b659bd4bc751 Lokesh Vutla 2020-08-06  134  static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain,
> cd844b0715ceda Lokesh Vutla 2019-04-30  135  					unsigned int virq, u32 hwirq)
> cd844b0715ceda Lokesh Vutla 2019-04-30  136  {
> cd844b0715ceda Lokesh Vutla 2019-04-30  137  	struct ti_sci_intr_irq_domain *intr = domain->host_data;
> a5b659bd4bc751 Lokesh Vutla 2020-08-06  138  	struct device_node *parent_node;
> cd844b0715ceda Lokesh Vutla 2019-04-30  139  	struct irq_fwspec fwspec;
> a5b659bd4bc751 Lokesh Vutla 2020-08-06  140  	u16 out_irq, p_hwirq;
>                                                 ^^^          ^^^^^^^
> 
> a5b659bd4bc751 Lokesh Vutla 2020-08-06  141  	int err = 0;
> cd844b0715ceda Lokesh Vutla 2019-04-30  142  
> a5b659bd4bc751 Lokesh Vutla 2020-08-06  143  	out_irq = ti_sci_get_free_resource(intr->out_irqs);
> a5b659bd4bc751 Lokesh Vutla 2020-08-06  144  	if (out_irq == TI_SCI_RESOURCE_NULL)
> cd844b0715ceda Lokesh Vutla 2019-04-30  145  		return -EINVAL;
> cd844b0715ceda Lokesh Vutla 2019-04-30  146  
> a5b659bd4bc751 Lokesh Vutla 2020-08-06  147  	p_hwirq = ti_sci_intr_xlate_irq(intr, out_irq);
> a5b659bd4bc751 Lokesh Vutla 2020-08-06 @148  	if (p_hwirq < 0)
>                                                     ^^^^^^^^^^^
> Impossible

This is already fixed by https://patchwork.kernel.org/patch/11737169/

Thanks and regards,
Lokesh

