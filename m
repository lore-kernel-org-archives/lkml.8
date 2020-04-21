Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC18CC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56F6206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnfsIgOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgDUNaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728519AbgDUNaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:30:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6335EC061A10;
        Tue, 21 Apr 2020 06:30:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n6so10616749ljg.12;
        Tue, 21 Apr 2020 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80lm6Fk0sekxxITrDb5bHy56T1zgUeTIAIaDXyiWSbc=;
        b=lnfsIgOT3/zSmQqA3A46dvPVKaDYEVabkhhKgjiqY74xqHvpBO+58J5eBepYDNYtfc
         sIwarSKjCSijir339k4w2TOywidHeOcJnrQ/y8c3pbYAo3vDYcoNPjixYPNpNM+Uwwfo
         lK5TNu6b7TRZj5Ly//EGBvDqLe9S+3fDKVMfDxg6h8xPk3Xq10JONj3eRENnrxipGSKP
         LlaIRzvlzdHnF/QIwX7+7zccSlJiXazWBPHr2fahBcsRvQ9Q3OUO10kX4YdKHh7gYBZy
         wMCFI3opl2p1BJj+v6eO8MPeWrOTRB0HM7eHyfAi/bnfUNrJYud1QftkGtVVxlyONGcM
         ql8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80lm6Fk0sekxxITrDb5bHy56T1zgUeTIAIaDXyiWSbc=;
        b=WprZVsa1CspqRPNHeK2UVcThdbkYOxZU77eXMbmQGGm9qla8u3UsLWy7/QamscVbBZ
         JdA8lX97XNud1pB4A6aEGghCetWz5poDMYmqR8ar4Ju1zDRV64iXNNsBjdl54YRLTmlY
         HxQxVFNXZkjAji0kZ4CHuy6vNtmSnG3Uznr9C9JOFh1em2AFm1Cn9qzTn1k/feCfWvnj
         Ts6v1XP/075HIgSoIcnegVAin8cQxGtDcDGzEgZmpm1yqDyKaCzG2r9dBNO05pWMMETg
         PYvznQ8VsCZaqEf5YBGfL9ZX1XYGUMCAHCIVxMVh9OlLGPwIFftm4CrWdSY+/OONKM5K
         s2oQ==
X-Gm-Message-State: AGi0PuY1jWDqs/NaCODGj8tiesTv3/+RxzgN9OiFOUVSHdVvhmsg16LM
        rpYkZKKU4Qm+rBi1PMzxzAiV+FtK6Es=
X-Google-Smtp-Source: APiQypKSxRpChdTnmNbZQWNvmSsagPnFGHTzxOoipT9qphhjvxRuBRdugg7zAZ4jjwkEiWbTXZsJMA==
X-Received: by 2002:a2e:b610:: with SMTP id r16mr13297479ljn.254.1587475843687;
        Tue, 21 Apr 2020 06:30:43 -0700 (PDT)
Received: from oak.local ([188.123.231.141])
        by smtp.gmail.com with ESMTPSA id v17sm2031456lfi.49.2020.04.21.06.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:30:42 -0700 (PDT)
From:   matwey.kornilov@gmail.com
To:     stern@rowland.harvard.edu, b-liu@ti.com, gregkh@linuxfoundation.org
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] musb: Improve performance for hub-attached webcams
Date:   Tue, 21 Apr 2020 16:30:13 +0300
Message-Id: <20200421133019.27167-1-matwey.kornilov@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matwey V. Kornilov" <matwey@sai.msu.ru>

The series is concerned to issues with isochronous transfer while
streaming the USB webcam data. I discovered the issue first time
when attached PWC USB webcam to AM335x-based BeagleBone Black SBC.
It appeared that the root issue was in numerous missed IN requests
during isochronous transfer where each missing leaded to the frame
drop. Since every IN request is triggered in MUSB driver
individually, it is important to queue the send IN request as
earlier as possible when the previous IN completed. At the same
time the URB giveback handler of the device driver has also to be
called there, that leads to arbitrarily delay depending on the
device driver performance. The details with the references are
described in [1].

The issue has two parts:

  1) peripheral driver URB callback performance
  2) MUSB host driver performance

It appeared that the first part is related to the wrong memory
allocation strategy in the most USB webcam drivers. Non-cached
memory is used in assumption that coherent DMA memory leads to
the better performance than non-coherent memory in conjunction with
the proper synchronization. Yet the assumption might be valid for
x86 platforms some time ago, the issue was fixed for PWC driver in:

    1161db6776bd ("media: usb: pwc: Don't use coherent DMA buffers for ISO transfer")

that leads to 3.5x performance gain. The more generic fix for this
common issue are coming for the rest drivers [2].

The patch allowed successfully running full-speed USB PWC webcams
attached directly to BeagleBone Black USB port.

However, the second part of the issue is still present for
peripheral device attached through the high-speed USB hub due to
its 125us frame time. The patch series is intended to reorganize
musb_advance_schedule() to allow host to send IN request quicker.

The patch series is organized as the following. First three patches
improve readability of the existing code in
musb_advance_schedule(). Patches 4 and 5 introduce updated
signature for musb_start_urb(). The last patch introduce new
code-path in musb_advance_schedule() which allows for faster
response.

References:

[1] https://www.spinics.net/lists/linux-usb/msg165735.html
[2] https://www.spinics.net/lists/linux-media/msg144279.html

Changes since v2:
 - rebase changes onto v5.7-rc2
Changes since v1:
 - Patch 6 was redone to keep URB giveback order and stop transmission at
   erroneous URB.

Matwey V. Kornilov (6):
  usb: musb: Use USB_DIR_IN when calling musb_advance_schedule()
  usb: musb: Introduce musb_qh_empty() helper function
  usb: musb: Introduce musb_qh_free() helper function
  usb: musb: Rename musb_start_urb() to musb_start_next_urb()
  usb: musb: Introduce musb_start_urb()
  usb: musb: Decrease URB starting latency in musb_advance_schedule()

 drivers/usb/musb/musb_host.c | 132 ++++++++++++++++++++++-------------
 drivers/usb/musb/musb_host.h |   1 +
 2 files changed, 86 insertions(+), 47 deletions(-)

-- 
2.25.0

