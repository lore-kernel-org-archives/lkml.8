Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E4EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223A62075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgGMMib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:38:31 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57176 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGMMib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:38:31 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1juxj1-0001AD-UL; Mon, 13 Jul 2020 06:38:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1juxj0-0000e9-Sw; Mon, 13 Jul 2020 06:38:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        gregkh@linuxfoundation.org, dan.j.williams@intel.com
References: <20200704205619.11172-1-richard@nod.at>
Date:   Mon, 13 Jul 2020 07:35:39 -0500
In-Reply-To: <20200704205619.11172-1-richard@nod.at> (Richard Weinberger's
        message of "Sat, 4 Jul 2020 22:56:19 +0200")
Message-ID: <87sgdvbnj8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1juxj0-0000e9-Sw;;;mid=<87sgdvbnj8.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18pMLZQ3OtSquT9B9ftcoTj28hZic45tqk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] [RFC] kernfs: Allow vm_ops->close() if VMA is never split
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Weinberger <richard@nod.at> writes:

> 10 years ago commit a6849fa1f7d7 ("sysfs: Fail bin file mmap if vma close is implemented.")
> removed support for vm_ops->close() for mmap on sysfs.
> As far I understand the reason is that due to the wrapping in kernfs
> every VMA split operation needs to be tracked to call vm_ops->close()
> for all fragments. This is not feasible with reasonable effort.
>
> Since commit 31383c6865a5 ("mm, hugetlbfs: introduce ->split() to vm_operations_struct")
> we can get notified as soon a VMA is split, this can help to relax the restriction.
> So I propose to allow having a custom close under the condition that a
> VMA cannot get split.

The existence of split may help but your patch does not address the
problem.

The difficult to handle case is not split.  Simply wrapping
vma->vm_ops->open and vma->vm_ops->close is enough to handle split.  The
challenge is when the kernel revokes acess to a kernfs file.  Revokes
happen when the module supporting a kernfs file is removed, or when a
piece of hardware is removed.

The code path for that revocation looks like:
	kernfs_remove or kernfs_remove_self
		__kernfs_remove
			kernfs_drain
        			kernfs_drain_open_files
                			unmap_mapping_range


The fundamental problem is that at the time of unmap_mapping_range the
code if it is to implement vma->vm_ops->close properly needs to call
close on all of the vmas.  The code can not wait longer as after
kernfs_remove returns the kernfs code makes the guarantee that the code
implementing vma->vm_ops->close has been removed from the kernel.

The technical challenge is how to implement walking the list of vmas and
call the vma->vops->close method on all of them at revoke time.  Last
I looked taking the locks that are necessary to do that is not safe to
do when holding the locks that are held in the kernfs_remove path.

A lot has changed in kernfs and the mm subsystem since I examined it,
so it might be worth looking at this again.

So in short the problem is that the code does not exist to call close
when the kernfs file is revoked.  Your patch below does not implement
that code.

Eric

>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/kernfs/file.c | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 06b342d8462b..82b09e72acff 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -347,6 +347,38 @@ static void kernfs_vma_open(struct vm_area_struct *vma)
>  	kernfs_put_active(of->kn);
>  }
>  
> +static void kernfs_vma_close(struct vm_area_struct *vma)
> +{
> +	struct file *file = vma->vm_file;
> +	struct kernfs_open_file *of = kernfs_of(file);
> +
> +	if (!of->vm_ops)
> +		return;
> +
> +	if (!kernfs_get_active(of->kn))
> +		return;
> +
> +	if (of->vm_ops->close)
> +		of->vm_ops->close(vma);
> +
> +	kernfs_put_active(of->kn);
> +}
> +
> +static int kernfs_vma_split(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	struct file *file = vma->vm_file;
> +	struct kernfs_open_file *of = kernfs_of(file);
> +
> +	/*
> +	 * We cannot keep track of split operations,
> +	 * so refuse splitting a VMA if someone uses close.
> +	 */
> +	if (of->vm_ops && of->vm_ops->close)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
>  {
>  	struct file *file = vmf->vma->vm_file;
> @@ -457,6 +489,8 @@ static struct mempolicy *kernfs_vma_get_policy(struct vm_area_struct *vma,
>  
>  static const struct vm_operations_struct kernfs_vm_ops = {
>  	.open		= kernfs_vma_open,
> +	.close		= kernfs_vma_close,
> +	.split		= kernfs_vma_split,
>  	.fault		= kernfs_vma_fault,
>  	.page_mkwrite	= kernfs_vma_page_mkwrite,
>  	.access		= kernfs_vma_access,
> @@ -505,14 +539,6 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (of->mmapped && of->vm_ops != vma->vm_ops)
>  		goto out_put;
>  
> -	/*
> -	 * It is not possible to successfully wrap close.
> -	 * So error if someone is trying to use close.
> -	 */
> -	rc = -EINVAL;
> -	if (vma->vm_ops && vma->vm_ops->close)
> -		goto out_put;
> -
>  	rc = 0;
>  	of->mmapped = true;
>  	of->vm_ops = vma->vm_ops;
