Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2590C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 11:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC7D2245C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 11:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo6e5+2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgHELgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 07:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgHEKsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 06:48:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42BEC0617A4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 03:48:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so5386863wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oXu2Y7fD3k9npiuJU8zEDUoptykKZDxN94zEJS+x19E=;
        b=Eo6e5+2DYZC6Gh7Rwranq886u1jwCGSVMrE2eg8tzZZiYkRL+M3N65nOffOrWz1btb
         7V9o2uoq9GVktmT2zCiBSTZ9Y2Y3kmBw0pXVv8XsJXmc9KVGnMNB3rGjoy+Y2SaU5r5S
         U4bfNTcAim88eWxcIS5kWztRiESjE7c36Ew1jUstr9ZWQBL6TYVhEsPHQidqCGsIq4l0
         r39jYwXPAMeKLG6++FUKfbyyLAFU43Znx1F9otom8AEinh47hjAWJvApWmRJNXfJXaUk
         FI1B3NPzimj2VI9LMpsL39ZYZ5v4jxGivhZcQ4Rk5YtbiS1nAmSobaWddFDOnoCuc4e4
         Up/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oXu2Y7fD3k9npiuJU8zEDUoptykKZDxN94zEJS+x19E=;
        b=POz8m+hUpdPV17e8xbFpI35o1TgHBfBxj/NIU5pl/mVBGLJaIcQdpdDzseNs63aiZZ
         i5CUAyAW0QymMowtbtxi2Rq0ZUpawivk+lQXQGdq7vc7fsmV41UOEFaCWxXvXxR20K7O
         zC+6Xggb4qoa4UMjWw3U3tOFomrB0X/lvkLTko9oeWsqGCrmBJVVRjmamtPwWw/lce3h
         fHQA9cIgm6OWgm4ne8r7h33K2kzvloLru3CXwooAOzDOq8jFVOI3+YiEYomcZc72eitq
         cyf214Ls3uDTdrpe+Mk/nQF9yicf2FgRaNOBKQwz0I10Eoz2XqhR8RRn9WM0Jyc86GPF
         S7+Q==
X-Gm-Message-State: AOAM5318jyNu0hSJGbBlTLkQFjs954+sIVvosEn4AU69KkUUwibq0n5T
        ebcM0rOxPYKN8/q3Xjn6VIS/3Iuq/10=
X-Google-Smtp-Source: ABdhPJxYNKu3WObBVVHD3oSW282IJS2I9MBZa4LIlt+LG6EOqVQdrYwGtJug+2ZhhKqohioW6GkOQQ==
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr2719406wmk.86.1596624501787;
        Wed, 05 Aug 2020 03:48:21 -0700 (PDT)
Received: from tsnow (IGLD-83-130-60-139.inter.net.il. [83.130.60.139])
        by smtp.gmail.com with ESMTPSA id o2sm2445394wrh.70.2020.08.05.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 03:48:19 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:48:16 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jerome.pouiller@silabs.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: refactor to avoid duplication at hif_tx.c
Message-ID: <20200805104816.GB3260@tsnow>
References: <20200805085608.GA100079@tsnow>
 <20200805090425.GA655071@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805090425.GA655071@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 11:04:25AM +0200, Greg KH wrote:
> On Wed, Aug 05, 2020 at 11:56:08AM +0300, Tomer Samara wrote:
> > Add functions wfx_full_send(), wfx_full_send_no_reply_async(),
> > wfx_full_send_no_reply() and wfx_full_send_no_reply_free()
> > which works as follow:
> > wfx_full_send() - simple wrapper for both wfx_fill_header()
> >                   and wfx_cmd_send().
> > wfx_full_send_no_reply_async() - wrapper for both but with
> >                                  NULL as reply and size zero.
> > wfx_full_send_no_reply() - same as wfx_full_send_no_reply_async()
> >                            but with false async value
> > wfx_full_send_no_reply_free() - same as wfx_full_send_no_reply()
> >                                 but also free the struct hif_msg.
> 
> Please only do one-thing-per-patch.  Why shouldn't this be a 4 patch
> series?
> 
> thanks,
> 
> greg k-h

All of the 4 functions are wrappers for the same duplicate code when 
every time there are different flags, so they are all connected, it is
feel to me more legit to patch them all together, should I split them
into 4 different patches?

Thanks,
	Tomer Samara
