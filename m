Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD8DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F73E20748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfqgHBk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgEUHPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgEUHPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:15:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AAAC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:15:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l17so5621025wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=p77jW0bTzDyLRaf317y5GD/ZKjkvxPMT932RAeaMAb4=;
        b=IfqgHBk8TUbVPf7O7vGbwylQQEkCh/0J1YVBnRPyZD1tREJ0pl89rrI1qu0U/2jA5t
         PQmPQDRhvT/+G/ztmJrpqcwtVq7paSbLKHk5hy3uM68F7yjgxuLYAYjLchbGeU4wfE5h
         yjwfz/RgjCAgSOGtLQxLcO7zV7huxv0whreIEV3eWz+UdShtJtfEwadiKUbTXWLg0VNq
         G09IRB4lZyG/oIeG6eELBr8P/l3uFM46MraO+UK9/nEDE36+c5w/r+bFjczh2/bMEqeY
         KzkAx75+/reOYhHfKVCuszmOE9YSI00Y31fIB4OLlrV0CCGr+5xEe15iRKhMWw02GIt0
         95yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=p77jW0bTzDyLRaf317y5GD/ZKjkvxPMT932RAeaMAb4=;
        b=TA/1NHdbFB3X0Qae2Sex4hQtVkR7Zwa8PjDN8hwzd+n1tNMR2LzyEVC97DVJQIPwVo
         bpVO4wC//KuJD0ElbrAtUc15IQpc3PNYwGzE5Gbygql8RPhATb18yGydd1ojT46JFGJT
         nWlSdqLu0ZxdIqOE6HMPVaMKL7D+cGpBlAF8g6Q1FTkekpUa9WwmpoBo14SMM46+4Dyg
         xlhzMz5rxNd2oBudTVmzBLa1NagDS/9Ir9OtmNMMs0DlGsADEfTUcvbyMaDRRWemsnUk
         4/5pmI9u0wWdfESEE9ZJll72P5t9pj4GUKanm+DeVaqmWiGRsyhn1r+Fgb9jTlNUpjI3
         4Hnw==
X-Gm-Message-State: AOAM5326DuuAcFQ06OCV1q812CuxwA/KwcMminl9wpEgEWL+qweNybKo
        cVhSd0SDEtlNYs3LD8l/LiH5Hg==
X-Google-Smtp-Source: ABdhPJw75EkeQPC0RMpgE1lAuQ0zdCw15S/xf4hV+CXMc9qNSnh5vVlU00bc6Oaho791ZHu99726gA==
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr7162745wrw.78.1590045308398;
        Thu, 21 May 2020 00:15:08 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id 1sm5720506wmz.13.2020.05.21.00.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 00:15:07 -0700 (PDT)
Date:   Thu, 21 May 2020 08:15:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v13 00/11] Convert PWM period and duty cycle to u64
Message-ID: <20200521071505.GL271301@dell>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <20200423114857.GG3612@dell>
 <20200423215306.GA8670@codeaurora.org>
 <20200424064303.GJ3612@dell>
 <20200424221422.GA31118@codeaurora.org>
 <20200427064434.GA3559@dell>
 <20200520231508.GA29437@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200520231508.GA29437@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020, Guru Das Srinagesh wrote:

> On Mon, Apr 27, 2020 at 07:44:34AM +0100, Lee Jones wrote:
> > On Fri, 24 Apr 2020, Guru Das Srinagesh wrote:
> > 
> > > On Fri, Apr 24, 2020 at 07:43:03AM +0100, Lee Jones wrote:
> > > > A great deal of mailing lists contain numerous protections against
> > > > things like flooding and spamming.  One of those protections is a
> > > > check for "Too many recipients to the message".  Most of the time this
> > > > simply requires moderator intervention by way of review and approval,
> > > > but this ultimately depends on the ML's configuration.
> > > > 
> > > > The first thing to ascertain is why your recipients list is so large.
> > > > Have you added every reviewer, subsystem-maintainer, maintainer and
> > > > contributor suggested by get-maintainer.pl?  If so, consider pruning
> > > > that a little.  Contributors do not tend to care about subsequent
> > > > changes to a file.  As someone who receives a lot of patches, I tend
> > > > to get fed-up when receiving patches simply because I made a change X
> > > > years ago.  Stick to listed maintainers/reviewers in the first
> > > > instance and see how far that takes you.
> > > 
> > > Thank you for the detailed reply. I did this in the first few patchsets
> > > and then when a few patches didn't get any attention, expanded the
> > > audience thus. Still, around 50% of the patches in this series remain
> > > unreviewed by anyone.
> > 
> > This isn't a reason to add more recipients (who are likely to care
> > even less than your original group).  However it *is* a good argument
> > for including all of the specified maintainers/reviewers in on all of
> > the patches.
> > 
> > > > If your recipients list is as succinct as reasonably possible, maybe
> > > > just accept that every version isn't going to be archived by every
> > > > ML.  It's still much more useful for the correct people to have
> > > > visibility into the set than for it to be archived multiple times.
> > > 
> > > Thank you, will prune the list and remove past contributors from the
> > > Cc-list and add all parties to all patches.
> > 
> > Great.  Once you've done that, we can start to help you acquire the
> > Acks you need on your remaining patches.
> 
> Hi Lee, Thierry, Uwe,
> 
> In v14 of this patchset I've pruned the list of contributors, removed
> past contributors from the cc-list, and added all parties to all patches
> (except for the patches that are yet to reviewed, for which I've added
> what get_maintainer.pl showed me). I've also resent v14 a couple of
> times already, with around a week's time interval between resends, and
> somehow it seems like this set has lost traction.
> 
> Could you please indicate what next steps I should take to have more
> eyes on the unreviewed patches? Only 4 out of 11 patches remain
> unreviewed.

Looks like we're waiting on Thierry (again).

This has been a common theme over the past few months.

Perhaps he has changed employer/project?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
