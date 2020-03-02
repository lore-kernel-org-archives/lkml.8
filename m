Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05510C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8FC246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AuDffj4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCBHqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:46:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35202 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBHqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:46:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0227hKVq187428;
        Mon, 2 Mar 2020 07:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2mPZCjCiEQN8LuFrAx6hDaMcPmsg2dvMTzR2q4y1+UU=;
 b=AuDffj4x3FTTxai7qPvmM030rRwjEIy4kQdU76CHjdbNLFglvw+3GZ9/L34qBWawVUOu
 c2gxYcEvXORG6OvuMIXEPF2xg9qdlMPRMdaEb3iRkYfRVV6cmfsGC83zCHzDiy7o82PI
 5CBFu84rWALNAV2XAsuZ7FrCOhL5IC2QMveQ+aYwd0JWipIOhe0zUsp9e6gYCa5P6G6f
 PxLpDMuuOIVTaRDaAUoiLROfadK/oYmc+FFbSR+xCh90kwxqYmIR8rfcLLnP1b/zi2EO
 IrjAopXqvos01L4H4H6b3cInc0HrmQCMyJwHLkpZWE3RKeuBpos5a/yySS156aVDlqXK wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yghn2sv5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Mar 2020 07:45:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0227iTPd086420;
        Mon, 2 Mar 2020 07:45:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2yg1p12v6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Mar 2020 07:45:58 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0227jsep001123;
        Mon, 2 Mar 2020 07:45:54 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Mar 2020 23:45:52 -0800
Date:   Mon, 2 Mar 2020 10:45:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, simon@nikanor.nu, chandra627@gmail.com,
        fabian.krueger@fau.de, gneukum1@gmail.com,
        michael.scheiderer@fau.de
Subject: Re: [PATCH] staging: kpc2000: kpc2000_spi: Use new structure for SPI
 transfer delays
Message-ID: <20200302074542.GB4140@kadam>
References: <20200227144643.23195-1-sergiu.cuciurean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227144643.23195-1-sergiu.cuciurean@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003020059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 04:46:43PM +0200, Sergiu Cuciurean wrote:
> In a recent change to the SPI subsystem [1], a new `delay` struct was added

Don't do [1] footnote, just say "SPI subsystem in commit bebcfd272df6
("spi: introduce `delay` field for `spi_transfer` + spi_transfer_delay_exec()")
You can use footnotes for URLs if you want (not required).

> to replace the `delay_usecs`. This change replaces the current
> `delay_usecs` with `delay` for this driver.
> 
> The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
> that both `delay_usecs` & `delay` are used (in this order to preserve
> backwards compatibility).
> 
> [1] commit bebcfd272df6 ("spi: introduce `delay` field for
> `spi_transfer` + spi_transfer_delay_exec()")
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
>  drivers/staging/kpc2000/kpc2000_spi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
> index 1c360daa703d..cc9b147fd437 100644
> --- a/drivers/staging/kpc2000/kpc2000_spi.c
> +++ b/drivers/staging/kpc2000/kpc2000_spi.c
> @@ -386,8 +386,9 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
>  			}
>  		}
>  
> -		if (transfer->delay_usecs)
> -			udelay(transfer->delay_usecs);
> +		if (transfer->delay.value &&
> +		    (transfer->delay.unit == SPI_DELAY_UNIT_USECS))
> +			udelay(transfer->delay.value);

What if the units are in USEC now?  We should probably not just ignore
it right?

regards,
dan carpenter

