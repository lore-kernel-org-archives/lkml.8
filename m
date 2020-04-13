Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0EAC2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 099FB206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VMQYWJ1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbgDMRGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:06:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37628 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732482AbgDMRGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:06:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DH5e1j186408;
        Mon, 13 Apr 2020 17:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=UAfRx68GmugaLtPZinUg/SwF6hel61cQgW6F9C717Cw=;
 b=VMQYWJ1YGtI4OmsNMa5Z3PjHN1LLlly2qYJbeEGxJfSs0RlbHWZTZ9TqwVy2dkl9gSDL
 h5234uiAA/9y741PT2sNDTczXE1sChiF/8X1HiuUipo4jqJFcaSexs3EVmygV34e89X8
 k8djMEXXdlM+ZfSiXmQX5xIkU1UV5FAuZGuMhtWVeGs4juml8lBdQILVdiL33AAWVWGW
 vBdlq6TMo1epDvd42rHezyZU+FSLImicPR3nDPsqz+CAlqFDZ9EXoiIgxbY1JP4ckY44
 Rz4RsTB+j5xk31gjIuasJRLS6rYRUmIxMysC0RyJe4wAHATKE65nuqfzfQCtVPbLBchT Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30b6hpfq2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 17:06:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DH1uQ0105916;
        Mon, 13 Apr 2020 17:06:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30bqpck88c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 17:06:04 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03DH5wCw006578;
        Mon, 13 Apr 2020 17:06:01 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Apr 2020 10:05:58 -0700
Date:   Mon, 13 Apr 2020 13:06:18 -0400
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
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3 05/10] mmap locking API: convert mmap_sem call sites
 missed by coccinelle
Message-ID: <20200413170618.3luttzyzwjsd5y26@ca-dmjordan1.us.oracle.com>
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-6-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327225102.25061-6-walken@google.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:50:57PM -0700, Michel Lespinasse wrote:
> Convert the last few remaining mmap_sem rwsem calls to use the new
> mmap locking API. These were missed by coccinelle for some reason
> (I think coccinelle does not support some of the preprocessor
> constructs in these files ?)

Adding the wrappers for instrumentation makes sense to me.  For patches 1-5,
you can add
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

I'll wait for the next version to review the rest.
