Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54594C2BA17
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288A920787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Rm0wLfSN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmbIfeAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390158AbgDCAcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:32:23 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37309 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388709AbgDCAcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 20:32:22 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A273F5C02FA;
        Thu,  2 Apr 2020 20:32:21 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Thu, 02 Apr 2020 20:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=LkWwfmUQHqYqlnvd8zxThHRzsAgIZHe
        hDpsmbY7QtMk=; b=Rm0wLfSNFVZ5Il6PlDetGYdhLi+2EzgyGJ8CkMX7C3hPUdd
        hHitR413r35ldvcLY6KWAdk8bClsD6ta4ZwltkNJvnNJWZHEQlhw6O9G9Al0xhN4
        w9WjLYRTDHXSj7qLhHKNDovRkxhbRAcKEQaGauCQtias3VvuWl7dEO++jAhSjGEP
        BUxGPFEJfXs4qLIZuD5AqQNzPee0LCmZSBmVNR/3pwjgPLg5DRc4RNGh9O28TZR5
        /juQXV3bpZUOaiadfgKNBYRc6hHzgt0nsE4jIqUXpemP5H+Hk14YA6Tj9oZBuYlM
        MMngz9rsUzhtscwQ9tE5sKWjUlYkh58Yj7KIAEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LkWwfm
        UQHqYqlnvd8zxThHRzsAgIZHehDpsmbY7QtMk=; b=kmbIfeAfLHy+eo4h1JEy+/
        yINlUvUuJqEExMlFqxMHpOhEMGnHc9Ndi4rnPlorQKtlJHZDlczVBkJ/uRyf2SDY
        gt8lFZ1eUONZLWbPKkZDjryxJJNB214zxAJjQkOfZDwyzD0iGwz4Ov4UnhpGedae
        9E/V7qcXC56fjLlhMoA2GTsUBKyrshPFBpnPgz9TSBIi0rJju9k4diKOIlQ6OYcE
        /tyLD731qh+Rcq0RGRRJoR6cj5iTHvpJcTIGhCmSbHyMZ4lcCEj+F+j2FMbN2Vlk
        9l9uE9bJcTmIG/29AFWI+KloFbUn6LGN+tyQZexTiPF//ODomDsGU90zGys80Y7A
        ==
X-ME-Sender: <xms:FISGXo0AtIezSwEUulMpaimthn2b-cZNTOI76hAMLpRBEVmwQBG7Kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdehgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
    rdhiugdrrghu
X-ME-Proxy: <xmx:FISGXvObzOdOpmoltqeidVZqBr4o6bUEHdX9nvkuBBN4Q7Hgnsq7Og>
    <xmx:FISGXu9n0CUoEUT7YQh3cg4e7bXpX156aKwTdge30vWXiDGUw1kjWQ>
    <xmx:FISGXpJF6oJ_qpM8ORDnzCPok6UGEnxY4NUX4edekqTvbNsqCHPl3g>
    <xmx:FYSGXkEmstYTkXivRx6fcfv_MfqxsWlj0Ps1gqXrOGyLzaCsDjk8ow>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B0678E00B0; Thu,  2 Apr 2020 20:32:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-1080-gca5de7b-fmstable-20200402v5
Mime-Version: 1.0
Message-Id: <8ca08ea0-2f3e-4b44-a595-bfe96ca02b3f@www.fastmail.com>
In-Reply-To: <20200402194955.16643-1-eajames@linux.ibm.com>
References: <20200402194955.16643-1-eajames@linux.ibm.com>
Date:   Fri, 03 Apr 2020 11:02:41 +1030
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



On Fri, 3 Apr 2020, at 06:19, Eddie James wrote:
> This series adds a driver to control the Aspeed XDMA engine embedded in the
> AST2500 and AST2600. The XDMA engine performs automatic DMA operations
> over PCI-E between the Aspeed SOC (acting as a BMC) and a host processor.
> 
> Changes since v6:
>  - See individual patches

v7 is not an evolution on v6 - v7 contains a bunch of bugs that v6 fixed (at least
wrt locking). How did you generate this series?

Also my name is misspelled in each of the Reviewed-by: tags which makes me
think that something has gone quite wrong with the posting of v7, and I'm
concerned that this was based on e.g. v5 but with my tags against v6 applied.

Andrew
