Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423DDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1053D20724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A6XkrfUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgHTKyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbgHTKxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:53:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79B0C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2XSx4viBFbJgOBV8yT1eTUmZXgBSR5PRDZ/vc6Xsztk=; b=A6XkrfUyczaG2gRtYRVA9qaLEa
        mui6hOulro1g2Y5BfTw/FEAU/arMhynrfMmhFzQubn2YNSI5Gg0uUd5qE/giIPqhUiC0pX1CodiB+
        prd0Jye9c0grjBneKHVdswbT2CCqw4iHHt2HyZAsWRjGQ0Wvg4G0JxDHmyV/aCvnjhJqa2O9GITR5
        Tj6Ut5jVxES3xFyXV89CFc1Or8pGixRKurgNZMjFKipuaxpoNhGcdnZu1khhqcrb0E+wMVo10SgMZ
        rUB9wSaLbWI6TGi9Nl44UErGQMOxVgilmqStx5lQ+s2aSttVFPuy5rAxYVlpvw/gHxcimESYKwPso
        TsHxx3fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8iBU-0007Xv-VS; Thu, 20 Aug 2020 10:52:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 561BF302526;
        Thu, 20 Aug 2020 12:52:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 37DC42C38827A; Thu, 20 Aug 2020 12:52:36 +0200 (CEST)
Message-ID: <20200820103832.486877479@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Aug 2020 12:38:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 0/7] x86/debug: Untangle handle_debug()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

handle_debug() is a mess, and now that we have separate user and kernel paths,
try and clean it up.

Included amluto's fix for convenience.

The whole set passes x86-selftests and the RR DR0 testcase.

