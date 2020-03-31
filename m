Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F002C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AA020714
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgCaLyc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:54:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:4171 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730357AbgCaLyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 07:54:32 -0400
IronPort-SDR: FD9P8U211bxNlGXPbKa5c0RAEpvI8ZNAs8UJxVVMz6VBlOuY/LIhRAxNkYu7lJ0y0MUeDwvbgU
 xDPU9RkiIgaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 04:54:31 -0700
IronPort-SDR: jVzNgoxsBvTeACswyPw0g3F8gBbwAcWBsNPozis+fEdbZAPIf8R5uIU/TJB3wVIQpzJibXb0NN
 agU6zcQmyP5w==
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="422268159"
Received: from unknown (HELO localhost) ([10.249.38.166])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 04:54:27 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Peter Lister <peter@bikeshed.quignogs.org.uk>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Compactly make code examples into literal blocks
In-Reply-To: <7d7f4cbb-e8e8-411d-62f4-7a32a2ac8d8a@bikeshed.quignogs.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200326192947.GM22483@bombadil.infradead.org> <20200326195156.11858-1-peter@bikeshed.quignogs.org.uk> <87imiqghop.fsf@intel.com> <20200327104126.667b5d5b@lwn.net> <7d7f4cbb-e8e8-411d-62f4-7a32a2ac8d8a@bikeshed.quignogs.org.uk>
Date:   Tue, 31 Mar 2020 14:54:24 +0300
Message-ID: <87sghog2of.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020, Peter Lister <peter@bikeshed.quignogs.org.uk> wrote:
> On 27/03/2020 16:41, Jonathan Corbet wrote:
>
>> On Fri, 27 Mar 2020 13:28:54 +0200
>> Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>
>>> IMHO the real problem is kernel-doc doing too much preprocessing on the
>>> input, preventing us from doing what would be the sensible thing in
>>> rst. The more we try to fix the problem by adding more kernel-doc
>>> processing, the further we dig ourselves into this hole.
>>>
>>> If kernel-doc didn't have its own notion of section headers, such as
>>> "example:", we wouldn't have this problem to begin with. We could just
>>> use the usual rst construct; "example::" followed by an indented block.
>>>
>>> I'm not going to stand in the way of the patch, but I'm telling you,
>>> this is going to get harder, not easier, on this path.
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
>>
>> I want to ponder on this for a bit.  Peter, that may mean that I hold this
>> patch past the 5.7 merge window, which perhaps makes sense at this point
>> anyway, sorry.  But I really would like to push things into a direction
>> that moves us away from gnarly perl hacks and toward something more
>> maintainable in the long term.
>
> I would have been surprised if it had been accepted as is.
>
> Matthew and Greg, thanks for reviewing - I have a feeling you might need 
> to do this a few times more.
>
> Over the past few days, I too have been pondering, certain thatthis 
> patch, a mini tweak of the existing kernel-doc, is not theright 
> answer.Equally, I'm unconvinced that the "right" answer is a wholesale 
> move to ReST, so where's the happy medium?
>
> <alert: long email, tldr: "Finding the happy medium on kerneldoc layout 
> in C source comments">
>
> A week or two back, I tried to fix doc build "indentation" warnings due 
> to return value listsin sfb-bus.c. Russell King didn't like my patch 
> saying "I think it's more important that the documentation interferes to 
> a minimal degree with the code in the file".[ Mauro's patch to sfb-bus.c 
> is now in linux-next. He fixed the problem with a bullet list - 
> thriftier with the line breaks andthe official fix in the kerneldoc 
> notes - but I'll argue that a simple list or definition list might be 
> more appropriate. ]
>
> Russell and Matthew argue that the primary purpose of source annotation 
> is to aid developers and that any significant detraction (verbosity, 
> whitespace) is not excused by prettier docs. FWIW, my background is 
> sysadmin (much perl) and system/kernel programming (mostly C) and I 
> agree with them.
>
> Jani, if you see risks of complexity and maintenance problems, then so 
> do I. But the point of kernel-doc is surely to be a specific semantic 
> markup which works for developers and maintainers and allows doc authors 
> access to their annotation.  The format clearly needs thought,perl is 
> less fashionable than it was and kernel-doc - er - needs work, but I 
> don't see the *idea* as inherently broken. I suggest that there would be 
> good developer buy-in to searchable pretty docs if a few compact idioms 
> reliably did The Right Thing and didn't spit out doc build warnings.

Historically the kernel documentation build was a Rube Goldberg machine,
and if you were lucky, you reached the end. There were failure points
all over the place. There were "impedance mismatches" in the inputs and
outputs at various stages. There were *insane* escaping issues to get
some text passed through as intended.

At the high level, we've reduced that to *two*, Sphinx and kernel-doc
the perl script, we've made kernel-doc emit rst instead of xml/html, and
we even run the script from within a Sphinx extension to get the error
reporting and dependency management right.

Being able to throw away a lot of conversion and interpretation from
kernel-doc was a goal, passing through the kernel-doc comments unchanged
as much as possible was a feature. This was really the key to making it
possible to document the kernel with Sphinx to begin with.

I think it's a mistake to add anything to kernel-doc that isn't trying
to streamline that process even more. Minimize what kernel-doc does as
much as possible (but not more).

The moment you start adding "a few compact idioms", you start
introducing more ways to trip over the mismatch between kernel-doc
syntax and rst. And you end up trying to figure out ways to escape stuff
in one or the other.


BR,
Jani.


PS. The kernel was always going to be held back by insane amounts of
existing kernel-doc comments, as well as aversion to adding build
dependencies. My vision of what a minimalistic Sphinx based C code
documentation system free of those ties might look like is Hawkmoth [1].

[1] https://github.com/jnikula/hawkmoth


>
> The build warnings I currently observe do not tell me "the author got it 
> wrong", but rather "kernel-doc didn't understand the author's intention".
>
> Consider this excerpt from the kerneldoc comment for bitmap_cut(), 
> recently added to lib/bitmap.c. (NB - this is an example in the 
> description section - the parameters, including src, have already been 
> described).
>
>   * In pictures, example for a big-endian 32-bit architecture:
>   *
>   * @src:
>   * 31                                   63
>   * |                                    |
>   * 10000000 11000001 11110010 00010101  10000000 11000001 01110010 00010101
>   *                 | |              |                                    |
>   *                16 14             0                                   32
>   *
>
> This fails because 1) the diagram isn't made literal (and so generates a 
> indentation build warning) and 2) "@src:" is interpreted as an extra 
> definition of src which scrunges the first one. I find it hard to assert 
> that the author's intentions were wrong; it's the kind of good 
> annotation we should hope for in a newly added function. If "* @src:" 
> gained an double colon and we guaranteed that, after a description 
> section header, references to a parameter didn't overwrite the original 
> definition, this would work fine.
>
> My instinct is to fix doc build issues with minimal changes: not actual 
> ReST, but clear idioms reliably generating good ReST. This should be 
> accompanied by tests for developers and reviewers so that we can have a 
> fair stab at getting it right first time and (of course) documentation.
>
> Could I ask anyone who disagrees to suggest their preferred way to lay 
> out the comment for bitmap_cut()?
>
> One head-on approachis to literalise *all* kerneldoc comments for 
> functions and structures. The kerneldoc keywords then serve only to 
> generate links; the ReST output is minimal but guaranteed validand 
> warning free. Would any readers of API docs be inconvenienced? The 
> target readership are presumably programmers, and the searchability of 
> the sphinx RTD is more useful to me than the formatting.
>
> All the best,
> Peter

-- 
Jani Nikula, Intel Open Source Graphics Center
