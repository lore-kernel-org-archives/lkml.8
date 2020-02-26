Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1AEC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E1920656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgBZTLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:11:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:19956 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgBZTLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:11:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 11:11:02 -0800
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="438538080"
Received: from unknown (HELO kcaccard-mobl1.jf.intel.com) ([10.24.11.14])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 11:11:01 -0800
Message-ID: <16822a0460e37e7a388217c63da8882d2904d8fc.camel@linux.intel.com>
Subject: Re: --orphan-handling=warn
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>
Date:   Wed, 26 Feb 2020 11:11:01 -0800
In-Reply-To: <202002252103.B4BBF01091@keescook>
References: <20200222072144.asqaxlv364s6ezbv@google.com>
         <20200222074254.GB11284@zn.tnic>
         <20200222162225.GA3326744@rani.riverdale.lan>
         <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
         <202002242122.AA4D1B8@keescook>
         <20200225182951.GA1179890@rani.riverdale.lan>
         <202002251140.4F28F0A4F@keescook>
         <CAKwvOdnkr1W4LTm8XmTKGkSDUhSBRowLbKwJwyitDMAGLh9ywg@mail.gmail.com>
         <202002251358.EDA50C11F@keescook>
         <20200226015606.ij7wn7emuj4bfkvn@google.com>
         <202002252103.B4BBF01091@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-25 at 21:35 -0800, Kees Cook wrote:
> 
> Thanks for looking into this! It'll be really nice to have the orphan
> section warnings working in the kernel. And getting the ground work
> for
> FGKASLR ready will be nice!
> 
> Kristen, can I convince you that FG stands for function-granular
> instead of fine-grain? :)
> 

Yes, sounds good to me - that way if we ever do basic block reordering
or some crazy thing like that we don't have to say even-finer-fine-
grained KASLR :).

Thanks for your help making this work.


