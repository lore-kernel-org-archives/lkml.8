Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC42C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8798720848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736942;
	bh=KFUxjOKDDuEoX/HZBQoELlfUW0gsxH8DtfLuAzv8vGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NgCU+jChpUOsD03bKP9ByOdlYwdvPMt1Mlu1Hks1MQDNTpZezZ7iIleFQNjoQTUAX
	 qsl3p/6f5Toe4DRLItzcTZ3K/FiXAb/TunZNu1v9wHeLxX3YMvyHHrAIAg+Ldt+BGD
	 B96fZQJyolsxlZcQDaW0Q+BebP6e0i/vFqWkHC90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgAKKCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbgAKKCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:02:21 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9279620842;
        Sat, 11 Jan 2020 10:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736940;
        bh=KFUxjOKDDuEoX/HZBQoELlfUW0gsxH8DtfLuAzv8vGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xExCdzAIv5a+WzNvcujdQzuEYIR7/g18fRkaoiY7+0WTOVA6bSWXSgzawWBnANic1
         L4caefLE6lNuoKfxv6TC5HlnjWbGnVqcanrVTQqeraXgxi90HYuhIW6osBhUc08qoC
         oyrf2z+6IBKTvhOg62wu1GfEwx9RMr+8ALcM4dmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 4.9 34/91] PM / devfreq: Check NULL governor in available_governors_show
Date:   Sat, 11 Jan 2020 10:49:27 +0100
Message-Id: <20200111094857.826488674@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

commit d68adc8f85cd757bd33c8d7b2660ad6f16f7f3dc upstream.

The governor is initialized after sysfs attributes become visible so in
theory the governor field can be NULL here.

Fixes: bcf23c79c4e46 ("PM / devfreq: Fix available_governor sysfs")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/devfreq/devfreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -982,7 +982,7 @@ static ssize_t available_governors_show(
 	 * The devfreq with immutable governor (e.g., passive) shows
 	 * only own governor.
 	 */
-	if (df->governor->immutable) {
+	if (df->governor && df->governor->immutable) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
 				   "%s ", df->governor_name);
 	/*


