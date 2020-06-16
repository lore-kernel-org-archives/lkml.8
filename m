Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F462C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A97208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oaSrhANL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgFPOpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFPOpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:45:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B76C061573;
        Tue, 16 Jun 2020 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+yV+Dbk3lnMuNQTcQ3eMoTUMqZiA/J2slyl5cLnxR+4=; b=oaSrhANLLk793Z15Ecu/uyXpsH
        66v5XxwkcpHckFVhA8sX6zFuoAi7kHOA+oCbMezmNS/YYQ9yI37h5TnYmSrc33PWsy5RW2qbVk7MD
        2AT02slLZB3b8MuW3reClxvCa7sznzQDizrxU+BjduLfZJ36hs7Byzqcbbos94yg7bUlOQxZjIYEJ
        EaGFD3svUUnisvxrvtDTxz+hRqmuXod9JsZjG5/W7BHQzMuIDaeBAuvVIqw8PwsHxxTlFulrj0kmS
        yn6iZpdMW5ZdR7eK5CnL8fu3WZy+zr/ummPjenxpzSNhvhfbq4HNKQZID43hJyiOuAyBK8bkA0g+i
        UZgG/dpw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlCqY-0005fa-7R; Tue, 16 Jun 2020 14:45:54 +0000
Date:   Tue, 16 Jun 2020 07:45:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Tetsuhiro Kohada <kohada.t2@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>,
        Takahiro Mori <Mori.Takahiro@ab.mitsubishielectric.co.jp>,
        Hirotaka Motai <Motai.Hirotaka@aj.mitsubishielectric.co.jp>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] exfat: remove EXFAT_SB_DIRTY flag
Message-ID: <20200616144554.GA8681@bombadil.infradead.org>
References: <a63b3032-a8e7-f1fe-d4de-1cee4be54a9a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63b3032-a8e7-f1fe-d4de-1cee4be54a9a@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 08:16:55AM +0200, Markus Elfring wrote:
> > remove EXFAT_SB_DIRTY flag and related codes.
> 
> I propose to omit this sentence because a similar information
> is provided a bit later again for this change description.

Please stop.
