Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61227C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 18:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207C020678
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 18:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586111647;
	bh=x+kFynGWyXXM2GC55ZgRHVmoTPi8QVw/0oosLlQMBYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lehwqo5jOEmnqGY7zDQZDDK+x9exF38Mk90gfrUsg986+gtCbSIu/mivAU+0OUKzB
	 L7+2BQI0UGMsnu4Ui77/znADvq+9Fc/amBVOoo4n8GrRYahQYiu99a7fXN6noqT7Qw
	 5UmBD5db6ZZhygHU92gM2Lsrmr5uxin8VmX8L/3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgDESeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 14:34:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42983 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgDESeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 14:34:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id cw6so16114153edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 11:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPuR6CYRhgjnpRT4NKAzGMXkYe/js8V/JzGHlIXiVwI=;
        b=BVBcnvGxbeEwOe6CYJrk0ROu8sLpOhFOtkOI/GkrWdicdUOuFa4HVvdXwt3l/Qc9uI
         37/lPj7jl3/IpEUKQXiNELVwx1HuBIXNikCLObDTrRVTq0bjPQ0UHf7zOSN8ZaseOwqY
         ksHRrwea1GLDHfKu0WX/JRlhTlVyRtJZCdq1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPuR6CYRhgjnpRT4NKAzGMXkYe/js8V/JzGHlIXiVwI=;
        b=MRzNWj96z/UNQ2HpB/mdTUVItlvld56C5kU9wf01e2roNJkZcPzLEItk3JxtEGSNN5
         VriPChcJLPxZJ0qJSAv6U8+KhOK/767AL4CpcJKtCimwojCdZlX3LMtb5vmIPmIzhHld
         RPlSuBu5yCWV95uiwXzENm0K/RcAKqc3pN3ZOCIoAM8ItM/DDviES3j6cUcoTSCquwB3
         1hRSI/Wc8i/L64h/x6/r8npWPnSzHmwPw9OghmBXPKpVh74HxrWKcRcH+TvaTosFSuXb
         VMxJjHZ74r8qztgvpQbH3k2J7u1qXCufnaUek+FknjG7+z4DtOfm8p33i6W2PxdFFGV4
         QN3A==
X-Gm-Message-State: AGi0PuZLVcgR+x/pvMFwlDu7NE9GiR+NMaVmttNA/y3senRxnH1Yaiy9
        8C3v+Dz/nC3dWjQMkWvuaP0+z9K+KNc=
X-Google-Smtp-Source: APiQypJ6hzYfcfDf5jbS8skGjwG1paBGCK/3QAfW6/R6eIRFoy6ymYKy5JU3YPgsibbe1AElmfYANw==
X-Received: by 2002:aa7:d855:: with SMTP id f21mr16930597eds.366.1586111641657;
        Sun, 05 Apr 2020 11:34:01 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id bz14sm2721591ejc.55.2020.04.05.11.34.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 11:34:01 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id w26so16146155edu.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 11:34:01 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr10353536lji.16.1586111332130;
 Sun, 05 Apr 2020 11:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <87h7xyrt5d.fsf@mpe.ellerman.id.au>
In-Reply-To: <87h7xyrt5d.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Apr 2020 11:28:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkkmNV5tMzQDmPAQuNJBuMcry--Jb+h8H1o4RA3kF7QQ@mail.gmail.com>
Message-ID: <CAHk-=wgkkmNV5tMzQDmPAQuNJBuMcry--Jb+h8H1o4RA3kF7QQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.7-1 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     afzal.mohd.ma@gmail.com, agust@denx.de, aik@ozlabs.ru,
        alistair@popple.id.au,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, bala24@linux.ibm.com,
        Bjorn Helgaas <bhelgaas@google.com>, chenzhou10@huawei.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christophe Leroy <christophe.leroy@c-s.fr>, clg@kaod.org,
        courbet@google.com, Daniel Axtens <dja@axtens.net>,
        dougmill@linux.vnet.ibm.com, farosas@linux.ibm.com,
        ganeshgr@linux.ibm.com, Grant Likely <grant.likely@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        gustavold@linux.ibm.com, Ilie Halip <ilie.halip@gmail.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Joe Perches <joe@perches.com>, kjain@linux.ibm.com,
        laurentiu.tudor@nxp.com, leonardo@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, lpechacek@suse.cz,
        maddy@linux.ibm.com, maskray@google.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        nathanl@linux.ibm.com,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        "Oliver O'Halloran" <oohall@gmail.com>, oss@buserror.net,
        po-hsu.lin@canonical.com, psampat@linux.ibm.com,
        Mike Rapoport <rppt@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        shilpa.bhat@linux.vnet.ibm.com, sourabhjain@linux.ibm.com,
        srikar@linux.vnet.ibm.com, tyreld@linux.ibm.com,
        vaibhav@linux.ibm.com, YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 5, 2020 at 5:53 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> There is one conflict in fs/sysfs/group.c, between our:
>
>   9255782f7061 ("sysfs: Wrap __compat_only_sysfs_link_entry_to_kobj function to change the symlink name")
[...]

The conflict was trivial.

But I want to kvetch a bit about that commit. It's doing some odd stuff.

In particular, it's wrapping things "the wrong way". Our naming rules
are that the double underscore versions are the internal helper
functions that you generally shouldn't use unless you have some extra
reason for it, and then the non-underscore versions are the preferred
and simpler user interface to those internal implementations.

IOW, the _wrapper_ doesn't have double underscores, it's the _wrappee_
that has the underscores.

That commit does the exact reverse of that usual pattern, which is
very confusing.

Now, I see _why_ you do that - normally the non-underscore version is
the "real" interface and the one we've always exported, and then the
double underscore is the special internal thing that maybe exposes
some internal detail (or maybe only does one special case of it and
leaves out locking or whatever).

In this case, for hysterical raisins, we only _had_ that
double-underscore version, and you basically added the new case and
did it without the underscores.

So I see why it happened the way it did, but I do think the end result
makes no sense and is odd and surprising.

The thing is, we have exactly *one* user of that double-underscore
version: tpm-chip.c (ok, there are two calls in that file, but it's a
single user).

So I think it should just have removed the __ version entirely. Make
tpm-chip just use the new semantics, and pass in the extra NULL
argument.

I guess I'll just do that as a cleanup patch on top, but it feels a
bit odd to have to do that cleanup when the original patch could have
just done the obvious thing.

                    Linus
