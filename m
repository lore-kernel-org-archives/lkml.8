Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85BDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 12:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA83D22D2C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 12:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgHFMS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 08:18:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727006AbgHFLPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 07:15:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 076AWtuR103123;
        Thu, 6 Aug 2020 07:00:16 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32rfpx1gjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 07:00:15 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 076B0D8t018097;
        Thu, 6 Aug 2020 11:00:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 32n017u9ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 11:00:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 076B0BHF19595764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Aug 2020 11:00:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C415AE055;
        Thu,  6 Aug 2020 11:00:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6979AE04D;
        Thu,  6 Aug 2020 11:00:10 +0000 (GMT)
Received: from osiris (unknown [9.171.40.123])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Aug 2020 11:00:10 +0000 (GMT)
Date:   Thu, 6 Aug 2020 13:00:09 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Joerg Roedel <jroedel@suse.de>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/Kconfig: add missing ZCRYPT dependency to VFIO_AP
Message-ID: <20200806110009.GA68234@osiris>
References: <20200805155053.3739-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805155053.3739-1-krzk@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_06:2020-08-06,2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=1 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 05:50:53PM +0200, Krzysztof Kozlowski wrote:
> The VFIO_AP uses ap_driver_register() (and deregister) functions
> implemented in ap_bus.c (compiled into ap.o).  However the ap.o will be
> built only if CONFIG_ZCRYPT is selected.
> 
> This was not visible before commit e93a1695d7fb ("iommu: Enable compile
> testing for some of drivers") because the CONFIG_VFIO_AP depends on
> CONFIG_S390_AP_IOMMU which depends on the missing CONFIG_ZCRYPT.  After
> adding COMPILE_TEST, it is possible to select a configuration with
> VFIO_AP and S390_AP_IOMMU but without the ZCRYPT.
> 
> Add proper dependency to the VFIO_AP to fix build errors:
> 
> ERROR: modpost: "ap_driver_register" [drivers/s390/crypto/vfio_ap.ko] undefined!
> ERROR: modpost: "ap_driver_unregister" [drivers/s390/crypto/vfio_ap.ko] undefined!
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: e93a1695d7fb ("iommu: Enable compile testing for some of drivers")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/s390/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
