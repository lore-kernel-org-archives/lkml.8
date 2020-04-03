Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596EDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBAD2063A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbgDCEfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:35:33 -0400
Received: from smtprelay0131.hostedemail.com ([216.40.44.131]:33954 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbgDCEfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:35:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DF844182CED5B;
        Fri,  3 Apr 2020 04:35:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: seed33_4d3b0b285b054
X-Filterd-Recvd-Size: 1327
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Apr 2020 04:35:30 +0000 (UTC)
Message-ID: <d74075e94b39b23d2e3acb24baaaedacfd0cc426.camel@perches.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: emxx_udc: Remove unused code
From:   Joe Perches <joe@perches.com>
To:     "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Apr 2020 21:33:34 -0700
In-Reply-To: <4bd376a6db77ef779972f377cc2c3789d03668e7.camel@gmail.com>
References: <20200402021706.788533-1-jbwyatt4@gmail.com>
         <20200403015057.7a972c79@elisabeth>
         <4bd376a6db77ef779972f377cc2c3789d03668e7.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-02 at 18:42 -0700, John B. Wyatt IV wrote:
> DEBUG is not actually used as far as I can tell (I am still new to
> kernel debugging systems to please correct me).

DEBUG is used by the <foo>_debug and <bar>_dbg macros
(pr_debug, dev_dbg)



