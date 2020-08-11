Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A0FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1B7206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="hiEOOvbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHKAH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:07:28 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:34045 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgHKAH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:07:27 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQY704mcmzL3;
        Tue, 11 Aug 2020 02:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597104444; bh=d2y0WYLtpsbbCqsITe1bdbnKMhMhr/VI7MHYqWAzY6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hiEOOvbzb5S5U3b9DTlED8FbJeNsrCN/e6900DXerj1NcEfI/DFLE4zRkrJhZHn1S
         TVWNpiN3Etx7+SEnMQr2l1z+iSFDhj0+5RFphY9bEdo+6vT/ZHgM0gVlrhSTVlYgj8
         5ZG/46rAoog0t/Uxp9HQFJbiKsSRgzCMbYSMqOR5Jp1dTVAR3oyRWoib/kJfQ3XRhM
         5CBM4efUNzQzQN0g6xLkF+zqezURbbTcjzxjWge0Ix8/JlgjddGV9f2OAKjkLxEOFy
         Uji7ClNDWn8k4Cc+/dXdVUF27DQD00ITevP5DgQFSAR5uaQtTxE305ZGVNVkVIFwg5
         o0smij06JtkJg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Tue, 11 Aug 2020 02:07:22 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: regulator: deadlock vs memory reclaim
Message-ID: <20200811000722.GA30574@qmqm.qmqm.pl>
References: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
 <9a5c8ca6-2027-4d89-e290-6db564b99962@gmail.com>
 <20200810201846.GA12091@qmqm.qmqm.pl>
 <d9c3f307-e124-ea5e-c036-71138f9232f4@gmail.com>
 <81e490af-d1da-873a-51b4-130ca82fd1f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81e490af-d1da-873a-51b4-130ca82fd1f6@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:56:13PM +0300, Dmitry Osipenko wrote:
> 10.08.2020 23:21, Dmitry Osipenko пишет:
> > 10.08.2020 23:18, Michał Mirosław пишет:
> >> On Mon, Aug 10, 2020 at 11:15:28PM +0300, Dmitry Osipenko wrote:
> >>> 10.08.2020 23:09, Michał Mirosław пишет:
> >>>> At first I also thought so, but there's more. Below is a lockdep
> >>>> complaint with your patch applied. I did a similar patch and then two more
> >>>> (following) and that is still not enough (sysfs/debugfs do allocations,
> >>>> too).
> >>> Then it should be good to move the locking for init_coupling() like I
> >>> suggested and use GFP_NOWAIT for the two other cases. It all could be a
> >>> single small patch. Could you please check whether GFP_NOWAIT helps?
> >>
> >> This would be equivalent to my patches. Problem with sysfs and debugfs
> >> remains as they don't have the option of GFP_NOWAIT. This needs to be
> >> moved outside of the locks.
> > 
> > Ah okay, you meant the debugfs core. I see now, thanks.
> > 
> 
> This indeed needs a capital solution.
> 
> It's not obvious how to fix it.. we can probably remove taking the
> list_mutex from lock_dependent(), but this still won't help the case of
> memory reclaiming because reclaim may cause touching the already locked
> regulator. IIUC, the case of memory reclaiming under regulator lock was
> always dangerous and happened to work by chance before, correct?

I just noticed that locking in regulator_resolve_coupling() is bogus.
This all holds up because regulator_list_mutex is held during the call.
Feel free to test a patch below.

I'm working my way to push allocations outside of the locks, but the
coupling-related locking will need to be fixed regardless.

Best Regards,
Michał Mirosław

---->8<----

[PATCH] regulator: remove superfluous lock in regulator_resolve_coupling()

The code modifies rdev, but locks c_rdev instead. The bug remains:
stored c_rdev could be freed just after unlock anyway. This doesn't blow
up because regulator_list_mutex taken outside holds it together.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 94f9225869da..e519bc9a860d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4859,13 +4859,9 @@ static void regulator_resolve_coupling(struct regulator_dev *rdev)
 			return;
 		}
 
-		regulator_lock(c_rdev);
-
 		c_desc->coupled_rdevs[i] = c_rdev;
 		c_desc->n_resolved++;
 
-		regulator_unlock(c_rdev);
-
 		regulator_resolve_coupling(c_rdev);
 	}
 }
-- 
2.20.1

