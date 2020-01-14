Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D7DC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139592467D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="CWwvQIMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgANKbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:31:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43409 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:31:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so13695634ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 02:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gH2onGwJqIgSVIVO9iF6x/48+kAkgINLPogWn+IxdXo=;
        b=CWwvQIMaFeGbGcccImhlvs+GWFEMa+s41DfLTdi1dEYXmM/c9ttvKpEVFZ3dqVHpAZ
         J1ZSto4Ma/A2rGpMzgBYWcSOtodiUWd8S/F3Qs5FtRli34jgB7d8FirhpsFA09NtKmiL
         7wggFVGtiFPUYJIFhzWaKeeGtyqMEDkyRMWSqSJBQzTt3IG/infOvP9BWGKVH9rGn/k0
         yXN0lMiLBlXfnNRVSj6EykH/yYhTGG3+qiiJ7+LK9ocNN9jYW+lId5t9wGBLib03Lyv/
         J4G7pK3IEIDviBleMQLqtKlxPxv0OcSo4pVcwadkegBN/Uwrg3xsYNLaBTHmyFqcX+uh
         ut3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gH2onGwJqIgSVIVO9iF6x/48+kAkgINLPogWn+IxdXo=;
        b=ImdAmo2rY/GseTtJGYN5CzbUw1V0UV4IbJgmiQ2phbzchlUgsLjobcZjomg0Qje9kI
         IlLxZENKXmK6tOtAJtcrU3XCBxFhIgwLKqDa4zvgtrzSD8F4yiya59mYTOnmESN5wPxO
         YzsUYoRlFbDyEWOzUjpQfEH2tSJkKsupIuAvFCnbNfDiZprsoVQ20w8I2Fe/QfvSknUv
         y1RKlO/YkBD2MxAargYY0jz4TU69B+6fyJmrddZNVTSkyjqUcAvKiGdRgaiNwZS/YppM
         q5x9aVGTDXs4Pt8m8iLeA70Jnc+RZeElsTDp/nzu4B1wARHl7TxXe/TE7fu0b/vHqOIx
         /QlA==
X-Gm-Message-State: APjAAAWbW8oBuKCvQSs016EEwGGidX6/OPTw9GbMNFN7nEEr4Yp9HySM
        nN9U4b3oUAL3FJDSGI2efr3YYg==
X-Google-Smtp-Source: APXvYqysJMZ2wctkZa481wCr4cDEEoTAjvmfbiYs1X+0OFb3uAQSoP+nU4jvncbrrWPLPosgB3gMvQ==
X-Received: by 2002:a2e:b010:: with SMTP id y16mr13956962ljk.238.1578997870606;
        Tue, 14 Jan 2020 02:31:10 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c189sm7081166lfg.75.2020.01.14.02.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 02:31:09 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A0F64100823; Tue, 14 Jan 2020 13:31:12 +0300 (+03)
Date:   Tue, 14 Jan 2020 13:31:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, alexander.duyck@gmail.com,
        rientjes@google.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200114103112.o6ozdbkfnzdsc2ke@box>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
 <20200111000352.efy6krudecpshezh@box>
 <20200114093122.GH19428@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114093122.GH19428@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 10:31:22AM +0100, Michal Hocko wrote:
> On Sat 11-01-20 03:03:52, Kirill A. Shutemov wrote:
> > On Thu, Jan 09, 2020 at 10:30:54PM +0800, Wei Yang wrote:
> > > As all the other places, we grab the lock before manipulate the defer list.
> > > Current implementation may face a race condition.
> > > 
> > > For example, the potential race would be:
> > > 
> > >     CPU1                      CPU2
> > >     mem_cgroup_move_account   split_huge_page_to_list
> > >       !list_empty
> > >                                 lock
> > >                                 !list_empty
> > >                                 list_del
> > >                                 unlock
> > >       lock
> > >       # !list_empty might not hold anymore
> > >       list_del_init
> > >       unlock
> > 
> > I don't think this particular race is possible. Both parties take page
> > lock before messing with deferred queue, but anytway:
> > 
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> I am confused, if the above race is not possible then what would be a
> real race? We really do not want to have a patch with a misleading
> changelog, do we?

The alternative is to make sure that all page_deferred_list() called with
page lock taken.

I'll look into it.

-- 
 Kirill A. Shutemov
