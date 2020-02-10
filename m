Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E74BC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8B320708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339262;
	bh=QSUZ27j32TTc/SGBQWBInWha7q1KUq5XJulnT+DwTL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GfAR42lTvQvS9pJ5ofczLsOjapTpFpDJWR1zZqPc+FMeUeOEesKVwORUVnHbWj5Wu
	 67c9FENPS0JeOCdv+a+Cs0Tf+6O/swXhGKPEfGX4ervcuIsXgYspJLAkk127Srcfml
	 3JHthPFPmJWGmpdrba8Od8bNh5ZQFWKRGB5/el6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgBJMyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:54:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730133AbgBJMmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:42:02 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56FAD20842;
        Mon, 10 Feb 2020 12:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338522;
        bh=QSUZ27j32TTc/SGBQWBInWha7q1KUq5XJulnT+DwTL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eOgEe4PouKF4A6lUKI6A2+8Lo3Xt0Tvg/4vLqz7qe+qSmCh9pHpZHKj5pUSPwizxS
         K/GgebfmHj8Lb7GPwxQvgZZM9Ym16Z1e10uywYGYsI0MIhTP19Qr8rf2vZcJG+0GHO
         UE4+5UN+swCTofijIGFnv4LYxm5cHtyxxrn/qs4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pascal Prime <pascal.prime@silabs.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 5.5 297/367] staging: wfx: revert unexpected change in debugfs output
Date:   Mon, 10 Feb 2020 04:33:30 -0800
Message-Id: <20200210122451.075275418@linuxfoundation.org>
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

From: Jérôme Pouiller <jerome.pouiller@silabs.com>

commit 8b08b6a8c31f18c3657405410e4c3f6bc4fa75f1 upstream.

It appears that commit 8c7128c4cf4e ("staging: align to fix warnings of
line over 80 characters") do slightly more than what is explained in
commit log.

Especially, it changes the output of the file rx_stats from debugfs.
>From some point of view, this file can be considered as a part of the
API. Any change on it should be clearly announced.

Since the change introduced does not seems to have any justification,
revert it.

Reported-by: Pascal Prime <pascal.prime@silabs.com>
Cc: Jules Irenge <jbi.octave@gmail.com>
Fixes: 8c7128c4cf4e ("staging: align to fix warnings of line over 80 characters")
Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Link: https://lore.kernel.org/r/20200115135338.14374-2-Jerome.Pouiller@silabs.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wfx/debug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/wfx/debug.c
+++ b/drivers/staging/wfx/debug.c
@@ -145,7 +145,7 @@ static int wfx_rx_stats_show(struct seq_
 		   st->pwr_clk_freq,
 		   st->is_ext_pwr_clk ? "yes" : "no");
 	seq_printf(seq,
-		   "N. of frames: %d, PER (x10e4): %d, Throughput: %dKbps/s\n",
+		   "Num. of frames: %d, PER (x10e4): %d, Throughput: %dKbps/s\n",
 		   st->nb_rx_frame, st->per_total, st->throughput);
 	seq_puts(seq, "       Num. of      PER     RSSI      SNR      CFO\n");
 	seq_puts(seq, "        frames  (x10e4)    (dBm)     (dB)    (kHz)\n");


