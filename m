Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA6DC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D803120732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qaKSz/Uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgCTNRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:17:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53926 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgCTNRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:17:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KDCx70053685;
        Fri, 20 Mar 2020 13:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Ca0hhfBrNJRfEHmVEAesPO0pLfWlBN93+jbMeyIxlq4=;
 b=qaKSz/Uq3skWoC5I5YMTYvFjQWSSoSsGQvPsBrH+Cikd5o4hPZdXqrjFOAO/TfVd3lY/
 sRRsboP9MvJ+bY2a6jztntwMgIe0qmNyr3gSoMRr7ZWY3D/V/bLMgdvgoABDvbqT4t0H
 xE2Y90EgZFILlctEwHm31bxzIwMwAHJGUSoJA585u1hY6K9NBMvFu8iiNgYoj2JrWibO
 +XPl7V2jABqEsCNz8wCHCN5+wFIMCH5ITd33IrfVxwsKaLFZ0RF8/reTqKRsPPsQjQ/u
 R6cuOxr0sVFveBq2BTrpxC1NUgpfYTvX+CkAHixLFEmRD00+7XKMslFuZ9LTmnKxMQGq iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yrq7mdh11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 13:17:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KDCdfQ057200;
        Fri, 20 Mar 2020 13:17:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2ys906s8xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 13:17:30 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02KDHSh5006058;
        Fri, 20 Mar 2020 13:17:29 GMT
Received: from [10.39.249.71] (/10.39.249.71)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Mar 2020 06:17:28 -0700
Subject: Re: [PATCH v2] xen-pciback: fix INTERRUPT_TYPE_* defines
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20200320030929.24735-1-marmarek@invisiblethingslab.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <46cf0d25-11bc-e580-fe30-9898551c28e2@oracle.com>
Date:   Thu, 19 Mar 2020 21:21:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320030929.24735-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=802 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=858 priorityscore=1501 clxscore=1015
 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/19/20 11:09 PM, Marek Marczykowski-Górecki wrote:
> xen_pcibk_get_interrupt_type() assumes INTERRUPT_TYPE_NONE being 0
> (initialize ret to 0 and return as INTERRUPT_TYPE_NONE).
> Fix the definition to make INTERRUPT_TYPE_NONE really 0, and also shift
> other values to not leave holes.
> But also, do not assume INTERRUPT_TYPE_NONE being 0 anymore to avoid
> similar confusions in the future.
>
> Fixes: 476878e4b2be ("xen-pciback: optionally allow interrupt enable flag writes")
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

