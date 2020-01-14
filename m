Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8F1C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8424222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ7h318y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgANPT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:19:26 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:35448 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgANPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:19:25 -0500
Received: by mail-pg1-f171.google.com with SMTP id l24so6539246pgk.2;
        Tue, 14 Jan 2020 07:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Blm5wTiE5tQruAK/YOnvK7ORBP3I4AIr+5nnogB08Js=;
        b=KJ7h318yoZcCOqNvMpHfvFuV5m7UOVddyKhbCESfxQXHvIW3RY1G6lozyKRHxNy3iB
         x4pRcwNYeDjhh94cUywIbhirrh1DDA9xKqE6z1zjMtHvzMDWJvs1qqzIcDfvfbHEumi3
         ZEsWxHhtSH4i27vc5I+nk6WpVPx6qIyXyXgSVYO9QHTUcwLMDNfqbItDZaQI/oh0eDhT
         OBUOVGm64rh7MMeiXZmiz5elW0pPkUed597qFBfbbbPdtNwa6THBT4IU1EDz/ZPt6bFe
         cjgOa9N1iJIgiDx4KWaFLOtGkRIZveiutBezMVuwHlgIxkwE7BpCWEJZDJdUGJWSa4/9
         RT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Blm5wTiE5tQruAK/YOnvK7ORBP3I4AIr+5nnogB08Js=;
        b=l57FNRt1zxCWAbxUEDvVGe5DjTgCpE9Ur+X8eNqPatPmxZVpWo14DOiXb6zY85f0ei
         Faqaje41P+UweKS+zeZCYzZ0uXwqELDvHiawrvMu9GmijLhOCbIVkzhzS9Gl3aqO3VZU
         AaPqHWk2591KN0mTBt7VC4FG8gypNspGqLKIXtN6kIPhqBIRem5EsMgaZf1Ktl7slfzN
         a2ZhMPEmrV2FlHUAYIKOVmZG1SF77WF2Dd1jZcVLMnUXWAa8235JYARZBwQHkqnlajFb
         /5S6lY0Ff7wcdnfgQWRyPp5JkolZWdA1uU9wP6N7ubMYS53l8prz2pj50RlQ0TJ5Rb+1
         4PXg==
X-Gm-Message-State: APjAAAXqM1LLq/467QcU+hP2kwYDeXzqfR72yG2c3saK/h3ywOdzSf9X
        nnb5RSRytYZpyhvIdqWfO24=
X-Google-Smtp-Source: APXvYqymo0T3qiC6GnnuQMNBtlZxD4FeMrNZhKd7v753KqwX3OyuZdxiC+lHs6IvP4nvI7twfrtIKQ==
X-Received: by 2002:a63:5c1c:: with SMTP id q28mr26632494pgb.245.1579015164721;
        Tue, 14 Jan 2020 07:19:24 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id 207sm18834425pfu.88.2020.01.14.07.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:19:23 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Voltage monitor on ZII's VF610 boards
Date:   Tue, 14 Jan 2020 07:19:01 -0800
Message-Id: <20200114151906.25491-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series configures voltage supply rail monitoring on all
applicable ZII VF610 boards. Should be pretty straightforward, but let
me know if any changes are necessary.

Thanks,
Andrey Smirnov

Andrey Smirnov (5):
  ARM: dts: vf610-zii-ssmb-spu3: Add voltage monitor DT node
  ARM: dts: vf610-zii-ssmb-dtu: Add voltage monitor DT node
  ARM: dts: vf610-zii-spb4: Add voltage monitor DT node
  ARM: dts: vf610-zii-dev: Add voltage monitor DT node
  ARM: dts: vf610-zii-cfu1: Add voltage monitor DT node

 arch/arm/boot/dts/vf610-zii-cfu1.dts      | 8 ++++++++
 arch/arm/boot/dts/vf610-zii-dev.dtsi      | 8 ++++++++
 arch/arm/boot/dts/vf610-zii-spb4.dts      | 8 ++++++++
 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts  | 8 ++++++++
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 8 ++++++++
 5 files changed, 40 insertions(+)

--
2.21.0
