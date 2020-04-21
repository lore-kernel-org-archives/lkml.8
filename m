Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060A7C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05092071C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nwQ42tRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgDUSBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:01:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57562 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDUSBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:01:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LHwabV118752;
        Tue, 21 Apr 2020 18:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=QGVtEOqCgBB+Nv3ETNm0ncvtWTeDNDelHZbNu+wNNYg=;
 b=nwQ42tRv1Wbt9K+XBtbw1IMUiEwtCbSLIhgOO8tqXver3yYbKYCa9BIXlA4BdRMZNgS4
 gaTBD3VsRhGEzhBaUW0Thax5QSSOdE+Yq9Os7BQ6swnpO/M5Eo2ZEja71mZvb2l5dl0b
 VkGSk7V5d5oBc+1sQGVKEf/8JhGZpjkNaA4oZhvR+uQHnzyJZZhT7/taqH0sFNnoJK9Q
 eVQuYFiepGMsiKTpdnd+m0/42ALhW0j3HEPX7tkIok5gpmrvrE8++eubDAV2IQq+Rzsb
 0oHBcZwy7vKam9hIYwe7/BSl6w0JdKXQZFF9gpAMIoyJKxuhHJoDiXR0foKcE05ZXxFT PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30fsgkxhjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 18:01:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LHuT3W140790;
        Tue, 21 Apr 2020 18:01:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30gbbeesen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 18:01:14 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03LI1BSF000995;
        Tue, 21 Apr 2020 18:01:12 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 11:01:11 -0700
Date:   Tue, 21 Apr 2020 21:01:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Denis Straghkov <d.straghkov@ispras.ru>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: rtw_wlan_util: Add size check of
 SSID IE
Message-ID: <20200421180102.GF2659@kadam>
References: <20200421170806.18783-1-d.straghkov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421170806.18783-1-d.straghkov@ispras.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=21 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=21 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 08:08:06PM +0300, Denis Straghkov wrote:
>  	/* checking SSID */
> +	ssid_len = 0;
>  	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _SSID_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
> -	if (!p) {
> -		DBG_871X("%s marc: cannot find SSID for survey event\n", __func__);
> -		hidden_ssid = true;
> -	} else {
> -		hidden_ssid = false;
> -	}
> -
> -	if ((NULL != p) && (false == hidden_ssid && (*(p + 1)))) {
> -		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
> -		bssid->Ssid.SsidLength = *(p + 1);
> -	} else {
> -		bssid->Ssid.SsidLength = 0;
> -		bssid->Ssid.Ssid[0] = '\0';
> -	}
> +        if (p) {
> +                ssid_len = *(p + 1);
> +                if (ssid_len > NDIS_802_11_LENGTH_SSID)
> +                        ssid_len = 0;
> +        }
> +        memcpy(bssid->Ssid.Ssid, (p + 2), ssid_len);
> +        bssid->Ssid.SsidLength = ssid_len;

This is using spaces instead of tabs.  Please run ./scripts/checkpatch.pl
on your patch.

regargs,
dan carpenter

