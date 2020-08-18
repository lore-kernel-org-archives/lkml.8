Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17F6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E1F2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHRIH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:07:26 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:39342 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbgHRIHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:07:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0E7CE1277;
        Tue, 18 Aug 2020 08:07:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: talk96_520c0712701d
X-Filterd-Recvd-Size: 1995
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Aug 2020 08:07:18 +0000 (UTC)
Message-ID: <f9803189e589cc719fc9a561003317a81d2da07e.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add --kconfig-prefix
From:   Joe Perches <joe@perches.com>
To:     Jerome Forissier <jerome@forissier.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 18 Aug 2020 01:07:17 -0700
In-Reply-To: <266350d9-c770-6a29-b784-46de2b005e39@forissier.org>
References: <20200817095056.31001-1-jerome@forissier.org>
         <20200818074349.726778-1-jerome@forissier.org>
         <266350d9-c770-6a29-b784-46de2b005e39@forissier.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-18 at 09:50 +0200, Jerome Forissier wrote:
> 
> On 8/18/20 9:43 AM, Jerome Forissier wrote:
> > Kconfig allows to customize the CONFIG_ prefix via the $CONFIG_
> > environment variable. Out-of-tree projects may therefore use Kconfig
> > with a different prefix, or they may use a custom configuration tool
> > which does not use the CONFIG_ prefix at all. Such projects may still
> > want to adhere to the Linux kernel coding style and run checkpatch.pl.
> > 
> > One example is OP-TEE [1] which does not use Kconfig but does have
> > configuration options prefixed with CFG_. It also mostly follows the
> > kernel coding style and therefore being able to use checkpatch is quite
> > valuable.
> > 
> > To make this possible, add the --kconfig-prefix command line option.
> 
> (Oh I forgot to add the link here :-/ sorry about that. Let me know if
> you want me to resend.)
> 
> [1] https://github.com/OP-TEE/optee_os

It's probably not important enough to bother.
A trivial search on "OP-TEE" works.
So I think it's fine, but if you feel like it,
go ahead.

Joe


