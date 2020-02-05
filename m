Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A97C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58B520702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgBEHmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 02:42:02 -0500
Received: from nautica.notk.org ([91.121.71.147]:46353 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgBEHmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 02:42:01 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Feb 2020 02:42:00 EST
Received: by nautica.notk.org (Postfix, from userid 1001)
        id AAAD2C01B; Wed,  5 Feb 2020 08:41:59 +0100 (CET)
Date:   Wed, 5 Feb 2020 08:41:44 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Sergey Alirzaev <l29ah@cock.li>
Cc:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] 9p: read only once on O_NONBLOCK
Message-ID: <20200205074144.GB16626@nautica>
References: <20200205003457.24340-1-l29ah@cock.li>
 <20200205003457.24340-2-l29ah@cock.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200205003457.24340-2-l29ah@cock.li>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Alirzaev wrote on Wed, Feb 05, 2020:
> A proper way to handle O_NONBLOCK would be making the requests and
> responses happen asynchronously, but this would require serious code
> refactoring.

FWIW I do have some async 9p code waiting (it's been sent to the list
ages ago but I never took the time to properly test it due to lack of
interest manifested), the problem here is more the caching model than a
synchronous issue, since in nocache mode (where this is used) there is
nowhere to fetch the data ahead of time.

If you're interested in that then please have a look at
https://lore.kernel.org/lkml/1544532108-21689-1-git-send-email-asmadeus@codewreck.org/

> Signed-off-by: Sergey Alirzaev <l29ah@cock.li>

That aside, I guess, why not?
Will take when other patch gets addressed.

Thanks,
-- 
Dominique
