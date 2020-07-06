Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF6CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46DCE20715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uksv0RIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgGFNXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgGFNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:23:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44949C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:23:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so32835614wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u3h3wext262E7n1BD957g5v244VzOwxa5GVfjSJ/geM=;
        b=uksv0RIAMXQoQTap1+LbsoaHNwksYV/iQZD8ux1lmeU9O85VFW8n7kl3i/NDkA4JVA
         zebixzLSa9+kaTmzRBd426DC3iUypNtbgsxskA3njEdNW5p5MFjFE3JZTLTCe4uCoTa1
         ZjdIvjDBPvmK5Q0podW8iTUhWGHmwBsmncGeTFCaK9yVlnLT+6x7wSym7bBY8ExPKKoG
         e22edvozdUOaKi2XubldCE4hJvhaHBvJTqtftT2LQEezOluR6+tLMrzvRkn8GNiFzCBZ
         cIYT5JDBf2zMlRYhxnOF91/VU0ubd9Sx6PJMe97l17KlLYIcLXImlsyx5hWLIlukaXMr
         7DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u3h3wext262E7n1BD957g5v244VzOwxa5GVfjSJ/geM=;
        b=A/JwLwnqwoErgmsscba9swSdWAwhqYxuprzGZWDnSnk2tom36O2U6NiRNUGBZXuR0Z
         /Ol2rpGPFilUzPtsW/EjXeLzPhN8I/SKaX/biAtsMK9xakotuSy0y8e7r/7lgKzBUPCI
         IyU9MU9KCjZ3+jPeP81rocwandfhrlH2i1jorYBohfkCmhVYzQLGXmHsN0R0UAdiSlku
         iIJR3VB7u87Vc6Nf5GGm146Ii1KnNmP/xg8d0sKoC9HtQdIGKO1jztD0uW9XDG3smhIP
         UdpvEDH+4OTTN+xd0LuNM74/pKv6DhCCiM9Ky4yXwiOFA9Y4MfPeBx90DQrpPC68qb07
         LH2g==
X-Gm-Message-State: AOAM5328EBBYIOhv4YjldMu+42EDw0Jt0cyb88WvF7WPcFGegaRmICzA
        AWiXei0rxVuWeENVRjB8KZfY3ZlW1/Q=
X-Google-Smtp-Source: ABdhPJynUMChBoPXZsaBUtlvF5PfwvvAXzjTta7pkSZW/T+8cY+XqI/yf/64XJ2bsoRhmLQyTIz/eA==
X-Received: by 2002:adf:f311:: with SMTP id i17mr50841740wro.237.1594041826875;
        Mon, 06 Jul 2020 06:23:46 -0700 (PDT)
Received: from ?IPv6:2a01:36d:103:236:99d9:83af:85e2:5437? (2a01-036d-0103-0236-99d9-83af-85e2-5437.pool6.digikabel.hu. [2a01:36d:103:236:99d9:83af:85e2:5437])
        by smtp.gmail.com with ESMTPSA id d81sm11472wmc.0.2020.07.06.06.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 06:23:46 -0700 (PDT)
From:   Tibor Raschko <tibrasch@gmail.com>
Subject: Re: [PATCH] CodingStyle: Inclusive Terminology
To:     linux-kernel@vger.kernel.org
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        tech-board-discuss@lists.linuxfound
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <810c098a-9920-3468-733e-4abb13bfbe6d@gmail.com>
Date:   Mon, 6 Jul 2020 15:23:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending the wrong message
===========================

I'm pretty sure everybody agrees that being inclusive is more than just
using the right words. Being truly inclusive means not caring about the
origin, birth, age, sex, skin color (amongst other things) at all. This
means not judging people based on these factors, and being friendly,
inviting and supportive with everybody in everyday life by default. On
the street, in hallways and rooms, and on the internet. This behavior
also includes using words and phrases that are non-offensive. So as a
result, the proposed patch advocates avoiding words such as "slave" and
"blacklist".

However, as it was already said in this discussion by other parties,
"context is everything". Quite ironically, this was said in a slightly
different context, but it doesn't change the importance and general
truth of these words. I'll go out on a limb and claim that nobody who
wrote "master-slave" during development of a device driver, or used the
word "blacklist" was actually thinking of African people or human
slavery.  In the context of the Linux kernel (and in computing in
general), these words have a long history and have zero bad connotation,
no racism, and absolutely null offense.  One could argue that
recommending to retroactively remove such references (which the original
proposal does) assumes that these were offensive, hence suggesting to a
certain degree that past developers who have used these words were
possibly racists. Retroactively removing those occurrences from code is
thus, I honestly think, disrespecting and insulting to the original
authors. Because why remove them if they didn't mean anything bad? And
before you say "because those instances could still be interpreted as
offensive", I'll get to that soon.

The proposal is just a surface treatment
===========================

