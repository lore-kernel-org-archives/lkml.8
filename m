Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB4FC83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34AD520787
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rylan.coffee header.i=@rylan.coffee header.b="I9Rl+wyc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nj/QXmBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgD3Bb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:31:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51611 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbgD3Bb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:31:57 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DDF925C00A0;
        Wed, 29 Apr 2020 21:31:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 29 Apr 2020 21:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rylan.coffee; h=
        date:from:to:subject:message-id:mime-version:content-type; s=
        fm3; bh=SYK7O3pWETptKlBHEnGL7d2b/hjrdjwGHndWnjpBIYc=; b=I9Rl+wyc
        wAmq++yMiOioQj+oWaq9nyXI0XsLaqEES0VZqiZwG3prd4qZiNH07Q145rQ02dNq
        hiLZJ6vBIMkLZ2ndPBKwbqopvZdd6zvQY6vIbd5CGzWXB8MQPZXo3IJGiz2sxYEH
        jEWLbfFBRRoXGB3avlx202U5BnmawUUsOJzYvFaXNo9CnkQs1LeZA+ul2U79Gx+C
        YR/tYQJUGn89eRpeqo9C9aZ5QzVUl8RZbUM6wKXIli0Nk8dnqRQrQMqNvv4ubNt6
        iASUhkOAh2Fc3GpsjNZ150ToHv9MC05eTZ13wdMxMXg/Iu93TTSsCBuxANMkhbUM
        ua3TxhhdnZ/dbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=SYK7O3pWETptKlBHEnGL7d2b/hjrd
        jwGHndWnjpBIYc=; b=nj/QXmBskjFwJjZz1SEW1HTzdX8C72xA7b4qZZetuwHhN
        PhYYmRuYS1q3NXxGVLmOQPNBVgH9Nwqd0fzzHSZE5j2S37tLeO5EInEUUr/PMT4Q
        /VwbstVRlh3+Te5/QOaSsRpOzg3jxqiclLh5JMtyPtbXm1/MhOSI345DWRT6NiY+
        Re6AGEKQvpx3TxC1FNlmHfv0KC2ps7kTtnDCJMH4oNayw2OEyCshrwzW45YuDnCt
        FcpKcLPcyN3llXYe4dHj7CAI3/8ym5xPdnFRKa8RLzo8vxmEpVtrfNCGURjxSj+L
        knem6Dwzvlf9Jwiu0XWft13qK+4rNWSxN+ep0XHPQ==
X-ME-Sender: <xms:iyqqXnUN-2jG3K83g1OHzb59grIIIjZflxFff9n6CzTX6jxhYluwHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieeggdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesthdtredttddtjeenucfhrhhomheptfihlhgrnhcuffhm
    vghllhhouceomhgrihhlsehrhihlrghnrdgtohhffhgvvgeqnecuggftrfgrthhtvghrnh
    epledukefggeevtdffjeduieefiedtuddufeeuvdehkeeuieelleeigfdvledufeelnecu
    kfhppedutdekrdegledrudehkedrkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgrihhlsehrhihlrghnrdgtohhffhgvvg
X-ME-Proxy: <xmx:iyqqXk_bOnBPMdhsAuA9Cx8DiMD_JJOWdmohjdJXLx9qsCThNAbYQQ>
    <xmx:iyqqXmfyNvhFEl-sZyw_u2rBq3rgtfHICqzKdd_fECy43MKqgILAxg>
    <xmx:iyqqXm-z82upvot94bBLUozn0b478f_YHZyc91ghnR9gelwOL-PtIA>
    <xmx:iyqqXoIpOUQVVdgBIbxjt6b_6umq_MMSUQE4voGi_jjtSKIaejryQw>
Received: from athena (pool-108-49-158-84.bstnma.fios.verizon.net [108.49.158.84])
        by mail.messagingengine.com (Postfix) with ESMTPA id 59DB73065EBD;
        Wed, 29 Apr 2020 21:31:55 -0400 (EDT)
Date:   Wed, 29 Apr 2020 21:31:54 -0400
From:   Rylan Dmello <mail@rylan.coffee>
To:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v2 0/7] staging: qlge: Checkpatch.pl indentation fixes in
 qlge_main.c
Message-ID: <cover.1588209862.git.mail@rylan.coffee>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes some indentation- and style-related issues in qlge_main.c
reported by checkpatch.pl, such as:

  WARNING: Avoid multiple line dereference
  WARNING: line over 80 characters
  WARNING: suspect code indent for conditional statements

v2:
 - Addressed feedback from Joe Perches by unindenting
   ql_set_mac_addr_reg and by replacing goto statements with break
   statements in the function.

Rylan Dmello (7):
  staging: qlge: Fix indentation in ql_set_mac_addr_reg
  staging: qlge: Remove gotos from ql_set_mac_addr_reg
  staging: qlge: Fix indentation in ql_get_mac_addr_reg
  staging: qlge: Remove goto statements from ql_get_mac_addr_reg
  staging: qlge: Remove multi-line dereference from ql_request_irq
  staging: qlge: Fix suspect code indent warning in ql_init_device
  staging: qlge: Fix function argument alignment warning in
    ql_init_device

 drivers/staging/qlge/qlge_main.c | 258 ++++++++++++++-----------------
 1 file changed, 120 insertions(+), 138 deletions(-)

-- 
2.26.2

