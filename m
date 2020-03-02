Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F10C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DE720842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgCBTT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:19:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:7782 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbgCBTT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:19:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 11:19:55 -0800
X-IronPort-AV: E=Sophos;i="5.70,508,1574150400"; 
   d="scan'208";a="228570400"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.24.8.183])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 11:19:55 -0800
Message-ID: <66d6506278121f22c4360110c38ee3653e4fb1c6.camel@linux.intel.com>
Subject: Re: [RFC PATCH 09/11] kallsyms: hide layout and expose seed
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Date:   Mon, 02 Mar 2020 11:19:55 -0800
In-Reply-To: <202003021107.38017F90@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
         <20200205223950.1212394-10-kristen@linux.intel.com>
         <202002060428.08B14F1@keescook>
         <a915e1eb131551aa766fde4c14de5a3e825af667.camel@linux.intel.com>
         <CAG48ez2SucOZORUhHNxt-9juzqcWjTZRD9E_PhP51LpH1UqeLg@mail.gmail.com>
         <41d7049cb704007b3cd30a3f48198eebb8a31783.camel@linux.intel.com>
         <202003021107.38017F90@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-02 at 11:08 -0800, Kees Cook wrote:
> On Mon, Mar 02, 2020 at 11:01:56AM -0800, Kristen Carlson Accardi
> wrote:
> > On Thu, 2020-02-06 at 20:27 +0100, Jann Horn wrote:
> > > https://codesearch.debian.net/search?q=%2Fproc%2Fkallsyms&literal=1
> > 
> > I looked through some of these packages as Jann suggested, and it
> > seems
> > like there are several that are using /proc/kallsyms to look for
> > specific symbol names to determine whether some feature has been
> > compiled into the kernel. This practice seems dubious to me,
> > knowing
> > that many kernel symbol names can be changed at any time, but
> > regardless seems to be fairly common.
> 
> Cool, so a sorted censored list is fine for non-root. Would root
> users
> break on a symbol-name-sorted view? (i.e. are two lists needed or can
> we
> stick to one?)
> 

Internally of course we'll always have to have 2 lists. I couldn't find
any examples of even root users needing the list to be in order by
address. At the same time, it feels like a less risky thing to do to
leave root users with the same thing they've always had and only muck
with non-root users.


