Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0268AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 06:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB43B20753
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 06:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ad5a9Zda";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="14dqTf2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDEG5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 02:57:16 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51675 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbgDEG5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 02:57:16 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E09B5C0004;
        Sun,  5 Apr 2020 02:57:15 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Sun, 05 Apr 2020 02:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=A9dbn5+Kyg5hHH3Cxnfh6Nqgtjiyajy
        p0XRJXLne8is=; b=ad5a9Zda845H8koTB0ERR7JZxprs0GdpMrwpRMZ7fZWSnYI
        7eL/bbCcC+dym83H2P2dMsjdkNQXWhpiH56vVsuP0kuaR/JgLwRTXKOOSww4Zbad
        xvqqV2oxA9ChQ+ljCKM/YmubHRPvb/ST9VNqC9zQfqHn1YgTMzUcuCdHFdPEkxph
        /gYZ71NE6Cupf59BzfE2aWpGRRAswj2whckDWzral6e+f0P8t1V9xzUZrhdNPXKT
        buYxT9RhPUsQKJ38t8yy7nu240JigMpJNxh8QpHgpMHtl//2gqX7uP9zVBpopcHA
        Ik9ySMGJRLydoSeJ78IiVopBvdt4OV9Qm9uuc+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=A9dbn5
        +Kyg5hHH3Cxnfh6Nqgtjiyajyp0XRJXLne8is=; b=14dqTf2+KbmRafna3KiVl5
        zzDeN6LUsvzS4hfOmtaXgtf3n0fvyXYWVEpRQ7MrszpbM606GKp6iFMH3gIUzfIy
        GkhSszW5H835rdIlDy3GylDdSP6ZHj6RHxuc/oH8oRlJhq6uuRvjBnRF1BdesFCP
        dBBvhzCCC6VkXw3TAgLjp7UOe16IQVo0vDDXePVUqiwcO2sbYN0WYqyxGrqzdEOp
        vpmZHJXP8cq7wHz+gvH59U6o2dIb3gdzNNjlDujJHAnwhQUptOBT2mwbv5rtwR9J
        3wIyAd9MLwYlxKg1s6mAmB5J8w/h3BoaAyF92MokFwXnHeUNa5v75/cw5L1FjUjA
        ==
X-ME-Sender: <xms:SoGJXqpQUeZqjkl-xACUmUBAr2Vg8rQ1sNxBJEcB3iSj0LoIAFcJtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
    rdhiugdrrghu
X-ME-Proxy: <xmx:SoGJXmgapWBt5Kf8rTkhp7r7bng-kjXQJRPw8G_rQEHZucHN3053Ow>
    <xmx:SoGJXoQiu6-9X_IgIbrVyp44d7z0rPw7jBSKJybq0rxbRDjSiczVJw>
    <xmx:SoGJXrKncthCYLZnHnddBt0_ovDAKwKHuOnHh_0MYhGT2fqZrEsSCw>
    <xmx:S4GJXiDZcqzwHGsOLHY60trRX9O_SJfagylrGPdMsXJRAMhB56CsyA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 62711E00B1; Sun,  5 Apr 2020 02:57:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-1082-g13d7805-fmstable-20200403v1
Mime-Version: 1.0
Message-Id: <73c7b292-fa99-4809-a0fa-b3605f35aff4@www.fastmail.com>
In-Reply-To: <d1fe0157-8a4b-f0f5-f0e4-443d6f4e3e4a@linux.ibm.com>
References: <20200402194955.16643-1-eajames@linux.ibm.com>
 <8ca08ea0-2f3e-4b44-a595-bfe96ca02b3f@www.fastmail.com>
 <d1fe0157-8a4b-f0f5-f0e4-443d6f4e3e4a@linux.ibm.com>
Date:   Sun, 05 Apr 2020 16:27:35 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "Rob Herring" <robh+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v7 0/5] soc: aspeed: Add XDMA engine driver
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Apr 2020, at 01:22, Eddie James wrote:
> 
> On 4/2/20 7:32 PM, Andrew Jeffery wrote:
> >
> > On Fri, 3 Apr 2020, at 06:19, Eddie James wrote:
> >> This series adds a driver to control the Aspeed XDMA engine embedded in the
> >> AST2500 and AST2600. The XDMA engine performs automatic DMA operations
> >> over PCI-E between the Aspeed SOC (acting as a BMC) and a host processor.
> >>
> >> Changes since v6:
> >>   - See individual patches
> > v7 is not an evolution on v6 - v7 contains a bunch of bugs that v6 fixed (at least
> > wrt locking). How did you generate this series?
> 
> 
> My goodness, I could have sworn that was v6. I took the series that was 
> merged in the openbmc kernel. Must have gotten mixed up. -_-

No worries, hopefully v8 is in the right state :)

> 
> 
> >
> > Also my name is misspelled in each of the Reviewed-by: tags which makes me
> > think that something has gone quite wrong with the posting of v7, and I'm
> > concerned that this was based on e.g. v5 but with my tags against v6 applied.
> 
> 
> Well thats because I added them manually since they had "disappeared" or 
> so I thought from v6 during the application to openbmc... guess that 
> should have been a warning sign

It certainly was for me!

Cheers,

Andrew
