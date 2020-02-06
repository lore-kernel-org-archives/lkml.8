Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCD4C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B26A20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgBFRnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:43:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:51172 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbgBFRnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:43:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 09:43:21 -0800
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="379136126"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.24.10.96])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 09:43:21 -0800
Message-ID: <a5ef8954d7f9148f0909ae8a94f66f2ae72ed08d.camel@linux.intel.com>
Subject: Re: [RFC PATCH 08/11] x86: Add support for finer grained KASLR
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Date:   Thu, 06 Feb 2020 09:43:21 -0800
In-Reply-To: <20200206173538.GY14914@hirez.programming.kicks-ass.net>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
         <20200205223950.1212394-9-kristen@linux.intel.com>
         <20200206103830.GW14879@hirez.programming.kicks-ass.net>
         <202002060356.BDFEEEFB6C@keescook>
         <20200206145253.GT14914@hirez.programming.kicks-ass.net>
         <9f337efdf226e51e3f5699243623e5de7505ac94.camel@linux.intel.com>
         <20200206173538.GY14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-06 at 18:35 +0100, Peter Zijlstra wrote:
> On Thu, Feb 06, 2020 at 09:25:01AM -0800, Kristen Carlson Accardi
> wrote:
> 
> > That's right - all of these tables that you mention had relocs and
> > thus
> > I did not have to do anything special for them. The orc_unwind_ip
> > tables get sorted during unwind_init(). 
> 
> No they're not:
> 
>   f14bf6a350df ("x86/unwind/orc: Remove boot-time ORC unwind tables
> sorting")
> 
> Or rather, it might be you're working on an old tree.

Doh! Ok, I can make a patch to add it back based on CONFIG_FG_KASLR, or
just do yet another resort at boot time.


