Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAC5C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EED4206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="GlT6yZOe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="flf7XDZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgEMGnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:43:03 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43753 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728712AbgEMGnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:43:03 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9F3795C00DD;
        Wed, 13 May 2020 02:43:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 13 May 2020 02:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=uvPlR1qQn6iWBIkjWobcrbQYsN1
        jy07EhunftcJwG3g=; b=GlT6yZOezN0ILa2rNOrgSeu0dTOtxT1HOZ/RBc0+1Kc
        eJWRuS2rpWtYFIr81gbSSfMlBQIWlRl9gxqa8714UY9LRh0iEJJn9EoAelkBHqw2
        CCUZ9c+wcE+feekbjIDDqhIZC7KtAoKduHcdvDNQr6uuqnviUkuvtsZot0TKcJ+E
        xVTVMcBggL2fYVJlOgE6wwVgDJYVjhTVFfAOskwmpwF7u2kSkO3JR1TZZT5fhtw1
        Nb5KtY7544eBXnnM31qzxxa9YOYXZ+WGsw36hxoYxVJkE67OsWKziSSZAp9+vu13
        Ij5hlBKfKv5HosXWzeBXuAMt4oupZDajRLckBPQx+0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=uvPlR1
        qQn6iWBIkjWobcrbQYsN1jy07EhunftcJwG3g=; b=flf7XDZ4GmWPln4onCPonN
        uZ2UHvwKMf2L3f//ChTO3A43svZEUaj8aRYhBQ7shcJMtNUJnpmP/6OvDSxTrdD8
        Ku5rpPon19xODSnTy7LQZPZyiipSP2OyxhyZAqnSUxqQm82YeIB5WUMHPvmHnFfO
        b28//uwmGhKqIiauOgcr/jmlAF/b8wXkVzV8I7sfgdN3s6ZNXf3a6VKuNq+iF2CU
        7VeoW490oRK/DrBsp1jCBX5Fn5EYf/NHVVIoOmGQIDUlIQQAXJTK3yih00h90bvX
        EkrEg5WFDQ2d7FUsRaYUt+53FlGqA9Wz9RkQ8nzC6qsIP2uU0R3McIVvphSoMAjw
        ==
X-ME-Sender: <xms:9Za7XjNUjv1KwRpd85I9tQ89qC6IZUhEZl09_B0V-K55dkLAm6a0eQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleefgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepueelledtheekleethfeludduvdfhffeuvdffudevgeehke
    egieffveehgeeftefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeef
    rdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:9Za7Xt_HOfaH8wIm5m_q7FW6-9RIvEzjppXGri70xD9CAgr7B0sWoQ>
    <xmx:9Za7XiTMIFtRmsDA-0KKiNkpRIxalQX1asvfS7okUJKVr91sBnziZA>
    <xmx:9Za7XnuvcvIKNv0iNBUCtyDdDrDE8_WSdPq9x6GkOVCO2Re9WkywKg>
    <xmx:9Za7Xpp3lXQXb0wD3RMzH-CadT8G4u8zm2c4RhQ0VCp3iLiF4c0aog>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 28EA0328005D;
        Wed, 13 May 2020 02:43:01 -0400 (EDT)
Date:   Wed, 13 May 2020 08:42:57 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     oleg@redhat.com, stable-commits@vger.kernel.org
Subject: Re: Patch "ipc/mqueue.c: change __do_notify() to bypass
 check_kill_permission()" has been added to the 4.14-stable tree
Message-ID: <20200513064257.GA762447@kroah.com>
References: <20200513005117.D244020753@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513005117.D244020753@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 08:51:16PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     ipc/mqueue.c: change __do_notify() to bypass check_kill_permission()
> 
> to the 4.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      ipc-mqueue.c-change-__do_notify-to-bypass-check_kill.patch
> and it can be found in the queue-4.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Nope, this breaks the build for 4.14, so I've dropped it.

greg k-h
