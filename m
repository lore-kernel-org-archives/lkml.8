Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A652FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E875206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LD4bUD3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgFROkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:40:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44184 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgFROkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:40:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IELV97133534;
        Thu, 18 Jun 2020 14:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=1ZpJX6R0cMOtPIBKgE1kLh0zQgcs3Eeo8C6fWzqosYI=;
 b=LD4bUD3VAYbIkhvI4GkWxNtjQiR7E/RxcF1c4a179UowF05CDqq4i9QsZQAxuys+99Nw
 +Kachflg1BWm604f43Mz7KC744CDGmGkIf8le98NfQbWCnBKgQH8rqckpMCr8zQHOpM1
 oNKsA8d5eduw28xzzvTJHmqVQaprb24TJmBcFfKvOkLdapw23WYLQNfGJcDg78Q6Huas
 065o6OlUT74h/q1laXpW+QeNAGhMFJHT5fJpwL3IFJIS3DHMcvZoZHpA1PffG+OMU1Og
 8O6q4ofivvc5InasAtOFRvmAv1l3Cuk+KYkCe9xUS6Roy3ttRUEhEG2tgzRN0N6fXedN Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31qg357jjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Jun 2020 14:40:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IEYRS9030582;
        Thu, 18 Jun 2020 14:40:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31q66b1568-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 14:40:18 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05IEeHmZ025858;
        Thu, 18 Jun 2020 14:40:17 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jun 2020 07:40:17 -0700
Date:   Thu, 18 Jun 2020 17:40:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shihab Rashed <shihab.rashed97@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: ioctl_cfg80211: fixed code
 styl issues
Message-ID: <20200618144009.GT4151@kadam>
References: <20200618141002.18895-1-shihab.rashed97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618141002.18895-1-shihab.rashed97@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0
 cotscore=-2147483648 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 04:10:02PM +0200, Shihab Rashed wrote:
> Fixed two brace coding style issues and one comment style issue found by
> checkpatch.
> 
> Signed-off-by: Shihab Rashed <shihab.rashed97@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 2fb80b6eb51d..3b06b60cdfd1 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -117,15 +117,12 @@ static struct ieee80211_supported_band *rtw_spt_band_alloc(
>  	struct ieee80211_supported_band *spt_band = NULL;
>  	int n_channels, n_bitrates;
>  
> -	if (band == NL80211_BAND_2GHZ)
> -	{
> +	if (band == NL80211_BAND_2GHZ)	{
                                      ^^
too many spaces.

>  		n_channels = RTW_2G_CHANNELS_NUM;
>  		n_bitrates = RTW_G_RATES_NUM;
> -	}
> -	else
> -	{
> +	} else	{
              ^^
too many spaces.

>  		goto exit;
> -	}
> +		}
                ^
Indented too far.

>  
>  	spt_band = rtw_zmalloc(sizeof(struct ieee80211_supported_band) +
>  			       sizeof(struct ieee80211_channel) * n_channels +


regards,
dan carpenter
