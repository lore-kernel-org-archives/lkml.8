Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B88C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 04:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC53F207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 04:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgEWETa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 00:19:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:13131 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgEWET3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 00:19:29 -0400
IronPort-SDR: Keyzep65a6EtPqBqxEVdyUlXeauHDlRuhIX2DaRAgMtDcvm52Q1Ont+y2n3qcLJfDDmUMoiq/g
 hFZ/KrCpmDfA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 21:19:29 -0700
IronPort-SDR: rpiurWJ+oFUBqukQpqVgrxtkeoWbz5PLleNm/cebf4hgnIWdDiecDJMq06DaOoVkyYVDps+yT/
 YTe87xmjt94w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,424,1583222400"; 
   d="scan'208";a="467494390"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga006.fm.intel.com with ESMTP; 22 May 2020 21:19:28 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4D93F301A90; Fri, 22 May 2020 21:19:28 -0700 (PDT)
Date:   Fri, 22 May 2020 21:19:28 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Don Porter <porter@cs.unc.edu>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200523041928.GU499505@tassilo.jf.intel.com>
References: <20200511045311.4785-1-sashal@kernel.org>
 <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
 <20200515164013.GF29995@sasha-vm>
 <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
 <20200518153407.GA499505@tassilo.jf.intel.com>
 <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
 <20200519164853.GA19706@linux.intel.com>
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Setting the fs register in userspace is an essential feature for running
> legacy code in SGX.  We have been following LKML discussions on this
> instruction for years, and hoping this feature would be supported by Linux,

If you need a feature you should comment on it. One of the reasons
it took so long is that the users didn't speak up.


-Andi
