Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88D5C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2702075A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgD1QKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:10:50 -0400
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:33800 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728615AbgD1QKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:10:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 62773180A68C6;
        Tue, 28 Apr 2020 16:10:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: owl46_23d38036f883f
X-Filterd-Recvd-Size: 1658
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Apr 2020 16:10:46 +0000 (UTC)
Message-ID: <b452dc29fb553fa5993b90131dcdbc04ed87532e.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add dedicated checker for 'Fixes:' tag
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Whitcroft <apw@canonical.com>, Markus.Elfring@web.de,
        mcroce@redhat.com
Date:   Tue, 28 Apr 2020 09:10:44 -0700
In-Reply-To: <20200428020223.GA28074@udknight>
References: <20200428020223.GA28074@udknight>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-28 at 10:02 +0800, Wang YanQing wrote:
> According to submitting-patches.rst, 'Fixes:' tag has a little
> stricter condition about the one line summary:
> ...
> Do not split the tag across multiple
> lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
> parsing scripts
> ...
> 
> And there is no 'Fixes:' tag format checker in checkpatch to check
> the commit id length too, so let's add dedicated checker to check
> these conditions for 'Fixes:' tag.

There's no need to duplicate functionality like this.
Put this additional Fixes: logic into the existing block.

(and don't take advise from Markus too seriously when it
comes to English grammar or wording.  He is not an arbiter
of taste for this code)


