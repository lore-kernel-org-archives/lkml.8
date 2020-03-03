Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3599C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54642083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Os41xsdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgCCLpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:45:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33444 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgCCLpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:45:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id x7so3977416wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PZ26SY4OwzsSrrvvDGgwwk0/Jl3p0EnMD6uJWZM6hTo=;
        b=Os41xsdyARcThMKgbHdgjT2+ry+sDNsiEi589q5nCVRho3STC+L29GGxO7sHC3e8mR
         +DAjmJXd+wBqZoeuUGQ8IfRJ48h7xqleIj9yg2t3x6sEaZjLp5+8uR/M69QtkqCLZmjB
         5n8viie8sqPIAQv/el8Cu2RHEevc3PnyAk+WKwjd7N72EO/PmDcplEzStoeeQXpTBd+B
         zfRLNNZFj6pgVODZ62JI9IxMFgP86GXWT9mVSe4OzNNIkcutBUlneGzQGtPujn3Tdhfk
         1G5BM85dir9NDY07dZk8lt6CEKfsyf/B7f4J5D74lvlB/MqFZqRi3bR/uEa3D6amHtMi
         DtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PZ26SY4OwzsSrrvvDGgwwk0/Jl3p0EnMD6uJWZM6hTo=;
        b=fqV01QCMeBiKVOv6/FpL6nD/UpT94z6UrpxOAHzrPSYWfH85SUt4Y5qCPJjuzdpvPy
         zlsF9n4O+YaYLvSZPV99dQEwzEnM9C/g+HD7HFYW+7xlvip/0ENZjkz6QPwxNNNZ0F4g
         mfGeXPlW3UoC8o6oS6DD4Va43vH0R2KfZbQJPvEUQ54dSlf9Und4IC1Dfdx1BzQjQZX9
         BKsP6tIkVPAaSP0hoLPqXyoIs1734I0OiyblveswKcohC9XF912v1GoG6RuZQ6StjuTy
         PLTr8s53buu7D37+gEiW7lWtot/dIGU8KKCwwhOfv+dKd1ybaRVYZJROnNVLEqDkkzzz
         hG/g==
X-Gm-Message-State: ANhLgQ2t/dAk5kV28I5/VyxodShFJ0Ni2iTwBNN8iop2HkOBw4hWWQR+
        ebZNqcQgPnDPqTHBrJ50tnZOOQ==
X-Google-Smtp-Source: ADFU+vvAQcjhLmXZmUStTMU0McPCavF6iV/MgepVuImdgSSkgWiW5gBhUK4eC9HXObGd07iarLeZ4g==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr5422393wrx.182.1583235918023;
        Tue, 03 Mar 2020 03:45:18 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id a7sm3510943wmb.0.2020.03.03.03.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 03:45:17 -0800 (PST)
Date:   Tue, 3 Mar 2020 12:45:10 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Raj, Ashok" <ashok.raj@linux.intel.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        grant.likely@arm.com, Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v12 2/4] uacce: add uacce driver
Message-ID: <20200303114510.GA584461@myrica>
References: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
 <1579097568-17542-3-git-send-email-zhangfei.gao@linaro.org>
 <20200224182201.GA22668@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224182201.GA22668@araj-mobl1.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 10:22:02AM -0800, Raj, Ashok wrote:
> Hi Kenneth,
> 
> sorry for waking up late on this patchset.
> 
> 
> On Wed, Jan 15, 2020 at 10:12:46PM +0800, Zhangfei Gao wrote:
> [... trimmed]
> 
> > +
> > +static int uacce_fops_open(struct inode *inode, struct file *filep)
> > +{
> > +	struct uacce_mm *uacce_mm = NULL;
> > +	struct uacce_device *uacce;
> > +	struct uacce_queue *q;
> > +	int ret = 0;
> > +
> > +	uacce = xa_load(&uacce_xa, iminor(inode));
> > +	if (!uacce)
> > +		return -ENODEV;
> > +
> > +	q = kzalloc(sizeof(struct uacce_queue), GFP_KERNEL);
> > +	if (!q)
> > +		return -ENOMEM;
> > +
> > +	mutex_lock(&uacce->mm_lock);
> > +	uacce_mm = uacce_mm_get(uacce, q, current->mm);
> 
> I think having this at open time is a bit unnatural. Since when a process
> does fork, we do not inherit the PASID. Although it inherits the fd
> but cannot use the mmaped address in the child.

Both the queue and the PASID are tied to a single address space. When it
disappears, the queue is stopped (zombie state) and the PASID is freed.
The fd is not usable nor recoverable at this point, it's just waiting to
be released.

> If you move this to the mmap time, its more natural. The child could
> do a mmap() get a new PASID + mmio space to work with the hardware.

I like the idea, as it ties the lifetime of the bond to that of the queue
mapping, but I have two small concerns:

* It adds a lot of side-effect to mmap(). In addition to mapping the MMIO
  region it would now create both the bond and the queue. For userspace,
  figuring out why the mmap() fails would be more difficult.

* It forces uacce drivers to implement an mmap() interface, and have MMIO
  regions to share. I suspect it's going to be the norm but at the moment
  it's not mandatory, drivers could just implement ioctls ops.

I guess the main benefit would be reusing an fd after the original address
space dies, but is it a use-case?

I'd rather go one step further in the other direction, declare that an fd
is a queue and is exclusive to an address space, by preventing any
operation (ioctl and mmap) from an mm other than the one that opened the
fd. It's not natural but it'd keep the kernel driver simple as we wouldn't
have to reconfigure the queue during the lifetime of the fd.

Thanks,
Jean
