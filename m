Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C30C4347E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55E722D02
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ns3KKIZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgHFJUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgHFJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:18:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB3BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LGsolx+q4+pRQwaFegj0pZt825v+uaehpXLibfoN7qg=; b=Ns3KKIZDE6iGgMooNVVQ63I1br
        CvPi4fQkVVaIqdaadNEcdq5e/qP0sFb+t7e7CxNw088wxUDhKLm0p07hCuJGdrAGGqArmBx3z+bcJ
        XAvI8FNyeJOKqNSXUOHdyXSYxUg6XuIVnKb6IMunukKE/jeTy9iKElJdtoyUUk6W3Kaj1ukYnZE9M
        UMqYPPJHj4IxUeNE6DnokltXo2FBVwg0LhQRzaOHrAkSzlN8ICB9ytGWeBT56i8nx35AsTjrmPfCe
        eN2klwLsvDa2jdXush1PsPISlab9rjivhBUdiBnclY6XsfOdaYiIMuAamMjrQkst0K9boxWwrfnlm
        a57pVYTg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3c2A-0000FS-J5; Thu, 06 Aug 2020 09:17:58 +0000
Date:   Thu, 6 Aug 2020 10:17:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/3] powerpc/uaccess: simplify the get_fs() set_fs()
 logic
Message-ID: <20200806091758.GA653@infradead.org>
References: <a6e62627d25fb7ae9b91d8bf553e707689e37498.1596702117.git.christophe.leroy@csgroup.eu>
 <cf39cb8e42cffe323393b8cecdc59a7230298eab.1596702117.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf39cb8e42cffe323393b8cecdc59a7230298eab.1596702117.git.christophe.leroy@csgroup.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you urgently need this?  My plan for 5.10 is to rebased and submit
the remaining bits of this branch:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/set_fs-removal

which will kill off set_fs/get_fs entirely.
