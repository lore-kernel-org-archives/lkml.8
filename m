Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1535EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73E62073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgE0Wfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE0Wfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:35:47 -0400
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:33:fb76:806e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEF2C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:35:46 -0700 (PDT)
Received: from mr1.cc.vt.edu (mr1.cc.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04RMZjSQ021662
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 18:35:45 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04RMZePL002980
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 18:35:45 -0400
Received: by mail-qt1-f200.google.com with SMTP id t24so3068778qtj.15
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=wAfrgwiy8FRYZqVG4if/0XphI1xwoqduQ4nX1CyB3XQ=;
        b=iwkaPL2Hh32pVcPWv/3SMe3jGTFknRGgrc2Aiz+ctsfKESsywJbnxa2Qlvhf0CX7IG
         iD5CCFuaWtYgeaVwgfvz9vmGKn0vr3/khOGqhf7myBUccyUDmIGJnVb5OS45FD3j6O8R
         CtE4YLwQEHJesXujtaIRFYkKD7IObMtenyKJw+yHavkP3RbDsDrzjl9kAuFFYyy1/uyB
         aUWIRH1lDYwHiIFTE7C9YafdBUplEFuok31PYgLgOsXwquG54ud1mQ5ZxcGwUP/3mkoc
         Mpf6E9Sop0lhgeebk5l9Ez4BPxOHLf7s1jUF8NYnKKKoHNdprPbRX72pBdlC1DONK7Zm
         9Pxw==
X-Gm-Message-State: AOAM5332yNqqbNmaw3kFShAC2kPscUgsqEygkGFmkBeZxUIKYwK3JhRs
        +TBBo2GfMoXFTfghhAZbpATuvVfjrcysB212SRX9HjolT6xgZ5C10KXzE1f5Qu4dZ0t0KBDAdzW
        LaQNnyJ+3KEht/xYXLWPfz5zpcq4g1+Xq4fU=
X-Received: by 2002:ad4:5624:: with SMTP id cb4mr244722qvb.154.1590618940014;
        Wed, 27 May 2020 15:35:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvSOV04NC8GPpLZ3kCE1Jln8ku1I0WYDMmMd8SFB2kWTPSoZpLpaIek+ain75HZ4nTzoLQeQ==
X-Received: by 2002:ad4:5624:: with SMTP id cb4mr244700qvb.154.1590618939680;
        Wed, 27 May 2020 15:35:39 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id w3sm3519357qkb.85.2020.05.27.15.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 15:35:38 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf_fdpic: fix execfd build regression
In-Reply-To: <877dwx3u9y.fsf@x220.int.ebiederm.org>
References: <20200527134911.1024114-1-arnd@arndb.de>
 <877dwx3u9y.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1590618937_16657P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 May 2020 18:35:37 -0400
Message-ID: <441347.1590618937@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1590618937_16657P
Content-Type: text/plain; charset=us-ascii

On Wed, 27 May 2020 17:08:57 -0500, Eric W. Biederman said:

> Is there an easy to build-test configuration that includes
> binfmt_elf_fdpic?

I tripped over it with a 'make ARM=arch allmodconfig', but any
config that includes CONFIG_BINFMT_ELF_FDPIC should suffice.
I haven't checked the 'depends' for that variable though...

> I have this sense that it might be smart to unify binfmt_elf
> and binftm_elf_fdpic to the extent possible, and that will take build
> tests.

Bring it on! :)


--==_Exmh_1590618937_16657P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXs7rOAdmEQWDXROgAQKfFg/6A1io4tXqeORzdvfNlEZnJZC5ZT1M+b1V
yC+vexxgJY/0oRN5y+76+hhBckAoacD4ABy9sH755aKwaPbsnmo9v3DCLK8W/Dxr
taIQ7NlSDWm9F4gTo4nkiutbogP5QjYbAnJdO5h/TrUN/HzOvf2TrJ43WYBxGQrE
4Tpy8knIfdZb/MNlSA0zbcqzzs3oZ4UxQvVs/xJ0NsLoR7FvVIELhEovxd+mpwLH
/Ynf2K73gIHhamKCRvCA3YZuXX1qWZPAr0XjJ/FcIWc8LsQD4WDksPKzYJjHun0B
sh/7aVPzd9HYcotsNamWAkdJL4wtH1LSItSS1TxX69FAN4OchXhiSZlHtPlJ1sI0
US2WjWffW0xC9rzJFTNvhft4FuB2AJlP4bJmuH7QXyR2UH0IG51J2LhQkzBwb7EV
bxa7pUV7lVrqEvB1nFc4nYC441kT8MlGF3AQh1W74InfeB7Os1nLrvVlzsoCXrFn
l7WLHTgi9Vtb7DXDmQz76+cpdq35NMbQL3+Aiqv/SphmTDIt8ePQ0hgH/5p3snGf
jh1zhjyQeRfgZj7cs0FpGtUhgO0cA1TcBhyPadUju1IVk5yut5hfPREd6dC2VmJS
Il5MuZFGpGfXkaLnE2EgnEVNmzXDQi2TnYguqvhtOgJPn9dl+X4EeR7rpTERWlkH
nBq+1ugzGtw=
=ccnE
-----END PGP SIGNATURE-----

--==_Exmh_1590618937_16657P--
