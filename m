Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770A8C5ACD8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4907B20772
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584529328;
	bh=ZNJbZkH0nXoHrj4DDwLg8d1qU7rSUHWk+hrUrCsVZWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cnkxZzyT4KnY/VCCVXYZXXpApZD0vAeJUoQVtaqbgd58N3fu6r355LLlx2EEYmEmv
	 TjThFpuD2VVWnDyhO5hynMjNzMecmFOFdyG9wSGKQcNqvejEKxBgzLKgIShuJSFH1m
	 sR/cjiEHYjrt13ycCASa2NKoI+Q1SnvpMGVXEwyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgCRLCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbgCRLCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:02:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA0E2076D;
        Wed, 18 Mar 2020 11:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584529326;
        bh=ZNJbZkH0nXoHrj4DDwLg8d1qU7rSUHWk+hrUrCsVZWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z1anWoqPAz0ydzDH4yHNE+g9oIyu5kuia5JrJZB6ql+zFhErDrFEJaML4T/jNdWXb
         CG6BzUJIFjNncmVTqoo9xd+U9Dn0jRNIeRdll160Q0bp96E8CyZSCa5o9Y9JWXGc/0
         vWRLbmvfUqjoPGSF8WA48HQnwDDF9WEgbzaS5r8c=
Date:   Wed, 18 Mar 2020 12:02:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Xin Tan <tanxin.ctf@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Vishnu DASA <vdasa@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Marshall <hubcap@omnibond.com>,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu
Subject: Re: [PATCH] VMCI: Fix NULL pointer dereference on context ptr
Message-ID: <20200318110204.GB2305113@kroah.com>
References: <1584426607-89366-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584426607-89366-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:29:57PM +0800, Xiyu Yang wrote:
> The refcount wrapper function vmci_ctx_get() may return NULL
> context ptr. Thus, we need to add a NULL pointer check
> before its dereference.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/misc/vmw_vmci/vmci_context.c    |  2 ++
>  drivers/misc/vmw_vmci/vmci_queue_pair.c | 17 +++++++++++------
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
> index 16695366ec92..a20878fba374 100644
> --- a/drivers/misc/vmw_vmci/vmci_context.c
> +++ b/drivers/misc/vmw_vmci/vmci_context.c
> @@ -898,6 +898,8 @@ void vmci_ctx_rcv_notifications_release(u32 context_id,
>  					bool success)
>  {
>  	struct vmci_ctx *context = vmci_ctx_get(context_id);
> +	if (context == NULL)
> +		return;

Same comment as on your other patch.

And is this a v2?

>  
>  	spin_lock(&context->lock);
>  	if (!success) {
> diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> index 8531ae781195..2ecb22d08692 100644
> --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> @@ -1575,11 +1575,14 @@ static int qp_broker_attach(struct qp_broker_entry *entry,
>  		 */
>  
>  		create_context = vmci_ctx_get(entry->create_id);
> -		supports_host_qp = vmci_ctx_supports_host_qp(create_context);
> -		vmci_ctx_put(create_context);
> +		if (!create_context) {
> +			supports_host_qp =
> +				vmci_ctx_supports_host_qp(create_context);
> +			vmci_ctx_put(create_context);
>  
> -		if (!supports_host_qp)
> -			return VMCI_ERROR_INVALID_RESOURCE;
> +			if (!supports_host_qp)
> +				return VMCI_ERROR_INVALID_RESOURCE;
> +		}
>  	}
>  
>  	if ((entry->qp.flags & ~VMCI_QP_ASYMM) != (flags & ~VMCI_QP_ASYMM_PEER))
> @@ -1808,7 +1811,8 @@ static int qp_alloc_host_work(struct vmci_handle *handle,
>  		pr_devel("queue pair broker failed to alloc (result=%d)\n",
>  			 result);
>  	}
> -	vmci_ctx_put(context);
> +	if (context)
> +		vmci_ctx_put(context);

can't vmci_ctx_put() take a NULL pointer?  If not, fix this that way
please.

thanks,

greg k-h
