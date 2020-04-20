Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD31C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B3A20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgDTONZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:13:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:35570 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDTONV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:13:21 -0400
IronPort-SDR: VES5JTzJEPlEsMu7awp9pQ1kfKCm4eE+4lEyhNjrlOnr+gXmlaA2T71/YoBsy2zPM1czYbqzQs
 94NuKmvf7pYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 07:13:20 -0700
IronPort-SDR: C5YEjk16KLceQ2xbcuHuxxgUq8Hl+pWRxukmQvSdIVbsp/4O33LXueqrv+89YaMIrfAgeqKblO
 eXZHU++Va91A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="245378864"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga007.fm.intel.com with ESMTP; 20 Apr 2020 07:13:20 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4D8943019B5; Mon, 20 Apr 2020 07:13:20 -0700 (PDT)
Date:   Mon, 20 Apr 2020 07:13:20 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Message-ID: <20200420141320.GC608746@tassilo.jf.intel.com>
References: <20191115191200.GD22747@tassilo.jf.intel.com>
 <A78C989F6D9628469189715575E55B236B50834A@IRSMSX104.ger.corp.intel.com>
 <CALCETrXc=-k3fQyxjBok0npjTMr6-Ho7+pkvzDUdG=b52Qz=9g@mail.gmail.com>
 <A78C989F6D9628469189715575E55B236B508C1A@IRSMSX104.ger.corp.intel.com>
 <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com>
 <29FD6626-4347-4B79-A027-52E44C7FDE55@intel.com>
 <20200413200336.GA11216@sasha-vm>
 <20200414003205.GF397326@tassilo.jf.intel.com>
 <20200417133021.GT1068@sasha-vm>
 <CALCETrW6LLmFR5Y6tmH=nPThCHefysf_nNwxHOFp4tAY4Spunw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW6LLmFR5Y6tmH=nPThCHefysf_nNwxHOFp4tAY4Spunw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Now maybe no one cares about #4.  

Yes noone cares. Selectors are largely obsolete.

> the *gdb developers* don't care.  But gdb isn't exactly a good example
> of a piece of software that tries to work correctly when dealing with
> unusual software.  Maybe other things like rr will care more.  It

rr is used to replay modern software, and modern software
doesn't care about selectors, thus rr doesn't care either.

Please stop the FUD.

Thanks,
-Andi
