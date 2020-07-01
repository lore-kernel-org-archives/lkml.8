Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ADFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6BF1207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbgGAOcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:32:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:44452 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731328AbgGAOcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:32:19 -0400
IronPort-SDR: BLdzghiPKst31UcPYVThfCPiBLDbJGEnmGtRzdUXTmsTbPIwmngUgYMLUxKUsolObxlBO2qYFi
 yJi4+e3LcgMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="164601737"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="164601737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 07:32:18 -0700
IronPort-SDR: xMZRsEBocY4ou+X3JlDrChWzZ4wk4zF+4qSsdv8rZwGe+mSaTYpIZ1H1TrEOwIlNVZUdFGoDbi
 0Y5TB98auCeQ==
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="455124215"
Received: from rapyeatx-mobl3.amr.corp.intel.com (HELO [10.255.2.31]) ([10.255.2.31])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 07:32:17 -0700
Subject: Re: [RFC] [PATCH 0/8] Migrate Pages in lieu of discard
To:     Zi Yan <ziy@nvidia.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200629234503.749E5340@viggo.jf.intel.com>
 <CALvZod55OFzOozsDbyTkUh1uZEobo4CZ=+8JgrJJHw8QuWh0hw@mail.gmail.com>
 <654d785f-3fe5-d8bd-86bf-bf7431527184@intel.com>
 <CALvZod5-YuMC8b6rs=a_ahh0WF14wgKJBW18CARJtGa_bYUn0Q@mail.gmail.com>
 <fdfeb902-e363-f8b5-4c63-df224b9817fa@intel.com>
 <8927EC7B-76F2-4DFC-9AD8-EC2F15E3CEF9@nvidia.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <9c47b66b-f381-4b98-2e8f-7262e8567e15@intel.com>
Date:   Wed, 1 Jul 2020 07:32:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <8927EC7B-76F2-4DFC-9AD8-EC2F15E3CEF9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 7/1/20 7:24 AM, Zi Yan wrote:
> On 30 Jun 2020, at 15:31, Dave Hansen wrote:
>>> BTW is this proposal only for systems having multi-tiers of
>>> memory? Can a multi-node DRAM-only system take advantage of
>>> this proposal? For example I have a system with two DRAM nodes
>>> running two jobs hardwalled to each node. For each job the
>>> other node is kind of low-tier memory. If I can describe the
>>> per-job demotion paths then these jobs can take advantage of
>>> this proposal during occasional peaks.
>> I don't see any reason it could not work there.  There would just
>> need to be a way to set up a different demotion path policy that
>> what was done here.
> We might need a different threshold (or GFP flag) for allocating
> new pages in remote node for demotion. Otherwise, we could see
> scenarios like: two nodes in a system are almost full and Node A
> is trying to demote some pages to Node B, which triggers page
> demotion from Node B to Node A.

I've always assumed that migration cycles would be illegal since it's
so hard to guarantee forward reclaim progress with them in place.
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJe/J5kAAoJEGg1lTBwyZKw0TMP/1kufbxVGSY331xhOL/QHEoE
Tsuo62l2CJ/CbhIBKzac24k1Rf9AiyxUukkVZfa32c2Kf03XWjUNiWVuRPSTMlfT
E0h2llYYbUBs+eVeT4Ksz4xkThKHlXPNuS1OMhuSVbjhieiPqp3J0blohXaWdkSa
DBgpiqNlVPD7V0NIA5qfsumZRrOJDdJNdLKbjI7GBVprEHu5N/X0NQpakPErtcka
kSz7Hjv5x+fbd3rxc2QhrnegBE1oMQGUl14nf/kIKnKuZV2WIdabaxrYWrQBvALa
Z2sfcBRU41/SKvz/syCwJpSr1XkfsjNKvDMlkflXndMTzzP4/rhAyDX5Wzw99Aws
zz6UmRhZrFOudq4R5jpOqJiDfn1RGYA8mH04bEOPjEgGRiXaxi5Sp6fh/BQG5p7n
QESH0LVHEhg8h+10FWZ5VYU1UwMIdzolBI8Y8VlJDjeSpzSFyyDFP7Re3OyQRfmb
ij5ThSozo35t+zEYS4yofgPMZKJ/aZ+EySEF5LZsipKC2RsRuFFpaDSOOGXZKLXq
G/R9g2LeLZK6iNNlCrIGjeAAKN8UZzOMJwapYV8czt0HTQ2vRjuDE1Y2TRD6gjXI
x6vUCfFyOEJw4l3mca+Sb1pmFcaiXBRxBrat6q23Ls+eCDMIaTgx5wA7NEeq0Td7
yShQbtIvJKRubiscJlZ/
=MjgB
-----END PGP SIGNATURE-----
