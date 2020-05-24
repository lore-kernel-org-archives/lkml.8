Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD27BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 13:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A42207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 13:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1+lv9Ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgEXNY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 09:24:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20049 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbgEXNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 09:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590326695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mHMPPRddlUGNjBweR3B9I+Hv0QjW0kgzgCw5Ey9i/ZI=;
        b=P1+lv9Ik0fcPvXPvVICTkKkmeJf/huBfopzTqgU2MUyPWi00i84y2/MOOB80YF7feQtHRY
        3Kc2e8qvtvVKDTEDnVnx8iRo1G5FudghsQpFRRQV6l6dE1Ky3QkKPONYI9ABNImE6UFKef
        cLRAI0sw2Jhiu52tM6p7DLYtt4VAzvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-vD-2LxgjNv6H1i3KD-_uTA-1; Sun, 24 May 2020 09:24:53 -0400
X-MC-Unique: vD-2LxgjNv6H1i3KD-_uTA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED27F460;
        Sun, 24 May 2020 13:24:51 +0000 (UTC)
Received: from elisabeth (unknown [10.36.110.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 646FA5C1B2;
        Sun, 24 May 2020 13:24:49 +0000 (UTC)
Date:   Sun, 24 May 2020 15:24:36 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bitmap: rework bitmap_cut()
Message-ID: <20200524152350.0192a835@elisabeth>
In-Reply-To: <20200307140739.GA31182@yury-thinkpad>
References: <20200306221423.18631-1-yury.norov@gmail.com>
        <20200307143341.5497e7ee@elisabeth>
        <20200307140739.GA31182@yury-thinkpad>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

On Sat, 7 Mar 2020 06:07:39 -0800
Yury Norov <yury.norov@gmail.com> wrote:

> On Sat, Mar 07, 2020 at 02:33:41PM +0100, Stefano Brivio wrote:
> >
> > [...]
> >
> > ...which means it would be a good idea to also add tests for numbers of
> > bits that are not multiple of eight, and single bits too.  
> 
> OK, I will look at this and send v2

Meanwhile, I could send the simple version of the fix I proposed for the
hypothetical partial overlapping issue you reported, and add this test,
recycling parts of the tests you already shared, if you agree. Just let
me know.

-- 
Stefano

