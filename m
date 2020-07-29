Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9866FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4922082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596059116;
	bh=BesB7bTZD5HunLMQL4muMlZRG06I521vgywh/4Rs0Jk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jRwcZctj5Tdl+rGuUraghZDQfhZYkKzJgZDZLJ8+Txbwe61DxXCHIbDadU0P6iJAI
	 JS4FphRkHQrEx5ZCiRBljXrymoKOYz+grEBXg1o+X3CikKZzd0ylE3ygx+Xnj7HDS8
	 reMrQ75NX8YB9MMWPKl/gvTFgjmL5/bhJ7gNxXLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgG2VpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbgG2VpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:45:12 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33A4C2082E;
        Wed, 29 Jul 2020 21:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596059112;
        bh=BesB7bTZD5HunLMQL4muMlZRG06I521vgywh/4Rs0Jk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w2X9xDACMiE2e2JJSEEOSceCSYfGetT2HjgtQZ17vD4+Xgk0geomUyeVK4fJ9raqP
         B7/hPOSYH/9mbsqiSHqPMgTtFAycC8rnUg0E3wjvj2Fg79HzxrGEnF+t7osA3n7qyb
         oVIBo3G9L5ZCtI7kxQVJCjLGdj7D2oZRT88fombw=
Date:   Wed, 29 Jul 2020 14:45:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        torvalds@linux-foundation.org, lokeshvutla@ti.com,
        tony@atomide.com, daniel.lezcano@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        davem@davemloft.net, hkallweit1@gmail.com, vkoul@kernel.org,
        grygorii.strashko@ti.com, peter.ujfalusi@ti.com,
        santosh.shilimkar@oracle.com, t-kristo@ti.com,
        zaslonko@linux.ibm.com, catalin.marinas@arm.com,
        Dave.Martin@arm.com, broonie@kernel.org, yu-cheng.yu@intel.com,
        Thinh.Nguyen@synopsys.com, felipe.balbi@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] include: Replace HTTP links with HTTPS ones
Message-Id: <20200729144510.d77300ba8f7e891fb9fb595d@linux-foundation.org>
In-Reply-To: <202007291420.9AF368B18@keescook>
References: <20200726110117.16346-1-grandmaster@al2klimov.de>
        <202007291420.9AF368B18@keescook>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 14:21:12 -0700 Kees Cook <keescook@chromium.org> wrote:

> On Sun, Jul 26, 2020 at 01:01:17PM +0200, Alexander A. Klimov wrote:
> > Rationale:
> > Reduces attack surface on kernel devs opening the links for MITM
> > as HTTPS traffic is much harder to manipulate.
> > 
> > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Jon, do you want to take this?

I added this to -mm yesterday.
