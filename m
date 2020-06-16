Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5808AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE2C20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="C+1WjSl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgFPNo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:44:26 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:43223 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728980AbgFPNoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:44:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592315045; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=neAnsfkRMgdLmxrFAs43gbDE9/rNCoat18mjJVvgJoU=; b=C+1WjSl8ynVwJ8EhanDDuPl5UFZjJVYazIGQhK7p7ALyZsBM02ltAGjaB7DA5NZFPf23EUUw
 sFfsIu7iyyCSQQbcVq9Tsm3Imo4w5e4Hk/l0QE3Ib/5JyZr4cY1tlqOUi+udlGLFBbs3KHTV
 1cYR8xGrBMAPFTogfXaTq/uFaAE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ee8cc996bebe35deb85aa37 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 13:43:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B2CEC43395; Tue, 16 Jun 2020 13:43:53 +0000 (UTC)
Received: from [192.168.1.102] (unknown [183.83.143.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBD87C433C9;
        Tue, 16 Jun 2020 13:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBD87C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH v2] dma-buf: Move dma_buf_release() from fops to
 dentry_ops
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Chenbo Feng <fengc@google.com>, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        syzbot+3643a18836bce555bff6@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20200611114418.19852-1-sumit.semwal@linaro.org>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <59f0062d-5ca9-84f1-ba92-c3463ff0e73d@codeaurora.org>
Date:   Tue, 16 Jun 2020 19:13:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200611114418.19852-1-sumit.semwal@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Sumit for the fix.

On 6/11/2020 5:14 PM, Sumit Semwal wrote:
> Charan Teja reported a 'use-after-free' in dmabuffs_dname [1], which
> happens if the dma_buf_release() is called while the userspace is
> accessing the dma_buf pseudo fs's dmabuffs_dname() in another process,
> and dma_buf_release() releases the dmabuf object when the last reference
> to the struct file goes away.
> 
> I discussed with Arnd Bergmann, and he suggested that rather than tying
> the dma_buf_release() to the file_operations' release(), we can tie it to
> the dentry_operations' d_release(), which will be called when the last ref
> to the dentry is removed.
> 
> The path exercised by __fput() calls f_op->release() first, and then calls
> dput, which eventually calls d_op->d_release().
> 
> In the 'normal' case, when no userspace access is happening via dma_buf
> pseudo fs, there should be exactly one fd, file, dentry and inode, so
> closing the fd will kill of everything right away.
> 
> In the presented case, the dentry's d_release() will be called only when
> the dentry's last ref is released.
> 
> Therefore, lets move dma_buf_release() from fops->release() to
> d_ops->d_release()
> 
> Many thanks to Arnd for his FS insights :)
> 
> [1]: https://lore.kernel.org/patchwork/patch/1238278/
> 
> Fixes: bb2bb9030425 ("dma-buf: add DMA_BUF_SET_NAME ioctls")
> Reported-by: syzbot+3643a18836bce555bff6@syzkaller.appspotmail.com
> Cc: <stable@vger.kernel.org> [5.3+]
> Cc: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Charan Teja Reddy <charante@codeaurora.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> 

Tested this patch for Android running on Snapdragon hardware and see no
issues.
Tested-by: Charan Teja Reddy <charante@codeaurora.org>

> ---
> v2: per Arnd: Moved dma_buf_release() above to avoid forward declaration;
>      removed dentry_ops check.
> ---
>  drivers/dma-buf/dma-buf.c | 54 ++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 01ce125f8e8d..412629601ad3 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -54,37 +54,11 @@ static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
>  			     dentry->d_name.name, ret > 0 ? name : "");
>  }
>  
> -static const struct dentry_operations dma_buf_dentry_ops = {
> -	.d_dname = dmabuffs_dname,
> -};
> -
> -static struct vfsmount *dma_buf_mnt;
> -
> -static int dma_buf_fs_init_context(struct fs_context *fc)
> -{
> -	struct pseudo_fs_context *ctx;
> -
> -	ctx = init_pseudo(fc, DMA_BUF_MAGIC);
> -	if (!ctx)
> -		return -ENOMEM;
> -	ctx->dops = &dma_buf_dentry_ops;
> -	return 0;
> -}
> -
> -static struct file_system_type dma_buf_fs_type = {
> -	.name = "dmabuf",
> -	.init_fs_context = dma_buf_fs_init_context,
> -	.kill_sb = kill_anon_super,
> -};
> -
> -static int dma_buf_release(struct inode *inode, struct file *file)
> +static void dma_buf_release(struct dentry *dentry)
>  {
>  	struct dma_buf *dmabuf;
>  
> -	if (!is_dma_buf_file(file))
> -		return -EINVAL;
> -
> -	dmabuf = file->private_data;
> +	dmabuf = dentry->d_fsdata;
>  
>  	BUG_ON(dmabuf->vmapping_counter);
>  
> @@ -110,9 +84,32 @@ static int dma_buf_release(struct inode *inode, struct file *file)
>  	module_put(dmabuf->owner);
>  	kfree(dmabuf->name);
>  	kfree(dmabuf);
> +}
> +
> +static const struct dentry_operations dma_buf_dentry_ops = {
> +	.d_dname = dmabuffs_dname,
> +	.d_release = dma_buf_release,
> +};
> +
> +static struct vfsmount *dma_buf_mnt;
> +
> +static int dma_buf_fs_init_context(struct fs_context *fc)
> +{
> +	struct pseudo_fs_context *ctx;
> +
> +	ctx = init_pseudo(fc, DMA_BUF_MAGIC);
> +	if (!ctx)
> +		return -ENOMEM;
> +	ctx->dops = &dma_buf_dentry_ops;
>  	return 0;
>  }
>  
> +static struct file_system_type dma_buf_fs_type = {
> +	.name = "dmabuf",
> +	.init_fs_context = dma_buf_fs_init_context,
> +	.kill_sb = kill_anon_super,
> +};
> +
>  static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct dma_buf *dmabuf;
> @@ -412,7 +409,6 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
>  }
>  
>  static const struct file_operations dma_buf_fops = {
> -	.release	= dma_buf_release,
>  	.mmap		= dma_buf_mmap_internal,
>  	.llseek		= dma_buf_llseek,
>  	.poll		= dma_buf_poll,
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
