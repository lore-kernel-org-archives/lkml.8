Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0DBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FCD22B47
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgH0Glf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:41:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbgH0Gle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:41:34 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 66EA699BB0E985A9E51E;
        Thu, 27 Aug 2020 14:41:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 14:41:28 +0800
Subject: Re: [PATCH 3/4] libnvdimm: eliminate two unnecessary zero
 initializations in badrange.c
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200820143027.3241-1-thunder.leizhen@huawei.com>
 <20200820143027.3241-4-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <962dd111-ceb3-36de-86d9-817e0e0a6e45@huawei.com>
Date:   Thu, 27 Aug 2020 14:41:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200820143027.3241-4-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will drop this patch, because badrange_add() is unlikely to be called.
There's no need to care about trivial performance improvements.

On 2020/8/20 22:30, Zhen Lei wrote:
> Currently, the "struct badrange_entry" has three members: start, length,
> list. In append_badrange_entry(), "start" and "length" will be assigned
> later, and "list" does not need to be initialized before calling
> list_add_tail(). That means, the kzalloc() in badrange_add() or
> alloc_and_append_badrange_entry() can be replaced with kmalloc(), because
> the zero initialization is not required.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/nvdimm/badrange.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
> index 7f78b659057902d..13145001c52ff39 100644
> --- a/drivers/nvdimm/badrange.c
> +++ b/drivers/nvdimm/badrange.c
> @@ -37,7 +37,7 @@ static int alloc_and_append_badrange_entry(struct badrange *badrange,
>  {
>  	struct badrange_entry *bre;
>  
> -	bre = kzalloc(sizeof(*bre), flags);
> +	bre = kmalloc(sizeof(*bre), flags);
>  	if (!bre)
>  		return -ENOMEM;
>  
> @@ -49,7 +49,7 @@ int badrange_add(struct badrange *badrange, u64 addr, u64 length)
>  {
>  	struct badrange_entry *bre, *bre_new;
>  
> -	bre_new = kzalloc(sizeof(*bre_new), GFP_KERNEL);
> +	bre_new = kmalloc(sizeof(*bre_new), GFP_KERNEL);
>  
>  	spin_lock(&badrange->lock);
>  
> 

