Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FDCC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40C02070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339761;
	bh=Ass9Qglo5YTankLhHR3RLmxch4QTiOoSFpOhVzRIISk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wv9sWnhXfDTIlAY5VZPesRcmVlnyem14Y7WJeoahgdiw0aB8B4cEtTgHzeQMdnrh5
	 pA4z8bkiVxakHqu9Zc87ea9VLtcCwn1kYzhV4HQX0TAHUohw7T+VWOMWMCnnbR7MTN
	 dBOWOQuc+dEOw43wq75P0YU+HYQVwc0hmltResWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbgBJNCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:02:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729754AbgBJMkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:33 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C06120842;
        Mon, 10 Feb 2020 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338433;
        bh=Ass9Qglo5YTankLhHR3RLmxch4QTiOoSFpOhVzRIISk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4cTdnlaU3Ovhh8fb7BiyvhEWOgP1rrYZGB9b+BMVeDGbU6oS0+HmPzb8D+36gwi7
         t0QZaX7ja9VxF+8QkvhMfE9efKTc9XIKINF0Htvc48nFOgF0IlYLexbG3R2cEeuSUH
         e5V73vBXmiauOFG7pCLzz2RBoA5zRTFeedgZB4zk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5.5 122/367] scripts/find-unused-docs: Fix massive false positives
Date:   Mon, 10 Feb 2020 04:30:35 -0800
Message-Id: <20200210122436.041153823@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 1630146db2111412e7524d05d812ff8f2c75977e upstream.

scripts/find-unused-docs.sh invokes scripts/kernel-doc to find out if a
source file contains kerneldoc or not.

However, as it passes the no longer supported "-text" option to
scripts/kernel-doc, the latter prints out its help text, causing all
files to be considered containing kerneldoc.

Get rid of these false positives by removing the no longer supported
"-text" option from the scripts/kernel-doc invocation.

Cc: stable@vger.kernel.org  # 4.16+
Fixes: b05142675310d2ac ("scripts: kernel-doc: get rid of unused output formats")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200127093107.26401-1-geert+renesas@glider.be
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/find-unused-docs.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/find-unused-docs.sh
+++ b/scripts/find-unused-docs.sh
@@ -54,7 +54,7 @@ for file in `find $1 -name '*.c'`; do
 	if [[ ${FILES_INCLUDED[$file]+_} ]]; then
 	continue;
 	fi
-	str=$(scripts/kernel-doc -text -export "$file" 2>/dev/null)
+	str=$(scripts/kernel-doc -export "$file" 2>/dev/null)
 	if [[ -n "$str" ]]; then
 	echo "$file"
 	fi


