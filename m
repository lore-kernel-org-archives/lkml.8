Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE1DC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE96246B9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCBEcM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:32:12 -0500
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:43076 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgCBEcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:32:11 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 0224VLkZ026820; Mon, 2 Mar 2020 13:31:21 +0900
X-Iguazu-Qid: 34tMS0bDK47Se8YtgA
X-Iguazu-QSIG: v=2; s=0; t=1583123481; q=34tMS0bDK47Se8YtgA; m=V2/eAlm3BqBCqan/3t+LPaiW6760SY8Xqa/I/6MJDOE=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1511) id 0224VJbL003938;
        Mon, 2 Mar 2020 13:31:19 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 0224VJj7020887;
        Mon, 2 Mar 2020 13:31:19 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 0224VIFS022182;
        Mon, 2 Mar 2020 13:31:18 +0900
From:   <masahiro31.yamada@kioxia.com>
To:     <hch@infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme: fix NVME_IOCTL_SUBMIT_IO for compat_ioctl
Thread-Topic: [PATCH] nvme: fix NVME_IOCTL_SUBMIT_IO for compat_ioctl
Thread-Index: AdXuGMxvHgc8BpX4QzmU2g6f3T18FAAzhnOAAFjp0yA=
Date:   Mon, 2 Mar 2020 04:31:17 +0000
X-TSB-HOP: ON
Message-ID: <b30b0bf2864444989f5a4e70eafbe6b8@TGXML281.toshiba.local>
References: <2caa4c913579464bbfdf06b36001ffc9@TGXML281.toshiba.local>
 <20200229185915.GB5698@infradead.org>
In-Reply-To: <20200229185915.GB5698@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [133.118.177.171]
msscp.transfermailtomossagent: 103
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>We can't just change the existing structure, instead we'll need
>a compat handler for the 32-bit x86 case.

Thank you for your comment.
OK. I'll recreate this patch which adds a handler for compat_ioctl,
not to change the existing structure.
