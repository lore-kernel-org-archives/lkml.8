Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7EAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0157920885
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="L88q8AT/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YOIrJO8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgFSHHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:07:04 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51629 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729009AbgFSHHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:07:02 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3925E580110;
        Fri, 19 Jun 2020 03:07:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 19 Jun 2020 03:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Iaq/G/g6pbIsquztKfoYM/2rAsj
        V4HKssqKg+8kxQbM=; b=L88q8AT/RGODoyttIOo/VtluZCybnabYcpoLzIW2uEV
        FMKP4dNQ9Nl6HE/nSHxWU+kJazmFlrFknoX+AkHnR7UYdtKLYX+szv6rFsl/P3vy
        GBKVsE2nOVk/x6Qv90LELqbheen81SbT0B5SnJvrLdFVXkC55YABWtL8SN8gTnZw
        1/UANpjBsPZMiBFpER7XwI9p2iRPqDXYPHZUlvJnvajeLjU9tWCxzdC3DkJoegn5
        uxjmAoijso6p/SfgpfMBvreIktsaOw9MdkrPGhWVeMS4Les6zcK5HETjwt1K3lFA
        HpfguQpisi/m47dg9wui6cBghW0Rd/WoVktklKMN/rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Iaq/G/
        g6pbIsquztKfoYM/2rAsjV4HKssqKg+8kxQbM=; b=YOIrJO8ZUj6zGNfOLzjcAx
        b5RiG1iFbZcbL2/KeBLyZPcsopk/EQ5l4cQMRAnr2XFlTjzXwyRbpAlnBNP5p3T6
        7M2v79P76YDSe9U+7ox397Sbj0S8VO71+rvNVszQE9MMj7kYUKXXOaKDCmJa95nK
        racG0aJY6CeM4ozEzKesUYzChJ4bdhC/RQWx6DaLL9rPYAiCAQr/dl5xpDKwMKyZ
        WVRGS5fD92Nb5K7PFpUwvlC+CsOBirzH9Bc43r46lkyknZIn0KaUOHLjs8X34gx1
        tbFVVjTFaiVC2FRYBIBiaz9kPN1FewKyQT0kZoVlNHfncNYOm1tCPRyJZnJ4S4Kg
        ==
X-ME-Sender: <xms:FGTsXtliYZaq89sSjvtZu8aEyMEx0DQw79i6GJhxUQvxskPMs2iCUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejhedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepjefhte
    evueegjeejtddtkeetieeiheeuhedvfffffedvteeifeffgfejffeuvedtnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdprghpphhsphhothdrtghomhenucfkphepkeefrdekie
    drkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:FGTsXo0oSBxPcRILkBfAPAcAgoyJs1G_NNzcnYu1TQKSaTbvkKblgg>
    <xmx:FGTsXjpKhH4OtvvVo6oi9Dse80IOClZerPBo7jkUCQSqOs9ciXHBuw>
    <xmx:FGTsXtkiX7cfddVeeLSSXrZkzd__e7Ibd-PhWITKFpU4-Uwmzb0PbA>
    <xmx:FWTsXkI1IsKBl76qrrWcY8Ga8m4HINlwk9uO17LAzlD_CMeJ7xijoA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F79D3280059;
        Fri, 19 Jun 2020 03:07:00 -0400 (EDT)
Date:   Fri, 19 Jun 2020 09:05:27 +0200
From:   Greg KH <greg@kroah.com>
To:     syzbot <syzbot+42bc0d31b9a21faebdf8@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, bp@alien8.de, devel@etsukata.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, x86@kernel.org
Subject: Re: INFO: trying to register non-static key in is_dynamic_key
Message-ID: <20200619070527.GA544353@kroah.com>
References: <00000000000004a76305a8624d22@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000004a76305a8624d22@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 02:17:15PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    b791d1bd Merge tag 'locking-kcsan-2020-06-11' of git://git..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f305a9100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=16c2467d4b6dbee2
> dashboard link: https://syzkaller.appspot.com/bug?extid=42bc0d31b9a21faebdf8
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136ad566100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10138f7a100000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+42bc0d31b9a21faebdf8@syzkaller.appspotmail.com
> 
> INFO: trying to register non-static key.
> the code is fine but needs lockdep annotation.

Why is INFO: triggering syzbot?

