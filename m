Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626D4C35247
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D6121569
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ghel7p+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgA0IO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:14:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39194 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0IO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:14:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R8CxIJ046723;
        Mon, 27 Jan 2020 08:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=OYqVXvzT0Nxa/D8evGCzueyUqWEOXT8pRhxN0eHd0lQ=;
 b=ghel7p+QFtmHH1/AqahRl2ODHODakwCAjHxWZz1HgpMQceDOChFX3/MBQ/F41muKNRSt
 52Q1hUcAMcF3M3CCkRcvQTp0DSJ6yLIEbiH7M/nZuQYMIbcd7iKXbjRMT9W3b5GtnfOf
 ds+/SY0OsWL978oR/giTgTDqJ3CM1lYtzFEptrwC8i24ej6uDRD4fUPVSv2OTiLlfdqt
 z/3LaIshMtz2/aVnGkBlMj0kXJ/flmtfKi4vi7Sh+szf0QYGe73FqFFMs96vWoBR+N9Y
 OSSuOYDK4aG62AaMjEMwGRi7z1/Cty1K7imeHBVmbymDR+kj9G/fX6aBO1g/E3aRNBnH nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xrd3twr2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 08:14:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R8EE6W009111;
        Mon, 27 Jan 2020 08:14:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xry6rc5rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 08:14:22 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00R8DvOT016606;
        Mon, 27 Jan 2020 08:13:57 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 00:13:57 -0800
Date:   Mon, 27 Jan 2020 11:13:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: comedi: drivers: fix condition with no effect
Message-ID: <20200127081349.GS1847@kadam>
References: <20200125131535.GA4171@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125131535.GA4171@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 06:45:35PM +0530, Saurav Girepunje wrote:
> fix warning reorted by coccicheck
> WARNING: possible condition with no effect (if == else)
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/comedi/drivers/das1800.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/das1800.c b/drivers/staging/comedi/drivers/das1800.c
> index f16aa7e9..7ab72e8 100644
> --- a/drivers/staging/comedi/drivers/das1800.c
> +++ b/drivers/staging/comedi/drivers/das1800.c
> @@ -1299,12 +1299,6 @@ static int das1800_attach(struct comedi_device *dev,
>  			outb(DAC(i), dev->iobase + DAS1800_SELECT);
>  			outw(0, dev->iobase + DAS1800_DAC);
>  		}
> -	} else if (board->id == DAS1800_ID_AO) {
> -		/*
> -		 * 'ao' boards have waveform analog outputs that are not
> -		 * currently supported.
> -		 */
> -		s->type		= COMEDI_SUBD_UNUSED;
>  	} else {
>  		s->type		= COMEDI_SUBD_UNUSED;

This is for documentation.  Just leave it as-is.

regards,
dan carpenter

