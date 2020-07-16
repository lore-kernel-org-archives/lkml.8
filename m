Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A74EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8E220775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594862650;
	bh=dDX1L5XjDb2eHGUfpWe1tSm+lPvDYEfgRhobXae+CSg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=0j4Oi3UBaTj7w+07Bx8WWoLnxyubknfLX1+S4lP7vGw0pWHi8Xrpg/Rmajb6ImIxt
	 4bURvav/eQcJwwQfirNJJdAGE9mGdFyb6xXnJ2FCN9NaVJg1xp6uHFGvZViP1RIufS
	 iQ2UK8KgRv9eluYdvfi75g6zASFJIZiXoCYUE++I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgGPBYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgGPBYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:24:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34F0220775;
        Thu, 16 Jul 2020 01:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594862648;
        bh=dDX1L5XjDb2eHGUfpWe1tSm+lPvDYEfgRhobXae+CSg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SHkg50mhZFVxz1ZaSvVhxg13f15nMzWP/EZ73ZE3XvBG5hinHrzJlMkRmBKywkv1K
         GLuY9oMChmw//sSDOCd+NsbsCHdr7GnD/KfnOCGIvXb6xIEdtx+JiiToZKglNR+dfn
         1+Ek1Wi+tN5gQd2yvfoadUJ2xN+7QFQRpJT/qt2Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <15ed3803e04699017c6a7909a8df83c215135a89.1594717630.git.rahul.tanwar@linux.intel.com>
References: <15ed3803e04699017c6a7909a8df83c215135a89.1594717630.git.rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v1] clk: intel: Address pending review concerns
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Date:   Wed, 15 Jul 2020 18:24:07 -0700
Message-ID: <159486264757.1987609.4166237347048554216@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2020-07-14 02:11:44)
> Use devm_clk_hw_register() instead of clk_hw_register().
> Remove unnecessary locking. Avoid memset by improving code.

Please make a better subject. Also should probably be split into
multiple patches and then making a subject will be easier.
