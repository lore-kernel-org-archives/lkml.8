Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B00BC0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DBD20578
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HIShHKke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbgCLC3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:29:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387608AbgCLC3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Jj6L8vIcZ93mZ6eanG7loVD291lPrGo+W34O45vAww=; b=HIShHKkeQH+3yNOsaYMjZBAn0o
        LxgYzRbK8kN8tAOUHcRHX18tSVWlTb9yexsxk+5sDZic+MpENzPUMWEFl6V9UvvkEp3W+7AcVF4w+
        /g1YlvOU/R+R594ghg5lUax6xjXiX5FsG4j0slA/7V7o2Xkyt8vrcjuG/PVZSTaQ4qWiH5qYgen2+
        VgjPRy36KC55yPk5/d2IO89IvCf/1j7Ao9o/OPxwvZBOjS636jziQ3KRGgBjLfxCgHrV++XGKGbHP
        uSD4Qe+ER5RmV1cKeWvM9ink9+Pj2V86+AwKqcvP7QgXK6UJhuxpyR1ej5QiSoELlwlF2JlDLPBOF
        jkDrc7eg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCDbZ-000361-13; Thu, 12 Mar 2020 02:29:49 +0000
Date:   Wed, 11 Mar 2020 19:29:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jules Irenge <jbi.octave@gmail.com>, boqun.feng@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] backing-dev: refactor wb_congested_put()
Message-ID: <20200312022948.GH22433@bombadil.infradead.org>
References: <20200312002156.49023-1-jbi.octave@gmail.com>
 <20200312002156.49023-2-jbi.octave@gmail.com>
 <20200311175919.30523d55b2e5307ba22bbdc0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311175919.30523d55b2e5307ba22bbdc0@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 05:59:19PM -0700, Andrew Morton wrote:
> hm, it's hard to get excited over this.  Open-coding the
> refcount_dec_and_lock_irqsave() internals at a callsite in order to
> make sparse happy.
> 
> Is there some other way, using __acquires (for example)?

sparse is really bad at conditional lock acquisition.  we have similar
problems over the vfs.  but we shouldn't be obfuscating our code to make
the tool happy.
