Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE2C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 628322076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgGQTvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:51:17 -0400
Received: from ms.lwn.net ([45.79.88.28]:36972 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgGQTvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:51:16 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8DAA3537;
        Fri, 17 Jul 2020 19:51:16 +0000 (UTC)
Date:   Fri, 17 Jul 2020 13:51:15 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Daniel Lima de Almeida <dwlsalmeida@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/25] Documentation: events/block.h: fix sphinx warning
Message-ID: <20200717135115.4bd4b051@lwn.net>
In-Reply-To: <RO1PR80MB35622AF97F6C440884FF4B46A07C0@RO1PR80MB3562.lamprd80.prod.outlook.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
        <20200717185624.2009393-8-dwlsalmeida@gmail.com>
        <7424fc52-9b37-1b66-ca7f-4e95d35d880c@infradead.org>
        <RO1PR80MB35622AF97F6C440884FF4B46A07C0@RO1PR80MB3562.lamprd80.prod.outlook.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 19:44:58 +0000
Daniel Lima de Almeida <dwlsalmeida@gmail.com> wrote:

> I was working on top of 'docs_next' if I recall correctly. Any suggestions?

Always look at linux-next to see what's going on.

Since most of those patches are not appropriate for docs-next, I don't
have them, but you should always see the current state of affairs in
linux-next.

jon
