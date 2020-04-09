Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A47C2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AA920771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i22hPosZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgDIKWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:22:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54146 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIKWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:22:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039AD3F2162825;
        Thu, 9 Apr 2020 10:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=d0vbh1SNAcfSwbd6w+AzaTccs3Ec+MTzHAp5ctJy/mI=;
 b=i22hPosZiC/dM+p3jpWetJjF42Y2kWHZbHkD+VgbrR48kvvVmP+4UMTpUhHObeenMkhb
 7kieRdzf8MJgNG252Vn2lddlxAS1iymIblQU3kAElcjKOYqKTzjFCRN81IgBlw1wPsos
 UP9dKE9ZCi7Q9HmsTjc6C2UoJbJRXP0C6ujRtdy2nVl7Q0c/Kad2RQl7G+AnNHHGnl75
 JtV4toMaM2PbmJrXooZFto+IcC126Dx1/2sFtvLsjrA1Hqg6t1Al4ts1fqbxdRloe1GQ
 2H9tdylmPE/VYHtHEE3QcxJUoI56rt6zC4BKVU9LONMpnk0nu4WuKmRseQiThfRXKV/M Rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 309gw4cj49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 10:22:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039ALakk093384;
        Thu, 9 Apr 2020 10:22:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3091m7g8m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 10:22:12 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 039AMBAk020185;
        Thu, 9 Apr 2020 10:22:11 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 03:22:10 -0700
Date:   Thu, 9 Apr 2020 13:22:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] staging: fbtft: fb_st7789v: Initialize the Display
Message-ID: <20200409102013.GP2001@kadam>
References: <1586424337-26602-1-git-send-email-oliver.graute@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586424337-26602-1-git-send-email-oliver.graute@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004090078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 11:25:32AM +0200, Oliver Graute wrote:
> From: Oliver Graute <oliver.graute@kococonnector.com>
> 
> Set Gamma Values and Register Values for the HSD20_IPS
> 
> Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> ---
>  drivers/staging/fbtft/fb_st7789v.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> index 84c5af2dc9a0..b0aa96b703a8 100644
> --- a/drivers/staging/fbtft/fb_st7789v.c
> +++ b/drivers/staging/fbtft/fb_st7789v.c
> @@ -17,8 +17,8 @@
>  #define DRVNAME "fb_st7789v"
>  
>  #define DEFAULT_GAMMA \
> -	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25\n" \
> -	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25"
> +	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
> +	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"

How do you know this won't break someone else's setup?

>  
>  /**
>   * enum st7789v_command - ST7789V display controller commands
> @@ -83,13 +83,13 @@ static int init_display(struct fbtft_par *par)
>  	/* set pixel format to RGB-565 */
>  	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_16BIT);
>  
> -	write_reg(par, PORCTRL, 0x08, 0x08, 0x00, 0x22, 0x22);
> +	write_reg(par, PORCTRL, 0x05, 0x05, 0x00, 0x33, 0x33);

Without knowing anything at all about this driver, it feels like this
should be:

	if (new_hardware)
		write_reg(par, PORCTRL, 0x05, 0x05, 0x00, 0x33, 0x33);
	else
		write_reg(par, PORCTRL, 0x08, 0x08, 0x00, 0x22, 0x22);

Same comment for the rest of the patch.

regards,
dan carpenter

