Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D462C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD7E2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BICrE1Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgFONRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:17:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729977AbgFONRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592227032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4Vkr71sMpCKYfAqOH3x/hoo6l2InpZflnB1ZSR/dAQ=;
        b=BICrE1Q/ZokH4IRkV7RZQH24oJRrDXNR06WsG2p4hQNJSobg5Z/NBK70ryEJW9X4I9bIF7
        LIHJKEpNi6M4yFCc8ChlsfZ6GfB+ENYosQO/Ln56qmMRf18GbIVM5ENbLK03gfH6lt24wy
        fbNSqYmrQRFsyJ9d6zdK9y43Ynpo6Zo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-HmND-qegOramLBGTlAtNyg-1; Mon, 15 Jun 2020 09:17:08 -0400
X-MC-Unique: HmND-qegOramLBGTlAtNyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBCB688FCE6;
        Mon, 15 Jun 2020 13:16:25 +0000 (UTC)
Received: from localhost (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC07D7CAA5;
        Mon, 15 Jun 2020 13:16:23 +0000 (UTC)
Date:   Mon, 15 Jun 2020 15:16:20 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bitmap: Add test for bitmap_cut()
Message-ID: <20200615151620.1ed53079@redhat.com>
In-Reply-To: <20200615114353.GY2428291@smile.fi.intel.com>
References: <cover.1592155364.git.sbrivio@redhat.com>
        <5fc45e6bbd4fa837cd9577f8a0c1d639df90a4ce.1592155364.git.sbrivio@redhat.com>
        <20200615094155.GQ2428291@smile.fi.intel.com>
        <20200615094616.GS2428291@smile.fi.intel.com>
        <20200615130825.60283f1b@redhat.com>
        <20200615114353.GY2428291@smile.fi.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 14:43:53 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Jun 15, 2020 at 01:08:25PM +0200, Stefano Brivio wrote:
> >   
> > [...]
> >   
> > By the way, tests for 'parse', 'parse_user' and 'parselist' report
> > issues:  
> 
> I believe this [1] will fix it.
> 
> [1]: 81c4f4d924d5 ("lib: fix bitmap_parse() on 64-bit big endian archs")

Yes, thanks, that works for me too.

-- 
Stefano

