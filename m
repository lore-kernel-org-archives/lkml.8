Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD3C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931FC206E7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c1nkAIFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHBTsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 15:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgHBTs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 15:48:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7ADC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 12:48:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q76so12389457wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 12:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=vMjEIb5uo7VhiRyfKlm7ANqD9A+lfo+NgIVGNjWXofY=;
        b=c1nkAIFMssVu0c5J+2yIcGuckCbtADYQwQza2wgKckbGzcm7920ShZqfAfnOKTTuje
         d/yv0G07aA3fGbyZ7+e7dk5OXybSWiSH4OJJwFKuyqOBPTsZQAldHH53id7Vq/dMmVHs
         Hq+e5ZUlSWO99ToHkA3hop35aWv+OgdWACcYUNNf6moHGI9MnY4jeAw05d5jGYc7CgDD
         N/IN9BY9PsjS2vnZoDWflPdbydqSAoxEnVoLQr+c2jVmPxKUsn15Ob7Ntd7gR/eCrp5X
         PNkziRS6LbaYVvJusW2I0mqUqOhm1ZhoSCW9WVVlhyeJgaZ21nAnLpYoZmJ1Wn78DRHe
         ueHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=vMjEIb5uo7VhiRyfKlm7ANqD9A+lfo+NgIVGNjWXofY=;
        b=N8O9z38gjdAaM4ujV0NQbYn7UWtPdRvdxGJCwHw1iEMRWShI+mwNKgNEAgr3hd4Pme
         s49jAHkG/h2ohIZu/eqKLDo1f237Z0+hfV/bBuaO1t2+uVs0APeIrNiaxmoxonUaNd7f
         3s7+JFo2u6IdOg9vuJNLCMErRg3oe8KknSduj1Aqc1X0w/6Ieqpdbe1J4Q+lA4f8e8Ho
         G4SSuOhnVbTX4a5aplZX3B0a283pmwkUOPuTMiSbPZhHurmpX72jdHOTtJaRHn1Zxu/v
         08UjyJ9O93e/IGUhXUkL5XFj6Df/A0mzDyjaVIUOvKRA+W3hGrqyn1I9CeS/PZM3+0EQ
         tUvw==
X-Gm-Message-State: AOAM5336N757dahGa8bdJYoGWQGOettUHGJFFRDPFLI0S6MXws+e9enF
        KX50UtJ48+5FXXi0tlyAiZ8=
X-Google-Smtp-Source: ABdhPJxzVReKK99f7Ep8s6t/Jy1sANA2ap+ksmiFj3WRTp5K2eaPl+6QIxF3gZpINPkQfvTsZcBUoA==
X-Received: by 2002:a1c:2095:: with SMTP id g143mr12408304wmg.78.1596397707431;
        Sun, 02 Aug 2020 12:48:27 -0700 (PDT)
Received: from [192.168.1.20] ([213.122.218.185])
        by smtp.googlemail.com with ESMTPSA id w132sm13141634wma.32.2020.08.02.12.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 12:48:26 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>, ricky_wu@realtek.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        philquadra@gmail.com, Arnd Bergmann <arnd@arndb.de>
From:   Chris Clayton <chris2553@googlemail.com>
Subject: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
 Intel NUC boxes
Message-ID: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
Date:   Sun, 2 Aug 2020 20:48:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8F92358A99E7EDD14B7F4564"
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8F92358A99E7EDD14B7F4564
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

bede03a579b3 introduced a bug which leaves the rts5229 PCI Express card reader on my Intel NUC6CAYH box.

The bug is in drivers/misc/cardreader/rtsx_pcr.c. A call to rtsx_pci_init_ocp() was added to rtsx_pci_init_hw().
At the call point, pcr->ops->init_ocp is NULL and pcr->option.ocp_en is 0, so in rtsx_pci_init_ocp() the cardreader
gets disabled.

I've avoided this by making excution code that results in the reader being disabled conditional on the device
not being an RTS5229. Of course, other rtsxxx card readers may also be disabled by this bug. I don't have the
knowledge to address that, so I'll leave to the driver maintainers.

The patch to avoid the bug is attached.

Fixes: bede03a579b3 ("misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260")
Link: https://marc.info/?l=linux-kernel&m=159105912832257
Link: https://bugzilla.kernel.org/show_bug.cgi?id=204003
Signed-off-by: Chris Clayton <chris2553@googlemail.com>

bede03a579b3 introduced a bug which leaves the rts5229 PCI Express card reader on my Intel NUC6CAYH box.

The bug is in drivers/misc/cardreader/rtsx_pcr.c. A call to rtsx_pci_init_ocp() was added to rtsx_pci_init_hw().
At the call point, pcr->ops->init_ocp is NULL and pcr->option.ocp_en is 0, so in rtsx_pci_init_ocp() the cardreader
gets disabled.

I've avoided this by making excution code that results in the reader being disabled conditional on the device
not being an RTS5229. Of course, other rtsxxx card readers may also be disabled by this bug. I don't have the
knowledge to address that, so I'll leave to the driver maintainers.

The patch to avoid the bug is attached.

Chris

--------------8F92358A99E7EDD14B7F4564
Content-Type: text/x-patch; charset=UTF-8;
 name="dont-disable-rts5229-cardreader-on-intel-NUC.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dont-disable-rts5229-cardreader-on-intel-NUC.patch"

--- linux-5.7.12/drivers/misc/cardreader/rtsx_pcr.c.orig	2020-08-02 13:36:50.216947944 +0100
+++ linux-5.7.12/drivers/misc/cardreader/rtsx_pcr.c	2020-08-02 18:37:30.456610731 +0100
@@ -1200,9 +1200,13 @@ void rtsx_pci_init_ocp(struct rtsx_pcr *
 				SD_OCP_GLITCH_MASK, pcr->hw_param.ocp_glitch);
 			rtsx_pci_enable_ocp(pcr);
 		} else {
-			/* OC power down */
-			rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN,
-				OC_POWER_DOWN);
+			/* On (some?) Intel NUC platforms, this disables
+			 * the rts5229 cardreader, so don't do it
+			 */
+			if(!CHK_PCI_PID(pcr, 0x5229))
+				/* OC power down */
+				rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN,
+					OC_POWER_DOWN);
 		}
 	}
 }

--------------8F92358A99E7EDD14B7F4564--
