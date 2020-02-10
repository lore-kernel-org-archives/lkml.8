Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E9C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F16214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TtfwFmaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgBJIe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:34:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38654 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbgBJIe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:34:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01A8Wx33161934;
        Mon, 10 Feb 2020 08:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jUUFk4pjb4VR5au3cMOhGdF3aMvNDZPsdfMNEMcE88Y=;
 b=TtfwFmaCYZ7mxxJyy/NgvB5hNwBeHzKKrJHA82hz4I5KiQk+l6BBp7Qjuc8d/zS+kffz
 1I5KRbVp8u/mPsKh1eIQfPxD3v+mN2nuiAEmHt/QtE2J4qQHY2QjYdD5eof45FAZuqQv
 ze5eygr9Pld5+VMbG0chzaJtOM7XteryWECz+U67qJSbNb3lhZXzSkqJrK6jSgTkGv1l
 3os1ruWNTWfsjLghuW461Fc3SH5/KuViEPuupuDutjjWWmU0e5/YTXJXR281kAUaxGJz
 zFYTMFhGjklMG9vBu8OTPpSm/LWGdHof7oJVFzojkPzY1EClwiOQ7DKt+oan/RWyjOji cA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y2p3s24gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 08:34:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01A8WXsp168413;
        Mon, 10 Feb 2020 08:32:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2y26pxshhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 08:32:52 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01A8Wp4w001439;
        Mon, 10 Feb 2020 08:32:51 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Feb 2020 00:32:51 -0800
Date:   Mon, 10 Feb 2020 11:32:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: debug: remove redundant call to strlen
Message-ID: <20200210083243.GW1778@kadam>
References: <20200208162508.29336-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208162508.29336-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9526 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002100071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9526 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002100071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 04:25:08PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to strlen is redundant since the return value is assigned
> to variable len but not subsequently used. Remove the redundant
> call.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/dwc3/debug.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
> index e56beb9d1e36..ee964352c8e2 100644
> --- a/drivers/usb/dwc3/debug.h
> +++ b/drivers/usb/dwc3/debug.h
> @@ -296,8 +296,6 @@ static inline const char *dwc3_ep_event_string(char *str, size_t size,
>  				status & DEPEVT_STATUS_TRANSFER_ACTIVE ?
>  				" (Active)" : " (Not Active)");
>  
> -		len = strlen(str);

This code is buggy.  It's a mixup between ret and len.  Get rid of "ret"
and use "len" throughout.

Unlike userspace snprintf() the kernel version always returns a positive
value.  It returns the number of bytes that would have been copied if
there were enough space.  This code should probably be changed to use
scnprintf() which returns the number of bytes which were copied
successfully.

The remove all the strlen() calls.  It should just be += the return.

	len += scnprintf(str + len, size - len, "Transfer Not Ready [%d] %s",
			 event->parameters,
			 status & DEPEVT_STATUS_TRANSFER_ACTIVE ?
				"(Active)" : "(Not Active)");

regards,
dan carpenter

