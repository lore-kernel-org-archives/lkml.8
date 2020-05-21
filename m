Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F65C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1831D204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgEUVnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:43:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:45314 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgEUVnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:43:01 -0400
IronPort-SDR: I+FSU/JJ36wTN2AM3ylGKxvF2IdoxUvIrbP5QUc1vMd6qrvJ4TfBbhWpIKIAoz2CfaMMEQqOcg
 8RWF4i/umq0A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 14:43:00 -0700
IronPort-SDR: VrRXXdswApTlmZiOJa6cs5ElnoZWHUwIDfzGnv+RA2jY/ZIdpIR0z5RnIuWMewWb6r5X06yxA5
 OInBbJzWRJuQ==
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="300460084"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.147.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 14:42:58 -0700
Message-ID: <7c8685090dd36ab0175ae91d1421f4cd7fb6aff0.camel@linux.intel.com>
Subject: Re: [PATCH v2 7/9] x86: Add support for function granular KASLR
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com, Tony Luck <tony.luck@intel.com>,
        linux-doc@vger.kernel.org
Date:   Thu, 21 May 2020 14:42:56 -0700
In-Reply-To: <202005211301.4853672E2@keescook>
References: <20200521165641.15940-1-kristen@linux.intel.com>
         <20200521165641.15940-8-kristen@linux.intel.com>
         <202005211301.4853672E2@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,
Thanks for your review - I will incorporate what I can into v3, or
explain why not once I give it a try :).

On Thu, 2020-05-21 at 14:08 -0700, Kees Cook wrote:
> > 
<snip>

> On Thu, May 21, 2020 at 09:56:38AM -0700, Kristen Carlson Accardi
> wrote:
> > +	/*
> > +	 * sometimes we are updating a relative offset that would
> > +	 * normally be relative to the next instruction (such as a
> > call).
> > +	 * In this case to calculate the target, you need to add 32bits
> > to
> > +	 * the pc to get the next instruction value. However, sometimes
> > +	 * targets are just data that was stored in a table such as
> > ksymtab
> > +	 * or cpu alternatives. In this case our target is not relative
> > to
> > +	 * the next instruction.
> > +	 */
> 
> Excellent and scary comment. ;) Was this found by trial and error?
> That
> sounds "fun" to debug. :P

This did suck to debug. Thank goodness for debugging with gdb in a VM.
As you know, I had previously had a patch to use a prand to be able to
retain the same layout across boots, and that came in handy here. While
we decided to not submit this functionality with this initial merge
attempt, I will add it on in the future as it does make debugging much
easier when you can reliably duplicate failure modes.