... and a bad one at that. The "black" in "blacklist" has nothing to do
with African or Afro-American people. No matter how many occurrences of
"black" we eradicate from our dictionary, the word "black" will always
have bad connotations. This connotation stems from darkness, the absence
of beautiful colors, and historically from the coldness, darkness and
insecurity of the night. Dan W. dismisses this by saying this is an
etymological argument, but we cannot dismiss arguments just because they
are unbeneficial (is that even a word?) to our cause. The true problem
is not that the word "black" has bad connotations, but that people with
dark skin color have been labeled with a word that has a bad
connotation. If we don't want to be offensive, (as a small step) we must
stop thinking of African and Afro-American people as "black" and ban
this labeling of them. Note the big difference: Instead of banning the
use of a simple color in some contexts which have nothing to do with
oppression, hate or slavery, we should instead stop referring to groups
of people with a word that incites bad feelings. For this reason, I
argue that banning "blacklist" is just a surface treatment that doesn't
recognize the true problem behind it, and even if implemented will stay
ineffective. Accepting this proposal is like fixing an error message in
the kernel logs by simply removing the error message instead of fixing
the underlying bug. To fix the bug in our language, we must stop
referring to "black" people as black people. A measure where proponents
of the patch fail at most.

Being respectful
===========================

The case for "slave" is a bit different, obviously, because the
etymology here does link to actual human slavery. Again, it is important
to note the context however. In computing, this means something
completely different, end of sentence. Supporters of the patch will come
and say, "it doesn't need to be meant offensively to be taken
offensively". That's true, of course, but only if it is a
misunderstanding, which in the computing context has zero chance. If you
know and understand what the other party *really* meant, then something
that wasn't meant offensively cannot be taken offensively. The right
word here is not "offensive", but one or more of "uncomfortable",
"disturbing", or "upsetting". Now *that* is understandable. If you have
a history of you or your ancestors been oppressed, then talking about
slavery understandably generates unwelcome emotional reactions. But this
has nothing to do with inclusion, racism, or hate. However, because we
don't want to emotionally upset people, I actually support avoiding
references to "slave" in the future. Importantly though, this support is
out of respect, and not because it has anything to do with being
offensive. In this context, we should, and for correctness sake must,
stop referring to "offensiveness".

Though even this logic is borderline: just recently, half a million
people have fallen victim to COVID-19 in over just a couple of months.
The number of affected relatives are probably 2-3x of that, who are now
emotionally shaken and uncomfortable about talking about the virus.
Imagine where we would be now (or where we will be in half a year) if we
stopped referring to COVID to avoid emotionally upsetting these people.

About that argument with efficiency
===========================

The patch author goes into detail to "illustrate" how avoiding these
words will improve efficiency. I'm sorry to call this out, but this is
utterly bogus and distracting from the issue at hand. First of all, not
any maintainer has been slowed done or has worked less efficiently
because they saw the word "blacklist" or "slave" in the kernel sources.
These *technical* phrases are not like bad code formatting where
disconformity leads to worse readability or makes the coding intent
harder to follow or understand. Quite the contrary, if anybody read the
proposed "denylist" instead of "blacklist", they will stop for a second,
think "what an odd choice of words...", and if it wasn't for the current
black-lives-matter movement, would have a year ago probably even
refactored the code (or requested a v2-patch) with the usual terminology
of "blacklist". In other words, this argument has zero real-life basis
and will, if implemented, achieve the opposite effect of what it is
claiming.

If we do this, there is no end to politics
===========================

Let me start with an example. The patch author neglectfully forgets
about proposing to ban "whitelist", not just "blacklist". If we agree
that "blacklist" is wrong because it assumes that everything "black" is
always bad (and thus black people'd be bad), then obviously we *have to*
remove whitelist too. Because "whitelist" then assumes that everything
"white" is always good, and now since we're unable to ignore the
reference to skin-color, so this is just as racist (actually even
worse), suggesting white supremacy. It is obvious that whoever thought
out the exclusion of "blacklist" didn't think this through. But we all
know, these words to be replaced all stem from outside our community,
and the current patch is not the result of careful consideration, but
the result of giving-in to external pressure, and to political and media
waves. The Linux community should stand strong and be inclusive by
*being* welcoming, friendly and helpful to everybody irrespective of
skin color, not by *saying* what current political activists expect us
to say. It might even be better to stop talking about skin color in the
context of kernel development altogether, because skin color doesn't
matter here. Here people judge others by technical competency. Any
discussions otherwise are fueled by external factors and are a
distraction. Note this does *not* mean we turn our backs to racism or
offensive behavior. If we see any such poisonous activity among our
circles now or in the future, we must and will single them out and teach
them better, and for incorrigible cases we distance ourselves from them.
But these will be one-off cases that will be handled appropriately.
Unless it becomes a common problem among Linux developers, it is not our
responsibility to write down each and every desirable human behavior
(again, see top about "sending the wrong message"). We've successfully
avoided pests from infecting our circles in the past and we'll continue
to do so. Avoiding the word "blacklist" makes no difference here. How do
I know? Because let's be real: The use of the word "blacklist" has not
deterred a developer from joining our community yet... for about 25
years now. On the other hand this discussion is now wasting everybody's
time. With that last sentence in mind, sorry for this mail turning out
so long.

Raschko T.


