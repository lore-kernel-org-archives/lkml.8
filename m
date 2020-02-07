Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF16EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBAA20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBGQw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:52:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:65412 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgBGQw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:52:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 08:52:56 -0800
X-IronPort-AV: E=Sophos;i="5.70,414,1574150400"; 
   d="scan'208";a="280023013"
Received: from unknown (HELO kcaccard-mobl1.jf.intel.com) ([10.24.10.111])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 08:52:56 -0800
Message-ID: <7d1309623b172bfcd4517898c99138c6f363604b.camel@linux.intel.com>
Subject: Re: [RFC PATCH 04/11] x86/boot/KASLR: Introduce PRNG for faster
 shuffling
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com
Date:   Fri, 07 Feb 2020 08:52:55 -0800
In-Reply-To: <202002070100.2521E7563@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
         <20200205223950.1212394-5-kristen@linux.intel.com>
         <20200206151001.GA280489@zx2c4.com>
         <CAGiyFdes26XnNeDfaz-vkm+bU7MBYQiK3xty2EigGjOXBGui2w@mail.gmail.com>
         <202002070100.2521E7563@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-07 at 01:05 -0800, Kees Cook wrote:
> On Fri, Feb 07, 2020 at 08:23:53AM +0100, Jean-Philippe Aumasson
> wrote:
> > On Thu, Feb 6, 2020 at 4:10 PM Jason A. Donenfeld <Jason@zx2c4.com>
> > wrote:
> > 
> > > Hey Kees,
> > > 
> > > On Wed, Feb 05, 2020 at 02:39:43PM -0800, Kristen Carlson Accardi
> > > wrote:
> > > > +#define rot(x, k) (((x)<<(k))|((x)>>(64-(k))))
> > > > +static u64 prng_u64(struct prng_state *x)
> > > > +{
> > > > +     u64 e;
> > > > +
> > > > +     e = x->a - rot(x->b, 7);
> > > > +     x->a = x->b ^ rot(x->c, 13);
> > > > +     x->b = x->c + rot(x->d, 37);
> > > > +     x->c = x->d + e;
> > > > +     x->d = e + x->a;
> > > > +
> > > > +     return x->d;
> > > > +}
> > > 
> > > I haven't looked closely at where the original entropy sources
> > > are
> > > coming from and how all this works, but on first glance, this
> > > prng
> > > doesn't look like an especially cryptographically secure one. I
> > > realize
> > > that isn't necessarily your intention (you're focused on speed),
> > > but
> > > actually might this be sort of important? If I understand
> > > correctly, the
> > > objective of this patch set is so that leaking the address of one
> > > function doesn't leak the address of all other functions, as is
> > > the case
> > > with fixed-offset kaslr. But if you leak the addresses of _some_
> > > set of
> > > functions, and your prng is bogus, might it be possible to figure
> > > out
> > > the rest? For some prngs, if you give me the output stream of a
> > > few
> > > numbers, I can predict the rest. For others, it's not this
> > > straight
> > > forward, but there are some varieties of similar attacks. If any
> > > of that
> > > set of concerns turns out to apply to your prng_u64 here, would
> > > that
> > > undermine kaslr in similar ways as the current fixed-offset
> > > variety? Or
> > > does it not matter because it's some kind of blinded fixed-size
> > > shuffle
> > > with complex reasoning that makes this not a problem?
> > 
> > Let me share my 2 cents:
> > 
> > That permutation might be safe but afaict it hasn't been analyzed
> > wrt
> > modern cryptographic techniques and there might well be
> > differential
> > characteristics, statistical biases, etc.
> > 
> > What about just using SipHash's permutation, already in the kernel?
> > It
> > works on 4*u64 words too, and 6 rounds would be enough.
> > 
> > Doing a basic ops count, we currently have 5 group operations and 3
> > rotations per round or 150 and 90 for the 30 init rounds. With
> > SipHash it'd
> > be 48 and 36 with the proposed 6 rounds. Probably insignificant
> > speed wise
> > as init is only done once but just to show that we'd get both
> > better
> > security assurance and better performance.
> 
> Yeah, this was never meant to be anything but a POC and after timing
> tests, it seemed like an unneeded abstraction but was kept for this
> RFC so it was possible to specify a stable seed at boot for
> debugging,
> etc. I think this patch will not survive to v1. :)

That's right, I'm going to drop it and go with the ChaCha20
implementation as was suggested.


