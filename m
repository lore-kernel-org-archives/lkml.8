Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFCAC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB863207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CfJCRY58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgEHIvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:51:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40282 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgEHIvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:51:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0488lwp9066596;
        Fri, 8 May 2020 08:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=AWbUZitwGxqH5XK2qvZBSe3apYjT0vdFp0iz/vgH32U=;
 b=CfJCRY58BEkHUdPT/WP0qB2DDdtV9oL9tJgua2Nrve3zL7CeCCGIkB8bf6rgWPVJCMCK
 Bhremhku2blJuXF9HLzZiwMTDymIx2sdfVnv/3eWgQBt58FpfWaTo8IUhPbg6m6N+pLJ
 ySRUeCZ9+cmmB5XR2ffYj+6m0fnechdYXG4Q2M/33cYed0RRy6L9zmHzzz5AyXDGNJdV
 m4JBzXnEd6SarXecfCIbvoHbKPeUPdl2YHNEjlpeSDLQ/uxT9OoKY9ciD0mHtBb+eHAG
 uIUdqD6wxtmVInUp0YRTEoQat0UvK7lhMubaWdCEgRyTgTzR9b61hpwg/Nrp29v5QLBE iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30vtexsucp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 08:51:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0488kgWO163200;
        Fri, 8 May 2020 08:49:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30vteg9pxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 08:49:49 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0488nmOY027677;
        Fri, 8 May 2020 08:49:48 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 May 2020 01:49:47 -0700
Date:   Fri, 8 May 2020 11:49:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] memory: tegra: Fix an error handling path in
 'tegra186_emc_probe()'
Message-ID: <20200508084941.GE9365@kadam>
References: <20200506200907.195502-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506200907.195502-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 10:09:07PM +0200, Christophe JAILLET wrote:
> @@ -237,7 +239,7 @@ static int tegra186_emc_probe(struct platform_device *pdev)
>  			"failed to set rate range [%lu-%lu] for %pC\n",
>  			emc->debugfs.min_rate, emc->debugfs.max_rate,
>  			emc->clk);
> -		return err;
> +		goto err_put_bpmp;
>  	}
>  
>  	emc->debugfs.root = debugfs_create_dir("emc", NULL);

Not really related to this patch but the error handling on this
debugfs_create_dir() call is wrong.  It never returns NULL.  The error
should just be ignored.  It shouldn't try print a message when debugfs
is deliberately disabled.

As in the correct code looks like:

 
        emc->debugfs.root = debugfs_create_dir("emc", NULL);
-       if (!emc->debugfs.root) {
-               dev_err(&pdev->dev, "failed to create debugfs directory\n");
-               return 0;
-       }
-
        debugfs_create_file("available_rates", S_IRUGO, emc->debugfs.root,
                            emc, &tegra186_emc_debug_available_rates_fops);
        debugfs_create_file("min_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,

debugfs_create_file() will return an error pointer if debugfs_create_dir()
fails or if debugfs is disabled.  (It is a no-op).

regards,
dan carpenter

