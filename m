Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668DCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34BC42054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yn+OBNG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgHKKUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:20:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49070 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgHKKUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:20:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BACeE2145102;
        Tue, 11 Aug 2020 10:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=HcDjjzqVyfcUJIc+LnJzTj0NlEAoMZO5Bzk9COQkEZM=;
 b=Yn+OBNG0P5mri8dkG+3CJNa9a7w3c9TXSS7Lx80OX1yyrbv+jMnXC1qBb2qgZomou2AU
 PksfGFHLbackgq++paNuGqKsXgdEF+ek1rZZLEzu0Z6KsyPXEC3GyzKtJZXqpL8jDMvT
 hqk4tvzWI7hdXErtss6vbfDAMc6QxwDWmRsqZOadzZrb68S8DzaHMC1h6RibhC2TEjdA
 jRvzSVuhZUUrvfNN+aS4yC2moqs7pnrRDR4tH1d7d8UO2UdIHBNg4J3BKIwla1WuoCiB
 nbQOxJ/BqfqGMYhLSp3QpMNLAV5Q5lp+smm2SO8zK3uVDmuMfy9Q1O7/u2OCvA2reMD0 dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32smpnbr9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Aug 2020 10:19:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BACRU3160982;
        Tue, 11 Aug 2020 10:17:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32t5yyeb7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 10:17:58 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07BAHtfH023548;
        Tue, 11 Aug 2020 10:17:56 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Aug 2020 10:17:55 +0000
Date:   Tue, 11 Aug 2020 13:17:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
        longman@redhat.com, akpm@linux-foundation.org, mhocko@suse.com,
        hannes@cmpxchg.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ks7010: Do not use GFP_KERNEL in atomic context
Message-ID: <20200811101746.GN1793@kadam>
References: <20200809111846.745826-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809111846.745826-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1011 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 01:18:46PM +0200, Christophe JAILLET wrote:
> A possible call chain is as follow:
>   ks_wlan_start_xmit                    (ks_wlan_net.c)
>     --> hostif_data_request             (ks_hostif.c)
>       --> michael_mic                   (ks_hostif.c)
> 
> 'ks_wlan_start_xmit()' is a '.ndo_start_xmit()' function (see
> net_device_ops structure). Such calls are guarded by the __netif_tx_lock
> spinlock. So memory allocation must be atomic.
> 
> So, use GFP_ATOMIC instead of GFP_KERNEL 'in michael_mic()'
> 
> Fixes: ???
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This is completely speculative. I don't know if the call chain given above
> if possible in RL application.
> So review carefully :)
> 
> If the fix is correct, it is also more the starting point of a bigger
> change, because in 'michael_mic()' there is a call to
> 'crypto_alloc_shash()' and this function uses GFP_KERNEL internally (in
> 'crypto_create_tfm()')
> Should this need to be changed, I don't know how 'ks_hostif.c' should be
> fixed. Changing allocation in 'crypto/api.c' looks like an overkill.
> 
> In other word, I think that my patch is wrong, but don't know what else to
> propose :).

Your patch is correct but you're also right that it's incomplete.

If you look at drivers/staging/rtl8192e/rtllib_crypt_tkip.c then they
declare the shash on stack instead of using crypto_alloc_shash().
	SHASH_DESC_ON_STACK(desc, tfm_michael);

That's probably what we should do here as well.  Although I don't know
this code very well at all...  This is probably the sort of change where
it would be good to have someone test it.

regards,
dan carpenter

