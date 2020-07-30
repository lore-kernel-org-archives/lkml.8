Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38998C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064412083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096477;
	bh=iq0cc1HbAjP3ZijxgovlgnyFFQEtr+kzZijALmDgw4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QN1zLMykxDzrgpxSKerY9wqCKRqedBAfO+EHrnLxAbY62WH1ORB5d1LfZb/1/8ouT
	 4wF1LAaGwKqfW9ajFloVgDpUf/PcgW4FYrruv6ys2nJRtgzRGsMPwEwKGUez4eEz3/
	 PN9W8/M8MQk43DT1MptfgC3bCFFQJ/bI9ZYfRzu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgG3IHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729512AbgG3IHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:07:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40BFA2070B;
        Thu, 30 Jul 2020 08:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096466;
        bh=iq0cc1HbAjP3ZijxgovlgnyFFQEtr+kzZijALmDgw4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yonx/axNkjFZbgrUTsjparbqTrwxWCeR/RQW4PFMcmvmMPP9CrToEwth3ZTI890A0
         nac1jCWzbXNTFk73wYzFWYY+ruAqbQM8B3fYxoPQ7MIoXkSMVuPuJBGtEgOuwXHfNk
         Qwc6lTxHiOyq73EzQIl/AInUnVgDeWtnYoYwyxOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 13/14] regmap: debugfs: check count when read regmap file
Date:   Thu, 30 Jul 2020 10:04:56 +0200
Message-Id: <20200730074419.551880453@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074418.882736401@linuxfoundation.org>
References: <20200730074418.882736401@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

commit 74edd08a4fbf51d65fd8f4c7d8289cd0f392bd91 upstream.

When executing the following command, we met kernel dump.
dmesg -c > /dev/null; cd /sys;
for i in `ls /sys/kernel/debug/regmap/* -d`; do
	echo "Checking regmap in $i";
	cat $i/registers;
done && grep -ri "0x02d0" *;

It is because the count value is too big, and kmalloc fails. So add an
upper bound check to allow max size `PAGE_SIZE << (MAX_ORDER - 1)`.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/1584064687-12964-1-git-send-email-peng.fan@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/regmap/regmap-debugfs.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -204,6 +204,9 @@ static ssize_t regmap_read_debugfs(struc
 	if (*ppos < 0 || !count)
 		return -EINVAL;
 
+	if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
+		count = PAGE_SIZE << (MAX_ORDER - 1);
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -352,6 +355,9 @@ static ssize_t regmap_reg_ranges_read_fi
 	if (*ppos < 0 || !count)
 		return -EINVAL;
 
+	if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
+		count = PAGE_SIZE << (MAX_ORDER - 1);
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;


