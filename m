Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4278C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4DE2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="D1LrFsUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgGAUW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:22:57 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:37982 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbgGAUW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:22:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593634976; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=9DtYIWXpuLm3hP8kFbvWXOXBuE1hHKm2i8hLKRF2Exg=;
 b=D1LrFsUJUmjhBMj5LwuCTvJLtsRu4jtLh5pLlLcLruPTGqrq5In580z1WXtrhcEpp/dn7fSY
 bDBn4/adqHotMDM1V1NINOx6jQE0/mza4Hm468h2/8Odg0sb4PqOmVLtRHrulaRpLIaYzu6B
 ty7O8aaBuUwdpcp9ualvEjn60H8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5efcf09c6f2ee827da114fec (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 01 Jul 2020 20:22:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F615C433CA; Wed,  1 Jul 2020 20:22:52 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 895C3C433C6;
        Wed,  1 Jul 2020 20:22:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Jul 2020 01:52:51 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v6 3/3] remoteproc: Add coredump debugfs entry
In-Reply-To: <1593460933-4262-4-git-send-email-rishabhb@codeaurora.org>
References: <1593460933-4262-1-git-send-email-rishabhb@codeaurora.org>
 <1593460933-4262-4-git-send-email-rishabhb@codeaurora.org>
Message-ID: <483d227972b66a86b08d1abd8c396d0a@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-30 01:32, Rishabh Bhatnagar wrote:
> Add coredump debugfs entry to configure the type of dump that will
> be collected during recovery. User can select between default or
> inline coredump functionality. Also coredump collection can be
> disabled through this interface.
> This functionality can be configured differently for different
> remote processors.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_debugfs.c | 86 
> +++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c
> b/drivers/remoteproc/remoteproc_debugfs.c
> index 732770e..cca0a91 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -28,6 +28,90 @@
>  static struct dentry *rproc_dbg;
> 
>  /*
> + * A coredump-configuration-to-string lookup table, for exposing a
> + * human readable configuration via debugfs. Always keep in sync with
> + * enum rproc_coredump_mechanism
> + */
> +static const char * const rproc_coredump_str[] = {
> +	[RPROC_COREDUMP_DEFAULT]	= "default",
> +	[RPROC_COREDUMP_INLINE]	= "inline",
> +	[RPROC_COREDUMP_DISABLED]	= "disabled",
> +};
> +
> +/* Expose the current coredump configuration via debugfs */
> +static ssize_t rproc_coredump_read(struct file *filp, char __user 
> *userbuf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct rproc *rproc = filp->private_data;
> +	const char *buf = rproc_coredump_str[rproc->dump_conf];

Nit: It would be nice to have a
line feed after the string.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> +
> +	return simple_read_from_buffer(userbuf, count, ppos, buf, 
> strlen(buf));
> +}
> +
> +/*
> + * By writing to the 'coredump' debugfs entry, we control the behavior 
> of the
> + * coredump mechanism dynamically. The default value of this entry is
> "default".
> + *
> + * The 'coredump' debugfs entry supports these commands:
> + *
> + * default:	This is the default coredump mechanism. When the 
> remoteproc
> + *		crashes the entire coredump will be copied to a separate buffer
> + *		and exposed to userspace.
> + *
> + * inline:	The coredump will not be copied to a separate buffer and 
> the
> + *		recovery process will have to wait until data is read by
> + *		userspace. But this avoid usage of extra memory.
> + *
> + * disabled:	This will disable coredump. Recovery will proceed without
> + *		collecting any dump.
> + */
> +static ssize_t rproc_coredump_write(struct file *filp,
> +				    const char __user *user_buf, size_t count,
> +				    loff_t *ppos)
> +{
> +	struct rproc *rproc = filp->private_data;
> +	int ret, err = 0;
> +	char buf[20];
> +
> +	if (count > sizeof(buf))
> +		return -EINVAL;
> +
> +	ret = copy_from_user(buf, user_buf, count);
> +	if (ret)
> +		return -EFAULT;
> +
> +	/* remove end of line */
> +	if (buf[count - 1] == '\n')
> +		buf[count - 1] = '\0';
> +
> +	if (rproc->state == RPROC_CRASHED) {
> +		dev_err(&rproc->dev, "can't change coredump configuration\n");
> +		err = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (!strncmp(buf, "disable", count)) {
> +		rproc->dump_conf = RPROC_COREDUMP_DISABLED;
> +	} else if (!strncmp(buf, "inline", count)) {
> +		rproc->dump_conf = RPROC_COREDUMP_INLINE;
> +	} else if (!strncmp(buf, "default", count)) {
> +		rproc->dump_conf = RPROC_COREDUMP_DEFAULT;
> +	} else {
> +		dev_err(&rproc->dev, "Invalid coredump configuration\n");
> +		err = -EINVAL;
> +	}
> +out:
> +	return err ? err : count;
> +}
> +
> +static const struct file_operations rproc_coredump_fops = {
> +	.read = rproc_coredump_read,
> +	.write = rproc_coredump_write,
> +	.open = simple_open,
> +	.llseek = generic_file_llseek,
> +};
> +
> +/*
>   * Some remote processors may support dumping trace logs into a shared
>   * memory buffer. We expose this trace buffer using debugfs, so users
>   * can easily tell what's going on remotely.
> @@ -337,6 +421,8 @@ void rproc_create_debug_dir(struct rproc *rproc)
>  			    rproc, &rproc_rsc_table_fops);
>  	debugfs_create_file("carveout_memories", 0400, rproc->dbg_dir,
>  			    rproc, &rproc_carveouts_fops);
> +	debugfs_create_file("coredump", 0600, rproc->dbg_dir,
> +			    rproc, &rproc_coredump_fops);
>  }
> 
>  void __init rproc_init_debugfs(void)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
