Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597E4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F40F2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hXoXZ6TB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHCQm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:42:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B468EC061757
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 09:42:53 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c15so18039436edj.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0pKh21HmMgiXpI5XylfnfnlKkDhj9u5DS7LTshm78/Q=;
        b=hXoXZ6TBCbBScXYbb5A1s7OlEyuW5Wtgf1zZ0XwdDpBSIHsqy8yvn5+w2rGc69nZIT
         l14JxxWwHcaySE3rw7efhnidZfyYOHa92F+dTJ+xiUKYry90lsnY3Oy+qndo0W7azWJp
         HxqF9785aLkrsVVsbqgHaqnHqSXxXIEZw0afc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0pKh21HmMgiXpI5XylfnfnlKkDhj9u5DS7LTshm78/Q=;
        b=AUKm3RmO8WNmCaLCpLc1WNB/GYbLB1YaWB4hXLEuj9TdgSK9vVi4RG73jy7F23zE1k
         eGTxiT0Nt6o+ryGY0vywT5muljtKRMlfD+25h7GG3iJ6WZxzLVtMfftlaPd2+5Yn+K6L
         0IWEVRWnPdwWVcBbv/nZo7OkBG3I/rJjWMj2TnzU44zlBrod5nVrzo+x+E4Bcpfre+Eq
         4/LoavVMtBdw0O4g77eR3wUBihhxTGK9VPcbw4yPGHpHVUnZdVZuOWtRX+jUfLsLltNh
         wRsKDtK9/O34XSGf+VEGVtbTKUx/LxVr7idzte8t5OiXGYrhrmhcA1llE2GQc0tlsyJm
         /q6Q==
X-Gm-Message-State: AOAM533V7iM5sXw8lr6OnFfCELHKsZTZ4BDXXwmfBerp7QNdjguRcMm1
        0Laryl0LoVu4ijif3qwBtzYVlOc0NXnU/husFm+jgw==
X-Google-Smtp-Source: ABdhPJwGt6JJkCjQ+xGlIzKcZ+W4kFA471qhTIr1uxHZ9OOmk1ZAH30Hdlmr+9NCbPwUEszgoyIELLGeaKMDR31yuwI=
X-Received: by 2002:aa7:c915:: with SMTP id b21mr17121686edt.17.1596472972292;
 Mon, 03 Aug 2020 09:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
In-Reply-To: <1845353.1596469795@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 3 Aug 2020 18:42:41 +0200
Message-ID: <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
Subject: Re: [GIT PULL] Filesystem Information
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 5:50 PM David Howells <dhowells@redhat.com> wrote:
>
>
> Hi Linus,
>
> Here's a set of patches that adds a system call, fsinfo(), that allows
> information about the VFS, mount topology, superblock and files to be
> retrieved.
>
> The patchset is based on top of the mount notifications patchset so that
> the mount notification mechanism can be hooked to provide event counters
> that can be retrieved with fsinfo(), thereby making it a lot faster to wo=
rk
> out which mounts have changed.
>
> Note that there was a last minute change requested by Mikl=C3=B3s: the ev=
ent
> counter bits got moved from the mount notification patchset to this one.
> The counters got made atomic_long_t inside the kernel and __u64 in the
> UAPI.  The aggregate changes can be assessed by comparing pre-change tag,
> fsinfo-core-20200724 to the requested pull tag.
>
> Karel Zak has created preliminary patches that add support to libmount[*]
> and Ian Kent has started working on making systemd use these and mount
> notifications[**].

So why are you asking to pull at this stage?

Has anyone done a review of the patchset?

I think it's obvious that this API needs more work.  The integration
work done by Ian is a good direction, but it's not quite the full
validation and review that a complex new API needs.

At least that's my opinion.

Thanks,
Miklos
