Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44FCC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6132076A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o7JX6O+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgD1DrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgD1DrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:47:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DE8C03C1A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 20:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=53Jqa1FKe7i1g/uMIshJnn4Rf04JmaipDVp50h/a3ho=; b=o7JX6O+9omjwiEUUFqOG/zo9kV
        0jtSpjuBE9nxa69av6ybtXUAnHbUwV5oV/RYkCGvp7OVGjgn+H6hnyV16Jx8J5QcIqtpe2v8VCRYY
        8iAuScvv8vmRDcR2crKve1iwa5nyb20CxtQDq6d0aFRv/XwSRYvw18ydDFDmRYZXACZJ+AYK542Zq
        apX2h3S9qlRnG8kWd3ZwbkpaqEq0BA5d0gw9OnLB8M95w6ygl81OazjlFMJYAS42rLsc6ZxcV99Ai
        33hH3qFeh7JRnpATd49HJxW3Hz8ka4Tcwbqcjpth9QMNbXS4JZwl+J6d4vzkWKKWoMUR4uHcdk2Px
        XINQVfPA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTHD5-00061l-T8; Tue, 28 Apr 2020 03:47:03 +0000
Subject: Re: [PATCH] module: Allow to disable modsign in kernel cmdline
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200428034310.44035-1-tianjia.zhang@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <713892bf-ffe8-8cfd-b2c5-7090626c02fe@infradead.org>
Date:   Mon, 27 Apr 2020 20:47:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428034310.44035-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 8:43 PM, Tianjia Zhang wrote:
> This change allows to disable modsign completely at the beginning,
> and turn off by set the kernel cmdline `no_modsig_enforce` when
> CONFIG_MODULE_SIG_FORCE is enabled.
> 
> Yet another change allows to always show the current status of
> modsign through `/sys/module/module/parameters/sig_enforce`.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  kernel/module.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 646f1e2330d2..0e68e1286377 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -269,6 +269,14 @@ static void module_assert_mutex_or_preempt(void)
>  
>  static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
>  module_param(sig_enforce, bool_enable_only, 0644);
> +#ifdef CONFIG_MODULE_SIG_FORCE
> +static int __init set_no_modsig_enforce(char *str)
> +{
> +	sig_enforce = false;
> +	return 1;
> +}
> +__setup("no_modsig_enforce", set_no_modsig_enforce);
> +#endif /* !CONFIG_MODULE_SIG_FORCE */
>  
>  /*
>   * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
> 

Hi,
Please document this cmdline option, probably in
Documentation/admin-guide/kernel-parameters.txt.

thanks.

-- 
~Randy

