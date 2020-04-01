Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B4DC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F012078C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B1OBTGwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbgDAQ4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:56:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56526 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732784AbgDAQUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:20:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031GIeiP192555;
        Wed, 1 Apr 2020 16:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=wf5Epvd2PkMi8L7E/eRCUSR0FOvN4Hz0yrwmht90YC0=;
 b=B1OBTGwNefZz4cvyBMFGvInJhvACIyJVqEmEJQzCbvhwtMRqnux8ubHv88gUbJgRISwc
 sgQmJYNDDopM8HVE9vyndAjbTtCMdIoiwwuWNaKk9Fq4z0IJsf82fb26GoPVQzVprvNE
 jH21TQWFzyg+ARWRC5s1+eg0c1gnH48JZE/Pn220xQB2xncVFBUZfdqqti5OQqxdAP3a
 xZ8NYJsN91wJTh/BMvle72pBf1hqadkuN3ealpyD49mz+IuVUHtzBFpryfpcFtHy++I9
 gvkQFQO+C0rK+UPXM/DX+49O9GfxjF/ObUeOj/4KTwr59M/btMolfsLq8nOLGAXPI0Ow TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 303aqhpxbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 16:19:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031GGsu9071569;
        Wed, 1 Apr 2020 16:17:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 302g2gwbn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 16:17:56 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 031GHspi005974;
        Wed, 1 Apr 2020 16:17:54 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Apr 2020 09:17:54 -0700
Date:   Wed, 1 Apr 2020 12:18:10 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
Message-ID: <20200401161810.xvqikca2x46yqrlx@ca-dmjordan1.us.oracle.com>
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <20200401154217.GQ22681@dhcp22.suse.cz>
 <dfc0014a-9b85-5eeb-70ea-d622ccf5d988@redhat.com>
 <20200401160048.GU22681@dhcp22.suse.cz>
 <20200401160929.jwekhr24tb44odea@ca-dmjordan1.us.oracle.com>
 <20200401161243.GW22681@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401161243.GW22681@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 06:12:43PM +0200, Michal Hocko wrote:
> On Wed 01-04-20 12:09:29, Daniel Jordan wrote:
> > On Wed, Apr 01, 2020 at 06:00:48PM +0200, Michal Hocko wrote:
> > > On Wed 01-04-20 17:50:22, David Hildenbrand wrote:
> > > > On 01.04.20 17:42, Michal Hocko wrote:
> > > > > This needs a double checking but I strongly believe that the lock can be
> > > > > simply dropped in this path.
> > 
> > This is what my fix does, it limits the time the resize lock is held.
> 
> Just remove it from the deferred intialization and add a comment that we
> deliberately not taking the lock here because abc

I think it has to be a little more involved because of the window where
interrupts might allocate during deferred init, as Vlastimil pointed out a few
years ago when the change was made.  I'll explain myself in the changelog.
