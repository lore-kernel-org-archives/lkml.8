Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5542077D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jhu/uGxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgFBEsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:48:15 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19237 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgFBEsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:48:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed5d9ae0000>; Mon, 01 Jun 2020 21:46:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 01 Jun 2020 21:48:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 01 Jun 2020 21:48:14 -0700
Received: from [10.2.56.10] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Jun
 2020 04:48:09 +0000
Subject: Re: [PATCH] mm/vmstat: Add events for PMD based THP migration without
 split
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     <linux-mm@kvack.org>, <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <1590118444-21601-1-git-send-email-anshuman.khandual@arm.com>
 <20200601165736.qw5kwwknxltk7bv6@ca-dmjordan1.us.oracle.com>
 <0a936ec7-f44f-1d72-915f-f5758d25fd72@nvidia.com>
 <1e71d815-5359-3ebe-5d2b-5a3b54b63b51@arm.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <274be3bf-2206-5e98-8114-1d91fac472c9@nvidia.com>
Date:   Mon, 1 Jun 2020 21:48:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1e71d815-5359-3ebe-5d2b-5a3b54b63b51@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591073198; bh=u6lPTpjCI+gaUy3MTSH/RHMFz1vUb7fWJf9p4QDoBpE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jhu/uGxUYNr5WDT8xucP55UuqM1volhBWfQ0lBWdtIuuZdfrAA/Z+q5I3/BUmzOZ5
         FdxVLonV+v6bmCPw2shM8XVJP8T/wyHN948EA5e9FhCqlvpzRLH6vVNTex6f5jLkg+
         8c+dLGaySGxQd7DA/lmfMek9SxuVWlrwcoSVBISJP+pqFLAMHAq0t/uV3vZSORAcWW
         fdbVOOb+uh2SvWbWim3WND6Y54GBAcRFH5SSgz+VnPFLsvYpurwEeoqA7pSrOreUbJ
         RW5VIIvTM5OswNTiZDNgQ0r7xvhN5NVC2xLXGFcrGaEimlrF9kV8+Hu7PwQMEtDogX
         DTJbUb9TM1yrg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-01 21:20, Anshuman Khandual wrote:
...
>> also important: maybe this patch should also be tracking other causes
>> of THP PMD migration failure, in order to get a truer accounting of the
>> situation.

I hope one of the experts here can weigh in on that...

> Is there any other failure reasons which are only specific to THP migration.
> Else, adding stats about generic migration failure reasons will just blur
> the overall understanding about THP migration successes and failure cases
> that results in splitting.
> 

Thinking about that: we do have PGMIGRATE_SUCCESS and PGMIGRATE_FAIL, so I
suppose comparing those numbers with the new THP_PMD_MIGRATION_SUCCESS and
THP_PMD_MIGRATION_FAILURE events should cover it.

However, the fact that this is under discussion hints at the need for a
bit of documentation help. What do you think about adding some notes about
all of this to, say, Documentation/vm/page_migration.rst ?

thanks,
-- 
John Hubbard
NVIDIA
