Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D525C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6941F20782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NjwFR5rA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGCVZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgGCVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:25:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC9DC061794;
        Fri,  3 Jul 2020 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=q4J879L4YQKukzKjdiMRKCK48D9NTUnc6yNfM2nMmEE=; b=NjwFR5rATHmGpubQHBZiHM3tSB
        5SxAmYnqfIgEcs2T4xD+epYC9StkjmQW1ltxYfAJUMM595lp+qq+QTNvwKaMhHJJri2apmRID521L
        oPnPNfkfV/uQPHeVJ80YTSoiqPl1vXvKTjMkcgeoEZhLszEt6QOz3wzvRQB4nCgKMVnQhM+QJtWap
        YhTUee7zUvxYPme8pOhYhWv1F1kJazmrDqqqPJDYZ/+Llm3Ij+OnOkSeppDri3121F4QbDv6Ue/4f
        zuXqCH3MbtUlkMTY0rO7N+Wl778r60TkruQgxESvSZXf1We3YtvxpGYZimj2Js7PSAqWR6mmCu+wd
        JUL5U4bA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTB3-0006Bh-OS; Fri, 03 Jul 2020 21:24:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/3] Documentation: trace: eliminate doubled words
Date:   Fri,  3 Jul 2020 14:24:50 -0700
Message-Id: <20200703212453.30553-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix doubled (duplicated) words in trace documentation.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>


 Documentation/trace/ftrace.rst           |    4 ++--
 Documentation/trace/histogram-design.rst |    4 ++--
 Documentation/trace/stm.rst              |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
