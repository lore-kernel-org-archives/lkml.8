Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706CEC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558862076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbgEXWGt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 18:06:49 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:59027 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388407AbgEXWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:06:49 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A0AD8100004;
        Sun, 24 May 2020 22:06:44 +0000 (UTC)
Date:   Mon, 25 May 2020 00:06:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc:     "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "kdasu.kdev@gmail.com" <kdasu.kdev@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH v4 4/5] dt: bindings: brcmnand: add v2.1 and v2.2
 support
Message-ID: <20200525000643.4ed45a73@xps13>
In-Reply-To: <DB7PR03MB4604C2B50C013033D0CB95F8F5B20@DB7PR03MB4604.eurprd03.prod.outlook.com>
References: <20200522121524.4161539-5-noltari@gmail.com>
        <20200524192550.4559-1-miquel.raynal@bootlin.com>
        <20200524212740.08c2810f@xps13>
        <DB7PR03MB4604C2B50C013033D0CB95F8F5B20@DB7PR03MB4604.eurprd03.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Álvaro Fernández Rojas <noltari@gmail.com> wrote on Sun, 24 May 2020
21:13:41 +0000:

> Thanks for merging the patches :).
> 
> BTW, is there something wrong with patch 5?
> I can see patches 1-4 applied in https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/log/?h=nand/next, but I can’t see patch 5.
> 

Done :)
