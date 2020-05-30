Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E7FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3852C207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgE3XQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 19:16:29 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51054 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbgE3XQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:16:29 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 48A0127F0C; Sat, 30 May 2020 19:16:28 -0400 (EDT)
Message-Id: <cover.1590880333.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 0/4] Mac IOP driver fixes
Date:   Sun, 31 May 2020 09:12:13 +1000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series has several bug fixes for the IOP driver and some
improvements to the debug level log messages.

Geert, please consider pushing these fixes for v5.8, if not the
whole series.


Finn Thain (4):
  m68k/mac: Don't send IOP message until channel is idle
  m68k/mac: Fix IOP status/control register writes
  m68k/mac: Don't send uninitialized data in IOP message reply
  m68k/mac: Improve IOP debug messages

 arch/m68k/mac/iop.c | 60 ++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

-- 
2.26.2

