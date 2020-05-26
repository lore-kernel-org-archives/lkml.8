Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A12C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADA92075F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MBeddPfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgEZIqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:46:44 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45034 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731381AbgEZIqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:46:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04Q8kT6X068476;
        Tue, 26 May 2020 03:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590482789;
        bh=0Y+nhVgwiEkxt0mUjsYykJjEaX7tRpeEpMLVHzZ+DNo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MBeddPfvkWYbQK5rg0wdmK+J1K0CaiHvzKIlC2eQ+rLbwImma31zzyfLRHlMNTibG
         JaMnPviNBJQhbcTHSZrHh5+fcKs54ZWfC7rhsz30mtDNaB8p/r+UM0dx4PZee8lb6N
         aXLuXXis2fFrBXsCQkZikQIMbTuZKRQQ5HNRv9yY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04Q8kTJN097919
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 03:46:29 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 May 2020 03:46:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 26 May 2020 03:46:28 -0500
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04Q8kQPC063391;
        Tue, 26 May 2020 03:46:27 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Richard Weinberger <richard@nod.at>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: Replace zero-length array with flexible-array
Date:   Tue, 26 May 2020 14:16:23 +0530
Message-ID: <159048016213.21698.5509230411205527625.b4-ty@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507190033.GA15215@embeddedor>
References: <20200507190033.GA15215@embeddedor>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 14:00:33 -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git cfi/next, thanks!


Regards
-- 
Vignesh

