Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35480C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12CB220825
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="a29d+QtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgG2FNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgG2FNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:13:45 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B1ACC0619D2;
        Tue, 28 Jul 2020 22:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=8ofPcXSCXP+ZIlac+sNg6nfmS98eLPjwRZ
        kxOQ8UBiY=; b=a29d+QtPUMqMvkWa3mATEkskB6hN/0IsdAEYwiRpXdbydVXQGq
        NJaPi0m14+lTGGuPHYV2xQ9Ra3I40htwCSKRCEbUm/OXtmqJEQFvbKYAeCDDGvTS
        /FzTq6UEMIzFExKRlcck4jlI/ALrubiXibVvgbla/FXlyG+6VzlXEc9j8=
Received: from xhacker (unknown [101.86.17.135])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCXjUCFBSFfwOg9AA--.30602S3;
        Wed, 29 Jul 2020 13:13:43 +0800 (CST)
Date:   Wed, 29 Jul 2020 13:09:52 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: regulator: mp886x: support
 mps,switch-frequency
Message-ID: <20200729130952.260671f1@xhacker>
In-Reply-To: <20200729130839.10a9bf88@xhacker>
References: <20200729130839.10a9bf88@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCXjUCFBSFfwOg9AA--.30602S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xryktw13Wr1fWrWUGrW5Awb_yoWDKwc_Wa
        4xAayUKws3JF4F9F4qvF4qkFWrJw4SyFWxZrnrJ39Yyryjka4qgr98Xr9Iyr47GF4UuF9x
        W34xXrWqgrsIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb38YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
        IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CE
        w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF
        7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxU2uc_DUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Both MP8867 and MP8869 support different switch frequency.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/regulator/mp886x.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/mp886x.txt b/Documentation/devicetree/bindings/regulator/mp886x.txt
index 551867829459..e747000cebba 100644
--- a/Documentation/devicetree/bindings/regulator/mp886x.txt
+++ b/Documentation/devicetree/bindings/regulator/mp886x.txt
@@ -9,6 +9,10 @@ Required properties:
 - mps,fb-voltage-divider: An array of two integers containing the resistor
   values R1 and R2 of the feedback voltage divider in kilo ohms.
 
+Optional properties:
+- mps,switch-frequency: The valid switch frequency in Hertz. Available values
+  are: 500000, 750000, 1000000, 1250000, 1500000
+
 Any property defined as part of the core regulator binding, defined in
 ./regulator.txt, can also be used.
 
-- 
2.28.0.rc1


