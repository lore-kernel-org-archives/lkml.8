Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCB9C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4CF206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QUSBYNqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgBMR6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:58:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42144 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMR6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:58:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DHnDmY149658;
        Thu, 13 Feb 2020 17:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Lr2ff7BNAkqLAkRgxJk1xwlEWpx8tFNSwxBL0+W8sLg=;
 b=QUSBYNqQh8fmU0UOxitL4OfEki1jaAsfdKQPoCZtOFb2ROx+X0umxmPqWq6dLS8F/SR6
 X+zlG1hvy4pOZgmvKVZaiZEeMshqOoq3r+aSSZqOEmZV7rFqJyYr4O1vxC5KV/GcoVh5
 DWZFLZanK8PsitgVzRrf50s0hptoSctGiNmlnLznK9UfqgyNjjlWR3BxLmTZ0lfGkfPG
 INuwGNzB6I5eWeYCtt0CHMaS45KjPsrhfMPCACEbeAkJXKk0iQJ5RqIaOxwwOYnGO+jg
 F7PiLwOEljgfPukQrbx3m8wy01/DT/JreLqc3iNh12Vo8ln4Y5rylQXcSjVfcr/BLj9C /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2y2p3sv38m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 17:57:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DHvTbg028918;
        Thu, 13 Feb 2020 17:57:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2y4kajy2m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 17:57:58 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01DHvses018923;
        Thu, 13 Feb 2020 17:57:54 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Feb 2020 09:57:53 -0800
Date:   Thu, 13 Feb 2020 09:57:53 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression: hibernation is broken since
 e6bc9de714972cac34daa1dc1567ee48a47a9342
Message-ID: <20200213175753.GS6874@magnolia>
References: <20200213172351.GA6747@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213172351.GA6747@dumbo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 06:23:51PM +0100, Domenico Andreoli wrote:
> Hi,
> 
>   at some point between 5.2 and 5.3 my laptop started to refuse
> hibernating and come back to a full functional state. It's fully 100%
> reproducible, no oopses or any other damage to the state seems to happen.
> 
> It took me a while to follow the trail down to this commit. If I revert
> it from v5.6-rc1, the hibernation is back as in the old times.

Hmm, do you know which hibernation mechanism your computer is using?

--D

> 
> commit e6bc9de714972cac34daa1dc1567ee48a47a9342
> Merge: b6c0d3577246 dc617f29dbe5
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Sep 18 17:35:20 2019 -0700
> 
>     Merge tag 'vfs-5.4-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
> 
>     Pull swap access updates from Darrick Wong:
>      "Prohibit writing to active swap files and swap partitions.
> 
>       There's no non-malicious use case for allowing userspace to scribble
>       on storage that the kernel thinks it owns"
> 
>     * tag 'vfs-5.4-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux:
>       vfs: don't allow writes to swap files
>       mm: set S_SWAPFILE on blockdev swap devices
> 
> 
> Is it possible to do anything?
> 
> Regards,
> Domenico
> 
> -- 
> rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
> ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
