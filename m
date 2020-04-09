Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27477C2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA78E2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fH92QFgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDIKka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:40:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43136 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIKk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:40:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039Ad80m013796;
        Thu, 9 Apr 2020 10:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=fNK9gwoEb/fx991nZsqjXEhcrailCIwT8xqiE5HZJCU=;
 b=fH92QFgUwfUGwoa6GnbYplnHDJIy0blkH3i92TawijqEcl0fXYiwAjY4mKHdew1xJnhj
 T2Ld+EQpOXkeN2KVtEqgD0jmcz2rCMV6A0Br5XqWTKKXwjeuCcObd7gctdRg0ph27UrT
 Ats6HGa/CWKlBWKZnsnCDQYdw0oAFlP4tgLvWC/OcEQ1zkYrQTKfjmOjpF6Dqn2ZGFlr
 FpF7ZshVy0ihWjWlPr6c/K8QUdRvL9VjLuX8H2HvCF/PIoaz9zbi63gRUqIggA8OftM3
 v5RRzTt+8/SD5GgVXnlyK/xxitEtPQ4CJAAdRJ8P0K9NW1oXqPnlg/Gd/+P3NHR81VBg Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 309gw4cme7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 10:40:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039AasXS013589;
        Thu, 9 Apr 2020 10:40:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 309ag48r4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 10:40:23 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 039AeLFp019390;
        Thu, 9 Apr 2020 10:40:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 03:40:20 -0700
Date:   Thu, 9 Apr 2020 13:40:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
Message-ID: <20200409103049.GA14081@kadam>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
 <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
 <4b7e1cf3-6fa7-60af-a1d3-2457339dbe8a@wanadoo.fr>
 <efb5a518fdc47f0120b94a7e8a95d275c0f4ad43.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb5a518fdc47f0120b94a7e8a95d275c0f4ad43.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004090081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 suspectscore=2 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 08:10:23PM -0700, Joe Perches wrote:
> Some types of false positives:
> 
> o Many of the formats seem to end in a ':' or a ' '
>   maybe those should be excluded
>    #86: FILE: drivers/android/binder_alloc_selftest.c:86:
>    +	pr_err("free seq: ");
> 

Yeah.  I also ignored strings that end in a space in my version.

>    o Split string formats should be excluded better
>      as only the first string fragment is checked:
>    #1001: FILE: drivers/ata/pata_octeon_cf.c:1001:
>    +	dev_info(&pdev->dev, "version " DRV_VERSION" %d bit%s.\n",

I ignored anything with a newline in it anywhere.

>    +		 is_16bit ? 16 : 8,
>    +		 cf_port->is_true_ide ? ", True IDE" : "");
> 
>    probably a few others, including a desire to check
>    if a pr_cont is below the use within a few lines.

Seems tricky to implement...  I think if you can't make it work it's
still usefull even with a some false positives.

regards,
dan carpenter
