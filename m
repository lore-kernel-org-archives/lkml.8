Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CBFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8C62078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgIAQZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:25:19 -0400
Received: from gofer.mess.org ([88.97.38.141]:36619 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730027AbgIAQZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:25:14 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 7D41DC63F2; Tue,  1 Sep 2020 17:25:12 +0100 (BST)
Date:   Tue, 1 Sep 2020 17:25:12 +0100
From:   Sean Young <sean@mess.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jia-Ju Bai <baijiaju@tsinghua.edu.cn>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 016/125] media: pci: ttpci: av7110: fix possible
 buffer overflow caused by bad DMA value in debiirq()
Message-ID: <20200901162512.GA30837@gofer.mess.org>
References: <20200901150934.576210879@linuxfoundation.org>
 <20200901150935.368387062@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901150935.368387062@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

On Tue, Sep 01, 2020 at 05:09:31PM +0200, Greg Kroah-Hartman wrote:
> From: Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
> 
> [ Upstream commit 6499a0db9b0f1e903d52f8244eacc1d4be00eea2 ]
> 
> The value av7110->debi_virt is stored in DMA memory, and it is assigned
> to data, and thus data[0] can be modified at any time by malicious
> hardware. In this case, "if (data[0] < 2)" can be passed, but then
> data[0] can be changed into a large number, which may cause buffer
> overflow when the code "av7110->ci_slot[data[0]]" is used.
> 
> To fix this possible bug, data[0] is assigned to a local variable, which
> replaces the use of data[0].

See the discussion here:

https://lkml.org/lkml/2020/8/31/479

It does not seem worthwhile merging to the stable trees.

Thanks

Sean

> 
> Signed-off-by: Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
> Signed-off-by: Sean Young <sean@mess.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/media/pci/ttpci/av7110.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/pci/ttpci/av7110.c b/drivers/media/pci/ttpci/av7110.c
> index d6816effb8786..d02b5fd940c12 100644
> --- a/drivers/media/pci/ttpci/av7110.c
> +++ b/drivers/media/pci/ttpci/av7110.c
> @@ -424,14 +424,15 @@ static void debiirq(unsigned long cookie)
>  	case DATA_CI_GET:
>  	{
>  		u8 *data = av7110->debi_virt;
> +		u8 data_0 = data[0];
>  
> -		if ((data[0] < 2) && data[2] == 0xff) {
> +		if (data_0 < 2 && data[2] == 0xff) {
>  			int flags = 0;
>  			if (data[5] > 0)
>  				flags |= CA_CI_MODULE_PRESENT;
>  			if (data[5] > 5)
>  				flags |= CA_CI_MODULE_READY;
> -			av7110->ci_slot[data[0]].flags = flags;
> +			av7110->ci_slot[data_0].flags = flags;
>  		} else
>  			ci_get_data(&av7110->ci_rbuffer,
>  				    av7110->debi_virt,
> -- 
> 2.25.1
> 
> 
