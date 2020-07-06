Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A13C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A182220739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vF4HVStZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgGFK6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbgGFK6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:58:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7870C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:58:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so37310798wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x8Z8JBLkIf9gokF5uM/AGC9kJirOjgHJ7kWDqVi6w/A=;
        b=vF4HVStZbzn/5LHcT/RPjlAS2HiUSkfmrdiog79nSSntPrS/oKIThnVNSL6WJ8U3qv
         Trd6E43UZ5RKJk1Khxd39irBA0EV9PMmbbjqCEIT1IQOppKKRG4wbsYhM4FD9GkMCqvj
         a/KCLSYAeTB9NcLhv/LYg6lXTN03tOtyU6Npb90kQ55fY4I4dKi4Xss5YJLuCMLAQwSy
         hwWFDVsSChIj+F1En0Jd70HUpvK6L5ZQPjwfdNcJeyxaoAGGjzVGlh2MuDA14xXtJvf2
         rLVKbhAFcA1kNuvUzTLFksCpDSPJpRk9V9t6G3FiPnSqS1kt0wRgMkSKzxJTcXp/jz3W
         s5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x8Z8JBLkIf9gokF5uM/AGC9kJirOjgHJ7kWDqVi6w/A=;
        b=i8DLGpFf/Ky0QF9S+dWm2+k3CMQdYuPkeaRPt4gogm5LpjjPHmQBze7lT7TO4CZRaz
         RM+8Jc9SXA/bO8VrYQlsCXMz0bRqNqpj7aJOmtrh6c3vYqkDMEG0lNH6sFkh6pEmUtT+
         906njjNilvXl3vPHHx3ZYhhLj8mCOTxp+2F6VtANTCqVIK7UbnKssgkshfTf356P6onW
         6g2dB18rAzFMgfcHl8naFQqcDHnhOxQpkMelZ1Rz6x2xrElrO+L8uLEqmhNjLPzgDFO0
         XuGyNzceHVwAgc9imcl6WXUQSP1lFqLH7exUuOrHJVl7XYGByC0ObK6cvKk2gVovtSXv
         Y2Gg==
X-Gm-Message-State: AOAM531p8icvjg0Y9VoIt4RdTKxsvhSKdKM9NtvulcomO+QIbDe9J99R
        mSf9SM4f91obVeCl7j52NYcM5Vmq95U=
X-Google-Smtp-Source: ABdhPJwvbPt1UdKZviBodaclJpfbhPynPjxJs6cTVhcaQzjInG1RvzcQCgY1WhLiyPXVlfk7n42GPQ==
X-Received: by 2002:adf:8462:: with SMTP id 89mr47273748wrf.420.1594033086327;
        Mon, 06 Jul 2020 03:58:06 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id r28sm15367696wrr.20.2020.07.06.03.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:58:06 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:58:04 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v3 2/6] console_struct.h: Add members for mouse report
Message-ID: <87ede95db49e13da9f7db2231e5253fda6099775.1594032517.git.tammo.block@gmail.com>
References: <cover.1594032517.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594032517.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need two values to store the status of mouse reporting, both need at
least two (vc_protocol_mouse) or three (vc_report_mouse) bits.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 include/linux/console_struct.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 153734816b49..d0aada27feb2 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -30,6 +30,12 @@ enum vc_intensity {
 	VCI_MASK = 0x3,
 };
 
+enum vc_pmouse {
+	VC_PMOUSE_X10,
+	VC_PMOUSE_SRG,
+	VC_PMOUSE_URXVT
+};
+
 /**
  * struct vc_state -- state of a VC
  * @x: cursor's x-position
@@ -132,6 +138,8 @@ struct vc_data {
 	struct pid 	*vt_pid;
 	int		vt_newvt;
 	wait_queue_head_t paste_wait;
+	unsigned char	vc_report_mouse;	/* Which events to report to userspace */
+	enum vc_pmouse	vc_protocol_mouse;	/* What protocol to use for report */
 	/* mode flags */
 	unsigned int	vc_disp_ctrl	: 1;	/* Display chars < 32? */
 	unsigned int	vc_toggle_meta	: 1;	/* Toggle high bit? */
@@ -144,7 +152,6 @@ struct vc_data {
 	unsigned int	vc_priv		: 3;
 	unsigned int	vc_need_wrap	: 1;
 	unsigned int	vc_can_do_color	: 1;
-	unsigned int	vc_report_mouse : 2;
 	unsigned char	vc_utf		: 1;	/* Unicode UTF-8 encoding */
 	unsigned char	vc_utf_count;
 		 int	vc_utf_char;
-- 
2.27.0

