Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76653C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 11:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DAA20848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 11:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgAKLeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 06:34:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:50325 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729006AbgAKLeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 06:34:18 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 00BBXTQb023225;
        Sat, 11 Jan 2020 05:33:29 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 00BBXSxW023224;
        Sat, 11 Jan 2020 05:33:28 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 11 Jan 2020 05:33:28 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, arnd@arndb.de,
        tglx@linutronix.de, vincenzo.frascino@arm.com, luto@kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org
Subject: Re: Surprising code generated for vdso_read_begin()
Message-ID: <20200111113328.GX3191@gate.crashing.org>
References: <cover.1577111363.git.christophe.leroy@c-s.fr> <bd4557a7-9715-59aa-5d8e-488c5e516a98@c-s.fr> <20200109200733.GS3191@gate.crashing.org> <77a8bf25-6615-6c0a-56d4-eae7aa8a8f09@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77a8bf25-6615-6c0a-56d4-eae7aa8a8f09@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 07:45:44AM +0100, Christophe Leroy wrote:
> Le 09/01/2020 à 21:07, Segher Boessenkool a écrit :
> >It looks like the compiler did loop peeling.  What GCC version is this?
> >Please try current trunk (to become GCC 10), or at least GCC 9?
> 
> It is with GCC 5.5
> 
> https://mirrors.edge.kernel.org/pub/tools/crosstool/ doesn't have more 
> recent than 8.1

Arnd, can you update the tools?  We are at 8.3 and 9.2 now :-)  Or is
this hard and/or painful to do?

> With 8.1, the problem doesn't show up.

Good to hear that.  Hrm, I wonder when it was fixed...


Segher
