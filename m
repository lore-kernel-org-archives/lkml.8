Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4592CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B86A20756
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgEORzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:55:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:17940 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgEORzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:55:50 -0400
IronPort-SDR: iSBZmHUl0AyrPoSGEk2gU4+OSPIJ2896RYl/sRZOoTlPb3ULpmHVhErE0n3oQFl6EYAbb9UcNN
 UeCpHOdbcdQA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 10:55:50 -0700
IronPort-SDR: kOXZFks6zNMq5aNddunKZXfcLmzxdbvtqz0sta1Cx4xMRY6kxz5uq0JTPAh0XyuhTsgCaC6rYQ
 51ThK6E2oI4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="464978376"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga006.fm.intel.com with ESMTP; 15 May 2020 10:55:50 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 29E68301AAA; Fri, 15 May 2020 10:55:50 -0700 (PDT)
Date:   Fri, 15 May 2020 10:55:50 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, hpa@zytor.com, dave.hansen@intel.com,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200515175550.GP3538@tassilo.jf.intel.com>
References: <20200511045311.4785-1-sashal@kernel.org>
 <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
 <20200515164013.GF29995@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515164013.GF29995@sasha-vm>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Indeed, we've seen a few hacks that basically just enable FSGSBASE:
> 
> - https://github.com/oscarlab/graphene-sgx-driver
> - https://github.com/occlum/enable_rdfsbase
> 
> And would very much like to get rid of them...

These are insecure and open root holes without the patches
used here.

-Andi
