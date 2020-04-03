Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0212BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 03:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB37C2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 03:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="xCpnIFv0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="spNmuEnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390392AbgDCDuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 23:50:10 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:37957 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389477AbgDCDuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 23:50:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D3E795802F5;
        Thu,  2 Apr 2020 23:50:08 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Thu, 02 Apr 2020 23:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=P0i5a44/PsPVXizK2loCZDTGox+XOyW
        9+9DooRb9EMI=; b=xCpnIFv0cZaUC0AT3DOLbflHBL9J8ZgbLYc5wbe/jrK9xf0
        2DrW2l0EHIfkNsyHA1GvpB7OtMjoRjcPThiu1r4wTCJJOnrfJyZPiFq4Dg3AJ6wf
        a85rCFiUQkwyYiwQOtCWvxoHxzKiqttkGod6I0yWN/TioFl+i1V7Hj5IQTYCwbQC
        znkD6kxL2gP/y+MCtrePHGlpybz2YLv9gsZyE7LY9Op1vYXzEstBJtZ4vRbOeaZF
        vTx+w1purQ9LiCNNN1fxdjz2t3ZXhaUKs/FwwOl8bY3vHTrntt2MYrpNxcxZxRzz
        UVhqrJO6Uhqo3L0+MijmP3fdZAPUbPcAaf8l0ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=P0i5a4
        4/PsPVXizK2loCZDTGox+XOyW9+9DooRb9EMI=; b=spNmuEnPJL8Uu297qnnHKy
        rVOe2vFT6f/6b+xH026WDSohpHZdg8xnj9yghCLCKM/rgNrP0qcKPPvuEq3bz91c
        IkLsmP8xu1bPI2TfqfgUQUOHRQU3C9Lb1ukkQhXGAbCYh6bizNqEYrv9khjRe5wZ
        VpxfvrnYKrJYAH1X5aeawv1fijcB0QqbTnJEBIL2i8j7OWw2zsRljAEOfL4ISZ0p
        wo3BZ2RoeP9T46XJgve+IcLR4rEpIH8oPKxmdTjQEhUxhzf62WB+8z9+VUlPdAHR
        Li/tpyMFcYScbN0Byx2BjzYEvBksqSffm8w1fyHumWEm/LlV/MOVHc601cm5UMag
        ==
X-ME-Sender: <xms:abKGXrawh2OniH8S0iCs40jn3tE3MLaWUO1O7DzwPZMwVHiZwOiUmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdehgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucffohhmrg
    hinhepkhgvrhhnvghlrdhorhhgpdguvghvihgtvghsrdhpihhnghenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiug
    drrghu
X-ME-Proxy: <xmx:abKGXvlPkC1DxluARvIz4GaXXaHhMdSSm3xWLd9ypVAGbxaeaS2-Sw>
    <xmx:abKGXu3Aj5bepyhous-L-NVYVZy5zOZEmFcgFo4Z9CiCwBm8fmqjmg>
    <xmx:abKGXn1jySVFIH3-waYbwYInoEN1TIXY0UmbLkxz2p-O6vvw7YFerA>
    <xmx:cLKGXryKVaezoVOQ2k_ilBFTF_ZS0jkbQmrbG0_MwuNVc1LC4v28CQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AFA09E00B0; Thu,  2 Apr 2020 23:50:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-1082-g13d7805-fmstable-20200403v1
Mime-Version: 1.0
Message-Id: <7734002a-181e-4baf-b9a3-af66894acc16@www.fastmail.com>
In-Reply-To: <cover.fe20dfec1a7c91771c6bb574814ffb4bb49e2136.1576462051.git-series.andrew@aj.id.au>
References: <cover.fe20dfec1a7c91771c6bb574814ffb4bb49e2136.1576462051.git-series.andrew@aj.id.au>
Date:   Fri, 03 Apr 2020 14:20:21 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        "Corey Minyard" <minyard@acm.org>, "Arnd Bergmann" <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        "Rob Herring" <robh+dt@kernel.org>,
        "Haiyue Wang" <haiyue.wang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: =?UTF-8?Q?Re:_[PATCH_v2_0/3]_ipmi:_kcs-bmc:_Rework_bindings_to_clean_up_?=
 =?UTF-8?Q?DT_warnings?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Dec 2019, at 12:57, Andrew Jeffery wrote:
> Hello,
> 
> This is a short series reworking the devicetree binding and driver for the
> ASPEED BMC KCS devices. With the number of supported ASPEED BMC devicetrees the
> changes enable removal of more than 100 lines of warning output from dtc.
> 
> v1 can be found here:
> 
> https://lore.kernel.org/lkml/cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au/
> 
> v2 cleans up the commit message of 2/3 and changes the name of the property
> governing the LPC IO address for the KCS devices.

Ping?
