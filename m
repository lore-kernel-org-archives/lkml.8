Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC51C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 04:26:05 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A533A2072B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 04:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4eTovrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A533A2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgDME0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 00:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgDME0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 00:26:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C192C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 21:26:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c7so10565182edl.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 21:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7VLJ5Ich2FM0bWh1w8Evhln7+j2H+ZhhTOXHT6N4JHQ=;
        b=A4eTovrkmhrPsPLRRu/7UwgNG+y8J4BHMGqCNJgA0t3HO/DudA8QlcM26ZwBphvApE
         ZgfZ9VorRykwy0J9Yr9CsdLP2Y8QoQYuKJJrzoWN05PkVCFpQUCdwgwkX7QNaXqQoTQI
         8Sci126kjt7/ZIbjWgFYp1EOCx884WJsJbbnachNFZtbNMbTeua7H7voIiRV8wRa21Yn
         fynBEiNNyU9EP2sNfk2FX1DvunHtkwVBWvohNb5K5ODWmRXtTIbFDD4Y+fgckekMDumR
         y3dX++HrjYiZZP6BsRQIGQS0cggIBgDzicnoj6Tjo8VekPyxbQR8lQBdVTZ4mSiBUhcx
         GmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7VLJ5Ich2FM0bWh1w8Evhln7+j2H+ZhhTOXHT6N4JHQ=;
        b=Lri7ITmgxhGa2Nr9mVvBXE85CAJPxMX/Abok+lQsnG0cRA52fhjYx3Ps1gIJ9uz08G
         X729WHNQeXwOokaX/10ELMrnENb7QNhDROxbGzXd1QqozoN8cgJQN87r/Vfks080Jqr3
         3tIJPc2PY4GojQJ1cBs/lyBjRNBNmi7PEbHRPRQKwd0C1NOcOZI+byt2a8cJ2Evmf/rv
         dmH3FoPmSizDJvDtpnE97iHAdYUfxavhKfz5wfw5OBsDtywepHP5wzIvM9XYXc/dK6jd
         tU4p8RKnUjOEM14eNvhdo+L9Q8jmxB2mXlGz65dsaHncycwGjLPE3vrIlEM+g8RrHSNF
         Cksw==
X-Gm-Message-State: AGi0Pubvu5gWIrMKrbreTZIaHHAR+QPy+cl74kaXW6JVSQOtphEXDBct
        VR63ZPNi+dWvah0IF6JK46AjybkGb+CMuhVVuIy0Mmqk
X-Google-Smtp-Source: APiQypI+8XhC3PfCftIq/RDnDbjekE//Ueo+Vs8crqBPq3Tcpj685vU+WsezaVQfY+F+VPgiIf87HPcwXmwumm+0Ra4=
X-Received: by 2002:a50:f095:: with SMTP id v21mr6475442edl.103.1586751960573;
 Sun, 12 Apr 2020 21:26:00 -0700 (PDT)
MIME-Version: 1.0
From:   josep lladonosa capell <jlladonosa@gmail.com>
Date:   Mon, 13 Apr 2020 06:25:49 +0200
Message-ID: <CAKJN6S4N-W4R+-XZxZ9WzLJKZwMmwxnO59Bve+WbpTMmBEE=nQ@mail.gmail.com>
Subject: [PATCH] sound/soc/intel/Kconfig: WhiskeyLake instead of WhiskyLake
To:     linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just found a typo.


--- linux/sound/soc/intel/Kconfig.orig    2020-04-13 06:02:28.998202335 +0200
+++ linux/sound/soc/intel/Kconfig    2020-04-13 06:02:52.714078533 +0200
@@ -162,7 +162,7 @@ config SND_SOC_INTEL_GLK
       enabled in the BIOS then enable this option by saying Y or m.

 config SND_SOC_INTEL_CNL
-    tristate "CannonLake/WhiskyLake Platforms"
+    tristate "CannonLake/WhiskeyLake Platforms"
     depends on PCI && ACPI
     depends on COMMON_CLK
     select SND_SOC_INTEL_SKYLAKE_FAMILY
