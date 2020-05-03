Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF3AC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD61C21835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgECPq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 11:46:26 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:38026 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728595AbgECPq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:46:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 743E31AA68;
        Sun,  3 May 2020 15:46:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: linen69_721df84ad8f1e
X-Filterd-Recvd-Size: 1355
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun,  3 May 2020 15:46:24 +0000 (UTC)
Message-ID: <83ef442fc90cbfce1d8566e43e9af2bd2089b4e1.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add support for title acrosses three lines
 in commit id description
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Date:   Sun, 03 May 2020 08:46:22 -0700
In-Reply-To: <20200503123435.GD10332@udknight>
References: <20200503123435.GD10332@udknight>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-03 at 20:34 +0800, Wang YanQing wrote:
> The current GIT_COMMIT_ID will report error when the title in commit id
> description acrosses three lines, take changelog of commit 87b0f983f66f
> ("net: mscc: ocelot: fix untagged packet drops when enslaving to vlan
> aware bridge") as a example.

I think it's a diminishing returns problem.

What percentage of commits in the last 10000
has this issue?


