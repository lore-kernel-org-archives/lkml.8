Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6975C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBDE2078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eqs64c8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgDGOQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:16:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57974 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgDGOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:16:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037ED3vM172731;
        Tue, 7 Apr 2020 14:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=yK09YV7sHccZ+in/N/EnR8J9sdEjaYyJawI3sE50HS8=;
 b=Eqs64c8kq+8i/FiSWw/q+MCzbqzmXi52Nmfj3oTE7D9H7jPPRxsvTmN53Px4uiEdTG/Y
 EZT1ZMQNhAANBVqumbdqC0fYBs+NnI3MesiDvtQeWK/HJueP3dwK53jfA5C7bo1sDFXd
 oOznTTn2BzQLt4XKgtW3grdsq2lfrKnJcGpsLL6bR9bMTQdlfuMo7LQF0EhvqVj5IFdJ
 TJsFNLRe5tkWvoEsVPFZbO0bWbRSsBJyAaTof2LYyY8yeCWcxLOnzL4K0Zr2tOPQ10PU
 UTBczpNo3Bdm3jEoffqcCjqkD/27DifD4NM4vvchNzowuWqHSqlgTCmLP/OiQdnpnfc8 Lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 306jvn570u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 14:16:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037ECTPD066162;
        Tue, 7 Apr 2020 14:16:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30839tfuee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 14:16:29 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 037EGQHo007736;
        Tue, 7 Apr 2020 14:16:26 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 07:16:25 -0700
Date:   Tue, 7 Apr 2020 17:16:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     gregkh@linuxfoundation.org, puranjay12@gmail.com,
        robsonde@gmail.com, zhengbin13@huawei.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8192e: remove set but not used variable
 'tmpRegC'
Message-ID: <20200407141616.GL2001@kadam>
References: <1586262964-4582-1-git-send-email-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1586262964-4582-1-git-send-email-wanghai38@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 08:36:04AM -0400, Wang Hai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c: In function rtl92e_start_adapter:
> drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:693:15: warning: variable ‘tmpRegC’ set but not used [-Wunused-but-set-variable]
> 
> commit 94a799425eee ("rtl8192e: Split into two directories")
> involved this, remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index ddcd788..ff934ae 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -690,7 +690,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
>  	u8 tmpvalue;
>  	u8 ICVersion, SwitchingRegulatorOutput;
>  	bool bfirmwareok = true;
> -	u32 tmpRegA, tmpRegC, TempCCk;
> +	u32 tmpRegA, TempCCk;
>  	int i = 0;
>  	u32 retry_times = 0;
>  
> @@ -889,8 +889,8 @@ bool rtl92e_start_adapter(struct net_device *dev)
>  		if (priv->IC_Cut >= IC_VersionCut_D) {
>  			tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
>  						    bMaskDWord);
> -			tmpRegC = rtl92e_get_bb_reg(dev, rOFDM0_XCTxIQImbalance,
> -						    bMaskDWord);
> +			rtl92e_get_bb_reg(dev, rOFDM0_XCTxIQImbalance,
> +					  bMaskDWord);

Delete the call as well.

regards,
dan carpenter

