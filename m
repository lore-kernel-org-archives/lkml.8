Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89313C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 16:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6208C20659
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 16:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E97Soa8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgDDQP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 12:15:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43210 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgDDQP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 12:15:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id o10so11475793qki.10;
        Sat, 04 Apr 2020 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h517eIrXfumVfl/Ir6NGKlk9+2KSVqM6SBkwQdKGP1E=;
        b=E97Soa8DpIZZlQFbHSK7gIU5zfy9IaRAzThGzVwS3zKqrwPQk0gW9VfOSdaijxQ685
         JlhYBxEfwbeqvw5V8ZW9b8GsrjSmn9qEdXs7iBTcD4sImnC72K1nR8LTunxNs2GsF4sw
         bkv3zaSakehfFDMAscKPYF4wnDrATu79zrNrptTP4suBzP3VkNLkzPU5hoKrA4vu8Y4Q
         hMHKZMvgNhcfbsBXliM/89GmRYaEN6EXDW7322O2lOaZEZTXSVXM4qEt1hVqqCRceP6t
         JtrgVdrFweKSUKiVbxYoL4EwGasp3yL7h1KBDTrZFDb3eChi18UyfPvWGAG2+aC8NCKN
         pzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h517eIrXfumVfl/Ir6NGKlk9+2KSVqM6SBkwQdKGP1E=;
        b=GF0GrASYQ7ry/UCRKzjJ6hakufODFSAnXFLk28UoUUiSKGA1AUJEPeRSdRTldGUx/j
         X8gGJJCvfDRFNqeqtcHzMrKGlhxnzs0THH7BvCcM8Qgw9Ewv8pLcExIkTcRwfYpZa8vS
         kGqsdDttH6cM/GBPeG1Z/VvCBRIlNl4aCYVOrxr8CAHsV9oUQKGnTcQxOqZpGYaAkfzU
         qoHxoXZJTkGUZAcS+JKQU8pz8ECVR9N2HZ0LI6y11sK2JkUtJNoQWRAdRVgkW+dFS4cQ
         t9R93sV22IBzrMqpSg+ElmOFxdivcwgB/O1snrmezCFQvQRF6peGohq3yyJOPfGUwD8B
         Lnpg==
X-Gm-Message-State: AGi0PubZoSM0ZsYIC9gn7ZGsNXHya5PDVQYBO+l+/GY/uBrEk3y/t9Jh
        xiGzlkc5pLnj/nZMqNA7bLalSHpDzCo=
X-Google-Smtp-Source: APiQypLXz4aA51rzNXQUddjVESGHlr5mqRv9glbZgOLOSdip/bhk4+yp0bFLL48u/SiwcAkjCLBKIw==
X-Received: by 2002:ae9:dd83:: with SMTP id r125mr14520880qkf.105.1586016953017;
        Sat, 04 Apr 2020 09:15:53 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id n67sm9213534qte.79.2020.04.04.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 09:15:52 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, charles.stevens@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt: Add bindings for IDT VersaClock 5P49V5925
Date:   Sat,  4 Apr 2020 11:15:36 -0500
Message-Id: <20200404161537.2312297-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200404161537.2312297-1-aford173@gmail.com>
References: <20200404161537.2312297-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDT VersaClock 5 5P49V6965 has 5 clock outputs, 4 fractional dividers.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
index 05a245c9df08..bcff681a4bd0 100644
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
@@ -12,6 +12,7 @@ Required properties:
 		"idt,5p49v5933"
 		"idt,5p49v5935"
 		"idt,5p49v6901"
+		"idt,5p49v6965"
 - reg:		i2c device address, shall be 0x68 or 0x6a.
 - #clock-cells:	from common clock binding; shall be set to 1.
 - clocks:	from common clock binding; list of parent clock handles,
-- 
2.25.1

