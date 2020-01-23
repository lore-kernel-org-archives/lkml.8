Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FB1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68E124683
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579770823;
	bh=WRzwJNR6jg+B3HOocJRb5HPmGvFQ1z/4qJ6S0Sl0M/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vD2y610mqCVliQYTyrT3iL9qiL5f9nKQBSugFxphkEbPrJRUArquVB+ji5tJGUkAz
	 9yzroE8Pp83atYzjysdB78TSBVoogz4uqkE3s7i+yGFQ7ddirs1gWvDag1sgfmAedz
	 3eZap6v3IgDLZfN5xOv5xG1EM8oMbeDj6CMlEDVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgAWJNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:13:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52231 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWJNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:13:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so1716727wmc.2;
        Thu, 23 Jan 2020 01:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SPWcVpEqvJz7GbyQVkDaNDKstaVbETmXMkdMpDNo2i8=;
        b=S7QUpyDkF/OGTMIK5+k+x2kyLXtQ1rgU/bV2fXZ1M5sXE1mlR+EsxMviA1/W4qiG69
         WAMmCxm8uaYb1PlKa3aJwbyk3nXyr57e6xqIyrdRRlI+b/bVeYEqgrYi7jGnYjYeN5YH
         ZDDQiGegblG9bzrzAtP//N2dAS34YBlDj/EBf1cjNAuKTbwImEpg4mx+cFCdHr7nt2zk
         fjsksBJPjcXPwLFT/t3bI5sNV5lr4wPa+LPgcZ6vZZRhuLV5zdOBNjBvSvXum5Gogz/C
         mk8fKPvt7U+ITKcHO/cUADi++orgyGJqsIhyh3QwRo/go8C0cIHrgaLIgZEfER5LJlva
         Vs8Q==
X-Gm-Message-State: APjAAAUZ1TX3B8lHRzAtjGAPlSJEwv/cLMYV+nDMzi9079m6yhHiyCet
        UFX8MFRjlwauXcMoUpXbDCQ=
X-Google-Smtp-Source: APXvYqxcYhcAWeRgYJpVo8HYAfmCV39KAnYESYEedoa8zu1GS1GiJSAtq9Gy4H1+2j3pOg4pwIhUvA==
X-Received: by 2002:a05:600c:10cd:: with SMTP id l13mr3152431wmd.102.1579770820674;
        Thu, 23 Jan 2020 01:13:40 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id g21sm1846838wmh.17.2020.01.23.01.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 01:13:39 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:13:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     sspatil@google.com, kirill@shutemov.name,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        oleksandr@redhat.com, surenb@google.com, timmurray@google.com,
        dancol@google.com, sonnyrao@google.com, bgeffon@google.com,
        hannes@cmpxchg.org, shakeelb@google.com, joaodias@google.com,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200123091339.GI29276@dhcp22.suse.cz>
References: <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <20200117155837.bowyjpndfiym6cgs@box>
 <20200117173239.GB140922@google.com>
 <20200117212653.7uftw3lk35oykkmb@box>
 <20200119161431.GA94410@google.com>
 <20200120075825.GH18451@dhcp22.suse.cz>
 <20200121183212.GF140922@google.com>
 <20200122082853.GS29276@dhcp22.suse.cz>
 <20200123014131.GA249784@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123014131.GA249784@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-01-20 17:41:31, Minchan Kim wrote:
[...]
> What do you want to see further?

Either a consensus that it is sufficient to have an inherently racy
interface that requires some form of external sychronization or
a robust interface that can cope with races in a sensible way.
And no, having a flag for future extension is definitely not the
way how a new API should be added. Seriously!

-- 
Michal Hocko
SUSE Labs
