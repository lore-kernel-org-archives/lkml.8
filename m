Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7A0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9AC206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595543147;
	bh=U5xaOXe6f3Tcm1RrClm9iWxqm5qPD/VcfmQNcqV27aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q81BQXOMX3TrbWe2IqnpVQjcKm+x5SwCp8AdnSAl2mwAKYTa3dKTfyFTbMU1DgfsL
	 uj7j4QslbgkN3JnA58fwpEs8I9JCcR8aFX09HffW5M/O5+Gibk5dhC1jVzQGIYd6n8
	 MN3pZstpUpWDSgJQSv4eRNMrcFd3VfpljI9i8evQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGWWZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgGWWZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:25:45 -0400
Received: from embeddedor (unknown [201.162.245.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAB0E2067D;
        Thu, 23 Jul 2020 22:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595543145;
        bh=U5xaOXe6f3Tcm1RrClm9iWxqm5qPD/VcfmQNcqV27aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+Uik1sWZe21IpT5GZ2gNJ9HvL7hsz/qGm/3nAdyNSAQdCQ2yaiw/t3/GQK55lw0p
         ulWAee5MaWLv9/Hu9CxedQeef0tTdtTPhenLXaCoCu21Tae1u+cmyTfeBgTgavZJHM
         PiSi0bBbOFToidJPd7OlaHgXAqIBOh80R0/7sLJA=
Date:   Thu, 23 Jul 2020 17:31:27 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 1/3] tty: Avoid the use of one-element arrays
Message-ID: <f49bf0e27eaac396c96d21392c8c284f9f5ef52a.1595543280.git.gustavoars@kernel.org>
References: <cover.1595543280.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1595543280.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are being deprecated[1]. Replace the one-element arrays
with simple value types 'char reserved_char' and 'compat_int_t reserved'[2],
once it seems these are just placeholders for alignment.

[1] https://github.com/KSPP/linux/issues/79
[2] https://github.com/KSPP/linux/issues/86

Tested-by: kernel test robot <lkp@intel.com>
Link: https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/0-day/tty-20200716.md
Acked-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/tty/tty_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 5a6f36b391d9..3b6e5ec3ba54 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2683,7 +2683,7 @@ struct serial_struct32 {
         compat_int_t    baud_base;
         unsigned short  close_delay;
         char    io_type;
-        char    reserved_char[1];
+        char    reserved_char;
         compat_int_t    hub6;
         unsigned short  closing_wait; /* time to wait before closing */
         unsigned short  closing_wait2; /* no longer used... */
@@ -2691,7 +2691,7 @@ struct serial_struct32 {
         unsigned short  iomem_reg_shift;
         unsigned int    port_high;
      /* compat_ulong_t  iomap_base FIXME */
-        compat_int_t    reserved[1];
+        compat_int_t    reserved;
 };
 
 static int compat_tty_tiocsserial(struct tty_struct *tty,
-- 
2.27.0

