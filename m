Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94805C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A1D208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598610350;
	bh=FXmXXck2z15ZKaC3fZIXJqQddJxZir7/9JxIbEn85RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EhOTRKsWd1kLHM1XsPfThN9UyPpK8vrbu/UuwMbHd1buQOKMD0WRMxkTwoCZkCmD7
	 hDLGzf3jjT2l87H5IOff3hVtvmdGflv19Bd05bA6VjeBswJwmH7CcsDRAooVe/w7Iq
	 HWfeKVcTi/u38KK/EEOwY+zrC8q+0hZdrs9xUGlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgH1KZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbgH1KZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:25:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDEB820737;
        Fri, 28 Aug 2020 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598610347;
        bh=FXmXXck2z15ZKaC3fZIXJqQddJxZir7/9JxIbEn85RE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOzQ2+vfPGmYNywVHZFXuVXJPsNXKC6s1CFJHnm2f9rXDnTGxBwIuNFceOzfRCZC7
         6slmLz52hdEAZz07PrSMqCCG+FEVEhbXulOx7I1mKRcc2po5rSk9GGASV1iyCY2Jl+
         dtfcwo1xveClMwljJ88I5Dxa4IjNcKCMt+EwpoyM=
Date:   Fri, 28 Aug 2020 12:25:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH 05/17] virt: acrn: Introduce ACRN HSM basic driver
Message-ID: <20200828102559.GA1470435@kroah.com>
References: <20200825024516.16766-1-shuo.a.liu@intel.com>
 <20200825024516.16766-6-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825024516.16766-6-shuo.a.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:45:05AM +0800, shuo.a.liu@intel.com wrote:
> +static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
> +			   unsigned long ioctl_param)
> +{
> +	if (cmd == ACRN_IOCTL_GET_API_VERSION) {
> +		if (copy_to_user((void __user *)ioctl_param,
> +				 &api_version, sizeof(api_version)))
> +			return -EFAULT;

Why are you versioning your api?  Shouldn't that not be a thing and you
either support an ioctl or you do not?



> +	}
> +
> +	return 0;
> +}
> +
> +static int acrn_dev_release(struct inode *inode, struct file *filp)
> +{
> +	struct acrn_vm *vm = filp->private_data;
> +
> +	kfree(vm);
> +	return 0;
> +}
> +
> +static const struct file_operations acrn_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= acrn_dev_open,
> +	.release	= acrn_dev_release,
> +	.unlocked_ioctl	= acrn_dev_ioctl,
> +};
> +
> +static struct miscdevice acrn_dev = {
> +	.minor	= MISC_DYNAMIC_MINOR,
> +	.name	= "acrn_hsm",
> +	.fops	= &acrn_fops,
> +};
> +
> +static int __init hsm_init(void)
> +{
> +	int ret;
> +
> +	if (x86_hyper_type != X86_HYPER_ACRN)
> +		return -ENODEV;
> +
> +	if (!acrn_is_privileged_vm())
> +		return -EPERM;
> +
> +	ret = hcall_get_api_version(slow_virt_to_phys(&api_version));
> +	if (ret < 0) {
> +		pr_err("Failed to get API version from hypervisor!\n");
> +		return ret;
> +	}
> +
> +	pr_info("API version is %u.%u\n",
> +		api_version.major_version, api_version.minor_version);

Shouldn't drivers be quiet when they load and all goes well?  pr_dbg()?

And can't you defer the "read the version" call until open happens?
Does it have to happen at module load time, increasing boot time for no
good reason if there is not a user?

thanks,

greg k-h
