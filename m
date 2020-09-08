Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B460DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501EA20578
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="li4blghH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbgIHTnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730841AbgIHPvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:51:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED74C0619E8;
        Tue,  8 Sep 2020 08:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8CxL1yeXWkk0rJ/neykBAt+9c9WgMzIqkK/An8RJ5lA=; b=li4blghHjMxWMgVzZNqgXG914L
        MyFahmcEppP6LPBtn66ptnT4bLkkI4icTyuqWnur1tnQuBl2TVaYuRgxC6pXiSLHyu0gs3fhxk9GG
        mgzy/iuio9zJIxvxMs6RWxFos6oQ+lzcZDfatO1g8/2SV6MJzeG0tig0BIh6+A5yFUTGcRQ83UuT9
        eAuF6uFmO8hUgJQXTNBY0kVXzI5e3H7w2B7eLtS9j8I0/as+8FPvIDBALMetRTHTefmXfhFXX9d1D
        Ri9fGIx0sF2GBeT+0bU71CzlWiKmof+uZ5gk9+hxuvbPnoi22bFwZ6oNgywLTIVd4gDTyHdF2A0Ts
        SZcTckdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFfpm-0007r4-Rn; Tue, 08 Sep 2020 15:47:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C470305C16;
        Tue,  8 Sep 2020 17:47:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4757F2BE37566; Tue,  8 Sep 2020 17:47:00 +0200 (CEST)
Date:   Tue, 8 Sep 2020 17:47:00 +0200
From:   peterz@infradead.org
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 00/12] x86/platform/uv: Updates for UV5
Message-ID: <20200908154700.GW1362448@hirez.programming.kicks-ass.net>
References: <20200907185430.363197758@hpe.com>
 <20200908152014.GB4114051@kroah.com>
 <03de6a71-5fc1-98f5-3886-536c72b2761d@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03de6a71-5fc1-98f5-3886-536c72b2761d@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 08:28:16AM -0700, Mike Travis wrote:
> I didn't.  If I could figure out how to convert quilt patches into git
> commits I might be able to do that?  (And I didn't know that diffstats were
> needed on the into?)

$ git quiltimport

Or, for the more enterprising person:

$ quilt series | while read file; do git am $file; done

Generating a diffstat from a quilt series (when applied):

$ quilt diff --combine - | diffstat
