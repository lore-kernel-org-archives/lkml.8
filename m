Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C0BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78B92071A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DBpk2k6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgE0B0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:26:31 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13587 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0B0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:26:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecdc1730000>; Tue, 26 May 2020 18:25:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 May 2020 18:26:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 May 2020 18:26:30 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 May
 2020 01:26:29 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 May 2020 01:26:29 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.50.17]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ecdc1c50003>; Tue, 26 May 2020 18:26:29 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] misc: xilinx-sdfec: convert get_user_pages() --> pin_user_pages()
Date:   Tue, 26 May 2020 18:26:25 -0700
Message-ID: <20200527012628.1100649-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590542707; bh=ShQgIonpjrN4inaE1D0TnZ3TUuscVNocNaQmsilKjaU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=DBpk2k6ro/0XXj68bcDqWQcx8cjVF1G1CWq87yBfGN5cMiOnhENPviM2iWntlKn2t
         o1gJ8CRO8dAOb+tBbeIum7XxxUWC1h4176vnIvX63IU33nOyDTa4THZEKWIkcJLsEx
         ZWii9wgRuJtOH2aehgsQYBsjEd/trbfA5O4v2ww+O/FmC3ZdDYatQMjJjKS5kZrTwK
         MvLpS0daX/yjs22DyOZg8gzhikwnOc48q9FrQ9aH44XTZDI88S3l5/95rjEhFnc2T+
         EwXKhULuozxf39W7WkcSpNNES+wVqKSaMsV7E8wGTLBdks85ci4QX/DY5o6YXrQLAa
         ENc8VhUaLjJTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are also a couple of tiny cleanup patches, just to fix up a few
minor issues that I spotted while converting from get_user_pages_fast()
to pin_user_pages_fast().

Note that I have only compile-tested these patches, although that does
also include cross-compiling for a few other arches. Any run-time
testing would be greatly appreciated!

Cc: Derek Kiernan <derek.kiernan@xilinx.com>
Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org

John Hubbard (3):
  misc: xilinx-sdfec: improve get_user_pages_fast() error handling
  misc: xilinx-sdfec: cleanup return value in xsdfec_table_write()
  misc: xilinx-sdfec: convert get_user_pages() --> pin_user_pages()

 drivers/misc/xilinx_sdfec.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)


base-commit: 9cb1fd0efd195590b828b9b865421ad345a4a145
--=20
2.26.2

