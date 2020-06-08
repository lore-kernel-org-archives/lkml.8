Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18643C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22882064C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YmNcypAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgFHH2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:28:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43916 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgFHH2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:28:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0587SGFU006604;
        Mon, 8 Jun 2020 07:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=iFFUWrJmQAMs+azOlyv2mkVbVKIPtj2LzUbOvvjmz4o=;
 b=YmNcypAZfmglnw+NsFR4ekBO8PSvVbRjinKDt5afAhHX+AYpUMbmqOKMblkXMhJ0r0D3
 o1XR1Agx+pG1e4AZki5CDt0ycPZi8VjBrkACy2kez6/6oXlmwMU8xErjcPBo8zg6ishE
 wOMV6n+bXcCIB+oLorEvbW6i+KQkkCifPUkAXVnJmEjV93JsQS+6EtyGnO3BJyAtQBew
 iPAkAXOuUciE7vV9vkLsgqb45+FqxGmzW9wzOM9gH0MNpV93k6WFaTPkE3VJpMQISQi5
 iXT035CD16vJy7jb68gEZTXHQw0rKHFfWzlAJSOLqcWjvbY0NtfMIN2VKfj2mU2RMogd qA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31g2jqwa4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 07:28:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0587LjiN010869;
        Mon, 8 Jun 2020 07:26:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31gmwpj6sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 07:26:33 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0587QWeV000572;
        Mon, 8 Jun 2020 07:26:32 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 00:26:31 -0700
Date:   Mon, 8 Jun 2020 10:26:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Rodolfo C. Villordo" <rodolfovillordo@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Forest Bond <forest@alittletooquiet.net>,Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,devel@driverdev.osuosl.org,linux-kernel@vger.kernel.org
Message-ID: <20200608072625.GV30374@kadam>
References: <20200607224156.GA24090@ip-172-31-24-31.ec2.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607224156.GA24090@ip-172-31-24-31.ec2.internal>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 10:41:56PM +0000, Rodolfo C. Villordo wrote:
>  	/* RTSRrvTime */
> -	uRrvTime = uRTSTime + uCTSTime + uAckTime + uDataTime + 3 * pDevice->uSIFS;
> +	uRrvTime = uRTSTime + uCTSTime + uAckTime + uDataTime
> +			+ 3 * pDevice->uSIFS;

The + character should go on the first line:

	uRrvTime = uRTSTime + uCTSTime + uAckTime + uDataTime +
		   3 * pDevice->uSIFS;

The second line should be indented with:

[tab][tab][space][space][space]3 * pDevice->uSIFS;

Same rules apply everywhere.  I'm not going to comment on every line.

>  	case RTSDUR_BA_F0: /* RTSDuration_ba_f0 */
> -		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
> -		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
> +		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType,
> +					     14, pDevice->byTopCCKBasicRate);
> +		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) &&
> +		    (wRate <= RATE_54M))


Here it's awkward to break the two wRate conditions across multiple
lines.  It's better to write:

		if ((byFBOption == AUTO_FB_0) &&
	            (wRate >= RATE_18M) && (wRate <= RATE_54M))

regards,
dan carpenter

