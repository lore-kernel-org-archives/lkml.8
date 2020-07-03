Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF6AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2A920884
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AWw1aPsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGCU46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 16:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCU46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 16:56:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFBDC061794;
        Fri,  3 Jul 2020 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OklJTjIK2GvSZajjtMqE8AHOQY76ZYipLpdReMlAK+s=; b=AWw1aPskRb8DXHdZK4K3t1F3pQ
        UJgW9wcmJ7LW5WlOSpwuvvtqApeyheurie1tx8ahNpmDlM8CsaLA9+anWBupNvWFrWkhvR37mmQez
        Yv/fVz1HVQqX2gWvkXzyCZ5qNWqkDU3zfx4K7usSjijca2xBagML3lI+MG8M+UYBOhp8UaOUdy71o
        /ztsTPa1cfJ2jDctB1eZj4o7BqaCNyMSXufUjRLduPC93HJFB1w/LDTIkZ2Mdtro6bt7/uv6PFWaA
        6pY/bHWjHp/QotfI5ozbdv1/BqInsQd1gAEu7VJOyDK+ioIkT781Onvgef/ULJePUS6I0UpVpCirx
        5Ro8Mb3w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrSju-0003a5-Pc; Fri, 03 Jul 2020 20:56:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 0/5] Documenation: hwmon: eliminate doubled words
Date:   Fri,  3 Jul 2020 13:56:44 -0700
Message-Id: <20200703205649.30125-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate duplicated words in Documentation/hwmon/ files.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org


 Documentation/hwmon/f71882fg.rst  |    2 +-
 Documentation/hwmon/lm93.rst      |    2 +-
 Documentation/hwmon/nct6775.rst   |    2 +-
 Documentation/hwmon/w83627ehf.rst |    2 +-
 Documentation/hwmon/w83l786ng.rst |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
