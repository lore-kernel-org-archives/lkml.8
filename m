Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ADBC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20EFB20739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgGESam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:30:42 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:58297 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgGESam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:30:42 -0400
X-Originating-IP: 212.92.121.187
Received: from localhost (unknown [212.92.121.187])
        (Authenticated sender: amit@amitshah.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B06631BF20A;
        Sun,  5 Jul 2020 18:30:39 +0000 (UTC)
Date:   Sun, 5 Jul 2020 20:30:38 +0200
From:   Amit Shah <amitshah@gmx.net>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] virtio_console: Constify some static variables
Message-ID: <20200703175529.GE3150@trundl.on>
References: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
 <20200701200950.30314-6-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701200950.30314-6-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (Wed) 01 Jul 2020 [22:09:50], Rikard Falkeborn wrote:
> The id_table and feature_table pointers in struct virtio_driver are
> pointers to const. Mark the corresponding static variables const to
> allow the compiler to put them in read-only memory.
> 
> Before:
>    text    data     bss     dec     hex filename
>   25447     713      76   26236    667c drivers/char/virtio_console.o
> 
> After:
>    text    data     bss     dec     hex filename
>   25488     673      76   26237    667d drivers/char/virtio_console.o
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Amit Shah <amit@kernel.org>

Please CC me on the entire series instead of individual patches in the
future.

Thanks,

		Amit
-- 
http://amitshah.net/
