Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845F9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F9820823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Avl/i8C4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgETUkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgETUkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:40:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEFFC061A0E;
        Wed, 20 May 2020 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y/KWCW/p6UEY0CE3GxluJHgj+NYN+hDzrTZTbCbfJ9E=; b=Avl/i8C4AYLClzRSFSxL0oNff2
        XckOGyx31b3U6eEb2mQPp9GnLvH7RYKCyJgKvMttSoafE4cmW/2tnQmWlado1W+ZEawITGDu+SSeq
        Yak6ru0HJEDPKYadBn+h7IOMEm83fDqZFcrTyE5Om37fMFtEIQCjbDeMFyvYJ5lTG4AjF4Wf18tZT
        qLaFcJC507IH4Lqqqu74m3TElJ7gYqoijxASzWjS/hDEonDVRchiWEO0GHXBIByO6ayqp1DAVCc0r
        ZG+7f04CuLMxa4nPioRXMpHOiyOzs+Wnk9Bi6AUKc64sRbi/bmNiSEZUM8li3ZIYgc+cRIVCSVRsu
        NYhyHoTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbVW0-0003wE-Fg; Wed, 20 May 2020 20:40:36 +0000
Date:   Wed, 20 May 2020 13:40:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 22/24] uaccess: add memzero_user
Message-ID: <20200520204036.GA1335@infradead.org>
References: <20200520172145.23284-1-pbonzini@redhat.com>
 <20200520172145.23284-23-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520172145.23284-23-pbonzini@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 01:21:43PM -0400, Paolo Bonzini wrote:
> +			unsafe_put_user(val, (unsigned long __user *) from, err_fault);

This adds a way too long line.  In many ways it would be much nicer if
you used an unsigned long __user * variable internally, a that would
remove all these crazy casts and actually make the code readable.
