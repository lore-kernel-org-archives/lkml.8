Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8717AC33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE83214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgAMIaq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:30:46 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:51604 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbgAMIaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:30:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2251A6088971;
        Mon, 13 Jan 2020 09:30:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4jK4EvQWYVfE; Mon, 13 Jan 2020 09:30:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C7D506088973;
        Mon, 13 Jan 2020 09:30:44 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M1ZKNBdCt1H8; Mon, 13 Jan 2020 09:30:44 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id A2E016088971;
        Mon, 13 Jan 2020 09:30:44 +0100 (CET)
Date:   Mon, 13 Jan 2020 09:30:44 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     liu song11 <liu.song11@zte.com.cn>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        jiang xuexin <jiang.xuexin@zte.com.cn>
Message-ID: <646354604.19725.1578904244502.JavaMail.zimbra@nod.at>
In-Reply-To: <202001131616025809130@zte.com.cn>
References: <20191216154441.6648-1-fishland@aliyun.com,202001131229371470661@zte.com.cn,1681702500.19692.1578902048331.JavaMail.zimbra@nod.at> <202001131616025809130@zte.com.cn>
Subject: Re: [PATCH] ubifs: Fix potentially out-of-bounds memory access
 inubifs_dump_node
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Fix potentially out-of-bounds memory access inubifs_dump_node
Thread-Index: wsuu19fXf87wL8iNmMhS98osXESf9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Although this will change a bit more, but the function of dumping data is
> retained,
> I will modify it as suggested and try to submit a patch, thanks.

Sure but the most common and important case is good then.
in fs/ubifs/file.c we use a fixed buffer size of UBIFS_MAX_DATA_NODE_SZ
to deal with data nodes. So, dumping is safe.

If we don't know the buffer size for minor cases, not a big deal.
Still better than giving up the feature completely.

Thanks,
//richard
