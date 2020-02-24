Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CECDC35DEA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA7F2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgBXXmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:42:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727081AbgBXXmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:42:15 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ONfguh087902
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 18:42:14 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ybu13e85e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 18:42:14 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alistair@popple.id.au>;
        Mon, 24 Feb 2020 23:42:11 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Feb 2020 23:42:08 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01ONg7rI60293124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 23:42:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24306A4051;
        Mon, 24 Feb 2020 23:42:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4259A4040;
        Mon, 24 Feb 2020 23:42:06 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Feb 2020 23:42:06 +0000 (GMT)
Received: from townsend.localnet (unknown [9.102.63.14])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id F36A4A01C4;
        Tue, 25 Feb 2020 10:42:01 +1100 (AEDT)
From:   Alistair Popple <alistair@popple.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH 4/8] powerpc: Mark 4xx as Orphan in MAINTAINERS
Date:   Tue, 25 Feb 2020 10:42:05 +1100
In-Reply-To: <20200224233146.23734-4-mpe@ellerman.id.au>
References: <20200224233146.23734-1-mpe@ellerman.id.au> <20200224233146.23734-4-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 20022423-0012-0000-0000-00000389EE01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022423-0013-0000-0000-000021C68ED4
Message-Id: <1582588767.8Bspa7yJx7@townsend>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_12:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1034 suspectscore=2
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=721 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alistair Popple <alistair@popple.id.au>

On Tuesday, 25 February 2020 10:31:42 AM AEDT Michael Ellerman wrote:
> The 4xx platforms are no longer maintained.
> 
> Cc: Alistair Popple <alistair@popple.id.au>
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  MAINTAINERS | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5c4f37c41188..939da2ac08db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9645,11 +9645,8 @@ F:	arch/powerpc/platforms/512x/
>  F:	arch/powerpc/platforms/52xx/
> 
>  LINUX FOR POWERPC EMBEDDED PPC4XX
> -M:	Alistair Popple <alistair@popple.id.au>
> -M:	Matt Porter <mporter@kernel.crashing.org>
> -W:	http://www.penguinppc.org/
>  L:	linuxppc-dev@lists.ozlabs.org
> -S:	Maintained
> +S:	Orphan
>  F:	arch/powerpc/platforms/40x/
>  F:	arch/powerpc/platforms/44x/




