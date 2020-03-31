Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F512073B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LPlrAqLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgCaS0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:26:55 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53247 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgCaS0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:26:54 -0400
Received: by mail-pj1-f67.google.com with SMTP id ng8so1431095pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=64CGxkVCN+tpcc5h0TLuNJ8a0+sAEqYpYu5ixxZ2mkg=;
        b=LPlrAqLP/r1SwN4Ni33l2KQkmUbmZQ5e2B8/T0hekORvqd7ZHsRdfVBuFJ+71qMGlI
         iNcSc7h4BDQPrR6lBAbeSfC2UjMpqitCX+rfJozQiFTo44sIVa9v3gYfOM6/hxSNwtAc
         SVRlyESM7ogE4R8gp9eKC7Bd4vn/+TDLdg1jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=64CGxkVCN+tpcc5h0TLuNJ8a0+sAEqYpYu5ixxZ2mkg=;
        b=WBB7acxBYBls+SyKNGlTGcjsfhxV0eLN/qoKJ3uk92UxTyuWBuTYQHXGq/VGkRaRZR
         DqCOcfVtyGNIpqO1aBh861UPoX17X4d8gzHOYUVqnAyfvYH5ryXj6Woz7OT+vm734Yh0
         wiV1miaX11uByNhaAs9iUpGqJHMlcGiL2IPzoN0qIqn8JCxWP4KUSBEg5jkswBbmHsy3
         O8kqmV2WO2v0sZ+9AravoJFpFM8TnGTHMVdgMDgDP07NRVS7P36rJ1Wv7rwKbcYS38ml
         RXc3XubUy8kkrj8+QHHl0neDqpniMUWOGWcEbXAtjBkXeJNGk6xfvPHZ49ZQuK74nbSG
         dWtw==
X-Gm-Message-State: AGi0Pua5thXRA9XbvPJ4dMUEkljipIqfgud+BmOpHkRA7FteSFeSw76b
        csP7y0G3GgaSbWsmcp6+OxLG7w==
X-Google-Smtp-Source: APiQypKI94JfKPIkpz/wT7WensQDX/0VxvYe7qtJDDSNIyHzhN59+sKmEZbVAOJ/tlrINrMpXAwDwA==
X-Received: by 2002:a17:90a:3606:: with SMTP id s6mr172866pjb.195.1585679213559;
        Tue, 31 Mar 2020 11:26:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r9sm8228895pfg.2.2020.03.31.11.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 11:26:52 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:26:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <202003311125.939F851A6@keescook>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
 <20200330224422.GX11244@42.do-not-panic.com>
 <8146e3d0-89c3-7f79-f786-084c58282c85@suse.cz>
 <20200331074836.GB30449@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331074836.GB30449@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:48:36AM +0200, Michal Hocko wrote:
> On Tue 31-03-20 09:42:46, Vlastimil Babka wrote:
> [...]
> > > Should we not do this, we'll have to live with the consequences of
> > > supporting the full swoop of sysctls are boot params, whatever
> > > consequences those may be.
> > 
> > Of course when the first user tries to set some particular sysctl as boot param
> > and finds and reports it doesn't work as intended, then it can be fixed or
> > blacklisted and it can't break anyone else?
> 
> Absolutely agreed. I would be really careful to not overengineer this
> whole thing.

Right -- this is supposed to be _simple_, and I think that's the primary
benefit here. If we encounter problems we can fix those cases. The
careful place, I think, needs to be with converting existing boot params
to be aliases. That's when timing considerations need to be taken into
account carefully.

-- 
Kees Cook
