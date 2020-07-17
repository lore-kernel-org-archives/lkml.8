Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CF9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FC920717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595004459;
	bh=4BXVUwtR/tkd2z02CT+MvIFZaGvYQkEZE2YjNF5AhjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=L/VIeMPEUNLTOkxzoQ52Ccblsr6l4ow0mVy1d4JbF5AHV2wScR4y6e76SQ2/tcDGM
	 gRLcJojKKNWyTS0M6kmIdGaWu52PegJ1tz83nUEcPLR3nAvgPVX8eT6tWskuUnr9j+
	 o4lVLLylnTLWb7XUDYG5iQLiuK/U4LS/StBzD90g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgGQQri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgGQQrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:47:37 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CDC220717
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595004456;
        bh=4BXVUwtR/tkd2z02CT+MvIFZaGvYQkEZE2YjNF5AhjE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fKmneDpBAiITP5CNK0MU5sUVxFhx7WYh/i+VAwD5D0MAlhGc3diiywNdx5o2yTtW5
         H+KLhFy3VdMnFpNiHW/jKjEh0atBDcYJOyKo54ET6m8avkAbC/kJ/pDhU6bjFhG2Dz
         zRoLQFMLgSMhJVFRgmv5YPh33uYSvFZtuULsnZR4=
Received: by mail-wm1-f43.google.com with SMTP id q15so15928090wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:47:36 -0700 (PDT)
X-Gm-Message-State: AOAM530orocKbP3UeO3zG55yidWylczxKkAnn8PqbzX+oVZzK12mNP3h
        RTOONhHu1kzdOl5GTyBydqma3pYY/wbMlLYMHJlR7Q==
X-Google-Smtp-Source: ABdhPJzXM6ShO9QunQ6h1oW3pXO/VsXg1+/b+5o5yRSKhYi7CtcrXGrAtQNL19genjr5cg0ReKqPfIacxdEL/vO0zWk=
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr10027972wmh.176.1595004455229;
 Fri, 17 Jul 2020 09:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
 <s5hlfjnzvu7.wl-tiwai@suse.de>
In-Reply-To: <s5hlfjnzvu7.wl-tiwai@suse.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 17 Jul 2020 09:47:23 -0700
X-Gmail-Original-Message-ID: <CALCETrWmK-b6apB57mp8oaSRNpcSLdoCFAXEp4EF-9LSUDNFBA@mail.gmail.com>
Message-ID: <CALCETrWmK-b6apB57mp8oaSRNpcSLdoCFAXEp4EF-9LSUDNFBA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v3] CodingStyle: Inclusive Terminology
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Airlie <airlied@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 1:02 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 08 Jul 2020 20:14:27 +0200,
> Dan Williams wrote:
> >
> > +Recommended replacements for 'blacklist/whitelist' are:
> > +    'denylist / allowlist'
> > +    'blocklist / passlist'
>
> I started looking through the tree now and noticed there are lots of
> patterns like "whitelisted" or "blacklisted".  How can the words fit
> for those?  Actually, there are two cases like:
>
> - Foo is blacklisted
> - Allow to load the non-whitelisted cards
>
> Currently I'm replacing the former with "Foo is in denylist", but not
> sure about the latter case.  I thought Kees mentioned about this, but
> don't remember the proposal...

Hmm.  In these cases, we're trying to convey one of two things.  A
given device/platform/CPU/whatever could be known to be problematic
and thus disallowed, or we could have a policy that we generally don't
trust hardware but we have specific reason to believe that this
particular hardware is okay.  After doing a highly scientific sampling
of a few cases, some of these are indeed lists and some are not.

If we're going to look for new words for these concepts, perhaps we
shouldn't focus on the *list* aspect -- after all, that's just a
rather popular implementation detail, but it's not the core concept
we're trying to express.  As an example case, we have a horrible
concept in which some Intel CPUs support a form of memory failure
recovery, and there is no enumeration mechanism.  Instead, there's a
list (sigh).  So we could say "your CPU is whitelisted for
such-and-such," which at least gets the idea across, but saying "your
CPU is allowlisted for such-and-such" seems like a stretch.  It's not
that we have a policy to allow things on the list -- it's that we
think that CPUs not on the list simply don't have the relevant
capability.

Here are some brainstormed ideas:

 - Such-and-such feature is quirked off.  (Or disabled due to a quirk.)

 - Your device is not on the known-good list.

 - Your device is not known-good.  It might work anyway -- to try it,
set such-and-such option.

 - Your device is known bad.

 - Your device is busted and we think you should pressure the
manufacturer to fix it.

 - Your device is too old and no longer supported.

 - Seriously, you're trying to use an 80386 on a modern kernel?  No
thanks.  We think it's neat that you still have one that works,
though.

 - (Specifically for modules and not part of the Linux kernel tree)
disable_autoload instead of blacklist, perhaps?

Part of my point is that we use blacklist and whitelist to mean
various things, and I don't think we should try to invent a couple of
new catch-all terms to replace them.  Perhaps replacing these words
could be an opportunity to come up with better descriptions at the
same time.
