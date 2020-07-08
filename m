Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5770CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9A7206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbgGHQsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:48:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:5694 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730349AbgGHQsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:48:00 -0400
IronPort-SDR: grbue0tLZSA/hSNVDlc9X5v0WG8C/pblu/HZCRslU1ECRiIQQkFvdi330uQdURbA+g8GPinZsf
 p3xFJN4ctXJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="147859201"
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="147859201"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 09:47:59 -0700
IronPort-SDR: 6MMsL8LobZj0NHElNGCZR9i1cX0Q5HUgnhNzrWmrFw9BeX368h7tv6pHkD8THPX8VxVTuCLjrj
 HtBYQMlWkiJw==
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="280009112"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.209.55.243])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 09:47:57 -0700
Message-ID: <6cba1bdea35eb19492c5d2674f2a58aae8635155.camel@linux.intel.com>
Subject: Re: [PATCH v3 09/10] kallsyms: Hide layout
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date:   Wed, 08 Jul 2020 09:47:55 -0700
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F68AC3B@ORSMSX115.amr.corp.intel.com>
References: <20200623172327.5701-1-kristen@linux.intel.com>
         <20200623172327.5701-10-kristen@linux.intel.com>
         <CAG48ez3YHoPOTZvabsNUcr=GP-rX+OXhNT54KcZT9eSQ28Fb8Q@mail.gmail.com>
         <202006240815.45AAD55@keescook>
         <f34eb868e609a1a8a7f19b77fe5d00bf3555bb00.camel@linux.intel.com>
         <3908561D78D1C84285E8C5FCA982C28F7F68AC3B@ORSMSX115.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-07 at 23:16 +0000, Luck, Tony wrote:
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Tested-by: Tony Luck <tony.luck@intel.com>
> 
> I'll happily review and test again ... but since you've made
> substantive
> changes, you should drop these tags until I do.

Will do - thanks! If nobody thinks this is a horrible direction, I'll
clean up this patch and submit it with the rest as part of v4.

> 
> FWIW I think random order is a good idea.  Do you shuffle once?
> Or every time somebody opens /proc/kallsyms?

I am shuffling every single time that somebody opens /proc/kallsyms -
this is because it's possible that somebody has loaded modules or bpf
stuff and there may be new/different symbols to display.


