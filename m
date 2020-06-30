Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B52AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C9742073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbgF3Hff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:35:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730089AbgF3Hff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:35:35 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U7XSqX072662;
        Tue, 30 Jun 2020 03:35:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31y3xd6sbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 03:35:27 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05U7YUm9077248;
        Tue, 30 Jun 2020 03:35:26 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31y3xd6sb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 03:35:26 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05U7FtrG027875;
        Tue, 30 Jun 2020 07:35:25 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 31wwr8ura4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 07:35:25 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05U7ZOAF38404402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 07:35:24 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD6C1124053;
        Tue, 30 Jun 2020 07:35:24 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF404124052;
        Tue, 30 Jun 2020 07:35:23 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jun 2020 07:35:23 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Jun 2020 09:35:23 +0200
From:   haver <haver@linux.vnet.ibm.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: Re: [PATCH 17/20] misc: genwqe: card_base: Do not      pass unused
 argument 'fatal_err'
In-Reply-To: <20200629140442.1043957-18-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
 <20200629140442.1043957-18-lee.jones@linaro.org>
Message-ID: <016718c7218cf811897cc32cf9476222@linux.vnet.ibm.com>
X-Sender: haver@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_02:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 cotscore=-2147483648 clxscore=1015 impostorscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-29 16:04, Lee Jones wrote:
> 'fatal_err' is taken as an argument to a static function which is only
> invoked once.  During this invocation 'fatal_err' is not set.  There
> doesn't appear to be a good reason to keep it around.
> 
> Also fixes the following W=1 kernel build warning:
> 
>  drivers/misc/genwqe/card_base.c:588: warning: Function parameter or
> member 'fatal_err' not described in 'genwqe_recover_card'
> 
> Cc: Michael Jung <mijung@gmx.net>
> Cc: Michael Ruettger <michael@ibmra.de>
> Cc: Frank Haverkamp <haver@linux.ibm.com>
> Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/genwqe/card_base.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/misc/genwqe/card_base.c 
> b/drivers/misc/genwqe/card_base.c
> index bceebf49de2d5..809a6f46f6de3 100644
> --- a/drivers/misc/genwqe/card_base.c
> +++ b/drivers/misc/genwqe/card_base.c
> @@ -569,30 +569,18 @@ static int genwqe_stop(struct genwqe_dev *cd)
> 
>  /**
>   * genwqe_recover_card() - Try to recover the card if it is possible
> - *
> - * If fatal_err is set no register access is possible anymore. It is
> - * likely that genwqe_start fails in that situation. Proper error
> - * handling is required in this case.
> + * @cd: GenWQE device information
>   *
>   * genwqe_bus_reset() will cause the pci code to call genwqe_remove()
>   * and later genwqe_probe() for all virtual functions.
>   */
> -static int genwqe_recover_card(struct genwqe_dev *cd, int fatal_err)
> +static int genwqe_recover_card(struct genwqe_dev *cd)
>  {
>  	int rc;
>  	struct pci_dev *pci_dev = cd->pci_dev;
> 
>  	genwqe_stop(cd);
> 
> -	/*
> -	 * Make sure chip is not reloaded to maintain FFDC. Write SLU
> -	 * Reset Register, CPLDReset field to 0.
> -	 */
> -	if (!fatal_err) {
> -		cd->softreset = 0x70ull;
> -		__genwqe_writeq(cd, IO_SLC_CFGREG_SOFTRESET, cd->softreset);
> -	}
> -
>  	rc = genwqe_bus_reset(cd);
>  	if (rc != 0) {
>  		dev_err(&pci_dev->dev,
> @@ -958,7 +946,7 @@ static int genwqe_health_thread(void *data)
> 
>  			cd->card_state = GENWQE_CARD_FATAL_ERROR;
> 
> -			rc = genwqe_recover_card(cd, 0);
> +			rc = genwqe_recover_card(cd);
>  			if (rc < 0) {
>  				/* FIXME Card is unusable and needs unbind! */
>  				goto fatal_error;

I think this one I want to keep. Since fatal_err is 0, !fatal_error is 1 
and the register write is actually executed.
I also want to keep the parameter even though it is only used with 0. 
The register bit causes a less drastic recovery, but if we would 
discover that that is not working ok, we rather discard the debug data 
we get in this case instead of letting the recovery fail. I think it 
does not hurt to keep it. Maybe you can add a comment?

Thanks

Frank
