Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4702C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 21:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A158920720
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 21:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KZTMMdqG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ldpreload.com header.i=@ldpreload.com header.b="ce0/pNz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHWVyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 17:54:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60922 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgHWVyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 17:54:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0E6F6EC4B;
        Sun, 23 Aug 2020 17:54:16 -0400 (EDT)
        (envelope-from geofft@ldpreload.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=ruWyg42XX5u7bHz/5Ra1vV/YPJY=; b=KZTMMd
        qGrd7BAHYdrkPuK5tj3J0wvN1ihX5Hp1hlrO6vCU7biWhg81F+/QaA9lLgnAdcLi
        UEDzv92OTDfgGVjRf1kwLmXCGIf5uIj3lqW2k44aPPMUmk/OTxoA73aTF/ug9n3u
        zh+MNVMkJmsHAcqhORrh/TT0RLHjhR1UNdTyg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97BB76EC4A;
        Sun, 23 Aug 2020 17:54:16 -0400 (EDT)
        (envelope-from geofft@ldpreload.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=ldpreload.com;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=mesmtp; bh=MD82nC4kZzwXi/pIq45sgtnv6h0tQhN4CayWIJ50cDI=; b=ce0/pNz1aQbB1dpmBMT9uJUkWxfDbPoByIaeFuQqyMcaASTeHfObDwLoD1MFQ70oVUdPG/S3Sot4a8Dn1uECPi7PDk7MB7MQCPujLoSrRklwEPZPtsEHG511gUMgTH6y69fGCwPDWBC0Uv++qerZqDjNkU00psxKiFb0VxMzFKc=
Received: from cactuar.ldpreload.com (unknown [198.27.64.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6C116EC49;
        Sun, 23 Aug 2020 17:54:15 -0400 (EDT)
        (envelope-from geofft@ldpreload.com)
Date:   Sun, 23 Aug 2020 17:54:14 -0400 (EDT)
From:   Geoffrey Thomas <geofft@ldpreload.com>
To:     Adrian Bunk <bunk@kernel.org>
cc:     Josh Triplett <josh@joshtriplett.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alex.gaynor@gmail.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: Linux kernel in-tree Rust support
In-Reply-To: <20200823210246.GA1811@localhost>
Message-ID: <alpine.DEB.2.11.2008231713130.4589@titan.ldpreload.com>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com> <20200712123151.GB25970@localhost> <20200712193944.GA81641@localhost> <20200823210246.GA1811@localhost>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Pobox-Relay-ID: 302C7A94-E58B-11EA-A9D7-2F5D23BA3BAF-67873895!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020, Adrian Bunk wrote:

> In librsvg, breakages with more recent Rust versions in the past year
> required updates of two vendored crates:

Interesting!

> https://gitlab.gnome.org/GNOME/librsvg/-/commit/de26c4d8b192ed0224e6d38f54e429838608b902

Looks like this was, for a while, a warning and not an error:

https://github.com/servo/rust-cssparser/commit/3c98d22c5de3b696bf1fde2b6c90069812312aa6

     = warning: this error has been downgraded to a warning for backwards compatibility with previous releases
     = warning: this represents potential undefined behavior in your code and this warning will become a hard error in the future

> https://gitlab.gnome.org/GNOME/librsvg/-/commit/696e4a6be2aeb00ea27945f94da066757431684d

Same here, and it looks like the same warning/error, too:

https://github.com/dimforge/nalgebra/issues/561

     = warning: this error has been downgraded to a warning for backwards compatibility with previous releases
     = warning: this represents potential undefined behavior in your code and this warning will become a hard error in the future

Following some links in that second issue, I see that this seems to be a 
summary of what's going on:

https://github.com/rust-lang/rust/issues/59159

in particular this paragraph: "at the time that NLL [non-lexical 
lifetimes] was stabilized, the compiler's acceptance of this borrowing 
pattern was categorized by the NLL team as a 'known bug'. The NLL team 
assumed that, as a bug fix, the compiler would be allowed to start 
rejecting the pattern in the future."

That is, both of these cases were code that should never have been 
accepted by the compiler because it is unsound, but the initial 
implementation of NLL was not clever enough to detect it. They later 
turned it into a warning, and later turned that into an error.

There is a link to this policy document which explains their process for 
breaking existing code in the case where it's necessary to fix a compiler 
bug or similar:

https://github.com/rust-lang/rfcs/blob/master/text/1589-rustc-bug-fix-procedure.md

There is also a link to this comment about why they decided to take this 
approach:

https://github.com/rust-lang/rust/pull/58739#issuecomment-476387184

which includes the followup task, "We do a retrospective and look to ways 
to alter our processes to better prevent this in the future." That is, it 
seems to me that the Rust team sees it as a mistake that they ended up in 
this situation.

Josh, do you know if that retrospective has happened? (I see some mumbling 
about NLL -> Polonius, can we be confident something similar won't happen 
with that? :) )

> For updating Rust in Debian stable for the next Firefox ESR update it
> would actually be useful if these violations of the "hard stability
> guarantee" in Rust get fixed, so that the old librsvg 2.44.10 builds
> again with the latest Rust.
>
> It also makes me wonder how such regressions slip into Rust releases.

I do conceptually agree with this, even though it is not technically a 
"regression" (because it was really the old compiler that was buggy, not 
the new one). If I understand it right, neither of these lines of code 
were valid with the pre-NLL implementation either. They were only accepted 
by the initial NLL implementation. While the purpose of NLL was to enable 
writing (valid/sound) code that wouldn't have been accepted by the 
previous, simpler implementation of lifetimes, it seems like it should 
have been possible to opt out of it while there were "known bugs" 
precisely to prevent these sort of effective-regressions. (And I suspect 
that it was in fact possible to do so, but perhaps not documented clearly 
/ perhaps there wasn't an awareness that this was a thing that users who 
deeply value stability would want to do.)

And yeah, I can see the value of a --accept-previously-accepted-buggy-code 
flag from the distros' point of view (even if I can also see why Rust 
upstream would not be super excited about it :) ). After all, if the 
choice is between the distro not taking _any_ bug fixes in rustc and the 
distro taking all but one, the latter seems like a better option.

The other takeaway, I think, is that you should regularly compile with 
warnings turned into hard errors. The policy document above (Rust RFC 
1589) says that all such changes need to be a warning and not a hard error 
for at least one compiler reversion. That happened in this case, and both 
fixes were applied in the vendored crates while they were still warnings. 
For any kernel Rust use, I'd strongly advocate for running CI on every 
stable branch after each compiler release, preferably after each compiler 
beta release, and shaking out any warnings - even if they are not warnings 
the compiler will turn into errors on its own, they may still point to 
logic bugs in the code.

(The Rust folks have some automation named "crater" for running these 
sorts of tests across the Rust ecosystem, which the document mentions. I'd 
expect that anything shipped in major distros, including librsvg + its 
dependencies as well as any Rust in the kernel, should be included in 
crater.)

-- 
Geoffrey Thomas
https://ldpreload.com
geofft@ldpreload.com


