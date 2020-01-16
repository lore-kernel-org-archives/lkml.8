Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F508C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DA02072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579188140;
	bh=Ku2aKwOP6DpwDuz0lw1HoPs2qvU3odL5bVvT1r9AdRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SDn9uAKKGLRa2RgOf7SmIIMZZRCDciVXgRU6Ev94FTnMyyDjLPYmgEQ9+m/eofuIc
	 HAW/equKjBDaqGmiy1dTf984gvbGuLeYSTmF8mXLbxptht3Eayc3O5U2HtSRZ7++At
	 AmYYp9oTB01hQ+8+ZcWkEEXf0WmC+vq6DPgZa9OU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgAPPWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:22:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40401 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgAPPWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:22:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so19549796wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 07:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FTzYumS8YOtnp3SJI0/nekGMa3Yhr59tUFnF0F2ptLU=;
        b=NdfWRXPZ2Qj+9Ie9rMFmSzcQO6QgaHigrvVSAdbsdKebbsMNYJAc8dIBfNwgHSbZE2
         KF12xrtz7HGwweQZh0w9/6yn+BXyeYa9cJs50Uflm6+diOYgvWPv6qFhFtmx9ocec+un
         XjFHeM8BdOwiqozA0SZe3EVZuUU9X2AjOtXiqBWKGau1CiClMQOubaJ9mmU8fJdk1avT
         temsNkOEi7hdXRPE3+JE43vHJFgEpcuE2Ugazi6wSyM9cV3kG/4YpEu3IV5qRFEGgXA8
         IOTpBumXy7QqU+h4kkcBVgdt6fnRBxV4kwA6NIXEylLqP+ogUdpErIqvtiku6zeLQie/
         7U3g==
X-Gm-Message-State: APjAAAWDVfFKqpr5NXV+72uhbmOxT8n1ertZkyqRnBJfTHOZgt79qQNL
        XV29p8eYTm0C/JVAJKxO1vY=
X-Google-Smtp-Source: APXvYqzM/cpTWKsf6QyyMx22ufqT++w4rkUpgAUuSjNwYreF7woTpENfGFHaB4N9Fu9yjJ35D7NQMA==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr3776668wrn.251.1579188136862;
        Thu, 16 Jan 2020 07:22:16 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id u22sm31139535wru.30.2020.01.16.07.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 07:22:16 -0800 (PST)
Date:   Thu, 16 Jan 2020 16:22:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Donald Dutile <ddutile@redhat.com>
Subject: Re: [PATCH v4] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-ID: <20200116152214.GX19428@dhcp22.suse.cz>
References: <20191217193238-1-cheloha@linux.vnet.ibm.com>
 <20200109212516.17849-1-cheloha@linux.vnet.ibm.com>
 <181caae3-ffb8-c745-a4c9-1aef93ea6dd5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181caae3-ffb8-c745-a4c9-1aef93ea6dd5@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-01-20 20:09:48, David Hildenbrand wrote:
> On 09.01.20 22:25, Scott Cheloha wrote:
> > Searching for a particular memory block by id is an O(n) operation
> > because each memory block's underlying device is kept in an unsorted
> > linked list on the subsystem bus.
> > 
> > We can cut the lookup cost to O(log n) if we cache the memory blocks in
> > a radix tree.  With a radix tree cache in place both memory subsystem
> > initialization and memory hotplug run palpably faster on systems with a
> > large number of memory blocks.
> > 
> > Signed-off-by: Scott Cheloha <cheloha@linux.ibm.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Nathan Lynch <nathanl@linux.ibm.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Soooo,
> 
> I just learned that radix trees are nowadays only a wrapper for xarray
> (for quite a while already!), and that the xarray interface shall be
> used in new code.

Good point. I somehow didn't realize this would add more work for a
later code refactoring. The mapping should be pretty straightforward.

Thanks for noticing!

-- 
Michal Hocko
SUSE Labs
