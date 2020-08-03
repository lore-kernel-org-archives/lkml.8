Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DDAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E565720678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kEokCWWj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e7sMIB59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHCISo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:18:44 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:36555 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbgHCISo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:18:44 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id B6F8D39D;
        Mon,  3 Aug 2020 04:18:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 03 Aug 2020 04:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=u
        Yg8O5tEu1MB1f4fPfz/YQ+9s7iAK9BjD2NI3o25nXI=; b=kEokCWWjf1w75CiP2
        mOWH0EMtEArBzu+goCbRnf/Pwn51Z4PeqCzP+FhJ0d4qFdwqgyIIXWJKAm/9EUak
        pOOi9xzwsR6/R2Hk1cPknCp9+oss/qnOi12eQSdK1b0+3IlAVDoGc9VIwI9Jqfyp
        L4JVLBh0G6bRo8vGv5X0e++3bG0f61hHPB6fpiLPV13GcAA7jy6yShTTI8idPYLw
        h3SO6m6rgTrssBIibqBMNL38v6lXwbTl4wxsaftg1B1ECFgzQqvz8rgDnECWIZ51
        0YfOzP/mtXrYdvyyxC6X4hmj0fk3UXd6fi3lzZdrx+RgkvCPWvS1eJKEVm+BhODO
        EWxtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=uYg8O5tEu1MB1f4fPfz/YQ+9s7iAK9BjD2NI3o25n
        XI=; b=e7sMIB59EaA+qirLEGFZvki5fhh8kTVXm1uh/qSWkyUJoct4H98FXo8P2
        ue1AZeCrPXyxwCV4gYNnmy+cthYq/Ghv97gU0XOJQlnOfk0cZpylHSquwCXMQKrn
        l7z6cv9dqtyH84cYTCTbQJ/rUgcLJXXxas1Z/eBN8Rp11eWfjErgihSqWvTD+TEk
        ViV0OlpaeHzyjKHKqdeYjPsv/OPUvKXWeir2DRPP6MLbbDUMlr6v3bx9IJD6Ksci
        gdAVqYk2ukqZYL0Kex3x002a5vLiIoQWt+qikhHN1VCfZCyH+iAGJuZ1L8ewkuxe
        z9m40G/RTVAvSYQ10MFnOlYA+Da1w==
X-ME-Sender: <xms:X8gnXx40-Fij4qqxg1NmVi4wrgj7ZJ3YyY0ugFPpxdv_6AbYlJL4wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeggddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuheekhe
    elffefieduteefkeejffdvueehjeejffehledugfetkedvleekudduvdenucfkphepkeef
    rdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:X8gnX-5AHziSfSW95WrBt3wm3qqP76mlHSsjh-ex6FSVlzJh0SbSPg>
    <xmx:X8gnX4fRbDAIiPvOMBHxjlVn64PsXeNkFJzdDsi_x6reVf7qN9w6nA>
    <xmx:X8gnX6Ls6-Hj_l2HcBIQNJquigyICPYJGBLy3041BFrjV-FP0tF5tA>
    <xmx:YsgnX-V5PUsERTSBEKW1Qpn28sg4v5r_0rLLmtJaUdXXJwW9-m2CPi9U8JI>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 22BA930600A9;
        Mon,  3 Aug 2020 04:18:39 -0400 (EDT)
Date:   Mon, 3 Aug 2020 10:18:23 +0200
From:   Greg KH <greg@kroah.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     =?utf-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        Solar Designer <solar@openwall.com>, b.zolnierkie@samsung.com,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kyungtae Kim <kt0755@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Anthony Liguori <aliguori@amazon.com>,
        xiao.zhang@windriver.com,
        DRI devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
Message-ID: <20200803081823.GD493272@kroah.com>
References: <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
 <dbcf2841-7718-2ba7-11e0-efa4b9de8de1@nsfocus.com>
 <9fb43895-ca91-9b07-ebfd-808cf854ca95@nsfocus.com>
 <9386c640-34dd-0a50-5694-4f87cc600e0f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9386c640-34dd-0a50-5694-4f87cc600e0f@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 10:08:43AM +0200, Jiri Slaby wrote:
> Hi,
> 
> On 31. 07. 20, 7:22, 张云海 wrote:
> > Remove whitespace at EOL
> 
> I am fine with the patch. However it should be sent properly (inline
> mail, having a PATCH subject etc. -- see
> Documentation/process/submitting-patches.rst). git send-email after git
> format-patch handles most of it.
> 
> There is also question who is willing to take it?
> 
> Bart? Greg? Should we route it via akpm, or will you Linus directly? (I
> can sign off and resend the patch which was attached to the mail I am
> replying to too, if need be.)

I can take it, if Bart can't, just let me know.

thanks,

greg k-h
