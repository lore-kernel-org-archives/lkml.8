Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDC3C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9EA20736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbgCKTfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:35:01 -0400
Received: from haggis.mythic-beasts.com ([46.235.224.141]:45905 "EHLO
        haggis.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731048AbgCKTfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:35:01 -0400
Received: from [146.90.33.204] (port=54428 helo=slartibartfast.quignogs.org.uk)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <peter@bikeshed.quignogs.org.uk>)
        id 1jC6wY-0008RB-Ah; Wed, 11 Mar 2020 19:23:02 +0000
From:   peter@bikeshed.quignogs.org.uk
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Lister <peter@bikeshed.quignogs.org.uk>
Subject: [PATCH 0/1] Format kerneldoc code snippets as literal block
Date:   Wed, 11 Mar 2020 19:22:55 +0000
Message-Id: <20200311192256.15911-1-peter@bikeshed.quignogs.org.uk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BlackCat-Spam-Score: 50
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Lister <peter@bikeshed.quignogs.org.uk>

A minimal patch to better format a couple of kerneldoc code snippets as
literal blocks and so remove kernel doc build warnings.

Peter Lister (1):
  Added double colons and blank lines within kerneldoc to format code
    snippets as ReST literal blocks.

 drivers/base/platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.24.1

