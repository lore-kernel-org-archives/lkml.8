Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F2BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA48B2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cxg1dx75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgFBOv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:51:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56726 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBOv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:51:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052EmxEh035683;
        Tue, 2 Jun 2020 14:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=v5KmClMttUtxsz3VzRYeCKjV1VZ4BWIMiIFVnngkDKo=;
 b=cxg1dx75ls7331FcYBokh3QyloVvAU5E7klpLhfP4DjftLTVNx2V0Bj1/IcXZKHbVFlH
 YCkgwGxQ+vm+iS0a1mShUp8n5QGY7/llQEGkdya4leCDjC4n0Bb2wmm9mXvOHaqAJ30d
 zgKHJ0jwkeIQ2EKDr2Y6SrlznOvQz/UUdQz1zgM3PEYIqir4bR/SByFcKAQK+AP9pFcN
 zfIYfCRJ6N2I+UU9YsKn/wB0NCW0N95VeXYiQNewtIcj6/dgo0saW4VGi5woYMkQfsB0
 L94554QRF5ouSt7KYvP2AeEPnhOCTMIrJNQTTawBJh7bDt23HoBdLxZ0/W/nNHCMX0ys tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31bfem4e03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 14:51:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052Em00A065367;
        Tue, 2 Jun 2020 14:51:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31dju1kqf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 14:51:45 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052Eph0Z011885;
        Tue, 2 Jun 2020 14:51:43 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 07:51:43 -0700
Date:   Tue, 2 Jun 2020 10:52:08 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        hughd@google.com, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmstat: Add events for PMD based THP migration
 without split
Message-ID: <20200602145208.qucum52lwslhiqff@ca-dmjordan1.us.oracle.com>
References: <1590118444-21601-1-git-send-email-anshuman.khandual@arm.com>
 <20200601165736.qw5kwwknxltk7bv6@ca-dmjordan1.us.oracle.com>
 <0a936ec7-f44f-1d72-915f-f5758d25fd72@nvidia.com>
 <1e71d815-5359-3ebe-5d2b-5a3b54b63b51@arm.com>
 <274be3bf-2206-5e98-8114-1d91fac472c9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274be3bf-2206-5e98-8114-1d91fac472c9@nvidia.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 09:48:09PM -0700, John Hubbard wrote:
> However, the fact that this is under discussion hints at the need for a
> bit of documentation help. What do you think about adding some notes about
> all of this to, say, Documentation/vm/page_migration.rst ?

Yes, that would be good.  I understand the intent better now but still think
the 'failure' event could be misinterpreted as outright failure instead of
splitting followed by successfully moving the constituent pages.

It might help to clarify in the changelog as well.
