Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB31C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0051920674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgHQDWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 23:22:21 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:48844 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbgHQDWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 23:22:21 -0400
Received: from localhost (unknown [159.226.5.99])
        by APP-03 (Coremail) with SMTP id rQCowACHzEjR8Dlfw6_aAg--.62973S2;
        Mon, 17 Aug 2020 10:52:01 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu
Cc:     linux-kernel@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>
Subject: [PATCH] upcall: Remove unneeded variable insize
Date:   Mon, 17 Aug 2020 02:51:45 +0000
Message-Id: <20200817025145.10009-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowACHzEjR8Dlfw6_aAg--.62973S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYw7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87
        Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUk5rcUUUUU=
X-Originating-IP: [159.226.5.99]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCAELA18J9krv4wAAsn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded variable insize in venus_pioctl().

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 fs/coda/upcall.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index eb3b1898da46..903bd7a4ee16 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -477,10 +477,9 @@ int venus_pioctl(struct super_block *sb, struct CodaFid *fid,
 {
         union inputArgs *inp;
         union outputArgs *outp;  
-	int insize, outsize, error;
+	int outsize, error;
 	int iocsize;
 
-	insize = VC_MAXMSGSIZE;
 	UPARG(CODA_IOCTL);
 
         /* build packet for Venus */
-- 
2.17.1

