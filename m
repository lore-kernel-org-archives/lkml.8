Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C5CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02CC521475
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322542;
	bh=FFSxGwBGfMCiFQduasCBES4XmyOFzA/eJW0MOePvNZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qNzEkB2gnv0RZ+yD/4UkErf1TFjLdUOEBYxc61hkFDJtaaaTxFypAaPEAnkjsmrXu
	 yD22JO985W2UFyb1jBzLLcMCvzUwXn77QTn/rwv/TWYDMpt9iucEi9rfrUuumMFFS5
	 phWkp2C4kkRGQLX10aAf3W+ceuzAIpBXWPgUcjC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgFPPtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:49:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731831AbgFPPs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:48:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 744662071A;
        Tue, 16 Jun 2020 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322537;
        bh=FFSxGwBGfMCiFQduasCBES4XmyOFzA/eJW0MOePvNZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJ6/26a8FvXnRPo/DMMK/peY+wzrxCtI6jrThuHJ0XeYjf+N1ioTB712mqSP8D/pw
         9+C65RoU8TjmibG1Quex4/+1fi7KwsNdpmEcN7YMRUzP4hIXt57tF/DOXCZLABTJF5
         sEE4WC/sU2bpTrw9HlYsN8doSpLDMzBJsOO/OEZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominik Mierzejewski <dominik@greysector.net>,
        Mattia Dongili <malattia@linux.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.7 161/163] platform/x86: sony-laptop: Make resuming thermal profile safer
Date:   Tue, 16 Jun 2020 17:35:35 +0200
Message-Id: <20200616153114.518926366@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mattia Dongili <malattia@linux.it>

commit 476d60b1b4c8a2b14a53ef9b772058f35e604661 upstream.

The thermal handle object may fail initialization when the module is
loaded in the first place. Avoid attempting to use it on resume then.

Fixes: 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer objects for ASL create_field() operator")
Reported-by: Dominik Mierzejewski <dominik@greysector.net>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207491
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/sony-laptop.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -2288,7 +2288,12 @@ static void sony_nc_thermal_cleanup(stru
 #ifdef CONFIG_PM_SLEEP
 static void sony_nc_thermal_resume(void)
 {
-	unsigned int status = sony_nc_thermal_mode_get();
+	int status;
+
+	if (!th_handle)
+		return;
+
+	status = sony_nc_thermal_mode_get();
 
 	if (status != th_handle->mode)
 		sony_nc_thermal_mode_set(th_handle->mode);


