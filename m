Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13814C7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00B920732
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581929332;
	bh=2n1FOg4ob9vCaDerlOyUi+t9WjKY54az5l5Xvk3dRyw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IAADJljnucKFqiorSuNbmN1OreDbebg7y6qAwn7MhnzjtokFWYiHKp0nzrY+DBl10
	 cpDCTDu8dOvrwg5F8i5ZRZqPAKqfBLPQzpsufyyM2rrmNxnfIz31aLL4NTMQqL6n1Y
	 3tfkydSzeL7RVagDU8j4/1Le4+34T/xZxqddG3sY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgBQIsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:48:51 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36411 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728245AbgBQIsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:48:51 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 67AB2578;
        Mon, 17 Feb 2020 03:48:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 17 Feb 2020 03:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=zWf+0HG22W45afcXZHRTV9rKlLD+feL1RTETMk2WVss=; b=qTbWMIvs
        G8Bd9in1JE2ZL5w8vE5vpfRBHHKNLQUyHwCZuqnPn/+dlIjYn/YtSR2UP/xTridr
        SLuvzcFjZXO1m6zM+aQ4J7JmQNtUAhXbcvwVOGHLMNDKwSwkj28mPjq0nKxlU2ZT
        62jMO0Kfryoh7nQFJM+nElBXju/nFC7w9sDd0uiORPswwz/pod4hqArPT8VBQSjT
        sN9ibdbtijnPeRLyd3zn1JiLPjGEAhC1wfSYaHYLb2Y8UKsEBO8aRlTiaE4ngSqq
        NFln2sJjUPBqoqhmA1fm/31cOeiTeiOllorE5D+zfDqhwmZj+dh009w8GRjcJv53
        4AtRdiEOaqKOMQ==
X-ME-Sender: <xms:cFNKXkvvDP516o28Hnax10xVfoDYo083A_beo_q-14r5p7G89mUglg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffosedttdertdertddtnecuhfhrohhmpedfvfhosghinhcuvedr
    ucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppedvtd
    efrddujeefrddvkedrudektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cFNKXrpDiV042wddYYQgdRjXiP3AvbTDQKQRHssAHfU_eeZUE1Usbg>
    <xmx:cFNKXkYQpWoMLg86ifjkVIagImNoEUufwIF3-Lah4VzAwDLqliYcgw>
    <xmx:cFNKXnxazG4VYRSPZrcA5t9jZ8B1jWxV3kdvql08aHAjw7ckAuWd3g>
    <xmx:cVNKXpWAw2LvpwOrtofAaaiE_088mePjiSKeNKV9p8q2lHxD0VN3Cw>
Received: from ares.fritz.box (203-173-28-180.dyn.iinet.net.au [203.173.28.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id D588A328005A;
        Mon, 17 Feb 2020 03:48:46 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Christoph Lameter <cl@linux.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] slabinfo: parse all NUMA attributes
Date:   Mon, 17 Feb 2020 19:48:26 +1100
Message-Id: <20200217084828.9092-1-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I found a few files in /sys/kernel/slab/foo/ that contain NUMA info that
is not currently being parsed by `slabinfo.c`.  I do not know whether
this is intentional or not?  Since I did not know this I just printed
the info in the NUMA report section like is done for the per node slabs
and partial slabs info.

Just for your interest; I found these while re-writing slabinfo in Rust,
thanks to the type-system.  I guess that if they were unintentionally
missed then this is a small win, if they were intentionally missed then
this series is just noise :)

Patch one is a one line whitespace fix.

To test I comment out the code that inhibits NUMA output for single node
machines and then the output looks like this (relevant bit at the bottom)

$ sudo slabinfo kmem_cache_node
Slabcache: kmem_cache_node  Aliases:  0 Order :  0 Objects: 1877
** Hardware cacheline aligned

Sizes (bytes)     Slabs              Debug                Memory
------------------------------------------------------------------------
Object :      64  Total  :      34   Sanity Checks : Off  Total:  139264
SlabObj:      64  Full   :      15   Redzoning     : Off  Used :  120128
SlabSiz:    4096  Partial:      17   Poisoning     : Off  Loss :   19136
Loss   :       0  CpuSlab:       2   Tracking      : Off  Lalig:       0
Align  :      64  Objects:      64   Tracing       : Off  Lpadd:       0

kmem_cache_node has no kmem_cache operations

kmem_cache_node: Kernel object allocation
-----------------------------------------------------------------------
No Data

kmem_cache_node: Kernel object freeing
------------------------------------------------------------------------
No Data

NUMA nodes           :    0
---------------------------
All slabs                34
Partial slabs            17
CPU slabs                 2
Objects                1.8K
Partial objects         789
Total objects          2.1K

Tobin C. Harding (2):
  tools: vm: slabinfo: Replace tabs with spaces
  tools: vm: slabinfo: Add numa information for objects

 tools/vm/slabinfo.c | 69 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

-- 
2.17.1

