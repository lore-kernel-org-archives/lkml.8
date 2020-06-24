Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AA8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933CF20738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gEsIwJTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405283AbgFXQwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:52:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40360 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404017AbgFXQwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:52:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OGpsjw150780;
        Wed, 24 Jun 2020 16:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=GqtsLr0XN/uA8zUbxgxcU20i7Gv21Vga+H3y1OhQf3A=;
 b=gEsIwJTS/vRyx0UP5ZRtuKgee0oJWW+QReARjY6jEalDhOk1K5Kq/7YPxnhTNcHbCPg1
 Qs7Mr7L3+JB0JWLWA4+Zd703z+BZy3Ww60uocrXQdmUcgk6XlUv9NXG2ZQ4tuzesc3DA
 tHtIWiPDOFOKNfpqsqHvy0UDHkgaSbqQoepS+8RSS/b5guFTsjpFHqiQJnWe8ZtaiYU9
 +X2IMozPqZG7KzKh402yOV6mdDDxlyQM+Tc/upCZqOCx3rfdTTe19D7dVouETmtddXVo
 eCFAof5p4aAtEMwjtTOhK8cjV9/Jq/6R9oK0UrSIhzsFaVpt8pBII0O4R5vvXIxwh46o QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31uustv0yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 16:52:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OGnJjU098319;
        Wed, 24 Jun 2020 16:52:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31uurr3hyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 16:52:02 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05OGpvDk022975;
        Wed, 24 Jun 2020 16:51:57 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 16:51:56 +0000
Date:   Wed, 24 Jun 2020 19:51:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, Kees Kook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
Message-ID: <20200624165148.GD31008@kadam>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Debian testing the initrd triggers the warning.

[   34.529809] process '/usr/bin/fstype' started with executable stack

$ checksec --format=json --extended --file=/var/tmp/mkinitramfs_eTyMPQ/bin/fstype | jq
{
  "file": {
    "relro": "no",
    "canary": "no",
    "nx": "no",
    "pie": "no",
    "clangcfi": "no",
    "safestack": "no",
    "rpath": "no",
    "runpath": "no",
    "symbols": "no",
    "fortify_source": "no",
    "fortified": "0",
    "fortify-able": "0"
  }
}

regards,
dan carpenter

