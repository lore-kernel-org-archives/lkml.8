Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8C6C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519822074B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgDUHZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:25:25 -0400
Received: from baldur.buserror.net ([165.227.176.147]:49720 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUHZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:25:24 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1jQnFN-0005gp-BL; Tue, 21 Apr 2020 02:23:09 -0500
Message-ID: <876d477d6d8db20c41be3eb59850c51e6badbfcf.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, robh@kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>
Date:   Tue, 21 Apr 2020 02:23:08 -0500
In-Reply-To: <20200420030538.101696-1-wenhu.wang@vivo.com>
References: <20200420030538.101696-1-wenhu.wang@vivo.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: wenhu.wang@vivo.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kernel@vivo.com, robh@kernel.org, christophe.leroy@c-s.fr, mpe@ellerman.id.au, rdunlap@infradead.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v2,RESEND] misc: new driver sram_uapi for user level
 SRAM access
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-04-19 at 20:05 -0700, Wang Wenhu wrote:
> +static void sram_uapi_res_insert(struct sram_uapi *uapi,
> +				 struct sram_resource *res)
> +{
> +	struct sram_resource *cur, *tmp;
> +	struct list_head *head = &uapi->res_list;
> +
> +	list_for_each_entry_safe(cur, tmp, head, list) {
> +		if (&tmp->list != head &&
> +		    (cur->info.offset + cur->info.size + res->info.size <=
> +		    tmp->info.offset)) {
> +			res->info.offset = cur->info.offset + cur->info.size;
> +			res->parent = uapi;
> +			list_add(&res->list, &cur->list);
> +			return;
> +		}
> +	}

We don't need yet another open coded allocator.  If you really need to do this
then use include/linux/genalloc.h, but maybe keep it simple and just have one
allocaton per file descriptor so you don't need to manage fd offsets?

> +static struct sram_resource *sram_uapi_find_res(struct sram_uapi *uapi,
> +						__u32 offset)
> +{
> +	struct sram_resource *res;
> +
> +	list_for_each_entry(res, &uapi->res_list, list) {
> +		if (res->info.offset == offset)
> +			return res;
> +	}
> +
> +	return NULL;
> +}

What if the allocation is more than one page, and the user mmaps starting
somewhere other than the first page?

> +	switch (cmd) {
> +	case SRAM_UAPI_IOC_SET_SRAM_TYPE:
> +		if (uapi->sa)
> +			return -EEXIST;
> +
> +		get_user(type, (const __u32 __user *)arg);
> +		uapi->sa = get_sram_api_from_type(type);
> +		if (uapi->sa)
> +			ret = 0;
> +		else
> +			ret = -ENODEV;
> +
> +		break;
> +

Just expose one device per backing SRAM, especially if the user has any reason
to care about where the SRAM is coming from (correlating sysfs nodes is much
more expressive than some vague notion of "type").

> +	case SRAM_UAPI_IOC_ALLOC:
> +		if (!uapi->sa)
> +			return -EINVAL;
> +
> +		res = kzalloc(sizeof(*res), GFP_KERNEL);
> +		if (!res)
> +			return -ENOMEM;
> +
> +		size = copy_from_user((void *)&res->info,
> +				      (const void __user *)arg,
> +				      sizeof(res->info));
> +		if (!PAGE_ALIGNED(res->info.size) || !res->info.size)
> +			return -EINVAL;

Missing EFAULT test (here and elsewhere), and res leaks on error.

> +
> +		res->virt = (void *)uapi->sa->sram_alloc(res->info.size,
> +							 &res->phys,
> +							 PAGE_SIZE);

Do we really need multiple allocators, or could the backend be limited to just
adding regions to a generic allocator (with that allocator also serving in-
kernel users)?

If sram_alloc is supposed to return a virtual address, why isn't that the
return type?

> +		if (!res->virt) {
> +			kfree(res);
> +			return -ENOMEM;
> +		}

ENOSPC might be more appropriate, as this isn't general-purpose RAM.

> +
> +		sram_uapi_res_insert(uapi, res);
> +		size = copy_to_user((void __user *)arg,
> +				    (const void *)&res->info,
> +				    sizeof(res->info));
> +
> +		ret = 0;
> +		break;
> +
> +	case SRAM_UAPI_IOC_FREE:
> +		if (!uapi->sa)
> +			return -EINVAL;
> +
> +		size = copy_from_user((void *)&info, (const void __user *)arg,
> +				      sizeof(info));
> +
> +		res = sram_uapi_res_delete(uapi, &info);
> +		if (!res) {
> +			pr_err("error no sram resource found\n");
> +			return -EINVAL;
> +		}
> +
> +		uapi->sa->sram_free(res->virt);
> +		kfree(res);
> +
> +		ret = 0;
> +		break;

So you can just delete any arbitrary offset, even if you weren't the one that
allocated it?  Even if this isn't meant for unprivileged use it seems error-
prone.  

> +
> +	default:
> +		pr_err("error no cmd not supported\n");
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int sram_uapi_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct sram_uapi *uapi = filp->private_data;
> +	struct sram_resource *res;
> +
> +	res = sram_uapi_find_res(uapi, vma->vm_pgoff);
> +	if (!res)
> +		return -EINVAL;
> +
> +	if (vma->vm_end - vma->vm_start > res->info.size)
> +		return -EINVAL;
> +
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       res->phys >> PAGE_SHIFT,
> +			       vma->vm_end - vma->vm_start,
> +			       vma->vm_page_prot);
> +}

Will noncached always be what's wanted here?

-Scott


