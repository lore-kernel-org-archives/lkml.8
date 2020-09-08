Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4427C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B539A2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgIHWWm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:22:42 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59330 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgIHWWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 18:22:35 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CDA7D1C0B7A; Wed,  9 Sep 2020 00:22:33 +0200 (CEST)
Date:   Wed, 9 Sep 2020 00:22:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, dmurphy@ti.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v3 2/2] dt-bindings: leds: Add bindings for MT6360 LED
Message-ID: <20200908222232.GB1005@bug>
References: <1599474459-20853-1-git-send-email-gene.chen.richtek@gmail.com>
 <1599474459-20853-3-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1599474459-20853-3-git-send-email-gene.chen.richtek@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add bindings document for LED support on MT6360 PMIC
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>

Put this first in the series.

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
