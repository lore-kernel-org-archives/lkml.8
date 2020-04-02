Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E20C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FCE208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585817899;
	bh=j4bhB5xdwFfogcO9ulwv3wg/RViA0Zrftbeka3e6ExA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A1aWbYYa23Grg+YIXKcVeneAI2o3qcBRlIjnRJQCeybJHlaNW0uyw0KC6ZyoraqoK
	 kCJOinu0m7BPH3qtTZhEYr9cJhYEg4ceTPYgYAuHPGDKJtdVsGYIkrEbavUg72xR9x
	 ZFqF4cIBE2FUuc073BaXvgHUVoH0Ckqv4YJjJ6FY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbgDBI6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:58:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46082 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387780AbgDBI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:58:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so3133097wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 01:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K2JhR4SxbadwlqUN/IjOvykPTmqpzOo0pony5csNGqQ=;
        b=TdB8/+tIpLcy7YJ22AM4BdZlo6t2S+E3UvR3EPTJxwOe9oAtauhprTmPBaSDWHTeFA
         mFEuAM8ASTSBjJCEn72Mlpa0WTyU0h+s0XlwEm9ppwk+w21P8e9AfyZwrfHEJoQ1NKC5
         PcXbZIqur79Z+cCS3QJsmWt29RudoUc33Ll68rdaB0P4EtajjuVO7tmfQGph40b/H+yj
         d2/FgSmDOZSReSKHiDCfkhFHGLnSmIxG6Rx7v92uWiGd5W60kT0nPVfS1saHZNkUZzOp
         WxoMXcV43jBpwjB/9otJLTfQ268r2ZsQ0ItVjWKOaeyRviZ4DDF0Hwn2/RqSA/sJTk/K
         FEsg==
X-Gm-Message-State: AGi0PubuTWnOqIHdYyIrIxtUxZmFTam+t8eQxVVbdzRH6xZKU+w30KoK
        aVdJVqQwp1fOVL3KNZOSuyY=
X-Google-Smtp-Source: APiQypKEO4qfbIDFx5anp0NEC4g9dSqvOO5psAXmB7l8aQ+1idmWuz8szhHxCraEOrWRGY21teZzuA==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr2295801wru.94.1585817895786;
        Thu, 02 Apr 2020 01:58:15 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id j135sm6487770wmj.46.2020.04.02.01.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 01:58:14 -0700 (PDT)
Date:   Thu, 2 Apr 2020 10:58:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?utf-8?B?Su+/vXLvv71tZQ==?= Glisse <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH -V2] /proc/PID/smaps: Add PMD migration entry parsing
Message-ID: <20200402085813.GN22681@dhcp22.suse.cz>
References: <20200402020031.1611223-1-ying.huang@intel.com>
 <20200402064437.GC22681@dhcp22.suse.cz>
 <87zhbufjyc.fsf@yhuang-dev.intel.com>
 <20200402074411.GH22681@dhcp22.suse.cz>
 <87v9mifgui.fsf@yhuang-dev.intel.com>
 <20200402082142.GL22681@dhcp22.suse.cz>
 <a8b089b7-75a8-327c-0418-a5209af0571b@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8b089b7-75a8-327c-0418-a5209af0571b@yandex-team.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-04-20 11:29:09, Konstantin Khlebnikov wrote:
> 
> 
> On 02/04/2020 11.21, Michal Hocko wrote:
> > On Thu 02-04-20 16:10:29, Huang, Ying wrote:
> > > Michal Hocko <mhocko@kernel.org> writes:
> > > 
> > > > On Thu 02-04-20 15:03:23, Huang, Ying wrote:
> > [...]
> > > > > > Could you explain why do we need this WARN_ON? I haven't really checked
> > > > > > the swap support for THP but cannot we have normal swap pmd entries?
> > > > > 
> > > > > I have some patches to add the swap pmd entry support, but they haven't
> > > > > been merged yet.
> > > > > 
> > > > > Similar checks are for all THP migration code paths, so I follow the
> > > > > same style.
> > > > 
> > > > I haven't checked other migration code paths but what is the reason to
> > > > add the warning here? Even if this shouldn't happen, smaps is perfectly
> > > > fine to ignore that situation, no?
> > > 
> > > Yes. smaps itself is perfectly fine to ignore it.  I think this is used
> > > to find bugs in other code paths such as THP migration related.
> > 
> > Please do not add new warnings without a good an strong reasons. As a
> > matter of fact there are people running with panic_on_warn and each
> > warning is fatal for them. Please also note that this is a user trigable
> > path and that requires even more care.
> > 
> 
> But this should not happen and if it does we'll never know without debug.

The migration path which already deals with this will notice, right?
Those are paths which really care about consistency.

> VM_WARN_ON checks something only if build with CONFIG_DEBUG_VM=y.
> 
> Anybody who runs debug kernels with panic_on_warn shouldn't expect much stability =)

That doesn't mean we should be adding warnings here and there nilly
willy.

-- 
Michal Hocko
SUSE Labs
