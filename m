Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C7FC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8409D24649
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgAMHyM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:54:12 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:51044 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgAMHyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 02:54:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3D7D56088971;
        Mon, 13 Jan 2020 08:54:09 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TUaezdVo-5cL; Mon, 13 Jan 2020 08:54:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BF4B8608310A;
        Mon, 13 Jan 2020 08:54:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0HgxGEBIOJfD; Mon, 13 Jan 2020 08:54:08 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6D7DB6088971;
        Mon, 13 Jan 2020 08:54:08 +0100 (CET)
Date:   Mon, 13 Jan 2020 08:54:08 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     liu song11 <liu.song11@zte.com.cn>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        jiang xuexin <jiang.xuexin@zte.com.cn>
Message-ID: <1681702500.19692.1578902048331.JavaMail.zimbra@nod.at>
In-Reply-To: <202001131229371470661@zte.com.cn>
References: <20191216154441.6648-1-fishland@aliyun.com,CAFLxGvyU=zh23vkYiAGRzyd4LGJodLwRRa1S03THAoSaSL=dGA@mail.gmail.com> <202001131229371470661@zte.com.cn>
Subject: Re: [PATCH] ubifs: Fix potentially out-of-bounds memory access in
 ubifs_dump_node
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Fix potentially out-of-bounds memory access in ubifs_dump_node
Thread-Index: U75eDtes0zTxvtUwzHGII2MO4QYnug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Problems with storage devices are indeed a problem, But because the wrong
> "ch->len" causes the kernel to crash, this cost is too heavy. We should
> avoid kernel crashes due to such errors.
> 
> 
> Although a crc error was found in "ubifs_check_node", it is difficult to
> simply judge whether "ch->len" is reasonable, so I think we only need to know
> the _location_ of the error data node, and it is not necessary to present its
> contents together.

What we can try is optionally passing the buffer length to ubifs_dump_node().
If crc is bad but ch->len is within bounds we can still safely dump.

Thanks,
//richard
