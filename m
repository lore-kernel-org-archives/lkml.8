Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA5C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2152064B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zededa.com header.i=@zededa.com header.b="eDmdY0vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIBTz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIBTz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:55:26 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04544C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 12:55:26 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id 92so146861qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 12:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zededa.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fgPZcNvT9XisUEbS+1Ao8QDv+2ALILbug++l9nLUnEc=;
        b=eDmdY0vjzVfcFNl+EMsQE7ZqH4oRZejSxSYWEoWWA0LEdXjBPBIYZ6CIsMOWOxGjre
         aBQ48+3bOVD8NsPa5zTC0V3LvdY7JTigVAGlNWdDDhyLOSLDRHqvX6bHJcCqOAD2JjBt
         Id0FOFZeYHGG1YX7QJRMv2hT3NNRju9/l+AAjpD3G9ARYo2LX9epD472g4knNpz9tXRY
         QIv8rjCWzc/9YstUFPMY/iJgPN6OkAs4plT5GpUmNOLHooN2SAnE4b94q7LW91GUs0/9
         1g5J0HWNcf1NiBHzYqIMtHP287gAFviB3+0k1iay05db9SxaajuERUn5e4bpDNGaxeZg
         avuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fgPZcNvT9XisUEbS+1Ao8QDv+2ALILbug++l9nLUnEc=;
        b=H3X+GJrNlzFn3NiLy7cnsjqWxIIYtNSBu/QB25zeEBpyiO3ECpRvsclZCb3YwYn33k
         qFGjnHgO2GWZKfDg6yN+DvXUg6uP3r7SxDVQWxOdagAkoUXKpp39rG57GWR/DlsDpXRD
         r6tloXsYrm/gUbzXlnnyTLEWZ1hP/4pIs71vB8IoxFoCLvmxdffgFBrT+KCFo1nG+hfh
         VXF2mdX4sSOeuXdmt44bjHSNESX3qMIlagXGIgocx0i1Eptfe+jJsoyPF1ZlOg6XVnW4
         rzBS7Xt98LZBUyU6IU2z3PRg6PmKgBox8g6HCLBxwtE4fZHxYZY863k9s4vkNDlCwa4v
         a37w==
X-Gm-Message-State: AOAM532O+/n1VZDw/nK1e/wJrrovcBeXiOTEqPa/hAcOLfCDsx7Qmnbq
        xsOkCsFtSSNvsWvIhcI2sPM/mfLqK7fzpOkNaN/Ieg==
X-Google-Smtp-Source: ABdhPJxH9r1RSltOF8T2/Z4xLh8CcWvsQpot7UP0gaqiZUBPftNT/cydeaBKOK6TZ0ETBxF8utLKbo/eFODKcZlSras=
X-Received: by 2002:ac8:76cb:: with SMTP id q11mr2050699qtr.63.1599076524368;
 Wed, 02 Sep 2020 12:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+1FSihpq_i-poiihdF0srE3fGXnncGtCMYqAGmNZu7fjNcY=w@mail.gmail.com>
 <CY4PR11MB15594EC5255084B8AE509068F02E0@CY4PR11MB1559.namprd11.prod.outlook.com>
 <1093525083.1169948.1598979998646@mail.yahoo.com> <559F4617-9633-4B40-BA55-E79305E20530@intel.com>
In-Reply-To: <559F4617-9633-4B40-BA55-E79305E20530@intel.com>
From:   Roman Shaposhnik <roman@zededa.com>
Date:   Wed, 2 Sep 2020 12:55:13 -0700
Message-ID: <CAMmSBy8vor1GBqNUSRjj=gNRBwDjzRWFcxuAU0EYkRDgwQ4K+g@mail.gmail.com>
Subject: Re: Various problems for the Xen for XenGT code and guide.
To:     "Lv, Zhiyuan" <zhiyuan.lv@intel.com>
Cc:     Jason Long <hack3rcon@yahoo.com>,
        Mario Marietto <marietto2008@gmail.com>,
        "igvt-g@lists.01.org" <igvt-g@lists.01.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Susie" <susie.li@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Li, Weinan Z" <weinan.z.li@intel.com>,
        "Downs, Mike" <mike.downs@intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 5:48 AM Lv, Zhiyuan <zhiyuan.lv@intel.com> wrote:
>
> Hi,
>
> It is mainly due to the business priority change. XenGT project was origi=
nally created for data center usages with XEON E3 servers which have integr=
ated processor graphics. After SkyLake E3, there are no new servers capable=
 of running GVT-g, and Intel future graphics for data center will have diff=
erent approaches for GPU sharing. Another reason is the XenGT upstream diff=
iculty. Different from KVMGT which has been fully merged to upstream, Xen p=
art of GVT-g still has technical opens that are hard to close quickly.

This is extremely useful -- thanks for sharing. Any chance you can
elaborate on the later part "and Intel future graphics for data center
will have different approaches for GPU sharing"?

IOW, is there anything that Intel is cooking up that may help Xen in
that department?

Thanks,
Roman.
