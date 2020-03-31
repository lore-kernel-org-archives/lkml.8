Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4951CC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2998820772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgCaKuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:50:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:60412 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730334AbgCaKuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:50:19 -0400
IronPort-SDR: 6N3+p9g2GPFr213W6+QPQ5anU4prJIU0Es2HR/K4WwlVsvUrCImzRblTdC2JP/7XbtoVCncdHM
 COCIpurndnFQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 03:50:19 -0700
IronPort-SDR: 7ZdsGnayby9LSlUmAMcalf9gYIQYKT0i8scMQNoonNhigi0Ho0g3Qr69ndtFg+P5kFKWpyB7st
 J43LhNPNzCBQ==
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="422252454"
Received: from unknown (HELO localhost) ([10.249.38.166])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 03:50:15 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     peter@bikeshed.quignogs.org.uk, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Compactly make code examples into literal blocks
In-Reply-To: <20200327165022.GP22483@bombadil.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200326192947.GM22483@bombadil.infradead.org> <20200326195156.11858-1-peter@bikeshed.quignogs.org.uk> <87imiqghop.fsf@intel.com> <20200327104126.667b5d5b@lwn.net> <20200327165022.GP22483@bombadil.infradead.org>
Date:   Tue, 31 Mar 2020 13:50:11 +0300
Message-ID: <87zhbwg5ng.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020, Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Mar 27, 2020 at 10:41:26AM -0600, Jonathan Corbet wrote:
>> On Fri, 27 Mar 2020 13:28:54 +0200
>> Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> 
>> > IMHO the real problem is kernel-doc doing too much preprocessing on the
>> > input, preventing us from doing what would be the sensible thing in
>> > rst. The more we try to fix the problem by adding more kernel-doc
>> > processing, the further we dig ourselves into this hole.
>> > 
>> > If kernel-doc didn't have its own notion of section headers, such as
>> > "example:", we wouldn't have this problem to begin with. We could just
>> > use the usual rst construct; "example::" followed by an indented block.
>> > 
>> > I'm not going to stand in the way of the patch, but I'm telling you,
>> > this is going to get harder, not easier, on this path.
>> 
>> I agree with you in principle.  The problem, of course, is that this is a
>> legacy gift from before the RST days and it will be hard to change.
>> 
>> A quick grep shows that the pattern:
>> 
>> 	* Example:
>> 
>> appears nearly 100 times in current kernels.  It is not inconceivable to
>> make a push to get rid of all of those, turning them into ordinary RST
>> syntax - especially since not all of those are actually kerneldoc
>> comments.
>> 
>> The same quick grep says that "returns?:" appears about 10,000 times.
>> *That* will be painful to change, and I can only imagine that some
>> resistance would have to be overcome at some point.
>> 
>> So what do folks think we should do? :)
>
> Let me just check I understand Jani's proposal here.  You want to change
>
> * Return: Number of pages, or negative errno on failure
>
> to
>
> * Return
> * ~~~~~~
> * Number of pages, or negative errno on failure
>
> If so, I oppose such an increase in verbosity and I think most others
> would too.  If not, please let me know what you're actually proposing ;-)

Due to historical reasons, I think kernel-doc must handle a handful of
special cases, as a preprocessor converting old conventions to rst. The
title line, parameters, returns, and some in-line markup for &struct,
etc.

I'm not proposing changing "return:", because it's too widespread.

I *am* questioning everything else that necessitates adding *more*
special casing to handle things that would be easy to do in rst. I think
we should be moving in the other direction, fixing things by removing
special casing where we can. Case in point, "example:" as a section.

Why should we be adding different ways of doing things in the
documentation comments and the documentation files? Not having to do
that was one of the original goals. Unify stuff to one markup. Make
kernel-doc comments in source an extension to the documents under
Documentation/.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
