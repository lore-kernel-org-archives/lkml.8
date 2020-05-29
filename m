Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB25C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58929207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QwXir7A9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgE2UUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:20:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56210 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2UUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:20:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TKC2gh052794;
        Fri, 29 May 2020 20:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=cZAoPBZ5GxltMX66Hp611oXlcHnQvjlOfG4fyu8hV48=;
 b=QwXir7A9ZyhU/iRVvcwOU4nTZl3XZWDKFrFd9lyaTUKnG+4SemndF6de4DSoAUWJwvao
 DiRE6n9+LMDVnwYOVCrFrAcKp+e6x9cEZWMOcfYCWuTFW+YpVqinLnvCJrOyxXlZHSHJ
 wZuOyIFjIP4LMPxIvZwL6aAc+QjKzadjlYzI6JDKOi8eoEflQBDoyCKEi5dZa84frQb8
 jmwQIYzHvWk0QWbGI75oHfb+GnlMdlOTzhP4UiyfGKzfd9sj9zpDuwTRYPk/Vfiw5Cit
 o3BfsJ30XhmcCG4GJbGZ0aDOeUQPYrdakRsycxHjmi+jFLIW7y4peFQg6lT0BH60cFw+ Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 316u8rca4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 20:17:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TKDjmb028513;
        Fri, 29 May 2020 20:17:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31a9kuqeta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 20:17:28 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04TKHPIH030039;
        Fri, 29 May 2020 20:17:25 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 13:17:25 -0700
Date:   Fri, 29 May 2020 16:17:50 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 08/12] mmap locking API: add MMAP_LOCK_INITIALIZER
Message-ID: <20200529201750.64dy7mu7gtkwltvu@ca-dmjordan1.us.oracle.com>
References: <20200520052908.204642-1-walken@google.com>
 <20200520052908.204642-9-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520052908.204642-9-walken@google.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=974 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=0
 phishscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:29:04PM -0700, Michel Lespinasse wrote:
> Define a new initializer for the mmap locking api.
> Initially this just evaluates to __RWSEM_INITIALIZER as the API
> is defined as wrappers around rwsem.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
