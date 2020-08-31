Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6179C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80BA2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHaMAj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:00:39 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:6009 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHaMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:00:37 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 879F3240011;
        Mon, 31 Aug 2020 12:00:33 +0000 (UTC)
Date:   Mon, 31 Aug 2020 14:00:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     James Bond <jameslouisebond@gmail.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ryan Jackson <rjackson@lnxi.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: ck804xrom: fix missing pci device put in error
 paths
Message-ID: <20200831140032.0fd355f6@xps13>
In-Reply-To: <CAPKyc-si2e2-9RDgLBO4Ox0wX5fr+NjSM_Noih_Pay+trNzndQ@mail.gmail.com>
References: <20200821070537.30317-1-jameslouisebond@gmail.com>
        <20200827144600.2ec7c4ab@xps13>
        <CAPKyc-si2e2-9RDgLBO4Ox0wX5fr+NjSM_Noih_Pay+trNzndQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

James Bond <jameslouisebond@gmail.com> wrote on Fri, 28 Aug 2020
21:28:40 -0500:

> Hi Miquèl,
> Thanks for your feedback.
> I have just rechecked this function and find that "pdev" currently is
> already put
> inside ck804xrom_cleanup, so my previous patch is meaningless...
> The current calling order is like:
> 
> window->pdev = pci_dev_get(pdev);
> ...
>     ck804xrom_cleanup(window)
>              ->  
>                   pci_dev_put(window->pdev);
> And sorry for bothering you.

Ok that's fine, thanks anyway!

Miquèl
