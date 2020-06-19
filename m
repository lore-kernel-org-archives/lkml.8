Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBB2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0382F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="f8JUjkyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbgFSTLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:11:01 -0400
Received: from ale.deltatee.com ([207.54.116.67]:50514 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbgFSTLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4cCwLXspapwlO5JNmpzGtEIMUrgS31d34ZsxIrdWjzQ=; b=f8JUjkyUOjpdYWcU3wOwZKLeVq
        YcRssBikeytE4vec/F6hXZ+2pruDoL2NyiGM4PZwFUHMoJ0kc4WBynnqrSWxjA7skUAHqnXgGTAIV
        q9vEt8UyzqkU6nXbbkguKZGnCu1owdHmsalTqXt04/Ztz0pvmCC3NV9gAouJe/NSW+7OvIRKJlTwF
        pSgq29h2f3lyLyMB/uYFsP5AX/oODtSXnbaXmEHTd4iunWw0WBJK7LdbpE08/uEy0m1dn+hhCbX1W
        UVWabBiLrNkKNzDcKO4Tllpcd4onCHVHxKFUbicbhdQIkGCHxo1JgGhsaKBE1Uk5WpBWh/0+MUksh
        RYVIMp7g==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jmMPh-00061F-Je; Fri, 19 Jun 2020 13:10:58 -0600
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20200619172514.GA1074@embeddedor>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <268330b2-e42b-4d62-1ff0-8462d68e498e@deltatee.com>
Date:   Fri, 19 Jun 2020 13:10:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619172514.GA1074@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: gustavo@embeddedor.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, gustavoars@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH][next] NTB: Use struct_size() helper in devm_kzalloc()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-06-19 11:25 a.m., Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes. Also, remove unnecessary
> variable _struct_size_.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Cool, I didn't know that existed! Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/ntb/test/ntb_msi_test.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
> index 99d826ed9c34..7095ecd6223a 100644
> --- a/drivers/ntb/test/ntb_msi_test.c
> +++ b/drivers/ntb/test/ntb_msi_test.c
> @@ -319,7 +319,6 @@ static void ntb_msit_remove_dbgfs(struct ntb_msit_ctx *nm)
>  static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
>  {
>  	struct ntb_msit_ctx *nm;
> -	size_t struct_size;
>  	int peers;
>  	int ret;
>  
> @@ -352,9 +351,7 @@ static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
>  		return ret;
>  	}
>  
> -	struct_size = sizeof(*nm) + sizeof(*nm->peers) * peers;
> -
> -	nm = devm_kzalloc(&ntb->dev, struct_size, GFP_KERNEL);
> +	nm = devm_kzalloc(&ntb->dev, struct_size(nm, peers, peers), GFP_KERNEL);
>  	if (!nm)
>  		return -ENOMEM;
>  
> 
