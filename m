Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105B9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 03:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16AC20878
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 03:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WL6U4IPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgFLD34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 23:29:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59270 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgFLD34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 23:29:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05C3NMO1116572;
        Fri, 12 Jun 2020 03:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=3r/RFyunZuTefVau6GRBcKb6mgNqSQqMP2oHRrS/4LU=;
 b=WL6U4IPjmtDQuEekJhKmta2nvIGEmMSRlZu+xJtd1BDk8o8JUoDRjLc97bGZfPhHp8yj
 SX8xI2+IZmMiujumSfqgcrLuQvDsjyrmwSIEg7rrJinZN5NqW/7ESPZqNhGT7CkuLQmi
 fNQgnJbcTucwgD1REL+tooy0smwpL7vdnp01worxGjUMV3wOtXbQIhVfPjyMUwJ7xCpj
 wOIw2rFaMiNTnxPd6wvY4pJENY/rgG2CYJ58jhG2sQ9XasTC/iPPDPJq1XBX+sKUeZDQ
 GrdxFiXdQbNX8y5Lzpke5clp21xsZ9MYTipjwDpWZ1nPuvWChWe+k4KVFY6Rl1j/YBMN yQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31g2jrk0ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 03:29:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05C3MtIB154197;
        Fri, 12 Jun 2020 03:29:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31m1rhgnke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 03:29:36 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05C3TYtc008852;
        Fri, 12 Jun 2020 03:29:34 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 20:29:33 -0700
Date:   Thu, 11 Jun 2020 23:29:59 -0400
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
Message-ID: <20200612032959.yo43ydg273zu35lx@ca-dmjordan1.us.oracle.com>
References: <20200609225451.3542648-1-daniel.m.jordan@oracle.com>
 <dc869b25-db3c-8c68-3278-8688c5288632@intel.com>
 <20200611165910.6dwd3c7z5brimjbm@ca-dmjordan1.us.oracle.com>
 <adcd3359-a90b-ab62-60e1-102277533e11@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adcd3359-a90b-ab62-60e1-102277533e11@intel.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 10:05:38AM -0700, Dave Hansen wrote:
> One other nit for this.  We *do* have actual hardware hotplug, and I'm
> pretty sure the alignment guarantees for hardware hotplug are pretty
> weak.  For instance, the alignment guarantees for persistent memory are
> still only 64MB even on modern platforms.
>
> Let's say we're on bare metal and we see an SRAT table that has some
> areas that show that hotplug might happen there.  Is this patch still
> ideal there?

Well, not if there's concern about hardware hotplug.

My assumption going in was that this wasn't a problem in practice.
078eb6aa50dc50 ("x86/mm/memory_hotplug: determine block size based on the end
of boot memory") was merged in 2018 to address qemu hotplug failures and >64G
systems have used a 2G block since 2014 with no complaints about alignment
issues, to my knowledge anyway.
