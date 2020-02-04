Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61E1C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704E52082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cawzCuUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgBDPty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:49:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21073 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727311AbgBDPty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580831393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jc0jwQ8Mrnulk4hcRGlXfLCKMEivRMsq7jO1NHpoXC0=;
        b=cawzCuUQaZSGs48+D+avs0xUCjMN0H1ejaofOITqXznJ4u2dup+q+4bHJU18nNnQGKZHiE
        kthZae9pFzHTmx9vOVYc1ImvjS6w3qOOQAfn4ZPlhyqWNXpoY5Ddeg3Bm0SnaY+62snuJh
        s2oqtPXy2TncIqQGdT1LRwBjMDQozss=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-0JNQ3P61POqjWghE2qeo9g-1; Tue, 04 Feb 2020 10:49:37 -0500
X-MC-Unique: 0JNQ3P61POqjWghE2qeo9g-1
Received: by mail-ot1-f72.google.com with SMTP id a20so11245956otl.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 07:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jc0jwQ8Mrnulk4hcRGlXfLCKMEivRMsq7jO1NHpoXC0=;
        b=IkhndPjib1mk5NvPptOWBWR/Vnn964xo32onqBILdYhGTJUksq3l1l1UzKNj1D98vh
         q9l3oLty2Qy8vYGISRQ47hcNd6sUSTRoZSCbc6lYXkPdPx18PxvtTrbmPZqtA7mTiexA
         taBIKdpUE+c1+6djdVyR5hGCIg9Lyn1jVtPwWecJmkRSKiZ7woyidvmRA0zNtiwdfs7y
         0kDqRzCYVX+BLZx0rDSB62rZl7diPKMsalsELuSduFKY1HFli+gTbnbR9gHfDfMUkUL+
         P7+xVuMw7aoxtVKHFmAdkPbYwoWMalOdjzMUFSL0WgohOlLhM77mjSt5jh5W3LP9Eqfv
         yzzQ==
X-Gm-Message-State: APjAAAVAIEqY2xLS/06Tb7JY0toO6Dqw4rF9SefCWsHOcvqQij6pk1RO
        C5sIralnjOcpcwQ1/eLxks/FTbLN12e+LwoBLuQjKpKju8qxZSyyNhP2GXv9ZxyIMZLmLY0s+gr
        EwptY0ChQIWslyRhxZkQJ1v2pZwC2f3IOB8aCwGQV
X-Received: by 2002:aca:1708:: with SMTP id j8mr3906521oii.166.1580831376590;
        Tue, 04 Feb 2020 07:49:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/7pJYKxR0wQIzWWmQ6QzoKdiSTwKnxwtzbmml2Vsp/OVsGZOcyT2Pr2dG8+zqCPa3KsU9UiVHZDCr6yugfxo=
X-Received: by 2002:aca:1708:: with SMTP id j8mr3906505oii.166.1580831376283;
 Tue, 04 Feb 2020 07:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20200116213937.77795-1-dev@lynxeye.de> <2d1a3d66-c2ee-f7ea-a884-11ac9150d994@tycho.nsa.gov>
 <CAFqZXNtJ2h-HPwzV9t1bizVB2=xWh=s3jY5aqXG1x86b+oEMYg@mail.gmail.com> <f821809b-548d-fd95-6574-7c74c634353e@tycho.nsa.gov>
In-Reply-To: <f821809b-548d-fd95-6574-7c74c634353e@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 4 Feb 2020 16:49:24 +0100
Message-ID: <CAFqZXNvih96sEODRJhFvCmx50ROWMb6vF1dK3sUJe_Q4hLiSzw@mail.gmail.com>
Subject: Re: [PATCH RFC] selinux: policydb - convert filename trans hash to rhashtable
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Lucas Stach <dev@lynxeye.de>, Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 4:39 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/4/20 10:01 AM, Ondrej Mosnacek wrote:
> > On Fri, Jan 17, 2020 at 8:11 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 1/16/20 4:39 PM, Lucas Stach wrote:
> >>> The current hash is too small for current usages in, e.g. the Fedora standard
> >>> policy. On file creates a considerable amount of CPU time is spent walking the
> >>> the hash chains. Increasing the number of hash buckets somewhat mitigates the
> >>> issue, but doesn't completely get rid of the long hash chains.
> >>>
> >>> This patch does take the bit more invasive route by converting the filename
> >>> trans hash to a rhashtable to allow this hash to scale with load.
> >>>
> >>> fs_mark create benchmark on a SSD device, no ramdisk:
> >>> Count          Size       Files/sec     App Overhead
> >>> before:
> >>> 10000          512        512.3           147715
> >>> after:
> >>> 10000          512        572.3            75141
> >>>
> >>> filenametr_cmp(), which was the topmost function in the CPU cycle trace before
> >>> at ~5% of the overall CPU time, is now down in the noise.
> >>
> >> Thank you for working on this.  IMHO, Fedora overuses name-based type
> >> transitions but that's another topic. I haven't yet investigated the
> >> root cause but with your patch applied, I see some test failures related
> >> to name-based transitions:
> >>
> >> [...]
> >> #   Failed test at overlay/test line 439.
> >> overlay/test ................ 114/119 # Looks like you failed 1 test of 119.
> >> [...]
> >> filesystem/test ............. 3/70 File context error, expected:
> >>          test_filesystem_filenametranscon1_t
> >> got:
> >>          test_filesystem_filetranscon_t
> >>
> >> #   Failed test at filesystem/test line 279.
> >> File context error, expected:
> >>          test_filesystem_filenametranscon2_t
> >> got:
> >>          test_filesystem_filetranscon_t
> >>
> >> #   Failed test at filesystem/test line 286.
> >> filesystem/test ............. 68/70 # Looks like you failed 2 tests of 70.
> >>
> >> You can reproduce by cloning the selinux-testsuite from
> >> https://github.com/SELinuxProject/selinux-testsuite, applying the
> >> filesystem tests patch from
> >> https://patchwork.kernel.org/patch/11337659/,
> >> and following the README.md instructions.
> >
> > I think I figured out what's wrong - see below.
> > <snip>
> >>> @@ -441,6 +442,39 @@ static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
> >>>
> >>>    }
> >>>
> >>> +static const struct rhashtable_params filename_trans_hashparams = {
> >>> +     .nelem_hint             = 1024,
> >>> +     .head_offset            = offsetof(struct filename_trans, hash_head),
> >
> > You need to add:
> >
> > +.hashfn = filenametr_hash,
> >
> > here so that the key is correctly hashed on lookup. After applying
> > this fix, the selinux-testuite passes for me with this patch.
>
> Hmm..does that then make the .obj_hashfn assignment below unnecessary or
> is that required too?  I'm unclear on the difference.

No, they serve different purposes - hashfn is used to hash the key you
pass when you do the lookup, while obj_hashfn is used to hash the full
objects stored in the hash table. In general, these can be different
types, but here we use the same type for both, so the same function
can be reused for both callbacks.

>
> >
> >>> +     .obj_hashfn             = filenametr_hash,
> >>> +     .obj_cmpfn              = filenametr_cmp,
> >>> +};
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

