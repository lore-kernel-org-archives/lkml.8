Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5F0C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F05320753
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDUUCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:02:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:1449 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgDUUCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:02:41 -0400
IronPort-SDR: 9LMCkZh6WqQfef3hyLjgYEId+QPsf/GuENHrfZrTkyQ46bB39l3oGPtA0tAMjIeKROPmyxTKJ6
 hTqkm7kFRpqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 13:02:39 -0700
IronPort-SDR: WGO5L1b5M/SkryVnOfAy0jnwxIRI1aVohTJFLb5GtiSS48MxksDrmoyJJOkdTf3nxB3nh1UTcN
 gf4S1rIQoxLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="290589627"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga002.fm.intel.com with ESMTP; 21 Apr 2020 13:02:38 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C5CCC3019B6; Tue, 21 Apr 2020 13:02:37 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:02:37 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Message-ID: <20200421200237.GF608746@tassilo.jf.intel.com>
References: <20200421160622.GJ1809@sasha-vm>
 <BB51CFEA-A635-4664-821C-B57094AE95F0@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BB51CFEA-A635-4664-821C-B57094AE95F0@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The very early versions had severely problematic ABIs. The new ones are probably okay except for, maybe, ptrace.  If we had merged the old ones, then we might have gotten stuck with the old, problematic ABI.

This is beyond vague. Is there a problem with the ABI or not?

If yes please point it out in an actionable concrete way that it can
be addressed.

If not there shouldn't be any reason to further block it.

Thanks

-Andi
