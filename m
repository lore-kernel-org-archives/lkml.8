Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B17C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 10:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6F4206E6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 10:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="rXYpY63d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgBBKJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 05:09:58 -0500
Received: from propper.duncanthrax.net ([91.207.61.48]:58358 "EHLO
        smtp.duncanthrax.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725942AbgBBKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 05:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wZQ4n/J3FvaNN+GM5vIGZaZCVjzkHLz1P2bpKAbuehY=; b=rXYpY63dgQ55z4LwVliGCLJCuJ
        Tpt2BUFLAlx9BIWzlmPilqh2CxzlljHIGYfuOzAXdbm0pT6HCBBgLGFNutZZUxp3++TvJKGU33C3p
        SEQnb6nzstwKNg92FVVg79n1Pfb0ofRLaHKLbXJvyhlhOgSEhIx9VvaexwjreYsvPMhw=;
Received: from [134.3.47.90] (helo=x280.stackframe.org)
        by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
        (envelope-from <svens@stackframe.org>)
        id 1iyBhm-00009N-7g; Sun, 02 Feb 2020 10:38:14 +0100
From:   Sven Schnelle <svens@stackframe.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@stackframe.org>
Subject: Add support for Ratoc U2SCX
Date:   Sun,  2 Feb 2020 10:37:47 +0100
Message-Id: <20200202093750.4439-1-svens@stackframe.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patchset add support for Ratoc U2SCX USB/SCSI converters. For additional
information see http://www.ratocsystems.com/english/products/U2SCX.html.

Regards
Sven

Sven Schnelle (2):
  usb/storage: add SCSI ID and LUN to debug output
  usb-storage: Add support for Ratoc U2SCX multiple device mode

 drivers/usb/storage/debug.c        |  3 ++-
 drivers/usb/storage/initializers.c | 27 +++++++++++++++++++++++++++
 drivers/usb/storage/initializers.h |  2 ++
 drivers/usb/storage/unusual_devs.h |  5 +++++
 4 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.24.1

