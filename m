Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD772C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04092076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgHTH7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:59:35 -0400
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:46182 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725798AbgHTH7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:59:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id F25CF181D330D;
        Thu, 20 Aug 2020 07:59:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paste48_5b144792702f
X-Filterd-Recvd-Size: 1775
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 20 Aug 2020 07:59:31 +0000 (UTC)
Message-ID: <29b6120680fbfb51936bb9100b2c9bb78385aef0.camel@perches.com>
Subject: Re: [RFC PATCH 1/5] printk: implement pr_cont_t
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 20 Aug 2020 00:59:30 -0700
In-Reply-To: <b17fc8afc8984fedb852921366190104@AcuMS.aculab.com>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
         <20200819232632.13418-2-john.ogness@linutronix.de>
         <e1e3164eabf69e04ad9e9ddc259ca685f48c5e27.camel@perches.com>
         <b17fc8afc8984fedb852921366190104@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-20 at 07:44 +0000, David Laight wrote:
> I've no idea how you'd 'size' the number of buffers.

I believe they are static and assume no more than 10
simultaneous uses of
printk_begin

+#define CONT_LINE_MAX LOG_LINE_MAX
+#define CONT_BUF_COUNT 10
+static char cont_buf[CONT_BUF_COUNT][CONT_LINE_MAX];
+static DECLARE_BITMAP(cont_buf_map, CONT_BUF_COUNT);

Though I don't see much value in a separate define
for CONT_LINE_MAx


