Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D10C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9EDA2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FUh4tqaV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kQ004FSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgHDHhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:37:34 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:46039 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729596AbgHDHhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:37:33 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9BDF85803B6;
        Tue,  4 Aug 2020 03:37:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 04 Aug 2020 03:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=F
        ocaEVAZNOs0ka4mL6/6OKxNWgHGmuyCC7zusvr1Pd4=; b=FUh4tqaVdu4BCwO17
        1kbbYDF7QOanYfyAl6laql1JXzWhnS8A8QlrfS3CdUZLXUAeLCdEk4JYjW+FzWb+
        HdQcHUL8nqK7aRVXWV5EQ9n/ihOnQKr7f802t/3KXFYAxLz8FQjw0dp0fyVe1bm3
        lspxwY32F3W0gN/HAhFWFIDDA1D+7R8XHrbivUiI5ePbcwM+cMyCu9L7RdN8kgG8
        2Kd5V3iQr8r3fAEuCRL33lulvObydW2aJaiff5GRxrRA8oZHt9qP5anVlWpSohoE
        f08KhdQNKlETk3Mi6GoaMmNIlCS/gwb7QGcBKUN0hkQyaAa9QTeYT78jIEmI7ac3
        XSDcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=FocaEVAZNOs0ka4mL6/6OKxNWgHGmuyCC7zusvr1P
        d4=; b=kQ004FSg9gs4aPO4D9qVcddcL27QJfEF+krIFkz/PSlsD7jT49WWF1Pyi
        Oxf/QaiPNBpKAMPAD0JeGktU5a73RdAIQ3v4m99uBTtFFZeweZBOgLcNC2MGjpiH
        agc6ZH7zh0S7IPnP85LpVaQpoeUSShrY2kewmnTnjjAvaJMvkvhngbv7etR08DiY
        yCp3HcR8ntRwQS+1nU5fs7y+X/VclWxzE659ys0bHvuJT+e4pqqkaa2BUlzV0D4k
        woNxnKgfYHoHVJtvfWmSVT/jlWSZJSNBatic/H4z2Yb4DEaZqGyzz8wRKBL3XL4o
        ezodNClD7d4VjdbSh8LCwXXHVLhqg==
X-ME-Sender: <xms:OhApX3OQzB_EZn2dDOhkhCf4ipDnmc5RLLf_TeUTJ7aUwH2HUL3wOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeehgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepueehke
    ehlefffeeiudetfeekjeffvdeuheejjeffheeludfgteekvdelkeduuddvnecukfhppeek
    fedrkeeirdekledruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:OhApXx_v2n9lecvivSPrCjw2ZFh8vZeJ1MlYDBc6ipjjNeMwFsTkfQ>
    <xmx:OhApX2QCAm1NoA70VI4fVBwUdt4IACAI4IOKTGNaNAQolAxURIguIw>
    <xmx:OhApX7tIFGk6mj6tbsp5zfY-vuPw54tIcP1DOX5uSsod7y-8ZerjeA>
    <xmx:PBApXz4OiQiYB_CIyeAVDDntFVYjAO_7_J-59wVmtvT4YY4zi71l7A>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D7EF030600B1;
        Tue,  4 Aug 2020 03:37:29 -0400 (EDT)
Date:   Tue, 4 Aug 2020 09:37:11 +0200
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
Message-ID: <20200804073711.GA1749774@kroah.com>
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

I'll go fix this all up now "by hand" :(

