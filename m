Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2864C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEEA9206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387015;
	bh=qLCmoWsysNXQVBAbiONmF42vjRw01PA0Q6hcW6qAx1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qr7TnKNxRelC2kV1UGh1q5Rn/elRL/YfBGmtUMDmWqkR0QOA4H8HPcxA1SPF0qEgb
	 xqQRIW2gD+4MtkxN4/QP3SB25XKEZbiiUrWOq+b+N0onNQpFaQRXLM8BSkVoVHohCQ
	 UH+DklCXGMmxvOgd0XMRGYyY5E/759BA/OTuCIk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgDTMuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729464AbgDTMtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:49:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D5ED20735;
        Mon, 20 Apr 2020 12:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386979;
        bh=qLCmoWsysNXQVBAbiONmF42vjRw01PA0Q6hcW6qAx1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k69zt625LLWbE7uVP+EvcBsbyRy0/BjVeE2Yy7jZ3lCxIPkwjHJLeqaeMi2D8LdLH
         le/zChms9Akz9KR6CkhG14x5cpqoOIIh4QfR7ULPYAnL30LnSZZOPRSGZLJLU5IuJG
         9NHN7CqLU3esN0nfUISn6hG5fqi7xw5yqZF2zBlc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 17/40] ALSA: usb-audio: Filter error from connector kctl ops, too
Date:   Mon, 20 Apr 2020 14:39:27 +0200
Message-Id: <20200420121459.353299438@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121444.178150063@linuxfoundation.org>
References: <20200420121444.178150063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 48cc42973509afac24e83d6edc23901d102872d1 upstream.

The ignore_ctl_error option should filter the error at kctl accesses,
but there was an overlook: mixer_ctl_connector_get() returns an error
from the request.

This patch covers the forgotten code path and apply filter_error()
properly.  The locking error is still returned since this is a fatal
error that has to be reported even with ignore_ctl_error option.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206873
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200412081331.4742-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1461,7 +1461,7 @@ error:
 		usb_audio_err(chip,
 			"cannot get connectors status: req = %#x, wValue = %#x, wIndex = %#x, type = %d\n",
 			UAC_GET_CUR, validx, idx, cval->val_type);
-		return ret;
+		return filter_error(cval, ret);
 	}
 
 	ucontrol->value.integer.value[0] = val;


