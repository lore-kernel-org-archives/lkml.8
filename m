Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2B9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 22:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C7B20872
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 22:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591137499;
	bh=w2DKDgUltB1bfWvKLY4YW3KtQ5ji1bpmbDm7KgFHUOQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hGFGMw3xvr1uvJrRbZV6i39LRkR8sq4k8UgNpYdO3qMS+NLdfe3s53iOq+LO7U5cf
	 8Ic3TG4U6FwW0buB2oHfV4TotvVf3RIucLDdLQP2MocaP8KjURfILpvh/bSaTF6lIp
	 Bp0N601lrqUkLlj/5QhuieYPv6QL878E0Rh6fL7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgFBWiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 18:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbgFBWiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 18:38:18 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA6C4207D5;
        Tue,  2 Jun 2020 22:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591137498;
        bh=w2DKDgUltB1bfWvKLY4YW3KtQ5ji1bpmbDm7KgFHUOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=I6a94wv3fCWUC+NITMcn3INWfhf1qbCzTBbu9KhGxO32uicdm3zKtCYWOG0GgtjT2
         JIhOsH3uGQlAopTRmSB8yrioke6ERHqn6++QCYnVu5NwrSKpJNwAMOYOuLRdiF08zX
         t+/MQJuHEDsE5oXGyobjBN41L1whDimPEmMZBmVI=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jgFXz-004aX9-Hm; Wed, 03 Jun 2020 00:38:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Mark Brown <broonie@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Luigi Semenzato <semenzato@chromium.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, Chao Yu <chao@kernel.org>,
        NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] a couple documentation fixes
Date:   Wed,  3 Jun 2020 00:38:12 +0200
Message-Id: <cover.1591137229.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

It follows a couple of fixes for two tables that got broken, probably due to
some conflict between the ReST conversion patches and ungoing updates.

IMO, it would be nice to have those two applied during the merge window,
as they produce a too noisy output.

I have a few more fixes somewhere on my trees, but my plan is to send
you probably after the merge window, as I'm currently busy with some
other stuff (too much work at atomisp side). 

Mauro Carvalho Chehab (2):
  fs: docs: f2fs.rst: fix a broken table
  docs: fs: proc.rst: fix a warning due to a merge conflict

 Documentation/filesystems/f2fs.rst | 150 +++++++++++++++++++----------
 Documentation/filesystems/proc.rst |   2 +-
 2 files changed, 99 insertions(+), 53 deletions(-)

-- 
2.26.2


