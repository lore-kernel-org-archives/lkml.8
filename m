Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47611C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CA720714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Te+uoNkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgCXSYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:24:21 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50680 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgCXSYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:24:20 -0400
Received: by mail-pj1-f68.google.com with SMTP id v13so1968374pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hdZ4pb4Hr5HLh2IG65w9wREWo960MwcI9Mci2dzvou4=;
        b=Te+uoNkO5YxQ0PKXCfa8hPTzOvAaDtBv/xpbdWENa6MfwcHMxtYXq/55et3D+JiKkY
         k4+jNo46o/8o71/LmFLB2IexDKnRrsjXYhSoJhHfbl+OStyILKMIElZXSlBG+hMqIiiP
         THT3fW3und8bgqoYTJX0uiGfiDFFaBZPa7of0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hdZ4pb4Hr5HLh2IG65w9wREWo960MwcI9Mci2dzvou4=;
        b=DSGdFqf7KvTkQsVCVsmYqXIKY2Q9PoYsmgzZg7PMQm2lJi6fLIBLNIT5g4Io1rTgWg
         7PAQv5rTuUOVuNbPwH7s1nW5/XCSLkUTLy667cy+zHA5SIQAE5YGBqXIDb8RS/n2ZGgD
         WddaPBoLJh01s1Ry6mhd3sbLg+i8OHG9macx3k0dNUFUVXboSvPgil2VySaltgtXmufq
         scg3DtSxd85826Ny6I/qfGy+HYsSsRoLATHRBXbQFN23bbdIR/JqgrGJM6oaI0gHLveb
         OC0ov8SByUFcmJo26GIisRYxTnXPEd4s21lC+kSuyzcJM19R19VuxPCLmcTNc9iyAj9/
         JdbQ==
X-Gm-Message-State: ANhLgQ0mWwW9gyeWFPbcf6yy3P7Tbn9CCrBOthoDFreNGTjztmcQ10Z/
        FZ3bSZoxG4LbODnnu8HhIUNM0Ym9z1s=
X-Google-Smtp-Source: ADFU+vsOsKtovHRYR1HCH2j5HOW+TQwDponkESPPOmpa5eJqfEtjFxsV1s5h4YhSH6jF3y7mNBC1FA==
X-Received: by 2002:a17:902:b096:: with SMTP id p22mr22516835plr.262.1585074259621;
        Tue, 24 Mar 2020 11:24:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm15518010pgh.88.2020.03.24.11.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:24:18 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:24:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC] kernel/sysctl: support setting sysctl parameters from
 kernel command line
Message-ID: <202003241121.44E725B@keescook>
References: <20200317132105.24555-1-vbabka@suse.cz>
 <202003171421.5DCADF51@keescook>
 <bc721358-6202-bdc5-0398-29921b3f9855@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc721358-6202-bdc5-0398-29921b3f9855@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:50:49PM +0100, Vlastimil Babka wrote:
> On 3/17/20 10:29 PM, Kees Cook wrote:
> > mm.transparent_hugepage.enabled
> 
> Hm, transparent_hugepage is in sysfs (/sys/kernel/mm), but not sysctl, at least
> in my case the sysctl tool doesn't list it. Yours does? Yay for consistency.

Oh, whoops! That was my mistake; my eyes skipped out of /proc/sys ;)

> > I like the idea if just for having to build less boiler plate for
> > supporting things that I've had to plumb to both boot_params and sysctl.
> > :)
> 
> Thanks, I will pursue the idea further then :)

Awesome! I've wanted this for a long time but never had the time to give
it a try. :)

-- 
Kees Cook
