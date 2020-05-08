Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C6BC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042652054F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942844;
	bh=W3z8GpEqUg7Gwz4mNu6eXk9h4W8cmjS7GxG53neu7o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t2sVCSsExghDVuWg9t/c+3rd6FbZJWZL8Eu3nzVPU+LtxY8KG1I7g78Zyql0PQqyc
	 5xJtWy5+CZvEAN+U4dqtdP5+F4JKj9up7T7LTC0EAUo9S7el8Xp7k45bMhtRCQwjFs
	 ozXYgSvolXlsc9TP8gCc0tA405q27amC2OgTwh4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgEHNAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729943AbgEHMwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:52:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64D2624966;
        Fri,  8 May 2020 12:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942334;
        bh=W3z8GpEqUg7Gwz4mNu6eXk9h4W8cmjS7GxG53neu7o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1+AOw3Xjl34z/0z5+m6UmnhHXmlBWWGoVf7PgSQ/Sae2odwNLvJzl/2wWtf3uVLE7
         sbgoDiivF+walwIyks3v4oG8Q+6AYfsJFyWHSNZNxgT4VoQ4b+w2aI+19Tw1/egiDL
         gW0d4OJicSkDLaAmfHfzEnXgkF1dXSOhAhB00c7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.19 29/32] platform/x86: GPD pocket fan: Fix error message when temp-limits are out of range
Date:   Fri,  8 May 2020 14:35:42 +0200
Message-Id: <20200508123039.219831478@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123034.886699170@linuxfoundation.org>
References: <20200508123034.886699170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 1d6f8c5bac93cceb2d4ac8e6331050652004d802 upstream.

Commit 1f27dbd8265d ("platform/x86: GPD pocket fan: Allow somewhat
lower/higher temperature limits") changed the module-param sanity check
to accept temperature limits between 20 and 90 degrees celcius.

But the error message printed when the module params are outside this
range was not updated. This commit updates the error message to match
the new min and max value for the temp-limits.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/gpd-pocket-fan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/x86/gpd-pocket-fan.c
+++ b/drivers/platform/x86/gpd-pocket-fan.c
@@ -128,7 +128,7 @@ static int gpd_pocket_fan_probe(struct p
 
 	for (i = 0; i < ARRAY_SIZE(temp_limits); i++) {
 		if (temp_limits[i] < 20000 || temp_limits[i] > 90000) {
-			dev_err(&pdev->dev, "Invalid temp-limit %d (must be between 40000 and 70000)\n",
+			dev_err(&pdev->dev, "Invalid temp-limit %d (must be between 20000 and 90000)\n",
 				temp_limits[i]);
 			temp_limits[0] = TEMP_LIMIT0_DEFAULT;
 			temp_limits[1] = TEMP_LIMIT1_DEFAULT;


