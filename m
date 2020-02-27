Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9136EC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E4A2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgB0Rhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:37:32 -0500
Received: from ale.deltatee.com ([207.54.116.67]:56838 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbgB0Rhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:37:31 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1j7N6B-00040E-8O; Thu, 27 Feb 2020 10:37:23 -0700
To:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-9-logang@deltatee.com>
 <96234649-fbc1-fb56-54d8-2f73dc455ffd@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9c6355d8-cf4e-9932-1cef-0a7140f0fa7e@deltatee.com>
Date:   Thu, 27 Feb 2020 10:37:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <96234649-fbc1-fb56-54d8-2f73dc455ffd@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v11 8/9] nvmet-passthru: Add enable/disable helpers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-02-26 4:33 p.m., Sagi Grimberg wrote:
> 
>> +    if (subsys->ver < NVME_VS(1, 2, 1)) {
>> +        pr_warn("nvme controller version is too old: %d.%d.%d,
>> advertising 1.2.1\n",
>> +            (int)NVME_MAJOR(subsys->ver),
>> +            (int)NVME_MINOR(subsys->ver),
>> +            (int)NVME_TERTIARY(subsys->ver));
>> +        subsys->ver = NVME_VS(1, 2, 1);
> 
> Umm.. is this OK? do we implement the mandatory 1.2.1 features on behalf
> of the passthru device?

This was the approach that Christoph suggested. It seemed sensible to
me. However, it would also *probably* be ok to just reject these
devices. Unless you feel strongly about this, I'll probably leave it the
way it is.

>> +    }
>> +
>> +    mutex_unlock(&subsys->lock);
>> +    return 0;
>> +
>> +out_put_ctrl:
>> +    nvme_put_ctrl(ctrl);
>> +out_unlock:
>> +    mutex_unlock(&subsys->lock);
>> +    return ret;
>> +}
>> +
>> +static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
>> +{
>> +    if (subsys->passthru_ctrl) {
>> +        xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
>> +        nvme_put_ctrl(subsys->passthru_ctrl);
>> +    }
>> +    subsys->passthru_ctrl = NULL;
>> +    subsys->ver = NVMET_DEFAULT_VS;
>> +}
> 
> Isn't it strange that a subsystem changes its version in its lifetime?

It does seem strange. However, it's not at all unprecedented. See
nvmet_subsys_attr_version_store() which gives the user direct control of
the version through configfs.

>> +
>> +void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
>> +{
>> +    mutex_lock(&subsys->lock);
>> +    __nvmet_passthru_ctrl_disable(subsys);
>> +    mutex_unlock(&subsys->lock);
>> +}
>> +
>> +void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
>> +{
>> +    mutex_lock(&subsys->lock);
>> +    __nvmet_passthru_ctrl_disable(subsys);
>> +    kfree(subsys->passthru_ctrl_path);
>> +    mutex_unlock(&subsys->lock);
> 
> Nit, any reason why the free is in the mutex?

Nope. Will fix.
