Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D00C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75FD2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgBQRGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:06:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729021AbgBQRGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:06:37 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HH4trX120726
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 12:06:36 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e1gmn9g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 12:06:36 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 17 Feb 2020 17:06:34 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Feb 2020 17:06:30 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01HH5Y3G44106064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 17:05:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FFDA11C04A;
        Mon, 17 Feb 2020 17:06:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E201A11C054;
        Mon, 17 Feb 2020 17:06:28 +0000 (GMT)
Received: from localhost (unknown [9.152.212.204])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Feb 2020 17:06:28 +0000 (GMT)
Date:   Mon, 17 Feb 2020 18:06:27 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: make 'install' not depend on vmlinux
References: <20200216144829.27023-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200216144829.27023-1-masahiroy@kernel.org>
X-TM-AS-GCONF: 00
x-cbid: 20021717-4275-0000-0000-000003A2DAEF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021717-4276-0000-0000-000038B6E000
Message-Id: <your-ad-here.call-01581959187-ext-6215@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_11:2020-02-17,2020-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=1 mlxlogscore=937
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 11:48:29PM +0900, Masahiro Yamada wrote:
> For the same reason as commit 19514fc665ff ("arm, kbuild: make "make
> install" not depend on vmlinux"), the install targets should never
> trigger the rebuild of the kernel.
> 
> The variable, CONFIGURE, is not set by anyone. Remove it as well.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
Applied, thanks

