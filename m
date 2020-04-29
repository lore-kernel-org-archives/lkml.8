Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B18BC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5482087E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ace3/2kG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgD2Mob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:44:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgD2Mob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:44:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03TCgm8U185089;
        Wed, 29 Apr 2020 12:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=wDExqGqXpcZDnGmuWjfBfH28yeSa4fR8ye9MRxfFVbk=;
 b=Ace3/2kGXgWBhupNWf6WZIs8/V9hqtLZQ6yvt9fIqP1JUgPPGshSRaTqDmf+YXxFe+gq
 Jk4p5wXeYG1RbqG6DpkFGUHRgBlyATMPoir9TUyhtDoxz1yCp5c2Q9EsdTtju7cKyQHf
 yxiazpkKjMto6N3teQsJsRGIpjH2GFJDUmioGee8ss6VjBDlMwwIXvc2winZmKVTTT40
 qeC087nGfJMEBhZoZT5pO+uPXmvFq0d8HHZcRhe7aVISu5Jrjf1cqratX5jVIWcvAJPD
 TKj+y2S2m1p17qWKYYDK53HeQgQi9jyGTPJ/sNxynfOf5AbUYABgL0FhEcE9kj7EQIyZ Kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30nucg5fux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 12:44:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03TCg5G0028007;
        Wed, 29 Apr 2020 12:44:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30mxrv10ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 12:44:11 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03TCi9n4014810;
        Wed, 29 Apr 2020 12:44:09 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Apr 2020 05:44:08 -0700
Date:   Wed, 29 Apr 2020 15:44:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: Avoid double lock for cp_rwsem
 during checkpoint
Message-ID: <20200429124402.GP2014@kadam>
References: <07a820a2-b3b3-32ca-75ce-ceaca106d2c6@web.de>
 <433d4ad5-22e5-fd2b-cab3-9752ed0c66fb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <433d4ad5-22e5-fd2b-cab3-9752ed0c66fb@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=979 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:28:36AM +0530, Sayali Lokhande wrote:
> Hi Markus
> 
> On 4/27/2020 4:08 PM, Markus Elfring wrote:
> > > … This results in deadlock as
> > > iput() tries to hold cp_rwsem, which is already held at the
> > > beginning by checkpoint->block_operations().
> > Will another imperative wording become helpful besides the provided information
> > for this change description?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=6a8b55ed4056ea5559ebe4f6a4b247f627870d4c#n151
> > 
> > Would you like to add the tag “Fixes” because of adjustments
> > for the data synchronisation?
> 
> I couldn't find any past commit which suits to be added under "Fixes" here.
> Let me know if you have any other comment.

This looks really old.  Maybe commit 399368372ed9 ("f2fs: introduce a
new global lock scheme")?

regards,
dan carpenter

