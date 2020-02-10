Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22938C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F0120715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340258;
	bh=QQIPvfVxsHQ0Kg/jbhKAMrFoi+8fum2mpB8s9nGUJJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BrkSWxhdIiV/BHIlnkqgaPHTHlK/FtSqqDEKgrXJpmRb3ArtvJ76Nip9NXOFZQSXx
	 wO+vGTj5eE7h81IofPfy1LClC0aiMIUh3DHasgA4TSs0fccEPpQus6wyCnstzWOYTY
	 LeyDNdUQZlnO5r+riqADFSrpU2zyWS1TWv+S9lHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgBJMjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:39:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbgBJMhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:18 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D75B20661;
        Mon, 10 Feb 2020 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338237;
        bh=QQIPvfVxsHQ0Kg/jbhKAMrFoi+8fum2mpB8s9nGUJJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvh7QryyoRNg694NRxUH5+6ldHUBsdmklLftYsvqTLehuQ1h2/uQ3+6wza3E2fhWb
         3nJGK9ZJsVIeh+vaOBUdlYzdHovXSolx4zQXUMD8k0ZBvhy9KNcReTAicaQq2cdiaL
         tVt9WvuYi/xpsyrcNuBiNRh1bxcXT1Ml4Ket2ahY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 045/309] ALSA: usb-audio: Fix endianess in descriptor validation
Date:   Mon, 10 Feb 2020 04:30:01 -0800
Message-Id: <20200210122410.375311791@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit f8e5f90b3a53bb75f05124ed19156388379a337d upstream.

I overlooked that some fields are words and need the converts from
LE in the recently added USB descriptor validation code.
This patch fixes those with the proper macro usages.

Fixes: 57f8770620e9 ("ALSA: usb-audio: More validations of descriptor units")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200201080530.22390-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/validate.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/usb/validate.c
+++ b/sound/usb/validate.c
@@ -110,7 +110,7 @@ static bool validate_processing_unit(con
 	default:
 		if (v->type == UAC1_EXTENSION_UNIT)
 			return true; /* OK */
-		switch (d->wProcessType) {
+		switch (le16_to_cpu(d->wProcessType)) {
 		case UAC_PROCESS_UP_DOWNMIX:
 		case UAC_PROCESS_DOLBY_PROLOGIC:
 			if (d->bLength < len + 1) /* bNrModes */
@@ -125,7 +125,7 @@ static bool validate_processing_unit(con
 	case UAC_VERSION_2:
 		if (v->type == UAC2_EXTENSION_UNIT_V2)
 			return true; /* OK */
-		switch (d->wProcessType) {
+		switch (le16_to_cpu(d->wProcessType)) {
 		case UAC2_PROCESS_UP_DOWNMIX:
 		case UAC2_PROCESS_DOLBY_PROLOCIC: /* SiC! */
 			if (d->bLength < len + 1) /* bNrModes */
@@ -142,7 +142,7 @@ static bool validate_processing_unit(con
 			len += 2; /* wClusterDescrID */
 			break;
 		}
-		switch (d->wProcessType) {
+		switch (le16_to_cpu(d->wProcessType)) {
 		case UAC3_PROCESS_UP_DOWNMIX:
 			if (d->bLength < len + 1) /* bNrModes */
 				return false;


