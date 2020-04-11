Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22AFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB472075E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgDKQpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 12:45:47 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:36892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726124AbgDKQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 12:45:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 7B64F182CCCD1;
        Sat, 11 Apr 2020 16:45:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: swing79_4f67ea8b28904
X-Filterd-Recvd-Size: 1213
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Apr 2020 16:45:45 +0000 (UTC)
Message-ID: <af4673918a3f6bfba51118d68d554d4a1ff3dad4.camel@perches.com>
Subject: Request to sort MAINTAINERS again just before an -rc1 release
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 11 Apr 2020 09:43:40 -0700
In-Reply-To: <f53fdf2283e1c847a4c44ea7bea4cb6600c06991.camel@perches.com>
References: <f53fdf2283e1c847a4c44ea7bea4cb6600c06991.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider running and committing:

$ ./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order

Immediately before any upcoming -rc1 is released.

Relatively few of any pending patches to MAINTAINERS
in -next would be impacted and there would be better
consistency in the file.

Thanks.

