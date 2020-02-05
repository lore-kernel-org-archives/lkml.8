Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8A2C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107EB217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b="yxVdJxXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgBEWGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:06:12 -0500
Received: from mx1.cock.li ([185.10.68.5]:38189 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727033AbgBEWGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:06:12 -0500
Date:   Thu, 6 Feb 2020 01:06:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
        t=1580940369; bh=EEta4kxNqs0o9NP0rc52RRu2fAQhB8tslJRFLKGaEbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yxVdJxXB3pX66l/rR2aXkcgiQvJFMrGBeOholbRzEHBhzj5c8WPi/3V7av68qSt2X
         FKkBhrB/+tWK0SWKuX92l82aPumRQfDii5eriYPz8wZKK4TPeiQg8r0R6wPMd3ULPK
         rTWZAFRHOztRCQu2HQ/od0Pe7szXp5orGQF/wLmgA8odyNQ6vt+1uVFHVSL17sjWC4
         zXoaxW/EJFxPwdvLk4852KcuTpKnHHUSgZUxojDaZjzIGh7+pMpSdslQcPT1GovoK4
         m15fJXH5VxrzzUUUKLNqZDKYYBHnjKnm/49K03a2nT8zp0nXUaTRPV1EWX7nLRJGXJ
         49lMSS0t2HJ1g==
From:   l29ah@cock.li
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Sergey Alirzaev <l29ah@cock.li>,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9pnet: allow making incomplete read requests
Message-ID: <20200205220607.m7tu6hsdr3xhm6l4@l29ah-x201.l29ah-x201>
References: <20200205204053.12751-1-l29ah@cock.li>
 <20200205215446.GB3942@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205215446.GB3942@nautica>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:54:46PM +0100, Dominique Martinet wrote:
> > [...]
> > +		if (n != count) {
> > +			*err = -EFAULT;
> > +			p9_tag_remove(clnt, req);
> > +			return n;
> >  		}
> > -		p9_tag_remove(clnt, req);
> > +	} else {
> > +		iov_iter_advance(to, count);
> > +		count;
> 
> Any reason for this stray 'count;' statement?
> If you're ok with this I'll just take patch without that line, don't
> bother resubmitting.

No reason, i've just accidentally left it.

> Will take a fair amount of time to make it to linux-next though, test
> setup needs some love and I want to run tests even if this should be
> straightforward...

Thanks!

-- 
()  ascii ribbon campaign - against html mail
/\  http://arc.pasp.de/   - against proprietary attachments
