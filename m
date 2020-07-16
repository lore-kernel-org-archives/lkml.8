Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0263C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A7AE2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594942819;
	bh=riITmyDuf/GN7tn3G7Z7oGKq7CHs6wg0gna9EwStjOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0jR0fRbQWfiG2tK+XiaGnM9sdQBIkdgl8hvdwPwpcbCD+vZiqVJD6ofxM9GpJPSTf
	 DkP+XNJOzkuMqSDvg9/K5NZVa6+NlUHg0NYExUBmUL9Xqxwy8HdLiVpcByz3oSJYOo
	 PEyDsRR3sBXfIV++GrKdCJD4e8BKikrQs/rYYhZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgGPXkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgGPXkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:40:17 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C9C207DD;
        Thu, 16 Jul 2020 22:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594938278;
        bh=riITmyDuf/GN7tn3G7Z7oGKq7CHs6wg0gna9EwStjOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rFcTojhGlgn7aOQAoBlbvZRbKqOM4JutY2KHUv9y/9rqJNTYzIZhvbLK04ZbumoGg
         wB6NekP1ii1I29EuOivzF8L8ZBLe6E4v9xkdD4tngqvYb8MxyNF1kIeDqM5ZoHEtDm
         Wlk4yIQUueHEmg9xpIZIGP6ZlrVvegsWUyjMsYN8=
Date:   Thu, 16 Jul 2020 15:24:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mmap: Merge vma after call_mmap() if possible
Message-Id: <20200716152438.9317f4f95b92de75f88ea99f@linux-foundation.org>
In-Reply-To: <1594696064-1409-1-git-send-email-linmiaohe@huawei.com>
References: <1594696064-1409-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 11:07:44 +0800 linmiaohe <linmiaohe@huawei.com> wrote:

> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> The vm_flags may be changed after call_mmap() because drivers may set some
> flags for their own purpose. As a result, we failed to merge the adjacent
> vma due to the different vm_flags as userspace can't pass in the same one.
> Try to merge vma after call_mmap() to fix this issue.
> 
> Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/mmap.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 59a4682ebf3f..9568117471f8 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1689,7 +1689,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		struct list_head *uf)
>  {
>  	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma, *prev;
> +	struct vm_area_struct *vma, *prev, *merge;
>  	int error;
>  	struct rb_node **rb_link, *rb_parent;
>  	unsigned long charged = 0;
> @@ -1773,6 +1773,20 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		if (error)
>  			goto unmap_and_free_vma;
>  
> +		/* If vm_flags changed after call_mmap(), we should try merge vma again
> +		 * as we may succeed this time.
> +		 */
> +		if (unlikely(vm_flags != vma->vm_flags && prev)) {
> +			merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
> +				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
> +			if (merge) {
> +				fput(file);
> +				vm_area_free(vma);
> +				vma = merge;
> +				goto unmap_writable;

Shouldn't we update local variable `vm_flags' here, to pick up the
change?  And possibly `addr'?

> +			}
> +		}
> +
>  		/* Can addr have changed??
>  		 *
>  		 * Answer: Yes, several device drivers can do it in their
> @@ -1795,6 +1809,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	vma_link(mm, vma, prev, rb_link, rb_parent);
>  	/* Once vma denies write, undo our temporary denial count */
>  	if (file) {
> +unmap_writable:
>  		if (vm_flags & VM_SHARED)
>  			mapping_unmap_writable(file->f_mapping);
>  		if (vm_flags & VM_DENYWRITE)

