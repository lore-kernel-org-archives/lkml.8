Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06407C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 00:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D592F2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 00:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="XucAWtFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgHJA7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 20:59:35 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:2798 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgHJA7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 20:59:32 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BPyKZ1RKgz2d;
        Mon, 10 Aug 2020 02:59:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597021170; bh=1eeKBL0o88wtLrMTjQEu0rJjKv4EBeqN/ITuA7qHIqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XucAWtFIvIbVpKNWzILk6bE15GVYS1WF5mUTYf0LaRS4ZXaFKoPwVWn+XWAJbGGuM
         c73uOdobi01CpQ4Z8EKHZfg0qssR8XTcY16oKHSB+lJSsmXGhrKd6zJdHc6zurbWPG
         6pDOSQzg6F/XF1dBL11+mw0vheq03EnQQTDPuWsO9A5Yr+z2eq55wl+R1+2rhEY58v
         mW54RAMm0ntzoPeGvNNrn5z6CGx1yShl9A+FDtxrNTiD9nPEYNasGtBdvD8xLuDexm
         LaxmbJ/lZa/iqHWw96vJsR8lF1CmQbfqY6Zg8mfZlRzLOlOUAiRxMONlKPO70FwcpK
         5uUUv07lykKAg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 02:59:27 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: simplify locking
Message-ID: <20200810005927.GA13107@qmqm.qmqm.pl>
References: <b22fadc413fd7a1f4018c2c9dc261abf837731cb.1597007683.git.mirq-linux@rere.qmqm.pl>
 <40871bc7-2d6c-10d4-53b3-0aded21edf3b@gmail.com>
 <20200809223030.GB5522@qmqm.qmqm.pl>
 <8850c09f-4b24-7ab2-a0f7-e0d752f5a404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8850c09f-4b24-7ab2-a0f7-e0d752f5a404@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 03:21:47AM +0300, Dmitry Osipenko wrote:
> 10.08.2020 01:30, Michał Mirosław пишет:
> > On Mon, Aug 10, 2020 at 12:40:04AM +0300, Dmitry Osipenko wrote:
> >> 10.08.2020 00:16, Michał Mirosław пишет:
> >>> Simplify regulator locking by removing locking around locking. rdev->ref
> >>> is now accessed only when the lock is taken. The code still smells fishy,
> >>> but now its obvious why.
> >>>
> >>> Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
> >>> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> >>> ---
> >>>  drivers/regulator/core.c         | 37 ++++++--------------------------
> >>>  include/linux/regulator/driver.h |  1 -
> >>>  2 files changed, 6 insertions(+), 32 deletions(-)
> >>>
> >>> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> >>> index 9e18997777d3..b0662927487c 100644
> >>> --- a/drivers/regulator/core.c
> >>> +++ b/drivers/regulator/core.c
> >>> @@ -45,7 +45,6 @@
> >>>  	pr_debug("%s: " fmt, rdev_get_name(rdev), ##__VA_ARGS__)
> >>>  
> >>>  static DEFINE_WW_CLASS(regulator_ww_class);
> >>> -static DEFINE_MUTEX(regulator_nesting_mutex);
> >>>  static DEFINE_MUTEX(regulator_list_mutex);
> >>>  static LIST_HEAD(regulator_map_list);
> >>>  static LIST_HEAD(regulator_ena_gpio_list);
> >>> @@ -150,32 +149,13 @@ static bool regulator_ops_is_valid(struct regulator_dev *rdev, int ops)
> >>>  static inline int regulator_lock_nested(struct regulator_dev *rdev,
> >>>  					struct ww_acquire_ctx *ww_ctx)
> >>>  {
> >>> -	bool lock = false;
> >>>  	int ret = 0;
> >>>  
> >>> -	mutex_lock(&regulator_nesting_mutex);
> >>> +	if (ww_ctx || !mutex_trylock_recursive(&rdev->mutex.base))
> >>
> >> Have you seen comment to the mutex_trylock_recursive()?
> >>
> >> https://elixir.bootlin.com/linux/v5.8/source/include/linux/mutex.h#L205
> >>
> >>  * This function should not be used, _ever_. It is purely for hysterical GEM
> >>  * raisins, and once those are gone this will be removed.
> >>
> >> I knew about this function and I don't think it's okay to use it, hence
> >> this is why there is that "nesting_mutex" and "owner" checking.
> >>
> >> If you disagree, then perhaps you should make another patch to remove
> >> the stale comment to trylock_recursive().
> > 
> > I think that reimplementing the function just to not use it is not the
> > right solution. The whole locking protocol is problematic and this patch
> > just uncovers one side of it.
> 
> It's not clear to me what is uncovered, the ref_cnt was always accessed
> under lock. Could you please explain in a more details?
> 
> Would be awesome if you could improve the code, but then you should
> un-deprecate the trylock_recursive() before making use of it. Maybe
> nobody will mind and it all will be good in the end.

I'm not sure why the framework wants recursive locking? If only for the
coupling case, then ww_mutex seems the right direction to replace it:
while walking the graph it will detect entering the same node
a second time. But this works only during the locking transaction (with
ww_context != NULL). Allowing recursive regulator_lock() outside of it
seems inviting trouble.

Best Regards,
Michał Mirosław
