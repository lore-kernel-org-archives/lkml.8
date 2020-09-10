Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A87C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2EE2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="muZzn4CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgIJD0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgIJD0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:26:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DDCC061573;
        Wed,  9 Sep 2020 20:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hNWu6r11XbnWnSUzeS/6VOacMvYJ0OzgTjH9UW8Sfi8=; b=muZzn4CLAo2obv8QjMLLRNHqPH
        d2A2NdUVWcswPqx+DMWymT4+LHcF2tXjBwyJnQPFgPaX3o9iLF/lVRwd7fzEbl9jvVReHOR2MXKIN
        ehwF9jmg48JUxJBJY0c4JjrmEMg6yy/lznve6wt0+uY6QjsZt0OCR2q2BwPTzlKSvShpCqi/InR1K
        +0aujQoSozzuC08FFSYCflkSNfgLKeTvIBJ/XjGx4l82FIA0X1lw1g3v0EIHVvWKRvDjIKHNsaZz5
        ffs/zXwybGhVhaboq9qXWardvgC/M4uLEwer+lZZoA9MQ+glEQoR1213bhkA6ppMiCQCTdHj9+hrw
        G8o7GLYQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGDDu-000659-Nm; Thu, 10 Sep 2020 03:26:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 0/3] Documentation/admin-guide: kernel-parameters: parameter cleanups
Date:   Wed,  9 Sep 2020 20:26:03 -0700
Message-Id: <20200910032606.7355-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org


 [PATCH 1/3] Documentation/admin-guide: kernel-parameters: update CMA entries
 [PATCH 2/3] Documentation/admin-guide: kernel-parameters: hyphenate comma-separated
 [PATCH 3/3] Documentation/admin-guide: kernel-parameters: add early_param() to list of types of boot parameters

 Documentation/admin-guide/kernel-parameters.rst |    4 +-
 Documentation/admin-guide/kernel-parameters.txt |   22 +++++++-------
 2 files changed, 13 insertions(+), 13 deletions(-)
