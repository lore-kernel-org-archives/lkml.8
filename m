Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE09C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FB42075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tot3Vjo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438262AbgDNKTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438218AbgDNKRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:17:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCC1C061A0C;
        Tue, 14 Apr 2020 03:17:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p8so5798042pgi.5;
        Tue, 14 Apr 2020 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hz5qaXSjMSJnZU949MlZ213oDPmzY4IGeJxDJZAJknk=;
        b=tot3Vjo6xI6pzrRfCjeQjJVaNufikVemoGG1FELtNHDZkT5Z6XnMlLcPG/frgqnTuC
         UcpYaSeG40QfrsI0FXKrrvtaZFegg+IPUBKiBh6l8j14PeCG5m3bHf/yc54qkIHUngnv
         3hwJG7YBs7kFfIyqbZS8592HYJwRIGSZshB7TVT2Guv+4GF8pXCNzMHft7qxPvIKSIW0
         lGqHaBAGR1AkAbkUBQzwlK6MPvVY6mp7XB6ZJRyQ3Wft6SE4XKKGTN8OYyvlLJqkrNGQ
         kRUJGhpDy6ho+OrmwtH6WNIjDHMSStW5J45ibreMy+6nm2zEteHf17H/bJrxmRES7C/k
         WAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hz5qaXSjMSJnZU949MlZ213oDPmzY4IGeJxDJZAJknk=;
        b=iu3mVpddd3KRdn1yX/BOfybwf9nVrdZFQA3H94rvu5pHVV3O+TGmT5ePBlu6Mx9GS4
         74AuXZw8ZAP9y9KFGm32qfjZWWwB4n2mo8qVnOw1zIHZg0Mb3CQr0LwtUYyPv1Tbmioi
         zf/vDiMuCdk4e864jUlcX8KIn1Cw0N1mUnpZkcVx84ThunS2e6M0BtYhX4L2tB+Vsx5q
         30Lhr37EEERty+LsfKhj+7zw0vIw3VY0L3bIJfuGHgnAa6/zQ1q2NFd9NTgQdh1tbOZH
         vI2zMP91ClKCZGAffv5C3bIfn7cDiMAwclnWTo4C/78YNx107PeJcevpRWBCQKQk9vyK
         PUnA==
X-Gm-Message-State: AGi0PuZmdHCE8gwyI5P4dJvLsTX3CIc2b2VIs9HKMbRAzGV6GZ6V1sFG
        brqeCE1u3vAg4wXGGmKvR3kjjCgnY8A=
X-Google-Smtp-Source: APiQypLoRS1/1KBwSsEAFhCwScvBiNQlHiEQhSgYhapLbYO5lRn1NvbSsxyy9gpq0USi0RXXPDp4pg==
X-Received: by 2002:a63:df01:: with SMTP id u1mr21633672pgg.166.1586859437219;
        Tue, 14 Apr 2020 03:17:17 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r189sm9870182pgr.31.2020.04.14.03.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 03:17:16 -0700 (PDT)
From:   zhang.lyra@gmail.com
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RESEND PATCH 0/2] add clock and emmc/sd nodes for SC9863A
Date:   Tue, 14 Apr 2020 18:16:34 +0800
Message-Id: <20200414101636.24503-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

SC9863A clock driver got merged, this patch-set adds clock nodes, emmc and sd card nodes,
so that we can startup debian on SC9863A.

Chunyan Zhang (2):
  arm64: dts: Add SC9863A clock nodes
  arm64: dts: Add SC9863A emmc and sd card nodes

 arch/arm64/boot/dts/sprd/sc9863a.dtsi |  66 +++++++++++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi | 164 ++++++++++++++++++++++++++
 2 files changed, 230 insertions(+)

-- 
2.20.1

