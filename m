Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84884C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FB2206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgD1UPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbgD1UPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:15:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C24C03C1AC;
        Tue, 28 Apr 2020 13:15:02 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 616212D6;
        Tue, 28 Apr 2020 20:15:01 +0000 (UTC)
Date:   Tue, 28 Apr 2020 14:15:00 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Miller <davem@davemloft.net>
Cc:     mchehab+huawei@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-hams@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-decnet-user@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, bpf@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, lvs-devel@vger.kernel.org
Subject: Re: [PATCH 00/38] net: manually convert files to ReST format - part
 1
Message-ID: <20200428141500.7ff1e82b@lwn.net>
In-Reply-To: <20200428.131143.378850463944291442.davem@davemloft.net>
References: <cover.1588024424.git.mchehab+huawei@kernel.org>
        <20200428.131143.378850463944291442.davem@davemloft.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 13:11:43 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> Jon, do you mind if I merge this via the networking tree?

Not at all, that's what I was expecting you would do.

Thanks,

jon
