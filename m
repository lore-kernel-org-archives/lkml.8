Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0218DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0AFC22B42
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgGaUsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgGaUsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:48:12 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB1821744;
        Fri, 31 Jul 2020 20:48:11 +0000 (UTC)
Date:   Fri, 31 Jul 2020 16:48:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>,
        Grant Likely <grant.likely@arm.com>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Replace custom spec to print
 decimals with generic one
Message-ID: <20200731164809.352f4b89@oasis.local.home>
In-Reply-To: <f8f423cd6afeca88cfa635f20a0b2bf85ddda3c5.camel@perches.com>
References: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
        <20200731180825.30575-2-andriy.shevchenko@linux.intel.com>
        <f8f423cd6afeca88cfa635f20a0b2bf85ddda3c5.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 11:20:21 -0700
Joe Perches <joe@perches.com> wrote:

> On Fri, 2020-07-31 at 21:08 +0300, Andy Shevchenko wrote:
> > When printing phandle via %pOFp the custom spec is used. First of all,
> > it has a SMALL flag which makes no sense for decimal numbers. Second,
> > we have already default spec for decimal numbers. Use the latter in
> > the %pOFp case as well.  
> []
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c  
> []
> > @@ -1979,12 +1979,6 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
> >  	char *buf_start = buf;
> >  	struct property *prop;
> >  	bool has_mult, pass;
> > -	static const struct printf_spec num_spec = {
> > -		.flags = SMALL,
> > -		.field_width = -1,
> > -		.precision = -1,
> > -		.base = 10,
> > -	};
> >  
> >  	struct printf_spec str_spec = spec;
> >  	str_spec.field_width = -1;
> > @@ -2024,7 +2018,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
> >  			str_spec.precision = precision;
> >  			break;
> >  		case 'p':	/* phandle */
> > -			buf = number(buf, end, (unsigned int)dn->phandle, num_spec);
> > +			buf = number(buf, end, (unsigned int)dn->phandle, default_dec_spec);  
> 
> Could changing .precision = -1 to 0 change any output?
> 

static const struct printf_spec default_dec_spec = {
	.base = 10,
	.precision = -1,
};


It's the field_width that changes from -1 to 0, which shouldn't cause
any issue.

-- Steve
