Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED9C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652EF2137B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgH2KqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:46:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:59580 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgH2KqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:46:16 -0400
IronPort-SDR: yh1bja9Zk3L9JuBaGgcPlrnE8b6xCUtUUC0qzJDtwjA2QTJXuFPdJX2bTeUMAARYaN0/vu789P
 szWw51/UT7Ww==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="157806884"
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="157806884"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2020 03:46:16 -0700
IronPort-SDR: T6xmkOoupvAZ9Yrhtai1YScQgfB10+J3wVSer2lE/p1UifbW5DV3S664Hwz8sLEDiUCjYjxyr+
 UVcVzcqM0qdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="501313399"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2020 03:46:13 -0700
Date:   Sat, 29 Aug 2020 18:46:12 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     <linux-kernel@vger.kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>, <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH 05/17] virt: acrn: Introduce ACRN HSM basic driver
Message-ID: <20200829104612.GD13723@shuo-intel.sh.intel.com>
References: <20200825024516.16766-1-shuo.a.liu@intel.com>
 <20200825024516.16766-6-shuo.a.liu@intel.com>
 <20200828102559.GA1470435@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200828102559.GA1470435@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri 28.Aug'20 at 12:25:59 +0200, Greg Kroah-Hartman wrote:
>On Tue, Aug 25, 2020 at 10:45:05AM +0800, shuo.a.liu@intel.com wrote:
>> +static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>> +			   unsigned long ioctl_param)
>> +{
>> +	if (cmd == ACRN_IOCTL_GET_API_VERSION) {
>> +		if (copy_to_user((void __user *)ioctl_param,
>> +				 &api_version, sizeof(api_version)))
>> +			return -EFAULT;
>
>Why are you versioning your api?  Shouldn't that not be a thing and you
>either support an ioctl or you do not?

The API version here is more for the hypercalls.
The hypercalls might evolve later and the version indicates which set of
interfaces (include the paramters' format) should be used by user space
tools. Currently, it's used rarely.

>
>
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int acrn_dev_release(struct inode *inode, struct file *filp)
>> +{
>> +	struct acrn_vm *vm = filp->private_data;
>> +
>> +	kfree(vm);
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations acrn_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.open		= acrn_dev_open,
>> +	.release	= acrn_dev_release,
>> +	.unlocked_ioctl	= acrn_dev_ioctl,
>> +};
>> +
>> +static struct miscdevice acrn_dev = {
>> +	.minor	= MISC_DYNAMIC_MINOR,
>> +	.name	= "acrn_hsm",
>> +	.fops	= &acrn_fops,
>> +};
>> +
>> +static int __init hsm_init(void)
>> +{
>> +	int ret;
>> +
>> +	if (x86_hyper_type != X86_HYPER_ACRN)
>> +		return -ENODEV;
>> +
>> +	if (!acrn_is_privileged_vm())
>> +		return -EPERM;
>> +
>> +	ret = hcall_get_api_version(slow_virt_to_phys(&api_version));
>> +	if (ret < 0) {
>> +		pr_err("Failed to get API version from hypervisor!\n");
>> +		return ret;
>> +	}
>> +
>> +	pr_info("API version is %u.%u\n",
>> +		api_version.major_version, api_version.minor_version);
>
>Shouldn't drivers be quiet when they load and all goes well?  pr_dbg()?
>
>And can't you defer the "read the version" call until open happens?
>Does it have to happen at module load time, increasing boot time for no
>good reason if there is not a user?

OK. I can defer the version fetch and pr_dbg() until open.

Thanks
shuo
