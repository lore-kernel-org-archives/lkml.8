Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CE1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F131C2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgHUIGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgHUIFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:05:40 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19349C061385;
        Fri, 21 Aug 2020 01:05:39 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 744CF2AC; Fri, 21 Aug 2020 10:05:34 +0200 (CEST)
Date:   Fri, 21 Aug 2020 10:05:31 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Mike Stunes <mstunes@vmware.com>
Cc:     "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v5 00/75] x86: SEV-ES Guest Support
Message-ID: <20200821080531.GC3319@8bytes.org>
References: <20200724160336.5435-1-joro@8bytes.org>
 <B65392F4-FD42-4AA3-8AA8-6C0C0D1FF007@vmware.com>
 <20200730122645.GA3257@8bytes.org>
 <F5603CBB-31FB-4EE8-B67A-A1F2DBEE28D8@vmware.com>
 <20200818150746.GA3319@8bytes.org>
 <6F9275F4-D5A4-4D30-8729-A57989568CA7@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6F9275F4-D5A4-4D30-8729-A57989568CA7@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Thu, Aug 20, 2020 at 12:58:13AM +0000, Mike Stunes wrote:
> Yes, I still see the issue — APs are offline after boot. I’ll spend
> some time seeing if I can figure out what the problem is. Thanks!

Tom and a few others debugged another FSGSBASE issue yesterday, which I
think might also be the cause for the AP startup problems you are
seeing (if you test on Rome).

Can you try to disable support for RDPID in the guest, but keep fsgsbase
enabled?

Thanks,

	Joerg
