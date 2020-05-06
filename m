Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66850C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419922073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GD+ZwYjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgEFMy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:54:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43432 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgEFMyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:54:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046CrGOY135206;
        Wed, 6 May 2020 12:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Q//xXX00B7/TVN4RISX5EFMGkinEKz/HRr2Wvyujl/c=;
 b=GD+ZwYjbp6s/Z+yEPbCzG6NTjToFNXJDFZNfzKuTgxCjIl+lIdQZ6dR605AIRFt1M7ht
 zPSPAbGnT2q/xdC3ZQ7eaX2LIlpiPK67r55e5oxSNjQDyEDy8NwZ08JfZZcvWtXi008E
 ixM1Qt1cTWdFfYx14jts6pbS1ZAVsP6k+sHB0FX74/JsIwOFSsmTnPojL8FCwx0ek7Jw
 0PN4DQNN3Zfxs8sS6Zm9SnxlY/SDqGHa2p0TUQ+hZjlcJ+/MR1nDEkmdJzNlKHCOV1OJ
 QAGVEh4Ugp1lohxb9IWLBZHzlBICJ/AD45f/SkQ7dfh0Yv73iFHTvydYus1YXe8U6Pqe 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30usgq17y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 12:54:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046CqnPM088039;
        Wed, 6 May 2020 12:54:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30sjdvf6vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 12:54:10 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046Cs7LX015783;
        Wed, 6 May 2020 12:54:07 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 05:54:06 -0700
Date:   Wed, 6 May 2020 15:53:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     gregkh@linuxfoundation.org, simon@nikanor.nu, jeremy@azazel.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] staging: kpc2000: fix error return code in
 kp2000_pcie_probe()
Message-ID: <20200506125359.GK1992@kadam>
References: <20200506125255.90336-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506125255.90336-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 12:52:55PM +0000, Wei Yongjun wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function. Also
> removed var 'rv' since we can use 'err' instead.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/staging/kpc2000/kpc2000/core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
> index 7b00d7069e21..14e07742dc9d 100644
> --- a/drivers/staging/kpc2000/kpc2000/core.c
> +++ b/drivers/staging/kpc2000/kpc2000/core.c
> @@ -298,7 +298,6 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
>  {
>  	int err = 0;
>  	struct kp2000_device *pcard;
> -	int rv;
>  	unsigned long reg_bar_phys_addr;
>  	unsigned long reg_bar_phys_len;
>  	unsigned long dma_bar_phys_addr;
> @@ -445,11 +444,11 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
>  	if (err < 0)
>  		goto err_release_dma;
>  
> -	rv = request_irq(pcard->pdev->irq, kp2000_irq_handler, IRQF_SHARED,
> +	err = request_irq(pcard->pdev->irq, kp2000_irq_handler, IRQF_SHARED,
>  			 pcard->name, pcard);
                        ^
Could you add a space character here so the white space still aligns?

Otherwise it looks good.  :)

regards,
dan carpenter

