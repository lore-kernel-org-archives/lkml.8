Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95902C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761A8214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbgCaLWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:22:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:11298 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbgCaLWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 07:22:48 -0400
IronPort-SDR: m3oV1wZ7CKXjUcCtgM/cia3tIqIMzcssjhKTPqn6cDCxdxfVsBNS0BB7E0C2+bj9oi7DCls2En
 Z0/5hrjJLOng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 04:22:47 -0700
IronPort-SDR: T46vXkmTBU59wKBI5vmZTpcqJ7Iy+LJTdx8Q1AX03unyLguBP+uRpLotN8mnXMmxnle/iHVQYd
 ns1r1Q/W+Iyw==
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="422260524"
Received: from unknown (HELO localhost) ([10.249.38.166])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 04:22:44 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     peter@bikeshed.quignogs.org.uk, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Compactly make code examples into literal blocks
In-Reply-To: <20200327173500.GR22483@bombadil.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200326192947.GM22483@bombadil.infradead.org> <20200326195156.11858-1-peter@bikeshed.quignogs.org.uk> <87imiqghop.fsf@intel.com> <20200327104126.667b5d5b@lwn.net> <20200327165022.GP22483@bombadil.infradead.org> <20200327111106.57982763@lwn.net> <20200327173500.GR22483@bombadil.infradead.org>
Date:   Tue, 31 Mar 2020 14:22:41 +0300
Message-ID: <87v9mkg45a.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020, Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Mar 27, 2020 at 11:11:06AM -0600, Jonathan Corbet wrote:
>> On Fri, 27 Mar 2020 09:50:22 -0700
>> Matthew Wilcox <willy@infradead.org> wrote:
>> 
>> > Let me just check I understand Jani's proposal here.  You want to change
>> > 
>> > * Return: Number of pages, or negative errno on failure
>> > 
>> > to
>> > 
>> > * Return
>> > * ~~~~~~
>> > * Number of pages, or negative errno on failure
>> > 
>> > If so, I oppose such an increase in verbosity and I think most others
>> > would too.  If not, please let me know what you're actually proposing ;-)
>> 
>> I told you there would be resistance :)
>
> Happy to help out!
>
>> I think a reasonable case can be made for using the same documentation
>> format throughout our docs, rather than inventing something special for
>> kerneldoc comments.  So I personally don't think the above is terrible,
>> but as I already noted, I anticipate resistance.
>> 
>> An alternative would be to make a little sphinx extension; then it would
>> read more like:
>> 
>> 	.. returns:: Number of pages, except when the moon is full
>> 
>> ...which would still probably not be entirely popular.

I don't really think it would need to be a sphinx extension. If I were
to do this from scratch, I'd just leave it be any convention that's
compatible with rst. Perhaps field lists [1], for both parameters and
return values. With that you could do things like:

 * :Returns: 0 on success.
 * :Returns: -ENOCOFFEE when out of coffee.
 * :Returns: Other negative error codes for other errors.

or:

 * :Returns: 0 on success, -ENOCOFFEE when out of coffee, and other negative
 *           error codes for other errors.

according to your tastes, and both render nicely. You could actually
start using those *now* without changes to kernel-doc or anything. Try
it!

(Side note, I think it would be nice to preprocess the current @param:
stuff into field lists instead of the definition lists that we use now.)

> I certainly see the value in consistency throughout our documentation.
> But I don't think it's a given that the documentation of the return
> value is necessarily its own section.  I see kernel-doc as being more
> about semantic markup and the rst files as being a presentation markup.
>
> So I'm fine with Return:: introducing a list or Example:: introducing
> a code section; these are special purpose keywords.  I'm not a fan of
> using raw rst in kernel-doc.  Of course if we can make the kernel-doc
> and rst languages the same for the same concepts, that's great.

IMO, if you want to make a list, you use rst lists. If you want to add a
preformatted text block, you use rst preformatted text block. I don't
see any reason why those should be tied to certain headings such as
"return" or "example". Return does not have to be a list, and example
does not have to be a preformatted block.

I am also not a fan of *overusing* rst in kernel-doc. But we have it
there so that you can use it when you need it, and not have to hack at
the godawful kernel-doc the perl script every time. So that you can just
point at the widely available documentation on rst for doing everything,
instead of telling people to go figure it out from the perl source.

BR,
Jani.


[1] https://docutils.sourceforge.io/docs/user/rst/quickref.html#field-lists

-- 
Jani Nikula, Intel Open Source Graphics Center
