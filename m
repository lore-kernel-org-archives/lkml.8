Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E077FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3C720672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HqCj0XD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgDTS2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:28:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53146 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgDTS2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:28:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KIIJF1103942;
        Mon, 20 Apr 2020 18:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=oY+flJNEcT5n1C0oC85AA3bhkX+vexhCiFlAFUbreiY=;
 b=HqCj0XD1DIyDa6ezvrf5M7Qhg+djArOCIGKo9FEqLJj0cSy5rsviL8CjSxolT8KF05Wg
 q9jHpumWeAVtNoEkmVTz0+7YlVnnLgNQs9AW0LwtvpegfOqPxolG0D+lHpMM57ozA1Tq
 1Y1xkEMBbUxjVLXOlQp9EfyPPkXpa2uGLnFmxvxcx6D807zheGmTHEJT8ESGbw0Dq/5P
 WpGKyly24uCj2cKjbWEvq8cjTun/rJMULoMImTdrg02r9vZcXFznezsjOf7HlaQz9NKQ
 P+dVUhUmDis90W4SU6O32GRuHd+GWE6Iih6lK5P42OlFAAhDesZS9ymd61geflsdEHLP 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30grpgdcr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 18:28:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KICPl3060800;
        Mon, 20 Apr 2020 18:28:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30gbbb9yb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 18:28:29 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03KISRId026904;
        Mon, 20 Apr 2020 18:28:27 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Apr 2020 11:28:27 -0700
Date:   Mon, 20 Apr 2020 14:28:48 -0400
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
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v4 10/10] mmap locking API: rename mmap_sem to mmap_lock
Message-ID: <20200420182848.lw3iwir2tgvt22bo@ca-dmjordan1.us.oracle.com>
References: <20200415004353.130248-1-walken@google.com>
 <20200415004353.130248-11-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415004353.130248-11-walken@google.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=707 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=769 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:43:53PM -0700, Michel Lespinasse wrote:
> Rename the mmap_sem field to mmap_lock. Any new uses of this lock
> should now go through the new mmap locking api. The mmap_lock is
> still implemented as a rwsem, though this could change in the future.

There are hundreds of stale 'mmap_sem' comments left after this.  What about
adding a wrapper type and leaving the name as is to avoid this?  The type is
called something like mmap_sem_struct.

That means the lockdep/might_lock/prefetch/etc calls have to have the
indirection inline, but that seems ok.  The main value of the series seems to
be paving the way for instrumentation, not making the type totally abstract.
