Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10E4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C7220738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591294580;
	bh=NwKcPM9opORdcXMXFoo6Zvka0pklrKSlzN6W/JgehYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kH/3PmJtw9o377oM63XT0D5RLQqhCezIAHSRq5AYjLwYaoNBvf3AaoDAnBgvhm8EE
	 x8cQ5dvxzYVQ2sEhk43ZNyVmv3TZQGi1fooHsQavkkJRnDIqj0fKTVetfDhVFcZJww
	 7It8Pg7d56iaS+Q2NaH5jruBqwpHVo2fOWrLG258=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgFDSQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgFDSQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:16:19 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 110E3206C3;
        Thu,  4 Jun 2020 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591294578;
        bh=NwKcPM9opORdcXMXFoo6Zvka0pklrKSlzN6W/JgehYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJC/NMYNvsAQNHNCYCrZH4JXiRkKVtCEskxnNgz/ZKr9culCDGFxSOOnPmTJSsiu4
         Rg3rETGfh8soY8g0zT1cpEu0xrZEy+SE69T3piYStco0q1KlTFLhODquEC2Yv+KkYG
         ga+CKQvCZyGLbKloHGzDVV+UKwjDKDR+Jz21SlKw=
Date:   Thu, 4 Jun 2020 13:21:23 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] docs: deprecated.rst: Add note to the use of
 struct_size() helper
Message-ID: <20200604182123.GD10051@embeddedor>
References: <20200604172138.GA21820@embeddedor>
 <202006041047.9B3E8FB951@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202006041047.9B3E8FB951@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 10:49:19AM -0700, Kees Cook wrote:
> On Thu, Jun 04, 2020 at 12:21:38PM -0500, Gustavo A. R. Silva wrote:
> > Add a note to educate people about the proper use of struct_size() when
> > the trailing array in the enclosing structure is a one-element array.
> > 
> > Zero-length and one-element arrays will soon be removed from the kernel,
> > but in the meantime, it's worth letting people know how to correctly
> > use struct_size() together with such constructs.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > 
> > Kees,
> >  
> > This is not substitute for the patch I'll write about flexible-arrays
> > and the deprecation of zero-lenght and one-element arrays.
> 
> Hm, hm. I think I'd rather just get the 0/1-array docs written, since
> that will mean this paragraph isn't needed at all. (Or rather, it can be

Yeah. My reasoning for is that it will take a while --at least one 
development cycle more-- to completely get rid of all the 0/1-arrays.
Also, this was motivated by the following comments from Christian
König:

"May I suggest that we add a section how to correctly do this to
Documentation/process/coding-style.rst or similar document?

I've seen a bunch of different approaches and some even doesn't work
with some gcc versions and result in a broken binary."[1]

> modified to say "if you're using struct_size() on a 1-array, stop using
> a 1-array, see [link]". If someone is going to switch around their code,
> they need to switch to flex at the same time, IMO.
> 

I agree with this. I can add the comments in quotes you suggest to this
patch.

But I think we can add this note while I continue working on the flexible-array
conversions. Once that work is complete, I can go back and update the
documentation. :)

What do you think?

Thanks
--
Gustavo

[1] https://lore.kernel.org/lkml/1065d63e-7959-e4b4-af4e-70607ba92296@amd.com/

> > 
> >  Documentation/process/deprecated.rst | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> > index 652e2aa02a66c..0b7b37718bf96 100644
> > --- a/Documentation/process/deprecated.rst
> > +++ b/Documentation/process/deprecated.rst
> > @@ -85,6 +85,17 @@ Instead, use the helper::
> >  
> >  	header = kzalloc(struct_size(header, item, count), GFP_KERNEL);
> >  
> > +NOTE: You might want to use the following form in case the trailing array
> > +is a one-element array, as unlike zero-length arrays and flexible-array
> > +members, `one-element arrays occupy at least as much space as a single
> > +object of the type <https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_,
> > +hence they contribute to the size of the enclosing structure::
> > +
> > +	header = kzalloc(struct_size(header, item, count - 1), GFP_KERNEL);
> > +
> > +It's also worth noting that one-element arrays --together with zero-length
> > +arrays-- will soon be completely removed from the codebase and deprecated.
> > +
> >  See array_size(), array3_size(), and struct_size(),
> >  for more details as well as the related check_add_overflow() and
> >  check_mul_overflow() family of functions.
> > -- 
> > 2.27.0
> > 
> 
> -- 
> Kees Cook
