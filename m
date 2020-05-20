Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9A9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A63320758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgETUu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgETUuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:50:55 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A23C061A0E;
        Wed, 20 May 2020 13:50:55 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jbVfh-00Cb7J-QP; Wed, 20 May 2020 20:50:37 +0000
Date:   Wed, 20 May 2020 21:50:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, vkuznets@redhat.com,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 22/24] uaccess: add memzero_user
Message-ID: <20200520205037.GB23230@ZenIV.linux.org.uk>
References: <20200520172145.23284-1-pbonzini@redhat.com>
 <20200520172145.23284-23-pbonzini@redhat.com>
 <20200520204036.GA1335@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520204036.GA1335@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 01:40:36PM -0700, Christoph Hellwig wrote:
> On Wed, May 20, 2020 at 01:21:43PM -0400, Paolo Bonzini wrote:
> > +			unsafe_put_user(val, (unsigned long __user *) from, err_fault);
> 
> This adds a way too long line.  In many ways it would be much nicer if
> you used an unsigned long __user * variable internally, a that would
> remove all these crazy casts and actually make the code readable.

Er...  what's wrong with clear_user(), anyway?
