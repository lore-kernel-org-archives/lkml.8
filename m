Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5B7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6788A2077D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="dSNDq5fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgGMKB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:01:59 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:34455 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728950AbgGMKB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:01:58 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id uvHTj6d52GLmCuvHXjAusU; Mon, 13 Jul 2020 12:01:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1594634516; bh=Qvmhkqy8a9fuPe1CeKmBjQ4cwdl+ZofLMoa2K+Ph6Jw=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=dSNDq5fq0noaKLmUIOxNZXt4OQrZfN0Rr0TxTQIi+DVUwGWLEPXyfct+USQuhYe1J
         DSU9NMQMNd44ekjlUOtNHvDkj3N75EQkV0dK0eB9JN2V2AXm1m+YPrGj8aBtSKz2yI
         55RCKsNFrn97ONJ1k76E1/bbH1ApaSHnX/yltJDGwIL4VLMJhi58SzX8Hqwn0ouEFi
         JiNhxgjcY4vpdT8wfxzhE9cJWat75KjROnvAMMXW02pxqDWo1lVmnjy0VO3268g4iQ
         +2rYLjhuBIkgsXoGkvn3msJJw7tErLsrk4RSQ6yeosChTXWsDXn6Lz19AL43Rj/FB1
         bA1zduNYFQnXw==
Subject: Re: [PATCH v1 2/6] [media] cx23885: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
References: <20200629073604.205478-1-vaibhavgupta40@gmail.com>
 <20200629073604.205478-3-vaibhavgupta40@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <c4a46846-208f-c834-56d7-02543c395795@xs4all.nl>
Date:   Mon, 13 Jul 2020 12:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200629073604.205478-3-vaibhavgupta40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEgDG4469ro2DKZtOFm+RMAiztJsuP9cXotS0TmKFGSp+9SgAmFhYVWhxx8yl1HV3fhJ0MUp67jAVE65zOxo52NzY9xIlIT4UHuJ5eIKrEQOM4LDUySb
 NgT01kC82efUbFUt0D2pfcDAlO7NOj0g1HAx5eODA2118fHYGLTjGvV65hvujMh1Kz/ZBgGV1FJERCgwknLrHWRkb68/0KqJkSjmLUSh8rlupLyIlpXI1sxL
 pttMKR+pabmKYUydmGw3JtBPaxZv1SXfsUcriO17OD3CRQIt17Ib15JgVW/GXbPYpnYofun0Y0Fv1JCXIKXN+d4QGY8N/y07yAUMW9B5Sz3PwiFf+8X+Aloc
 pSF3EBCnXi4bNNx+oG6C1AoUys5Tvw1Vtm1qy0OWsP3+AuOUISE5qP0/Dt/BXyILhVLlgj/HAywqgLGUhCxJkcfkE1zx+YW9DITON62v++oNDWzT4xUlHbxO
 vjB81y8ZqBQaG2D4Dz4+/X/8JASOUyBBLQwR0MF2PnoBAZ/hlQKxyCKT0ok=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2020 09:36, Vaibhav Gupta wrote:
> The .suspend() and .resume() callbacks are not defined for this driver.
> Still, their power managemgement stucture can be easily upgraded to

management structure

> gemeric, without affecting its normal behaviour.

generic

> 
> Hence, define them NULL and use struct dev_pm_ops type to bind them.
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/media/pci/cx23885/cx23885-core.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/pci/cx23885/cx23885-core.c b/drivers/media/pci/cx23885/cx23885-core.c
> index 7e0b0b7cc2a3..da9ee7270dfd 100644
> --- a/drivers/media/pci/cx23885/cx23885-core.c
> +++ b/drivers/media/pci/cx23885/cx23885-core.c
> @@ -2230,14 +2230,18 @@ static const struct pci_device_id cx23885_pci_tbl[] = {
>  };
>  MODULE_DEVICE_TABLE(pci, cx23885_pci_tbl);
>  
> +#define cx23885_suspend NULL
> +#define cx23885_resume NULL
> +
> +static SIMPLE_DEV_PM_OPS(cx23885_pm_ops, cx23885_suspend, cx23885_resume);
> +
>  static struct pci_driver cx23885_pci_driver = {
> -	.name     = "cx23885",
> -	.id_table = cx23885_pci_tbl,
> -	.probe    = cx23885_initdev,
> -	.remove   = cx23885_finidev,
> +	.name      = "cx23885",
> +	.id_table  = cx23885_pci_tbl,
> +	.probe     = cx23885_initdev,
> +	.remove    = cx23885_finidev,
>  	/* TODO */
> -	.suspend  = NULL,
> -	.resume   = NULL,
> +	.driver.pm = &cx23885_pm_ops,

I don't entirely understand this. Wouldn't it be sufficient to just
drop the .suspend/.resume assignments here? It is now required for
driver.pm to be non-NULL?

I'm not up to speed on the changes, but normally you can leave things
NULL if you don't support a feature (PM in this case).

Regards,

	Hans

>  };
>  
>  static int __init cx23885_init(void)
> 

