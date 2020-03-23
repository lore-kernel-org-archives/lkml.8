Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0EEC10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D1B20658
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XROB+1by"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgCWHce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:32:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38956 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgCWHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 03:32:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02N7T93m149295;
        Mon, 23 Mar 2020 07:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=SbyAzLPTSfg0LERazBvqTCZWVy8onnfoA8sEWerOK98=;
 b=XROB+1byvVNOsA410SlC+1cU3oogToJggiJEjTfCloTD3iICXpkSjJKEYSsVBktY0Bov
 FZwOrpbr94XRYVhMvZXs2YQUu9p3IbuPdmjCgAjbTDjEeMK/tyu0Uzt4+O6RLYKCGRMQ
 Lg0BlkBisu+moTeCIbvrQdDdRcziy5MDxbaBU3ZQxkiGagi4lgLSh1xH4TevBPHwuLxi
 k2SNQQl7E4XpFY8eqcpoyPkeTtruw59p2c3mg2xBfe/C6ct2hMvsMJU42sJPEVgkq9Q3
 IdWSDaLL3jQPPV8VSYEkVKcN44v++vl4QcvfVClWHpZzaA+IABhNlm+iAkJ3iDWUg/Xb Dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ywavkvwxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 07:32:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02N7RuC2060891;
        Mon, 23 Mar 2020 07:32:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ywvqqcvrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 07:32:24 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02N7WMjP020978;
        Mon, 23 Mar 2020 07:32:22 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 00:32:22 -0700
Date:   Mon, 23 Mar 2020 10:32:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: vt6656: Use BIT() macro in vnt_mac_reg_bits_*
 functions
Message-ID: <20200323073214.GJ4650@kadam>
References: <20200320181326.12156-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320181326.12156-1-oscar.carter@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230044
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 07:13:26PM +0100, Oscar Carter wrote:
> +#include <linux/bits.h>
>  #include "mac.h"
>  #include "baseband.h"
>  #include "rf.h"
> @@ -468,7 +469,7 @@ int vnt_vt3184_init(struct vnt_private *priv)
>  		if (ret)
>  			goto end;
> 
> -		ret = vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, 0x01);
> +		ret = vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, BIT(0));

Everyone knows 0x01 is bit(0) already.  This isn't more clear.  It
should be a define instead of a magic number.

> @@ -63,7 +64,8 @@ void vnt_set_channel(struct vnt_private *priv, u32 connection_channel)
>  	vnt_mac_reg_bits_on(priv, MAC_REG_MACCR, MACCR_CLRNAV);
> 
>  	/* Set Channel[7] = 0 to tell H/W channel is changing now. */
> -	vnt_mac_reg_bits_off(priv, MAC_REG_CHANNEL, 0xb0);
> +	vnt_mac_reg_bits_off(priv, MAC_REG_CHANNEL,
> +			     (BIT(7) | BIT(5) | BIT(4)));

This one especially is just a lot longer now but still not clear.

regards,
dan carpenter

