Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36DFC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06B7206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z59B/qFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgDTMNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:13:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36580 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgDTMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:13:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KBqb1C187946;
        Mon, 20 Apr 2020 12:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=C7+fcI4KZiXfIWW4U2ZyjNo5atQa1VYMh+jlIP/eLqg=;
 b=Z59B/qFcgrXjwvapB0YXbiA1Yn0eCWArZonLrcdXNPnDLJa4sqvAVyR2SbBaH1kGvhYk
 zwbnoQik+OQRLeMkkIe3SEN/kOyPZ20qakX+GJwVD7ijsa9XhYQFdjKECQVPr3/yoVWu
 51CF0obZjwaJqyqmNbi1yAKIlCW7+0LH7cZjMhacR8s2H3wSBXZguHdmhO5yo3Yml63f
 6NAZtVI7Xe5EJpDzxwOn5hU66Kp/KaLQRVp22BLvw/P4PZol1Yv01X1pmZJsy2gndTJ1
 IW+QqlTWpD5rPvaff3Qiz2T1bxO6IFZsXdS6VpFgN+U6UBjXZjgjVUKpRzO0Pmu60KWW Sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30ft6mxrnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 12:13:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KC8Io9102341;
        Mon, 20 Apr 2020 12:11:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30gb1d2r19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 12:11:15 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03KCB9nC001397;
        Mon, 20 Apr 2020 12:11:12 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Apr 2020 05:11:09 -0700
Date:   Mon, 20 Apr 2020 15:10:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        "John B . Wyatt IV" <jbwyatt4@gmail.com>,
        linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: vt6656: Use fls instead of for loop in
 vnt_update_top_rates
Message-ID: <20200420121059.GC2659@kadam>
References: <20200419100921.5421-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419100921.5421-1-oscar.carter@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9596 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=849 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9596 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxlogscore=914 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 12:09:21PM +0200, Oscar Carter wrote:
> -	for (i = RATE_11M;; i--) {
> -		if (priv->basic_rates & (u16)(1 << i)) {
> -			top_cck = i;
> -			break;
> -		}
> -		if (i == RATE_1M)
> -			break;
> -	}
> +	pos = fls(priv->basic_rates & GENMASK(RATE_54M, RATE_6M));
> +	priv->top_ofdm_basic_rate = pos ? pos-- : RATE_24M;
                                          ^^^^^
Argh...  Come on.  I don't want to have to break out the C standard to
see if this is defined behavior and where the sequence points are.  A
pre-op would be clear but the most clear thing is to write it like this:

	priv->top_ofdm_basic_rate = pos ? (pos - 1) : RATE_24M;


> 
> -	priv->top_cck_basic_rate = top_cck;
> +	pos = fls(priv->basic_rates & GENMASK(RATE_11M, RATE_1M));
> +	priv->top_cck_basic_rate = pos ? pos-- : RATE_1M;
                                         ^^^^^
Same.

regards,
dan carpenter

