Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833D1C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F06920658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594695;
	bh=+bIpSi/c6GEhT293GlRTXrXmug0KpOewySLts4rLX6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yjo8ghtZD4eGTE9HBGthlC8QzfkH82xOuyCne2n4BJTmqdRyE+JS9qVXkkNAnaOYU
	 mMREaFOv6qVeunyeQ9FAUp+5MsyWL4kqnhGtqcy3dke6RLzbWiCfvhZjjZzt8Ds+mO
	 fML/WM01j8SStTRjtpi/yKZk3q0kd0KUxcYiteVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbgIHTvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730549AbgIHPt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:49:57 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A15B62485E;
        Tue,  8 Sep 2020 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579927;
        bh=+bIpSi/c6GEhT293GlRTXrXmug0KpOewySLts4rLX6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UlNl1Ed1vZRIs4PpFFXMlgXZYq2oFcZZJ/sl9CbacAxhp0ZptaeO1ayAzKXSDu8j7
         I4lObF0bnm5KZb5u6lO2xVOsQ/3euAEL+7DXFeSoxlkbkdBekUgM5stX/ZJlS90Pai
         0yG7mwMlsUvvwXstKfSnDLGt/YTuEjWmfobMA5Gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tong Zhang <ztong0001@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 090/129] ALSA: ca0106: fix error code handling
Date:   Tue,  8 Sep 2020 17:25:31 +0200
Message-Id: <20200908152234.229551369@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tong Zhang <ztong0001@gmail.com>

commit ee0761d1d8222bcc5c86bf10849dc86cf008557c upstream.

snd_ca0106_spi_write() returns 1 on error, snd_ca0106_pcm_power_dac()
is returning the error code directly, and the caller is expecting an
negative error code

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200824224541.1260307-1-ztong0001@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/ca0106/ca0106_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -537,7 +537,8 @@ static int snd_ca0106_pcm_power_dac(stru
 		else
 			/* Power down */
 			chip->spi_dac_reg[reg] |= bit;
-		return snd_ca0106_spi_write(chip, chip->spi_dac_reg[reg]);
+		if (snd_ca0106_spi_write(chip, chip->spi_dac_reg[reg]) != 0)
+			return -ENXIO;
 	}
 	return 0;
 }


