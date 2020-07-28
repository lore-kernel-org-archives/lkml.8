Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0115C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D3520672
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgG1CWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:22:22 -0400
Received: from smtprelay0216.hostedemail.com ([216.40.44.216]:56242 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726269AbgG1CWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:22:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 4FAB2181D330D;
        Tue, 28 Jul 2020 02:22:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: anger93_0e0cfdb26f66
X-Filterd-Recvd-Size: 2213
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Jul 2020 02:22:19 +0000 (UTC)
Message-ID: <ae54364041b99b89f818812d957d4a4bb4efdc25.camel@perches.com>
Subject: Re: [PATCH][next] ACPICA: Use fallthrough pseudo-keyword
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Jul 2020 19:22:18 -0700
In-Reply-To: <b851b2c8-2d7c-939d-507d-b322dd4a0dbf@embeddedor.com>
References: <20200707200716.GA4920@embeddedor>
         <CAJZ5v0iDz_EsrpdMQQDfaVC2orMQkEcubmR6-J6mvtrXmKXbRg@mail.gmail.com>
         <BYAPR11MB325602EDA2D2ACC2B28EAF4687670@BYAPR11MB3256.namprd11.prod.outlook.com>
         <b851b2c8-2d7c-939d-507d-b322dd4a0dbf@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-27 at 17:23 -0500, Gustavo A. R. Silva wrote:
> Hi,
> 
> 
> This is a macro pseudo-keyword, which expands to /* fallthrough */
> for compilers that don't support the attribute __fallthrough__. See:

Not really.

It expands to
	do {} while (0)
for compilers that do not support the __fallthrough__ attribute.

The /* fallthrough */ after that is for the human reader
and is stripped before compilation.

> include/linux/compiler_attributes.h:213:
> 213 #if __has_attribute(__fallthrough__)
> 214 # define fallthrough                    __attribute__((__fallthrough__))
> 215 #else
> 216 # define fallthrough                    do {} while (0)  /* fallthrough */
> 217 #endif
> 
> So, any compiler (older or new) will be fine with it.

But old compilers should not emit warnings for these uses.


