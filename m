Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2802DC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E59520736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgDXOVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:21:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:51365 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgDXOVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:21:19 -0400
IronPort-SDR: EGUADPmuQpoAJeAE70gnWNAz84OOrGkcyAwBgKkoll4mFBBeeLbS1K6inQfFaDKNkH5b7erCXY
 +zhWcHdX+8EA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 07:21:18 -0700
IronPort-SDR: T4Dh+fjk2m2SVbIGw5lcG37MzigVUM71dhtRiCFQq4RsVNQyWYTuqKrw8ecxdH71vMwvzqV1b+
 bOLsTjqosHjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="403313438"
Received: from unknown (HELO localhost) ([10.239.159.128])
  by orsmga004.jf.intel.com with ESMTP; 24 Apr 2020 07:21:15 -0700
Date:   Fri, 24 Apr 2020 22:23:17 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        jmattson@google.com, yu.c.zhang@linux.intel.com
Subject: Re: [PATCH v11 9/9] KVM: X86: Set CET feature bits for CPUID
 enumeration
Message-ID: <20200424142317.GG24039@local-michael-cet-test>
References: <20200326081847.5870-1-weijiang.yang@intel.com>
 <20200326081847.5870-10-weijiang.yang@intel.com>
 <20200423165812.GC25564@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423165812.GC25564@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 09:58:12AM -0700, Sean Christopherson wrote:
> For the shortlog, use something like
> 
>   KVM: x86: Enable CET virtualization and advertise CET to userspace
> 
> It took me a while to find the patch that actually allowed setting CR4.CET
> because I was only scanning the shortlogs :-)
I always feel it's hard for me to get a good shortlog, sorry for
the inconvenience :-(
