Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF97C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7CB2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588245441;
	bh=yWtbilunzsxo7xtZWR1/a83wu91pcqoLS8Bvylbv1hk=;
	h=Date:From:To:Subject:List-ID:From;
	b=NhVahuRE2Y9AP4KirxBj5z87TehVRVPTl0b1Y5g1M/1oE74g+yy/UtVFG7up9Bjco
	 n/wRl1340ctid9cmEo46kHBqGPpP8qBiWcyiCxDxrj83438+dQBoa98qPNo481uIfp
	 2IHZtb5ksQa/nHyHBh3ItxtiOEkY/XADPHnkAQ48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgD3LRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgD3LRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:17:20 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E012076D;
        Thu, 30 Apr 2020 11:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588245439;
        bh=yWtbilunzsxo7xtZWR1/a83wu91pcqoLS8Bvylbv1hk=;
        h=Date:From:To:Subject:From;
        b=DW0Kr5Cgs1hv+JYaJeZtv+nPgxnYZTe7aZIf8uxlGA772zeF1oO1kpGTeBqb5W/Mq
         6xAVYNGdce2V/U2gDeZfY+6jgJYHDzN1K47OgsRRwnbYAo8vSKAbeExPVYUEysG6aS
         WhhdoIWpoVHayYEpFi9RcrLypb3is6vx5inSDBAs=
Date:   Thu, 30 Apr 2020 13:17:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: bug: Kbuild seems to require "make prepare-objtool" in order to use
 (some) new config vars
Message-ID: <20200430131715.32c1a1f6@coco.lan>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Not sure if this was already reported (or eventually fixed) upstream.

While doing a Kconfig reorg on media, I noticed a few weird things,
requiring me to call, on a few situations, "make modules_prepare"
manually after some changes.

I'm now working on a patchset to yet to be merged upstream aiming to
resurrect a driver from staging. It is currently on this tree
(with is based at the media development tree, on the top of 5.7-rc1):

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=atomisp_v2

There, I was able to identify a misbehavior that it is probably
what forced me to need calling "make modules_prepare".

The atomisp driver is on a very bad shape. Among its problems, it has a 
set of header definitions that should be different for two different
variants of the supported devices. In order to be able to compile for
either one of the variants, I added a new config var:
CONFIG_VIDEO_ATOMISP_ISP2401.

The problem is that calling just

	./scripts/config -e CONFIG_VIDEO_ATOMISP_ISP2401

or
	./scripts/config -d CONFIG_VIDEO_ATOMISP_ISP2401

is not enough anymore for the build to actually use the new config value.

It just keeps silently using the old config value.

I double-checked it by adding this macro at the Makefile:

	$(info ************ ISP2401: $(CONFIG_VIDEO_ATOMISP_ISP2401) ************)

The Makefile doesn't see the change, except if I explicitly call
"make modules_prepare" or "make prepare-objtool".

Even calling "make oldconfig" doesn't make it use the new CONFIG_*
value.

Thanks,
Mauro
