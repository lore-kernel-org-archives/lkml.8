Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8EEC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33EF2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgC3Hy5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:54:57 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:57477 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgC3Hy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:54:57 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 5A96B20000C;
        Mon, 30 Mar 2020 07:54:55 +0000 (UTC)
Date:   Mon, 30 Mar 2020 09:54:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangle6@huawei.com>, <zhangweimin12@huawei.com>,
        <yebin10@huawei.com>, <houtao1@huawei.com>
Subject: Re: [PATCH] mtd:clear cache_state to avoid writing to bad clocks
 repeatedly
Message-ID: <20200330095454.66297f84@xps13>
In-Reply-To: <1585400477-65705-1-git-send-email-nixiaoming@huawei.com>
References: <1585400477-65705-1-git-send-email-nixiaoming@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaoming,

Xiaoming Ni <nixiaoming@huawei.com> wrote on Sat, 28 Mar 2020 21:01:17
+0800:

Please also fix the title.

	"mtd: clear ..."


Thanks,
Miquèl
