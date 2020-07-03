Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A5CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E899920782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nUmxfeQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgGCV3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCV3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:29:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8AFC061794;
        Fri,  3 Jul 2020 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/7u1y2wkt8wxlyjfpGZrdn4AtvrSo84WKKJqoNgDn0k=; b=nUmxfeQV5k3Ubscn93XikvnOBc
        KLizXX2WRDer+wtVaxKXvUcXH7SWHQpWXK+M/L2aCbUpw/BeqWW6gd6XhXmKqJgJJX8hh1/75ls3J
        oGmrkgZJC/kSI1zxbY+IicVDxqAkANF7VXjGecUXKt6vs2Al3gZdcpluGHK7ZwCnLZ0fQpXm8jXbd
        lo2gFJHbFmrZ1nyt4QEmG4yRqFwf3gSFEhQbyBc8QxESVzCwUN5FFk3cP1ErtNBgtLvFRZvw1FuM/
        zko/+epNLWqqwM95pqzgbWQEEGBme1HwfXJ6nWhC9vqQu1DpyQRhjThI+3phyTBCuKZ0xdZXo2N0K
        rxjXjYtg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTF9-0006KB-M3; Fri, 03 Jul 2020 21:29:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH 0/2] Documentation: virt: eliminate duplicated words
Date:   Fri,  3 Jul 2020 14:29:04 -0700
Message-Id: <20200703212906.30655-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop doubled words in Documentation/virt/kvm/.


Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org


 Documentation/virt/kvm/api.rst     |   16 ++++++++--------
 Documentation/virt/kvm/s390-pv.rst |    2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)
