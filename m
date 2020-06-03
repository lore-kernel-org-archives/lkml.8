Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FC4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1474A206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="iSCF64D3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgFCLg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:36:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38639 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgFCLg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:36:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49cRhQ32M6z9sRW;
        Wed,  3 Jun 2020 21:36:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1591184216;
        bh=39iM+Z0hy1K0/qYyBuIARyEAO9/YU5aPM+R2qwBBQdM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iSCF64D3VHl6DjoxeOmJly7GrKK7olGjrkPSTmU13cAavhy+66gUU1DkpkLu6DRhA
         dOcNk5WDPMUw6onS6I/BuveZOoRtNU5omaxf/slwrH4RgyK7lXdhmEI02l4/jB48Yx
         sie1sk8T8cwMp3+S/5lfrT53Bsh8T48dGVYWlhAKiehfAkNdjpk+binImctf09Kwl8
         j1+gbPacA7Md5/Wgvt1hjJ+SaDHCgTt0okDBjy/8V/umMzZrjOAHQG9kBwr9WX1OkS
         a/iavYuuubkL/1q+RvMST1pTr+wdqku++XwGUGIOLg+B+9bXuhbCP12n6OFWXnjCrC
         z7BoTqDzCEDtg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Liao Pingfang <liao.pingfang@zte.com.cn>,
        linuxppc-dev@lists.ozlabs.org, Joe Perches <joe@perches.com>,
        Allison Randal <allison@lohutok.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colin Cross <ccross@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Wang Liang <wang.liang82@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc/nvram: Replace kmalloc with kzalloc in the error message
In-Reply-To: <20200602114158.GB30374@kadam>
References: <c3d22d89-9133-30aa-8270-c515df214963@web.de> <87imgai394.fsf@mpe.ellerman.id.au> <a3c158fa-3829-f38a-9202-8984b5ef5f21@web.de> <87a71liucy.fsf@mpe.ellerman.id.au> <20200602114158.GB30374@kadam>
Date:   Wed, 03 Jun 2020 21:37:18 +1000
Message-ID: <87tuzsgz2p.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:
> On Tue, Jun 02, 2020 at 09:23:57PM +1000, Michael Ellerman wrote:
>> Markus Elfring <Markus.Elfring@web.de> writes:
>> >>>> Please just remove the message instead, it's a tiny allocation that=
's
>> >>>> unlikely to ever fail, and the caller will print an error anyway.
>> >>>
>> >>> How do you think about to take another look at a previous update sug=
gestion
>> >>> like the following?
>> >>>
>> >>> powerpc/nvram: Delete three error messages for a failed memory alloc=
ation
>> >>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/00845261-852=
8-d011-d3b8-e9355a231d3a@users.sourceforge.net/
>> >>> https://lore.kernel.org/linuxppc-dev/00845261-8528-d011-d3b8-e9355a2=
31d3a@users.sourceforge.net/
>> >>> https://lore.kernel.org/patchwork/patch/752720/
>> >>> https://lkml.org/lkml/2017/1/19/537
>> >>
>> >> That deleted the messages from nvram_scan_partitions(), but neither of
>> >> the callers of nvram_scan_paritions() check its return value or print
>> >> anything if it fails. So removing those messages would make those
>> >> failures silent which is not what we want.
>> >
>> > * How do you think about information like the following?
>> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/process/coding-style.rst?id=3Df359287765c04711ff54fbd1164=
5271d8e5ff763#n883
>> > =E2=80=9C=E2=80=A6
>> > These generic allocation functions all emit a stack dump on failure wh=
en used
>> > without __GFP_NOWARN so there is no use in emitting an additional fail=
ure
>> > message when NULL is returned.
>> > =E2=80=A6=E2=80=9D
>>=20
>> Are you sure that's actually true?
>>=20
>> A quick look around in slub.c leads me to:
>>=20
>> slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
>> {
>> #ifdef CONFIG_SLUB_DEBUG
>
> You first have to enable EXPERT mode before you can disable SLUB_DEBUG.

I see ~175 defconfigs with CONFIG_EXPERT=3Dy, so that's not really a high
bar unfortunately.

And there's 38 defconfigs with SLUB_DEBUG=3Dn.

So for kernels built with those defconfigs that documentation is plain
wrong and misleading.

And then there's SLOB which doesn't dump stack anywhere AFAICS.

In fact slab_out_of_memory() doesn't emit a stack dump either, it just
prints a bunch of slab related info!

> So that hopefully means you *really* want to save memory.  It doesn't
> make sense to add a bunch of memory wasting printks when the users want
> to go to extra lengths to conserve memory.

I agree that in many cases those printks are just a waste of space in
the source and the binary and should be removed.

But I dislike being told "these generic allocation functions all emit a
stack dump" only to find out that actually they don't, they print some
other debug info, and depending on config settings they actually don't
print _anything_.

cheers
