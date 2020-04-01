Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F63C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8F42073B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FzxJt0Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbgDAKJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:09:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33474 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgDAKJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:09:26 -0400
Received: by mail-qk1-f195.google.com with SMTP id v7so26436766qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 03:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/JUjrVIAN05JaqOZ81e9IeMVI4IIpPJGuXB/jnNFM7c=;
        b=FzxJt0Nt0NgAOpqNI+AdrmKN0ewi+HoB2BYl1EDjlDDlCJbGfSSc3nt2OmQM8v08KX
         iSUuKe/+Ujy5NZxR2ldOqTxUSAp4hWsKkaxOTuxqLDX7dgCLt9yBU0Lpf/xKG8I/gBrp
         PHaK3fs5zyk12tmLZEuCpGQmwJ75uxSLvB8L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JUjrVIAN05JaqOZ81e9IeMVI4IIpPJGuXB/jnNFM7c=;
        b=l/C7NNZB8y8+SRN34QUYIKnUTp+FsQdyM8GLMfLex9SIkfvLT9Klw1UpgEkXvfZM30
         rdeXJSkm0Lkth4hwiVVYq3mRYrpAGKmQ0s9YZBarj2fX5uRlSc0yU1jtI3UjtgfOfZq6
         0wDrKOIbpm99ccuYmEDmEWZkDiJn2MREu9SnCNc5TXbCEOToLck0q6+W9oIhbh4YLbtZ
         V2dkZhnGHSYFybGE6gs8XcKgWZNYwVII51VFLGWat3y5Xh4xj/uUP4DsRcEfnP2DqUmd
         jvoDPpmoKBMe8v73gNlRltT2DoEELYEFXa5JGKuQsQQMK8hcMlgJDsTJCQwqEQ5PXEk0
         9L6Q==
X-Gm-Message-State: ANhLgQ3lqXh98bJC5mD+atRsT+NQvnTXDCtSoD7KlO+ZWK9ioVI3jDdb
        1ekkZl1ymFXH9PXJ2HZ6y1S7a56cBtTFzd04f+AGsA==
X-Google-Smtp-Source: ADFU+vtPd4E+NnE4TazTxijuOX3MAT9DQTdGDWseHds1p8VHfgot0c3aogWL65bsNKSGf7OpXSolx0nI1ArWW2w+E6o=
X-Received: by 2002:a37:6cb:: with SMTP id 194mr9284729qkg.235.1585735765690;
 Wed, 01 Apr 2020 03:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200331124017.2252-1-ignat@cloudflare.com> <20200331124017.2252-2-ignat@cloudflare.com>
 <20200401063620.catm73fbp5n4wv5r@yavin.dot.cyphar.com> <20200401063806.5crx6pnm6vzuc3la@yavin.dot.cyphar.com>
 <CALrw=nFmi_f-c3fbU5ZizP228y4R2LxHdN8eQ1ht3YVBW0CWjA@mail.gmail.com>
In-Reply-To: <CALrw=nFmi_f-c3fbU5ZizP228y4R2LxHdN8eQ1ht3YVBW0CWjA@mail.gmail.com>
From:   Marek Majkowski <marek@cloudflare.com>
Date:   Wed, 1 Apr 2020 11:09:14 +0100
Message-ID: <CAJPywT+WHZadscThYD2Y=K3q5DUUyHp1UFMtoCyXMU_+AbvDoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mnt: add support for non-rootfs initramfs
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        containers@lists.linux-foundation.org, christian.brauner@ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> However now we see more and more cases needing this and the
> boilerplate code and the additional memory copying (and sometimes
> security issues like you mentioned), which can handle this from the
> userspace becomes too much. I understand the simplicity reasons
> described in [1] ("You can't unmount rootfs for approximately the same
> reason you can't kill the init process..."), but to support this
> simplicity as well as the new containerised Linux world the kernel
> should give us a hand.

"You can't unmount rootfs for approximately the same reason you can't
kill the init process"

Pardon my ignorance but this explanation in docs never made any sense
to me. Rootfs is pretty much the same as tmpfs. I don't understand why
we can't do pivot_root on it and why, we can't unmount it later. I
must be missing some context. Can someone explain what is the reason
for rootfs to be restricted like that? Perhaps we could just relax
rootfs limits....

Marek
