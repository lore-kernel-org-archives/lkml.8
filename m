Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DDBC2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822D32078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgDJUpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:45:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:37826 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgDJUpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:45:09 -0400
IronPort-SDR: 3whyYo5dZuhI1StrbKFEn1HUarpQ0K5SxClT5/nlCXxlcwEsW9G8fBBE+BQMscIWPYAjmY0sfP
 gItFvQNQpJaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 13:45:09 -0700
IronPort-SDR: Ida5El/CDEgkpHlIE1XkMu5+hmSvqVIP63Z+oh/fQEnmStIi9kcXxf8FgolAcp0RC8MhUdrVCZ
 aECBWHySm81Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="scan'208";a="276291867"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2020 13:45:09 -0700
Date:   Fri, 10 Apr 2020 13:45:09 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, drjones@redhat.com,
        david@redhat.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krish.sadhukhan@oracle.com
Subject: Re: [PATCH v5 0/2] selftests: kvm: Introduce the mem_slot_test test
Message-ID: <20200410204509.GK22482@linux.intel.com>
References: <20200409220905.26573-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409220905.26573-1-wainersm@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 07:09:03PM -0300, Wainer dos Santos Moschetta wrote:
> This series introduces a new KVM selftest (mem_slot_test) that goal
> is to verify memory slots can be added up to the maximum allowed. An
> extra slot is attempted which should occur on error.
> 
> The patch 01 is needed so that the VM fd can be accessed from the
> test code (for the ioctl call attempting to add an extra slot).
> 
> I ran the test successfully on x86_64, aarch64, and s390x.  This
> is why it is enabled to build on those arches.

Any objection to folding these patches into a series I have to clean up
set_memory_region_test (which was mentioned in a prior version) and add
this as a testcase to set_memory_region_test instead of creating a whole
new test?

A large chunk of set_memory_region_test will still be x86_64 only, but
having the test reside in common code will hopefully make it easier to
extend to other architectures.
