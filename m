Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43FEC83002
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A7C2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="PKuE5VM0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p8B8FL6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgD3Gm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:42:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58175 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgD3Gm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:42:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 901365C00AF;
        Thu, 30 Apr 2020 02:42:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 30 Apr 2020 02:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=jAz8BqP1L52IWPGLL0vxJ+gS/S+
        8G9kBMZSXzW897Jo=; b=PKuE5VM0CASyCOgYSdvxd13brg8UVv0R8DaNeR38nkY
        NqnarYhOpjw7OBZ/Yh9ZHLpHp+M8YcWzOV87zd/RszZMj6VrVpuT6VVhJ2y+43jv
        BHBrGT/bJfwTri21TxAMb1otvOkHmyLAe9eVzBZtVskXcunQXuGepvmvHS/pcrky
        +JhdDT0hnHGzQ+gSNYhc2sO76wI1XhaORxPAvQWOHVmTYSGf1PlIGQb23MU/jGty
        C3KByaKnH2IkTk0d2Ag16Ngic9m0C/GNERLJhv0s9N+kpRjrMK7V94PtNPwLM5L9
        nc8kNcMHWvfIyDZqe/pfxftqU5q/VUypZnY5EtjGznw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jAz8Bq
        P1L52IWPGLL0vxJ+gS/S+8G9kBMZSXzW897Jo=; b=p8B8FL6Ci9B9K+4TDUWE7M
        zLk3HuT3JvOlEpqOxGJ0RUPiGzKM+fgAG3uUV7Fi1qjBnhNRwABZTMHqM8jByczD
        foHSQWfcXFfzklR91tX/ECcLeXkWpjehC9x8o/iDpwhNMJjWR4qNF3erPwn/BjOL
        C5NDEjYy7xinXOiKaxEO6w9mlAYor6O57FFiHwduCl95QL17D5AiM6EHup7PIlnf
        t65lrPuLQhF2tuK+mdRKEEXciXaqCnFq1KXYeZIPFWuRPgXLYIYcpgDmRmg1+DkM
        aicQgPfThaFPpJturq/yuXMwvFNoWR9L/ApZBxhGZujbKkMuacZwCma5Y1jX/aew
        ==
X-ME-Sender: <xms:cXOqXi5h9axX0lwRygHJjlhlzgkKVIIfYsoSOM3XbRSrha_1uhGe2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieeggddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:cXOqXgKBWWYmL9xDvkSG5z6v1QdvV4Y4dWMf8o4vnv3OHvJD86MINw>
    <xmx:cXOqXuZxw7EShR5fFEC-NHlAXzy4auXu1XEJQw8Ydss-Sp2pq5icpw>
    <xmx:cXOqXt2jI6BkvWP46eYjuCFTq9qt1MvJ2E7uL8mips-MmNPxpc5ggg>
    <xmx:cXOqXtOjeRJBxx8wyCkVFeMrbyMaWsvqk4xgy-mmlTppW90ZXa8GRA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id DE42B3065F05;
        Thu, 30 Apr 2020 02:42:56 -0400 (EDT)
Date:   Thu, 30 Apr 2020 08:42:51 +0200
From:   Greg KH <greg@kroah.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Clement Leger <cleger@kalray.eu>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH] remoteproc: Fix wrong rvring index computation
Message-ID: <20200430064251.GE2377651@kroah.com>
References: <20191004073736.8327-1-cleger@kalray.eu>
 <CAD=FV=WgUNySbRE9dZys28fFo3eZwf_2=cj68jaw1ftakJDzVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WgUNySbRE9dZys28fFo3eZwf_2=cj68jaw1ftakJDzVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:26:41PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri,  4 Oct 2019 Clement Leger <cleger@kalray.eu> wrote:
> >
> > Index of rvring is computed using pointer arithmetic. However, since
> > rvring->rvdev->vring is the base of the vring array, computation
> > of rvring idx should be reversed. It previously lead to writing at negative
> > indices in the resource table.
> >
> > Signed-off-by: Clement Leger <cleger@kalray.eu>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Randomly stumbled upon this in a list of patches.  This patch landed
> in mainline as:
> 
> 00a0eec59ddb remoteproc: Fix wrong rvring index computation
> 
> Should it be queued up for stable?  I'm guessing:
> 
> Fixes: c0d631570ad5 ("remoteproc: set vring addresses in resource table")

Thanks, now queued up.

greg k-h
