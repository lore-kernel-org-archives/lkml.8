Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E468EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C129220734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgFIU7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:59:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:62079 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbgFIU72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:59:28 -0400
IronPort-SDR: 5lDixr/p/vdxV4ZZj5a+19kyLXJID/gFnj438kBPkXHByo3Q8w5ok1TXJFuTIyPFeYrspL0Fg+
 B+XgYjjxk5gw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 13:59:27 -0700
IronPort-SDR: 0vHmxfcitgPq5aKmNiGaVNQijFphGRlPrPDnuFjSkrhPPNB25B1St8GMgMcxR6MjfyxsAjnbVY
 zDskt/CGzVyw==
X-IronPort-AV: E=Sophos;i="5.73,493,1583222400"; 
   d="scan'208";a="314305536"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.209.86.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 13:59:26 -0700
Message-ID: <fe529a4479b90d609937c10efb27394feda384a4.camel@linux.intel.com>
Subject: Re: [PATCH v2 9/9] module: Reorder functions
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Date:   Tue, 09 Jun 2020 13:59:23 -0700
In-Reply-To: <202006091331.A94BB0DA@keescook>
References: <20200521165641.15940-1-kristen@linux.intel.com>
         <20200521165641.15940-10-kristen@linux.intel.com>
         <202005211415.5A1ECC638@keescook>
         <9fdea0bc0008eccd6dfcad496b37930cf5bd364a.camel@linux.intel.com>
         <202006091331.A94BB0DA@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-09 at 13:42 -0700, Kees Cook wrote:
> On Tue, Jun 09, 2020 at 01:14:04PM -0700, Kristen Carlson Accardi
> wrote:
> > On Thu, 2020-05-21 at 14:33 -0700, Kees Cook wrote:
> > > Oh! And I am reminded suddenly about CONFIG_FG_KASLR needing to
> > > interact
> > > correctly with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION in that we do
> > > NOT
> > > want the sections to be collapsed at link time:
> > 
> > sorry - I'm a little confused and was wondering if you could
> > clarify
> > something. Does this mean you expect CONFIG_FG_KASLR=y and
> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y to be a valid config? I am
> > not
> 
> Yes, I don't see a reason they can't be used together.
> 
> > familiar with the option, but it seems like you are saying that it
> > requires sections to be collapsed, in which case both of these
> > options
> > as yes would not be allowed? Should I actively prevent this in the
> > Kconfig?
> 
> No, I'm saying that CONFIG_LD_DEAD_CODE_DATA_ELIMINATION does _not_
> actually require that the sections be collapsed, but the Makefile
> currently does this just to keep the resulting ELF "tidy". We want
> that disabled (for the .text parts) in the case of CONFIG_FG_KASLR.
> The
> dead code elimination step, is, IIUC, done at link time before the
> output sections are written.
> 

Ah ok, that makes sense. Thanks.


