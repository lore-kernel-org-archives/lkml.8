Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95FCC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30C72072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbgCSRxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:53:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:57567 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgCSRxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:53:06 -0400
IronPort-SDR: jgJJQVo8LfQqtnIUZ+0fs3gfQHd0eWE3O9PSL7V3pI535PTnWJsdSgfnDxFauplT3A851uF9hO
 Onv++lwmQvuw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 10:53:00 -0700
IronPort-SDR: oVW2A+P+v8UZ1v3CjfxeeilfiC243H2UiYB328K62YrscNe2463SDKKZlfrmRo9aAv28qSH7AH
 62hKZS4TO+Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="356107676"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2020 10:52:59 -0700
Date:   Thu, 19 Mar 2020 10:52:59 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        syzbot+00be5da1d75f1cc95f6b@syzkaller.appspotmail.com
Subject: Re: [PATCH] KVM: x86: remove bogus user-triggerable WARN_ON
Message-ID: <20200319175259.GE11305@linux.intel.com>
References: <20200319174318.20752-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319174318.20752-1-pbonzini@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 01:43:18PM -0400, Paolo Bonzini wrote:
> The WARN_ON is essentially comparing a user-provided value with 0.  It is
> trivial to trigger it just by passing garbage to KVM_SET_CLOCK.  Guests
> can break if you do so, but if it hurts when you do like this just do not
> do it.
> 
> Reported-by: syzbot+00be5da1d75f1cc95f6b@syzkaller.appspotmail.com
> Fixes: 9446e6fce0ab ("KVM: x86: fix WARN_ON check of an unsigned less than zero")
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
