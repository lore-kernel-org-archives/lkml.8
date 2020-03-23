Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA58C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD38720719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHiCizBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgCWVd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:33:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37017 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCWVd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:33:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id b23so18116981edx.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 14:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhnknTMAfH/wRzM1aNoHZGvfELya9SoXYzFYD0LL+XY=;
        b=JHiCizBxgvc+j7w2CR8qEtF10rjJazyvP28JcwYjWY87NnULzuRquBD2xdCHOmt58I
         9Bgvr/GpRQrQycF5UnWMEul7qpIT6iQY10T0PpLTH32rvyfntrMD50ZKh7etd0+RE63Q
         L7mAsD3Udvg8QJPSaS8rCC4NL04WOHi/5ZiWE+57KIjPERgxGhGpIcPb9nZKPfuS3+Sn
         L0neJPcZHC0cjgfQZm4waK/O87Z8q1FVKq2koyFn1c5RWjPUGoSvVXGhroDs2BQ9N+D3
         BYdv5NUKccrnJvxxxe//kFazPj7rCGqVspuFjNoHAUaBDQe7JIWS1DrAJVUyzVIqtbyA
         ueXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhnknTMAfH/wRzM1aNoHZGvfELya9SoXYzFYD0LL+XY=;
        b=hJE6r8YkEZInhYrs8MFtZysN0IcOG86qAOOY5qxxsGl9uj59LekLwCfDok+UdqJgEk
         uqf4X2xA7oIq2E9o+x77PLwhJ2WJChu+jaT4MwoqomymYXIh9yb+v5KxgLnlYd5/yvLf
         3HrKGQS0SucV/48ywb455G2ECslSmOu4S7ZyO2f5LTue9rsu7l2mP0LAzIpDqPKX+uaf
         1Xmpse5FgHUBH2MJd1LENGiqlxxwndVSMEHb2cYr8vAuy9RK9Zl6VYgrSqyV4pXPZVTq
         /gZQaA8+nyn6Sf+5b4sEAJ+00CTS51eMtYNoBpJKoogSNCblWLPm+QZIhu0tUhz0vfj7
         +7/w==
X-Gm-Message-State: ANhLgQ3H0RRaoAffEtZERuSbyToPY5UnbKFLISLe/U4FWWV+Klud8jJQ
        mupWdyCtCWsfqhQjufE+E4O9rDmrfal//GNqiiKNug==
X-Google-Smtp-Source: ADFU+vuJarP63ymQBTXL3joEpixrNSQwYHFgXElydF5vi1pdd4W1J4ZjXKpEs9Et3yCFPhnm1VGPn1bDtVwod8wCF6g=
X-Received: by 2002:a17:906:af57:: with SMTP id ly23mr7224694ejb.6.1584999202172;
 Mon, 23 Mar 2020 14:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200320175910.180266-1-yonghyun@google.com> <20200323111404.GA4554@infradead.org>
In-Reply-To: <20200323111404.GA4554@infradead.org>
From:   Yonghyun Hwang <yonghyun@google.com>
Date:   Mon, 23 Mar 2020 14:33:11 -0700
Message-ID: <CAEauFbww3X2WZuOvMbnhOD2ONBjqR-JS2BrxWPO=HqzXVcKakw@mail.gmail.com>
Subject: Re: [PATCH] vfio-mdev: support mediated device creation in kernel
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Havard Skinnemoen <hskinnemoen@google.com>,
        Moritz Fischer <mdf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 4:14 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Mar 20, 2020 at 10:59:10AM -0700, Yonghyun Hwang wrote:
> > To enable a mediated device, a device driver registers its device to VFIO
> > MDev framework. Once the mediated device gets enabled, UUID gets fed onto
> > the sysfs attribute, "create", to create the mediated device. This
> > additional step happens after boot-up gets complete. If the driver knows
> > how many mediated devices need to be created during probing time, the
> > additional step becomes cumbersome. This commit implements a new function
> > to allow the driver to create a mediated device in kernel.
>
> Please send this along with your proposed user so that we can understand
> the use.  Without that new exports have no chance of going in anyway.

My driver is still under development. Do you recommend me to implement
an example code for the new exports and re-submit the commit?

Thank you,
Yonghyun
