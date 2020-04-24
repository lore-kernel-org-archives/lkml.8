Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCA6C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5C820736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oKq8GXHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgDXNB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:01:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59570 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgDXNB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:01:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OCqlFw193994;
        Fri, 24 Apr 2020 13:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=FL8oOyNRXvYuWU+VLpC8MgYgzxS8aUTEYyMPQQVQSX4=;
 b=oKq8GXHJvR1WJkWK5fh72eg4nyaUKTMcTZnA95TsOiVoJZgHUVuf6dN8cvDNEJ9RUc+d
 8iq7pn41GoD7TLSLVxnHVs71iypvZacy/pl02SQQnyTxaZIWbdPkH49w3hsWUIQzBF6L
 4UAq+/j4UNceWxGbgx3kXHztao2tM9OB5oEkppTeGqCufJYt6zQC6/ZQ+7DWEKfbiH24
 QRWPJf+HqU5iCext9ovKzQ9L48fnI5kfj+SEI3O7mc2Pz46MOfrjU++RBXwmY7XyTxAX
 Zlf9/HHwDMFEb2bMwuO13AHlEgrF6aYiaFQ6wCEnGarN5lXVcLToqfQFpcxUQ186anFm og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30ketdm7fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 13:01:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OCvkIf068191;
        Fri, 24 Apr 2020 12:59:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30gb3xbvtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 12:59:53 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03OCxqof028966;
        Fri, 24 Apr 2020 12:59:52 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Apr 2020 05:59:51 -0700
Date:   Fri, 24 Apr 2020 15:59:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wfx: cleanup long lines in data_tx.c
Message-ID: <20200424125945.GP2659@kadam>
References: <20200424124105.GA18534@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424124105.GA18534@blackclown>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 06:11:32PM +0530, Suraj Upadhyay wrote:
>  static int wfx_get_hw_rate(struct wfx_dev *wdev,
>  			   const struct ieee80211_tx_rate *rate)
>  {
> +	struct ieee80211_rate tmp;
>  	if (rate->idx < 0)
>  		return -1;
>  	if (rate->flags & IEEE80211_TX_RC_MCS) {
> @@ -31,7 +32,8 @@ static int wfx_get_hw_rate(struct wfx_dev *wdev,
>  	}
>  	// WFx only support 2GHz, else band information should be retrieved
>  	// from ieee80211_tx_info
> -	return wdev->hw->wiphy->bands[NL80211_BAND_2GHZ]->bitrates[rate->idx].hw_value;
> +	tmp = wdev->hw->wiphy->bands[NL80211_BAND_2GHZ]->bitrates[rate->idx];
> +	return tmp.hw_value;

The original was better.  Just leave this one as-is.  It's okay to go
over 80 characters if there isn't a better option.

>  }
>  
>  /* TX policy cache implementation */
> @@ -159,14 +161,16 @@ static int wfx_tx_policy_upload(struct wfx_vif *wvif)
>  {
>  	struct tx_policy *policies = wvif->tx_policy_cache.cache;
>  	u8 tmp_rates[12];
> -	int i;
> +	int i, tmp;
>  
>  	do {
>  		spin_lock_bh(&wvif->tx_policy_cache.lock);
> -		for (i = 0; i < HIF_TX_RETRY_POLICY_MAX; ++i)
> -			if (!policies[i].uploaded &&
> -			    memzcmp(policies[i].rates, sizeof(policies[i].rates)))
> +		for (i = 0; i < HIF_TX_RETRY_POLICY_MAX; ++i) {
> +			tmp = memzcmp(policies[i].rates,
> +				      sizeof(policies[i].rates));
> +			if (!policies[i].uploaded && tmp)
>  				break;

The original was better.  I was hoping you would do:

			struct tx_policy *policy = &policies[i];

			if (!policy->uploaded &&
			    memzcmp(policy->rates, sizeof(policies->rates))
				break;


> +		}
>  		if (i < HIF_TX_RETRY_POLICY_MAX) {
>  			policies[i].uploaded = true;
>  			memcpy(tmp_rates, policies[i].rates, sizeof(tmp_rates));

regards,
dan carpenter

