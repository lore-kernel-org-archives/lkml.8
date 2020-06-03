Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1101FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2DB20678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Elf09EBn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gyta87TF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgFCMJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:09:52 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:51543 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725833AbgFCMJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:09:51 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2F5095CA;
        Wed,  3 Jun 2020 08:09:50 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Wed, 03 Jun 2020 08:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=KIKPwr659s7Oluc5bDuXmKZTOFH2ir7
        8GgHPyhXlIZc=; b=Elf09EBnIyTSWDhQ48lesKGzcvJGb/O8t5MQPBJzfZtMi5H
        gdYUQAdjsMyJBbdJvK7QcKtkRu/9mcw5hrgALETEUKgoQFvnP1tRePNq5VJ7Ox3C
        Q1zviSRRxUQisq7ClS0/SkwiwIYjDXiz1eNT1+dK8Av6alKe2q3CQNZfsoiNLAIU
        KnmKQpej81CKVf8PvlYYPNwer81R6wrSZFFLXBUZZEOcBm7BCfJaccXRRYdmkhu/
        69TFXmjx/q63LgXBrEaaXZ4wdR781UWoKxtlq9x1vnK9WseDqJV1/7dka8P6xTJJ
        oeMBcapzTCzz8tcXwEaNlhiU881by1mY3Rb7yug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KIKPwr
        659s7Oluc5bDuXmKZTOFH2ir78GgHPyhXlIZc=; b=gyta87TFekwgf1F9TE8IV+
        pmDMKZBNwj8zSekLpqjiu2XLxND0uSmu1XgWE6gN0XNaRGCC7VGupI+gfQXzBqXr
        XRVgd8wwwkoIohhxGTNZ3O19PxvthljmDwwKMJ6FLs6Q7u/HiRMItqhGCLjo5OPE
        Qhtmo8CC/3w6IGQyELAb5vIHnDpIpoDfNx7xucrGXBL+OHBZ09RI6Ay2sGGAg1bJ
        XUpYZoIKUFeUjLvbXSAd6miCw2TaEuDSdd7mocw/4ey75OllSvO4q7qtJZx6qdI6
        DhvOHf/kthQHqvllM1jC3sfe/5lG+VJcQyeW3oqBWvagQ/SE78R4aaN8uK9CxOJQ
        ==
X-ME-Sender: <xms:DJPXXjsfTE0V4mVwgmr-5qMIfKlamoetIs0bPQfjlVXSIoK9xbuQ3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefledgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:DJPXXkdq0okIZuqh_Z4AdVGrGGKJ3jx-ZKssyq8hhnRkNn3quPjDOw>
    <xmx:DJPXXmxi5zyqZjOF21Tf_w5Kn7Y5baOJhzlHp88i-8M60NWlga2LeA>
    <xmx:DJPXXiNcZXnetn9-91o7OhxsuDBpwk3tJ3l3L2jpQUoZt-ZbeOMmrA>
    <xmx:DZPXXvYF5KcAY5I_hT4vAuaGvLOxges-cHvobaLhZUnXnjNxnw3QWw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 21674E00A9; Wed,  3 Jun 2020 08:09:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-519-g0f677ba-fm-20200601.001-g0f677ba6
Mime-Version: 1.0
Message-Id: <443d4707-2344-4356-bafb-ca235687dccd@www.fastmail.com>
In-Reply-To: <20200603120526.16178-1-colin.king@canonical.com>
References: <20200603120526.16178-1-colin.king@canonical.com>
Date:   Wed, 03 Jun 2020 21:39:26 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Colin King" <colin.king@canonical.com>,
        "Jeremy Kerr" <jk@ozlabs.org>, "Joel Stanley" <joel@jms.id.au>,
        "Alistair Popple" <alistair@popple.id.au>,
        "Eddie James" <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH]_fsi:_master-ast-cf:_fix_spelling_mistake_"firwmare?=
 =?UTF-8?Q?"_->_"firmware"?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jun 2020, at 21:35, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
