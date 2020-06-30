Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27438C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF942073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbgF3HNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:13:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59110 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730635AbgF3HNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:13:53 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U73tFe053725;
        Tue, 30 Jun 2020 03:13:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31xkqkcubr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 03:13:49 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05U6WrKr055742;
        Tue, 30 Jun 2020 03:13:49 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31xkqkcubj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 03:13:49 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05U7AdjX009630;
        Tue, 30 Jun 2020 07:13:48 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 31wwr8e3mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 07:13:48 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05U7DlhG49021424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 07:13:47 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8E77C6055;
        Tue, 30 Jun 2020 07:13:47 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86DAFC605A;
        Tue, 30 Jun 2020 07:13:47 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jun 2020 07:13:47 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Jun 2020 09:13:47 +0200
From:   haver <haver@linux.vnet.ibm.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, Frank Haverkamp <haver@linux.ibm.com>
Subject: Re: [PATCH 2/4] misc: genwqe: Constify struct pci_error_handlers
In-Reply-To: <20200610224704.27082-3-rikard.falkeborn@gmail.com>
References: <20200610224704.27082-1-rikard.falkeborn@gmail.com>
 <20200610224704.27082-3-rikard.falkeborn@gmail.com>
Message-ID: <c91aed2e8b1530c2f4334774af510814@linux.vnet.ibm.com>
X-Sender: haver@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_01:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 cotscore=-2147483648
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-11 00:47, Rikard Falkeborn wrote:
> genwqe_err_handler is never modified, so it can be made const to allow
> the compiler to put it in read-only memory.
> 
> Before:
>    text    data     bss     dec     hex filename
>   20174    6104    2464   28742    7046 drivers/misc/genwqe/card_base.o
> 
> After:
>    text    data     bss     dec     hex filename
>   20270    6008    2464   28742    7046 drivers/misc/genwqe/card_base.o
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/misc/genwqe/card_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/genwqe/card_base.c 
> b/drivers/misc/genwqe/card_base.c
> index 1dc6c7c5cbce..9969c0003f15 100644
> --- a/drivers/misc/genwqe/card_base.c
> +++ b/drivers/misc/genwqe/card_base.c
> @@ -1324,7 +1324,7 @@ static int genwqe_sriov_configure(struct pci_dev
> *dev, int numvfs)
>  	return 0;
>  }
> 
> -static struct pci_error_handlers genwqe_err_handler = {
> +static const struct pci_error_handlers genwqe_err_handler = {
>  	.error_detected = genwqe_err_error_detected,
>  	.mmio_enabled	= genwqe_err_result_none,
>  	.slot_reset	= genwqe_err_slot_reset,

Good idea. Thanks for the contribution.

Signed-off-by: Frank Haverkamp <haver@linux.ibm.com>
