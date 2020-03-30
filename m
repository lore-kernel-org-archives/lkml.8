Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5BFC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E40206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgC3ChS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:37:18 -0400
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:56806 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728202AbgC3ChS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:37:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7D4E8180A8CA9;
        Mon, 30 Mar 2020 02:37:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: event23_79c1558705c46
X-Filterd-Recvd-Size: 1860
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 30 Mar 2020 02:37:16 +0000 (UTC)
Message-ID: <f53fdf2283e1c847a4c44ea7bea4cb6600c06991.camel@perches.com>
Subject: re: commit  23cb8490c0d3 ("MAINTAINERS: fix bad file pattern")
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 29 Mar 2020 19:35:22 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   MAINTAINERS: fix bad file pattern
    
    Testing 'parse-maintainers' due to the previous commit shows a bad file
    pattern for the "TI VPE/CAL DRIVERS" entry in the MAINTAINERS file.
    
    There's also a lot of mis-ordered entries, but I'm still a bit nervous
    about the inevitable and annoying merge problems it would probably cause
    to fix them up.
    
    The MAINTAINERS file is one of my least favorite files due to being huge
    and centralized, but fixing it is also horribly painful for that reason.

The identical commit was sent at least twice.
Once directly to you.

https://patchwork.kernel.org/patch/11361131/
https://lore.kernel.org/linux-media/20200128145828.74161-1-andriy.shevchenko@linux.intel.com/


About the pain associated to fixing the file:
I think it would be minimally painful to run

$ ./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order

Immediately before an -rc1 is released.

Relatively few of any pending patches to MAINTAINERS
in -next would be impacted and there would be better
consistency in the silly file.


