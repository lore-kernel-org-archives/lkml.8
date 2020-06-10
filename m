Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9ECC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF39020823
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hFI/zbFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgFJRQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:16:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39476 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgFJRQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:16:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AH6uQs063813;
        Wed, 10 Jun 2020 17:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=wS59L6vvmXCNVjet98GjK9oBN+CCQZkrpA0QujBKnZ0=;
 b=hFI/zbFTbjyY+2aOzvewZqBosGcClAxVbT0+kAM6xB3ZHBpK5V3EPPXo38hjj0YtJ4eq
 zYnfMN4F5I8HgV5jzWYQC+vBqaeBdxP8XukOyvlNW9Fn0Nj8DBc2Kxr6+wekrRpiAxKX
 t090KhG2PgRT8ejwtNCAWxHS5ZyF2aEd99aJkcv1occx9JtkfRxSt/u2uY03oKJP495/
 FplrxaX5iOruXxEyR7LKtLZI7ebNnmwKLi7FUAloPT0tZVhH38DlYuD2bL1Fu6sM558o
 cq4FVBBAfxkmg6lfkoBgchHtkEOgxKzTPq57lrfMIEmpkr/nMN2Z3Pm89vujUYT0dSFY 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31jepnwg61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 17:16:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AH7km6024523;
        Wed, 10 Jun 2020 17:16:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31gn2ytctv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 17:16:13 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05AHG8P1014115;
        Wed, 10 Jun 2020 17:16:12 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jun 2020 10:16:07 -0700
Date:   Wed, 10 Jun 2020 13:16:32 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v2] x86/mm: use max memory block size on bare metal
Message-ID: <20200610171632.uiaucnp65tg6xexk@ca-dmjordan1.us.oracle.com>
References: <20200609225451.3542648-1-daniel.m.jordan@oracle.com>
 <ab4e0907-522d-7834-03f3-014e3ed904c5@redhat.com>
 <0311c2e5-aa27-f59e-cd00-0c51332b73fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0311c2e5-aa27-f59e-cd00-0c51332b73fd@redhat.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 09:30:00AM +0200, David Hildenbrand wrote:
> On 10.06.20 09:20, David Hildenbrand wrote:
> > On 10.06.20 00:54, Daniel Jordan wrote:
> >> @@ -1390,6 +1391,15 @@ static unsigned long probe_memory_block_size(void)
> >>  		goto done;
> >>  	}
> >>  
> >> +	/*
> >> +	 * Use max block size to minimize overhead on bare metal, where
> >> +	 * alignment for memory hotplug isn't a concern.
> >> +	 */
> >> +	if (hypervisor_is_type(X86_HYPER_NATIVE)) {
> >> +		bz = MAX_BLOCK_SIZE;
> >> +		goto done;
> >> +	}
> > 
> > I'd assume that bioses on physical machines >= 64GB will not align
> > bigger (>= 2GB) DIMMs to something < 2GB.
> > 
> > Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

> FTWT, setup_arch() does the init_hypervisor_platform() call. I assume
> that should be early enough.

I checked all the places where x86 uses memory_block_size_bytes(), it looks ok.
