Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A669C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E3D20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="IGbycisR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgHJQMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:12:20 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:36957 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgHJQMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:12:19 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQLZp0gclz2d;
        Mon, 10 Aug 2020 18:12:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597075938; bh=GTkOzh/b40VK8cnJiaBx/bKeY6XCllkdkCv/kZijaTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IGbycisRi00k4XbjQq/9Qbuee4G2tBPYlKe2WVuq29MG/lpTWYYPQDsxb/edAF8rJ
         1LvALCOX2dnYdewz/5YLEortK16n19WQgixwqoFhRJR/PlYSS8k3AzyphVGn454wX7
         saoKmCL1saXFihjdUS0Kq11bO0/6ZZQdwtAq00FB5vDmYIRR1EE4LpRbXwohzhvsYh
         sGLYySCXD9g4/9bWXn5qlotNSbDXNY7+23p0XNV2oplvkqXw9P0q2UuvwhUCttjND1
         Euq9wHlejZMMxAv9tSTyBlFwgCc7KI7c4nPxisLuOFcD+FUoiSkjBykTFefYbS50Hm
         0k8ueBTkxdfxA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 18:12:16 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: simplify locking
Message-ID: <20200810161216.GB1100@qmqm.qmqm.pl>
References: <b22fadc413fd7a1f4018c2c9dc261abf837731cb.1597007683.git.mirq-linux@rere.qmqm.pl>
 <40871bc7-2d6c-10d4-53b3-0aded21edf3b@gmail.com>
 <20200809223030.GB5522@qmqm.qmqm.pl>
 <8850c09f-4b24-7ab2-a0f7-e0d752f5a404@gmail.com>
 <20200810005927.GA13107@qmqm.qmqm.pl>
 <dc398754-f31e-9703-01b1-fec2d3a381cf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc398754-f31e-9703-01b1-fec2d3a381cf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 08:14:20AM +0300, Dmitry Osipenko wrote:
> 10.08.2020 03:59, Michał Mirosław пишет:
> > On Mon, Aug 10, 2020 at 03:21:47AM +0300, Dmitry Osipenko wrote:
> >> 10.08.2020 01:30, Michał Mirosław пишет:
> >>> On Mon, Aug 10, 2020 at 12:40:04AM +0300, Dmitry Osipenko wrote:
> >>>> 10.08.2020 00:16, Michał Mirosław пишет:
[...]
> >>>>> -	mutex_lock(&regulator_nesting_mutex);
> >>>>> +	if (ww_ctx || !mutex_trylock_recursive(&rdev->mutex.base))
[...]
> >>> I think that reimplementing the function just to not use it is not the
> >>> right solution. The whole locking protocol is problematic and this patch
> >>> just uncovers one side of it.
> >>
> >> It's not clear to me what is uncovered, the ref_cnt was always accessed
> >> under lock. Could you please explain in a more details?
[...]
> The nested locking usage is discouraged in general because it is a
> source of bugs. I guess it should be possible to get rid of all nested
> lockings in the regulator core and use a pure ww_mutex, but somebody
> should dedicate time to work on it.

So using a deprecated function for deprecated functionality sounds just
appropriate, doesn't it? :-)

Best Regards,
Michał Mirosław
