Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EB6C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277BD20637
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584143526;
	bh=buyzexwwYTVxUp5UYXW17smeX7BEkmJhwRDsJSMamDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LvGz9giLHXI15ew9LiVCw0j2bMMBXdAR29BQH7lT1CCZi2h4/SaAji0zMIL17fv4i
	 iZCNTdTg7F06g+k19MFQBYYwKR9kCg0UuIhq1L6X0o9c2zO3ezrgqPwuZ3jEcFy7X/
	 nR02oev0ZWc58A+kotuiiEFHLJunfJrbu99xg3hM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgCMXwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgCMXwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:52:04 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B89FA20637;
        Fri, 13 Mar 2020 23:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584143524;
        bh=buyzexwwYTVxUp5UYXW17smeX7BEkmJhwRDsJSMamDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DaDhLEozHIyaWVLlS0unh7m1A8gWb0pzh+mWqv+IXbfZfO3B9Hlv7/WkGEqkxwpUJ
         FVPLoyv4xUaTqnznO2Df2gcsBehTjXqN2Pq+bNPiZy8HcgmTMq4WOJCmhnMomiP5Jo
         T/bndRjQqJ5a97DadRw7itYybOm/VZwUFL6G7SEo=
Date:   Fri, 13 Mar 2020 16:52:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/5] kselftest: add fixture parameters
Message-ID: <20200313165202.37d921cf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <202003131628.77119E4F4E@keescook>
References: <20200313031752.2332565-1-kuba@kernel.org>
        <20200313031752.2332565-5-kuba@kernel.org>
        <202003131628.77119E4F4E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 16:31:25 -0700 Kees Cook wrote:
> > @@ -326,7 +387,8 @@
> >  	} \
> >  	static void fixture_name##_##test_name( \
> >  		struct __test_metadata __attribute__((unused)) *_metadata, \
> > -		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
> > +		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
> > +		const FIXTURE_PARAMS(fixture_name) __attribute__((unused)) *params)  
> 
> Could this be done without expanding the function arguments? (i.e. can
> the params just stay attached to the __test_metadata, perhaps having the
> test runner adjust a new "current_param" variable to point to the
> current param? Having everything attached to the single __test_metadata
> makes a lot of things easier, IMO.

Sure! I felt a little awkward dereferencing _metadata in the test,
so I followed the example of self. But I can change.

Can I add a macro like CURRENT_PARAM() that would implicitly use
_metadata?
