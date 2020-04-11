Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1F9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 10:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D75020787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 10:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgDKKTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 06:19:09 -0400
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:60856 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725951AbgDKKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 06:19:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C797118224D6B;
        Sat, 11 Apr 2020 10:19:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: alley38_32a60c789110b
X-Filterd-Recvd-Size: 1745
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Apr 2020 10:19:07 +0000 (UTC)
Message-ID: <159680bb287fc43bb2129d3b731e15931bd9979c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Date:   Sat, 11 Apr 2020 03:17:03 -0700
In-Reply-To: <26b49cf5-453b-9a81-b045-fdc99c42fcf8@wanadoo.fr>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
         <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
         <6e52383e-100d-b016-32c2-6fb54938b6fe@wanadoo.fr>
         <c9fd4bc75812fed4799c2fb87b452b809a7e9a7a.camel@perches.com>
         <db2730700ab3eb7008413a1e7bba94ca7c49a031.camel@perches.com>
         <26b49cf5-453b-9a81-b045-fdc99c42fcf8@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-04-11 at 09:12 +0200, Christophe JAILLET wrote:
> 	./scripts/checkpatch.pl -f drivers/soc/kendryte/k210-sysctl.c
> 
> is missing line 189, even if it looks like a construction correctly spotted in some other files:
> 	if (foo) {
> 		dev_err(...);
> 		...
> 	};

Hi Christophe, many thanks for doing more testing

Are you sure about this one?  I get:

$ ./scripts/checkpatch.pl -f drivers/soc/kendryte/k210-sysctl.c
WARNING: Possible missing '\n' at the end of a logging message format string
#189: FILE: drivers/soc/kendryte/k210-sysctl.c:189:
+		dev_err(&pdev->dev, "failed to register clk");


