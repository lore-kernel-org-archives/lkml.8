Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E493C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3882192A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBFRZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:25:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:7210 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgBFRZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:25:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 09:25:02 -0800
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="232110534"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.24.10.96])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 09:25:02 -0800
Message-ID: <9f337efdf226e51e3f5699243623e5de7505ac94.camel@linux.intel.com>
Subject: Re: [RFC PATCH 08/11] x86: Add support for finer grained KASLR
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Date:   Thu, 06 Feb 2020 09:25:01 -0800
In-Reply-To: <20200206145253.GT14914@hirez.programming.kicks-ass.net>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
         <20200205223950.1212394-9-kristen@linux.intel.com>
         <20200206103830.GW14879@hirez.programming.kicks-ass.net>
         <202002060356.BDFEEEFB6C@keescook>
         <20200206145253.GT14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-06 at 15:52 +0100, Peter Zijlstra wrote:
> On Thu, Feb 06, 2020 at 04:06:17AM -0800, Kees Cook wrote:
> > On Thu, Feb 06, 2020 at 11:38:30AM +0100, Peter Zijlstra wrote:
> > > On Wed, Feb 05, 2020 at 02:39:47PM -0800, Kristen Carlson Accardi
> > > wrote:
> > > > +static long __start___ex_table_addr;
> > > > +static long __stop___ex_table_addr;
> > > > +static long _stext;
> > > > +static long _etext;
> > > > +static long _sinittext;
> > > > +static long _einittext;
> > > 
> > > Should you not also adjust __jump_table, __mcount_loc,
> > > __kprobe_blacklist and possibly others that include text
> > > addresses?
> > 
> > These don't appear to be sorted at build time. 
> 
> The ORC tables are though:
> 
>   57fa18994285 ("scripts/sorttable: Implement build-time ORC unwind
> table sorting")
> 
> > AIUI, the problem with
> > ex_table and kallsyms is that they're preprocessed at build time
> > and
> > opaque to the linker's relocation generation.
> 
> I was under the impression these tables no longer had relocation
> data;
> that since they're part of the main kernel, the final link stage
> could
> completely resolve them.
> 
> That said, I now see we actually have .rela__extable
> .rela.orc_unwind_ip
> etc.

That's right - all of these tables that you mention had relocs and thus
I did not have to do anything special for them. The orc_unwind_ip
tables get sorted during unwind_init(). If they are needed earlier than
that, then they could be re-sorted like we do with the exception table.



