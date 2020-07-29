Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F561C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2400C2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="k7PDIjfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgG2FNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgG2FNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:13:44 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 000F6C061794;
        Tue, 28 Jul 2020 22:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=gyAFFTHooPV1cN1UkwS8W36v0aFTve9g94HoZtdi3lI=; b=k7PDIjfZSm4sg
        o7grEP8rlg4ZxHPPG7a7P+6ljmG4hRzWpqEY453mZU8RI1IPUImdsC6jFv9QGE5U
        ugNiPqwv7zNXyVJ75qHAX2/RU0I61Vv4WRcslFPfKfnV9UbzMZ51yhfEV5Un0p+y
        3XhLaCdvYlm2ZopF8gZV3ThTUX1mP8=
Received: from xhacker (unknown [101.86.17.135])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCXjUCFBSFfwOg9AA--.30602S2;
        Wed, 29 Jul 2020 13:13:42 +0800 (CST)
Date:   Wed, 29 Jul 2020 13:08:39 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/4] regulator: mp886x: two features and dt json convert
Message-ID: <20200729130839.10a9bf88@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCXjUCFBSFfwOg9AA--.30602S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xryktw17CF47Zr1xGF1xZrb_yoWDXrgE9r
        yxAa47Gw4UZF1rCayIyFsrt34YyF4Iga48JFy7KrZ0vry7ZayUWrZxXr9Fyr4xWayUAFnr
        Wwn7JrWSyry3WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbF8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
        80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr
        1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8pnQUUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

This is to improve the mp886x regulator driver support.
patch1 implments .set_ramp_delay
patch2 and patch3 support the switch freq setting
patch4 converts dt binding to json-schema

Since v2:
  - put any schema conversions at the end of the series as Mark
    suggested.

Jisheng Zhang (4):
  regulator: mp886x: implement set_ramp_delay
  dt-bindings: regulator: mp886x: support mps,switch-frequency
  regulator: mp886x: support setting switch freq
  dt-bindings: regulator: Convert mp886x to json-schema

 .../devicetree/bindings/regulator/mp886x.txt  |  27 -----
 .../bindings/regulator/mps,mp886x.yaml        |  58 ++++++++++
 drivers/regulator/mp886x.c                    | 109 +++++++++++++++++-
 3 files changed, 164 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/mp886x.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp886x.yaml

-- 
2.28.0.rc1


