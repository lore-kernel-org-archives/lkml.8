Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09E3C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB142075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQlpqdhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgDXPBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727803AbgDXPBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:01:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEFCC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:01:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x2so1207467pfx.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WA6YT3P4wx7X3bQJbhgUgPtFkkYdVN+8YI+AxYkVvfc=;
        b=BQlpqdhQGV2aylcPBuD0WjOIJNHbEqb2CFlIb4cMsMbgbjfR+pYTHxrKEc4X6YopRi
         YaAonVMgHeSm7M603hfMSD+ITnD05BfrISS3gjOz4Ys+sClTMVW66c5YTPTaZvRgWTAW
         X7ERXfDhq6MRjeEOa+0oWjU1q6NX9GqichShNmvdk+T4uSTCnc/mmakRUIS2bkkrJFH9
         4d7itlRbPD6LKT7ElUkPF2gKYKOsKstB4kuZhLZpgiNvVRlq8dqIiORSEcmV811M007Q
         XdkI2spnVddmK4KHVrVNdvmhRDFehykWLNx+8il9uWTTNbhOFYFbu9uJxLya5J4UAv/X
         HeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WA6YT3P4wx7X3bQJbhgUgPtFkkYdVN+8YI+AxYkVvfc=;
        b=H4tYl5KBmB1RIlvJEbIcqjKXoUepMCpiILQ0qxRTIdcHSTNCx7mwjzj97h8ty19nAg
         gYK382yY0fyDXZpVcl3uqluGiJ1yezqNfwZKNfT3JFfbPI8P+IEMeNASfyiuy0h16M2P
         5OulItVDEqfm0UihnhLVwXQS+S2ho7tHkdCcJ5X5K8TaAIXesa9I8c+qJ5a4MCs8DpSi
         z7FcyaBzfZVrsSOLoJ/m4lwXTG2qch48hnh6ndqILM1DVAHrVH/M22vXAYnrmw0NBC7N
         9FLh8J72fOmneXYAyEzAHQQ6Hz/g41FuSWrWEBkipz+DimmiqXa5vFR1+xDcJjLVZ4bQ
         9fTw==
X-Gm-Message-State: AGi0PuYS9mlYDbWvwTwO1bf0bRjscocAeMx1K7ouG+ZCCxfKdMQfPgwG
        DSYAnZhNXWtliQBWVPJ9fUJ9YQLIHS5nwETF3m/pWg==
X-Google-Smtp-Source: APiQypLXsA3W50M8onD0U1i/mkh4IibmkTCfMUte8KQKocdydeRyWNAG5+VViUHyykOfHWnzpsR+rVfhd1nfodcWZKc=
X-Received: by 2002:a62:4e87:: with SMTP id c129mr9959414pfb.178.1587740477173;
 Fri, 24 Apr 2020 08:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <9c99c508da044822baf53db5e3fccd4f21b0f8d3.1587734346.git.andreyknvl@google.com>
 <635f48fcb4bb99c70ab9d7f0dfe84d1ec7dc540e.1587734346.git.andreyknvl@google.com>
 <20200424133745.GA600581@kroah.com>
In-Reply-To: <20200424133745.GA600581@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 24 Apr 2020 17:01:06 +0200
Message-ID: <CAAeHK+yAzWj3n6WTcuDip+CN3tkbK6UrSUckBC1TEqtZJ_ou0A@mail.gmail.com>
Subject: Re: [PATCH USB v2 2/2] usb: raw-gadget: fix typo in uapi headers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 3:37 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 24, 2020 at 03:20:20PM +0200, Andrey Konovalov wrote:
> > Change "trasferred" into "transferred".
> >
> > Change-Id: I2d8d1dcc9ba6aacafc03f4b76caca7409a6da1a6
>
> What is that?  :)
>
> And no signed-off-by?

That's me mistakenly removing signed-off-by instead of the gerrit tag
:) Let me try sending that again.
