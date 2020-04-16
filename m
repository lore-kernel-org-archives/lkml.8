Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAD6C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8A32051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406431AbgDPFYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:24:24 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:26137 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405910AbgDPFYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:24:20 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 771484E1CA0;
        Thu, 16 Apr 2020 13:23:00 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     christophe.leroy@c-s.fr
Cc:     gregkh@linuxfoundation.org, kernel@vivo.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, oss@buserror.net, wenhu.wang@vivo.com
Subject: Re: [PATCH v2,5/5] drivers: uio: new driver for fsl_85xx_cache_sram
Date:   Wed, 15 Apr 2020 22:22:47 -0700
Message-Id: <20200416052247.112887-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <37b6b890-e537-7424-6b26-04565681f40a@c-s.fr>
References: <37b6b890-e537-7424-6b26-04565681f40a@c-s.fr>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSlVCSEtCQkJCQk9JTExCTllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pkk6Fzo*Lzg6LAhNCUJNDEwS
        LSIaFCJVSlVKTkNMS0pPTkNJQ0NKVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQU9CTko3Bg++
X-HM-Tid: 0a718170ba219376kuws771484e1ca0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, kzalloc() would clean the allocated areas and the init of remaining array
elements are redundant. I will remove the block in v3.

>> > +		dev_err(&pdev->dev, "error no valid uio-map configured\n");
>> > +		ret = -EINVAL;
>> > +		goto err_info_free_internel;
>> > +	}
>> > +
>> > +	info->version = "0.1.0";
>> 
>> Could you define some DRIVER_VERSION in the top of the file next to 
>> DRIVER_NAME instead of hard coding in the middle on a function ?
>
>That's what v1 had, and Greg KH said to remove it.  I'm guessing that he
>thought it was the common-but-pointless practice of having the driver print a
>version number that never gets updated, rather than something the UIO API
>(unfortunately, compared to a feature query interface) expects.  That said,
>I'm not sure what the value is of making it a macro since it should only be
>used once, that use is self documenting, it isn't tunable, etc.  Though if
>this isn't a macro, UIO_NAME also shouldn't be (and if it is made a macro
>again, it should be UIO_VERSION, not DRIVER_VERSION).
>
>Does this really need a three-part version scheme?  What's wrong with a
>version of "1", to be changed to "2" in the hopefully-unlikely event that the
>userspace API changes?  Assuming UIO is used for this at all, which doesn't
>seem like a great fit to me.
>
>-Scott
>

As Scott mentioned, the version define as necessity by uio core but actually
useless for us here(and for many other type of devices I guess). So maybe the better
way is to set it optionally, but this belong first to uio core.

For the cache-sram uio driver, I will define an UIO_VERSION micro as a compromise
fit all wonders, no confusing as Greg first mentioned.

>> +static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
>> +	{	.compatible = "uio,fsl,p2020-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,p2010-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,p1020-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,p1011-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,p1013-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,p1022-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,mpc8548-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,mpc8544-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,mpc8572-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,mpc8536-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,p1021-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,p1012-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,p1025-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,p1016-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,p1024-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,p1015-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,p1010-l2-cache-controller",	},
>> +	{	.compatible = "uio,fsl,bsc9131-l2-cache-controller",	},
>> +	{},
>> +};
>
>NACK
>
>The device tree describes the hardware, not what driver you want to bind the
>hardware to, or how you want to allocate the resources.  And even if defining
>nodes for sram allocation were the right way to go, why do you have a separate
>compatible for each chip when you're just describing software configuration?
>
>Instead, have module parameters that take the sizes and alignments you'd like
>to allocate and expose to userspace.  Better still would be some sort of
>dynamic allocation (e.g. open a fd, ioctl to set the requested size/alignment,
>if it succeeds you can mmap it, and when the fd is closed the region is
>freed).
>
>-Scott
>

Can not agree more. But what if I want to define more than one cache-sram uio devices?
How about use the device tree for pseudo uio cache-sram driver?

static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
	{	.compatible = "uio,cache-sram",	},
	{},
};

Thanks,
Wenhu
