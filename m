Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD453C8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08A62137B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgD3KWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:22:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbgD3KWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:22:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UA2qQq049772;
        Thu, 30 Apr 2020 06:22:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhqaph5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 06:22:22 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03UA4XsU058309;
        Thu, 30 Apr 2020 06:22:22 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhqaph48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 06:22:21 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03UAKLFG009374;
        Thu, 30 Apr 2020 10:22:19 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 30mcu5ajgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 10:22:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03UAL7Gu60031290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 10:21:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85D7F4204B;
        Thu, 30 Apr 2020 10:22:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9D2242047;
        Thu, 30 Apr 2020 10:22:15 +0000 (GMT)
Received: from localhost (unknown [9.145.144.181])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 30 Apr 2020 10:22:15 +0000 (GMT)
Date:   Thu, 30 Apr 2020 12:22:14 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: ptrace: hard-code "s390x" instead of UTS_MACHINE
Message-ID: <your-ad-here.call-01588242134-ext-2784@work.hours>
References: <20200413013113.8529-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200413013113.8529-1-masahiroy@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_05:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 adultscore=0 suspectscore=1
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 10:31:13AM +0900, Masahiro Yamada wrote:
> s390 uses the UTS_MACHINE defined arch/s390/Makefile as follows:
> 
>   UTS_MACHINE     := s390x
> 
> We do not need to pass the fixed string from the command line.
> Hard-code user_regset_view::name, like many other architectures do.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/s390/kernel/Makefile | 5 -----
>  arch/s390/kernel/ptrace.c | 2 +-
>  2 files changed, 1 insertion(+), 6 deletions(-)

Yes, since we don't have 31-bit kernel build support for s390 anymore
this makes sense.
Applied, thanks.
