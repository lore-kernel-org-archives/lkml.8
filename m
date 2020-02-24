Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE034C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9682072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgBXOPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:15:03 -0500
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:38336 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727489AbgBXOPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:15:03 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 070C1837F27E;
        Mon, 24 Feb 2020 14:15:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: owner35_6600d9892995f
X-Filterd-Recvd-Size: 4636
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Feb 2020 14:15:00 +0000 (UTC)
Message-ID: <8c458c189abb45fb3021f7882a40d28a24cc662d.camel@perches.com>
Subject: Re: [PATCH] staging: wfx: match parentheses alignment
From:   Joe Perches <joe@perches.com>
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Feb 2020 06:13:32 -0800
In-Reply-To: <20200223193201.GA20843@kaaira-HP-Pavilion-Notebook>
References: <20200223193201.GA20843@kaaira-HP-Pavilion-Notebook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-24 at 01:02 +0530, Kaaira Gupta wrote:
> match next line with open parentheses by giving appropriate tabs.

This patch is only for data_tx.c

There are many more parentheses that are not aligned
in staging/wfx in other files.

Realistically, either change the subject to show
that it's only for data_tx or do them all.

(but not traces.h, those use a different style)

$ ./scripts/checkpatch.pl -f --terse --nosummary --types=parenthesis_alignment drivers/staging/wfx/*.[ch]
drivers/staging/wfx/data_tx.c:303: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/data_tx.c:371: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/debug.c:35: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:35: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:45: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:55: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:72: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:97: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:106: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:118: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:133: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/key.c:147: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/queue.c:393: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/queue.c:408: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/queue.c:433: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/sta.c:123: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/sta.c:235: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/sta.c:291: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/sta.c:340: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/sta.c:717: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:156: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:194: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:206: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:211: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:234: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:257: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:265: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:271: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:278: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:296: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:302: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:307: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:313: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:324: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:329: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:334: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:351: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:362: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:416: CHECK: Alignment should match open parenthesis
drivers/staging/wfx/traces.h:418: CHECK: Alignment should match open parenthesis




