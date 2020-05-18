Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEFEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F290207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gx65fZNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgERXlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:41:42 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:40883 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726407AbgERXll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:41:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 35437AF9;
        Mon, 18 May 2020 19:41:40 -0400 (EDT)
Received: from imap10 ([10.202.2.60])
  by compute1.internal (MEProxy); Mon, 18 May 2020 19:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=J1AR48
        /Bqor8PSknA+RS5/aKkcT8MxVKSlgexmnnodk=; b=Gx65fZNsPlulb/wmjgwQnn
        gTP7oNnJH22elYHhP4vVlNG7ccXkIQyVb0dO68AWobSWeIXSVk01mtfdBPJaBWNB
        amvxrJRWZn95E8xxn6Nzh7V5MdbYcD7qRGXRioxa1iFVNPskAMp4oTCQHvYWPsB9
        9F3pOa6ovJkUjuLLOqGBZmp9ozwqPbkIl3OOUx09+us5KdyAIiEzaXSLKliHv7TU
        Q7zt4wVhUQ10Fgkv5iRrM+aSE1DDdII11dRqm1PX0ZDUTz8cmY9bzHFBJB1h6ErY
        AswrTuTZSbpj5rYaeTXrteVC4WnSDtlx5WnKYzAN9fvnq5/Gn8BFcHATqWPkvzHA
        ==
X-ME-Sender: <xms:Mh3DXgBBd0nGbBVTdcfNgvya-PFyUwirjsLn650H7VoeQbWNhz4M-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtiedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevohhl
    ihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepheegheehieeludegleelteekieejheeuteetgefgiedvkedugefh
    hfeuffelvddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhg
X-ME-Proxy: <xmx:Mh3DXijJIqCcFmAs1yKayzoQX_qBuzDrVP99DtISBYsylFDScncmzw>
    <xmx:Mh3DXjnuyYfrLH6GNoE_Nhq4X3zCoyafdV8ipVN72jsEuRSKy--tHA>
    <xmx:Mh3DXmwQcYxFiJDUwBS54HQ6wzcTa2mhGgUQALYwnMK7JPzGwyI-NQ>
    <xmx:Mx3DXuJVM_Cn79aYmNQYN1Dt6wRt3Pz1FOx6Pstg1WTFv8SB5liEvA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 421B62005D; Mon, 18 May 2020 19:41:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-464-g810d66a-fmstable-20200518v1
Mime-Version: 1.0
Message-Id: <bb232cfa-5965-42d0-88cf-46d13f7ebda3@www.fastmail.com>
In-Reply-To: <CAJfpegtVca6H1JPW00OF-7sCwpomMCo=A2qr5K=9uGKEGjEp3w@mail.gmail.com>
References: <000000000000b4684e05a2968ca6@google.com>
 <aa7812b8-60ae-8578-40db-e71ad766b4d3@oracle.com>
 <CAJfpegtVca6H1JPW00OF-7sCwpomMCo=A2qr5K=9uGKEGjEp3w@mail.gmail.com>
Date:   Mon, 18 May 2020 19:41:18 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Mike Kravetz" <mike.kravetz@oracle.com>
Cc:     syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Miklos Szeredi" <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>
Subject: Re: kernel BUG at mm/hugetlb.c:LINE!
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, May 12, 2020, at 11:04 AM, Miklos Szeredi wrote:

> > However, in this syzbot test case the 'file' is in an overlayfs filesystem
> > created as follows:
> >
> > mkdir("./file0", 000)                   = 0
> > mount(NULL, "./file0", "hugetlbfs", MS_MANDLOCK|MS_POSIXACL, NULL) = 0
> > chdir("./file0")                        = 0
> > mkdir("./file1", 000)                   = 0
> > mkdir("./bus", 000)                     = 0
> > mkdir("./file0", 000)                   = 0
> > mount("\177ELF\2\1\1", "./bus", "overlay", 0, "lowerdir=./bus,workdir=./file1,u"...) = 0

Is there any actual valid use case for mounting an overlayfs on top of hugetlbfs?  I can't think of one.  Why isn't the response to this to instead only allow mounting overlayfs on top of basically a set of whitelisted filesystems?

