Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A583C2BBD0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1192420767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AQFYevxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgIBQ5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBQ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:57:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDC5C061244;
        Wed,  2 Sep 2020 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kt6lC69jtDUmQkH0re64HecwS3W6LIg6JZ3PvsNLKNU=; b=AQFYevxzS8D2m7F+nkGeA+e6rQ
        OWV0LQ1lhehxooqel3ozGpK8vlogIUig7Q3fhC5CcDYVR4ps9AOIE9xXUzTlRgdViUff/9yVarO8D
        WJIaYB8Pb2ZxWb+RkwTP9IoTP3FzVVrYXI0qmrLvzRms5zvdkbL3hwEzLvfUh5KGtR9XgwpCRJiwj
        MhkGZtBulygSqCQLSUzBPDpsIrGZgisp6+13I6g0Io2tPWtQt1ef3JN/b1B06hRpNmkd7Gz9CjZPt
        N4w2tR5O+sWvoOhmO0SCMITRmPHQIJtjX5h5cdCh7SPHrnUFmtqFIhkKVCJS3aQkN/vjslcll4WmB
        h7Iznk+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDW44-0000XA-Sd; Wed, 02 Sep 2020 16:56:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44F563011C6;
        Wed,  2 Sep 2020 18:56:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E72E2B997071; Wed,  2 Sep 2020 18:56:52 +0200 (CEST)
Date:   Wed, 2 Sep 2020 18:56:52 +0200
From:   peterz@infradead.org
To:     Nadav Amit <namit@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/special_insn: reverse __force_order logic
Message-ID: <20200902165652.GO1362448@hirez.programming.kicks-ass.net>
References: <20200901161857.566142-1-namit@vmware.com>
 <20200902125402.GG1362448@hirez.programming.kicks-ass.net>
 <1E3FD845-E71A-4518-A0BF-FAD31CBC3E28@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1E3FD845-E71A-4518-A0BF-FAD31CBC3E28@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:32:18PM +0000, Nadav Amit wrote:

> Thanks for pointer. I did not see the discussion, and embarrassingly, I have
> also never figured out how to reply on lkml emails without registering to
> lkml.

The lore.kernel.org thing I pointed you to allows you to download an
mbox with the email in (see the very bottom of the page). Use your
favorite MUA to open it and reply :-)
