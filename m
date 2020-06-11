Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A9DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AFA206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ymBiEkAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgFKQ7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:59:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34820 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgFKQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:59:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BGr7IF092042;
        Thu, 11 Jun 2020 16:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=pATssJ82ubYGIfysCxQP65ExUCwZERILo2N1U80Ii2M=;
 b=ymBiEkAWF8S8FJFO5+E1nZzVGvGj5tvwF9MQHSMRfCe0zn/6Zd8KfSKZmXzecXKptOjP
 u027pNP7g2yBCYKO4lgyzKJWMAWLowT6TN4mv1VR0YpxZNaG1WNEUVNiqEFZwsHHpYKG
 xzcC+gLzGjRfA1qjLSKjMoA4nXEHL7EgVV7Bb0KgrIG7r5/r8Q12jjMF0ydGeWa2kM80
 c9Kh+t3ngVJF6eN4mUFqXu3dwBdm9hZLmjLYhiLY9yQwkzRp79HVJ/um3pZ4sWTWsfY3
 kDvUiX7fekE/tO2RlNuK5MVokUGjKbf7x/y+uMJPrfELtWrYagy38ctV0+rVwLEAXQDE 8g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31jepp2v65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jun 2020 16:58:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BGs9kl046671;
        Thu, 11 Jun 2020 16:58:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31gmqsdpp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 16:58:50 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05BGwihH031049;
        Thu, 11 Jun 2020 16:58:48 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 09:58:44 -0700
Date:   Thu, 11 Jun 2020 12:59:10 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v2] x86/mm: use max memory block size on bare metal
Message-ID: <20200611165910.6dwd3c7z5brimjbm@ca-dmjordan1.us.oracle.com>
References: <20200609225451.3542648-1-daniel.m.jordan@oracle.com>
 <dc869b25-db3c-8c68-3278-8688c5288632@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc869b25-db3c-8c68-3278-8688c5288632@intel.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006110133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 07:16:02AM -0700, Dave Hansen wrote:
> On 6/9/20 3:54 PM, Daniel Jordan wrote:
> > +	/*
> > +	 * Use max block size to minimize overhead on bare metal, where
> > +	 * alignment for memory hotplug isn't a concern.
> > +	 */
> > +	if (hypervisor_is_type(X86_HYPER_NATIVE)) {
> > +		bz = MAX_BLOCK_SIZE;
> > +		goto done;
> > +	}
> 
> What ends up being the worst case scenario?  Booting a really small
> bare-metal x86 system, say with 64MB or 128MB of RAM?  What's the
> overhead there?

Might not be following you, so bear with me, but we only get to this check on a
system with a physical address end of at least MEM_SIZE_FOR_LARGE_BLOCK (64G),
and this would still (ever so slightly...) reduce overhead of memory block init
at boot in that case.
