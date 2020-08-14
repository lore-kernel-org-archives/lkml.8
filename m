Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546D0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333EC206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgHNKe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:34:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47412 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHNKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:34:56 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k6X2e-0004w2-DI; Fri, 14 Aug 2020 10:34:32 +0000
Date:   Fri, 14 Aug 2020 12:34:31 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, vbabka@suse.cz,
        daniel.m.jordan@oracle.com, Nicolas.Viennot@twosigma.com,
        walken@google.com, mchristi@redhat.com, arnd@arndb.de,
        viro@zeniv.linux.org.uk, thomascedeno@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sys.c: Convert to use the preferred fallthrough
 macro
Message-ID: <20200814103431.jytlvc4wgxb2yx57@wittgenstein>
References: <20200814085718.40326-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200814085718.40326-1-linmiaohe@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 04:57:18AM -0400, Miaohe Lin wrote:
> Convert the uses of fallthrough comments to fallthrough macro.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

This matches what we have documented in:

Documentation/process/deprecated.rst
Documentation/process/coding-style.rst

I'm going to reference that info in the commit message.

Applied, queueing for post rc1.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  kernel/sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index ca11af9d815d..ab6c409b1159 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1753,7 +1753,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
>  
>  		if (who == RUSAGE_CHILDREN)
>  			break;
> -		/* fall through */
> +		fallthrough;
>  
>  	case RUSAGE_SELF:
>  		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
> -- 
> 2.19.1
> 
