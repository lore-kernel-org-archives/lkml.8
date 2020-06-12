Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DC2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4158720835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fXqC4B0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgFLRnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:43:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLRna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:43:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CHh2GJ020379;
        Fri, 12 Jun 2020 17:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2HKjUnGV9l2/3QVc26ktJ2ExXTSwqCntl/WmJ1OPOAQ=;
 b=fXqC4B0F+31nHBQIiZF+Z3dZz1mibIBrsYxtQYnmOBtyhHSByIk1gtSrX49sCiOT1JCL
 Ogdcu5diqaCUuroGDBcmKJ+Hb5HjTPcD04iE0ZHByMvJ93TKgM5nWdtfWndOiWmdZ9LH
 AEUuUKs+TxMhDQQTwfl0BLWwClJhFEitOxEpqHn/JvafAwBULdaVWDW5sv92kIPhBnrh
 TBx67TII8Y6UQSEr0350crJLwIeDOtn7eDy+otQeKJ97vXJ8n+1ZR97gPi1lqk2dHK1D
 qJS1wEthJkadjfDQJUdHqfzTW34Vo9NG+YdCnu4Jo1g5Xu5+hpMSGb5BifYUAwQo3U44 Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31jepp7xsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 17:43:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CHglGs132320;
        Fri, 12 Jun 2020 17:43:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31mebng3cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 17:43:17 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05CHgNna012115;
        Fri, 12 Jun 2020 17:42:23 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 10:42:22 -0700
Date:   Fri, 12 Jun 2020 20:42:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] coresight: cti: Fix error handling in probe
Message-ID: <20200612174215.GI4282@kadam>
References: <20200612121047.GF4282@kadam>
 <20200612121133.GA1139533@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612121133.GA1139533@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 03:11:33PM +0300, Dan Carpenter wrote:
> +static int cti_pm_setup(struct cti_drvdata *drvdata)
> +{
> +	int ret;
> +
> +	if (drvdata->ctidev.cpu == -1)
> +		return 0;
> +
> +	if (nr_cti_cpu)
> +		goto done;
> +
> +	cpus_read_lock();
        ^^^^^^^^^^^^^^^^
One thing which I do wonder is why we have locking here but not in the
cti_pm_release() function.  That was how the original code was so the
patch doesn't change anything, but I am curious.

> +	ret = cpuhp_setup_state_nocalls_cpuslocked(
> +			CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
> +			"arm/coresight_cti:starting",
> +			cti_starting_cpu, cti_dying_cpu);
> +	if (ret) {
> +		cpus_read_unlock();
> +		return ret;
> +	}
> +
> +	ret = cpu_pm_register_notifier(&cti_cpu_pm_nb);
> +	cpus_read_unlock();
> +	if (ret) {
> +		cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
> +		return ret;
> +	}
> +
> +done:
> +	nr_cti_cpu++;
> +	cti_cpu_drvdata[drvdata->ctidev.cpu] = drvdata;
> +
> +	return 0;
> +}
> +
>  /* release PM registrations */
>  static void cti_pm_release(struct cti_drvdata *drvdata)
>  {
> -	if (drvdata->ctidev.cpu >= 0) {
> -		if (--nr_cti_cpu == 0) {
> -			cpu_pm_unregister_notifier(&cti_cpu_pm_nb);
> +	if (drvdata->ctidev.cpu == -1)
> +		return;
>  
> -			cpuhp_remove_state_nocalls(
> -				CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
> -		}
> -		cti_cpu_drvdata[drvdata->ctidev.cpu] = NULL;
> +	cti_cpu_drvdata[drvdata->ctidev.cpu] = drvdata;
> +	if (--nr_cti_cpu == 0) {
> +		cpu_pm_unregister_notifier(&cti_cpu_pm_nb);
> +		cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
>  	}
>  }

regards,
dan carpenter

