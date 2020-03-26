Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FE6C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CC720714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iNi3HDYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgCZS6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:58:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35434 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZS6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:58:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QInG0x004620;
        Thu, 26 Mar 2020 18:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6o5UWSo4SFsyev7vitT/qH8UlQgFN1m+GAnP6vmJrIE=;
 b=iNi3HDYczgmg/jvag0eBycnWWfMBzX8wja1UAaIlTfvACKJAKey3IhMPDJ8668sSyVxJ
 n6yqnq1kFX+Sr2S29E2ZIaGsdMKR0L52ilIz0KoQXvGqud+9WorV/bbdJcDTogHm/h0N
 VJkdztBjsqS9MAvE3I/Pzs9os4H4hps7Z8kRCYyDI4wbBMKIfRZ86o0RD04s3vkquo0D
 1UMfzRvYBkP4TqSrZA9ujBkFzC6MSvEwBoSrshrksWYM9IkHNZpytJ91oJgJxSOyA0C8
 Z2CYlaPa281phHtzENAqdczmwlOYUsauv1zFM5xFwRnxNNa0acxdR0s89GjyxvFkcZ0g CA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ywabrhprg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 18:58:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QIp4vH056829;
        Thu, 26 Mar 2020 18:58:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2yxw4u76jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 18:58:05 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02QIw320030108;
        Thu, 26 Mar 2020 18:58:03 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 11:58:02 -0700
Date:   Thu, 26 Mar 2020 14:58:22 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
Message-ID: <20200326185822.6n56yl2llvdranur@ca-dmjordan1.us.oracle.com>
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <20200319190512.cwnvgvv3upzcchkm@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319190512.cwnvgvv3upzcchkm@ca-dmjordan1.us.oracle.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 03:05:12PM -0400, Daniel Jordan wrote:
> Regardless,
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Darn, I spoke too soon.

On a two-socket Xeon, smaller values of TICK_PAGE_COUNT caused the deferred
init timestamp to grow by over 25%.  This was with pgdatinit0 bound to the
timer interrupt CPU to make sure the issue always reproduces.

               TICK_PAGE_COUNT     node 0 deferred
                                   init time (ms)
               ---------------     ---------------
                          4096                 610
                          8192                 587
                         16384                 487
                         32768                 480    // used in the patch

Instead of trying to find a constant that lets the timer interrupt run often
enough, I think a better way forward is to reconsider how we handle the resize
lock.  I plan to prototype something and reply back with what I get.
