Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB53C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A10420767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593104715;
	bh=FuIrMaNLOL3cUBGG11kfx2VjDq55+oGZQx5P+LqMPOY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XszbiSuVzePqDpDnDblVG4f0eSCp7ritav6sMDR6hwr87JNJm5jjx4YBPgkspYetM
	 4yaiq/2f8C2osCza+CVM94MYt0o/sAGYt4hhjpmEv8f24Vs8ah60xN6vpQHverWYt3
	 s5/c0Xaiyk+s6mR/uBf19CsjRFRnGs1fw/g39mOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406587AbgFYRFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:05:13 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:51072 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406413AbgFYRFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:05:12 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 05PH4apF005239;
        Fri, 26 Jun 2020 02:04:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 05PH4apF005239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593104677;
        bh=nRGp11E9+TGPA/vFfv5nOdt3IyfYXfdO0vNH3A47FpM=;
        h=From:To:Cc:Subject:Date:From;
        b=NkAI115ErUxhGKy2OjZpq/dlWccsA+60/iifHUCZl42BKKUsU6g29pLdvnLSUOa8/
         OjAGdFs4jsqU2ZkTRhEH4jFnR06QrKnkInpx3Xyt0HU3uNlMOr7m2I59oSvbbWssnI
         exPWKYCVu5evhG58Iex0P3xfT6QH+yFrDm10KnzzcW8Oqrwk7DMZyamhi7nJPi8Qam
         7j8MYm14pvsVZ4lL7P9QjcwrB+SOv+FUaEdpTcOGBy9S0KOY5WvAus3EYhXjj5X6cr
         XcCX35YftpCkAlmSJ2rZRiIQB+MbIFnMBnoa/fTESZzTJ7kPpVBRxMHQLFVTm+vhiV
         5ArZhCynh8HYw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] dt-bindings: fix 'make clean' and improve dt-schema check rules
Date:   Fri, 26 Jun 2020 02:04:30 +0900
Message-Id: <20200625170434.635114-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Masahiro Yamada (4):
  dt-bindings: fix error in 'make clean' after 'make dt_binding_check'
  dt-bindings: do not build processed-schema.yaml for 'make
    dt_binding_check'
  dt-bindings: copy process-schema-examples.yaml to process-schema.yaml
  dt-bindings: split DT schema check rules

 .gitignore                                 |  1 +
 Documentation/devicetree/bindings/Makefile | 35 ++++++++++++++++------
 Makefile                                   |  2 +-
 scripts/Makefile.build                     |  2 ++
 scripts/Makefile.lib                       | 27 +++++++++--------
 5 files changed, 44 insertions(+), 23 deletions(-)

-- 
2.25.1

