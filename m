Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D45217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCvThtJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgAVT3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:29:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34982 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgAVT3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:29:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so353973lja.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 11:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/8PhwQ7PARQ3iAPf2q6hZ8qBDbIwXVdDfMoRjqypk98=;
        b=VCvThtJv4iskIOTDyB9qsKIzrebzj7NOZKES1kA/7kGsmEoslzuSc4Y0CEusiLFbfl
         sJq/RASWZ8dtWjqJQsZTpblBu+LqE9E1y6RAK2kVXxfN135JczX8ersybzLckQwUBqnS
         1Tikd506F0Ssgrvngx2P5XxR7FD+UHnpS6x0+USCjinW6ajxGUQIZa1UI45NP3tMnHro
         2mbz16dMb4OhnegNSThBC9CEf/O+BjtdPFN3FefK0ibTxi6O/wkMLwLnHoooYwyciHqV
         dvzaXwKhS+Pwgv0aQfiMNHynikhdfoHRDALhRvkeq9URmdzyo7jaVNf6bWmC6RF9UOTU
         5ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/8PhwQ7PARQ3iAPf2q6hZ8qBDbIwXVdDfMoRjqypk98=;
        b=hwInYg0CzHqUTflJ7wUxLZjB22SOkJcUIG+AO4vZgma/PRspBORsJwScrgsgkwrJQ2
         eh96GbObMp7U/Z812br1EQmjT4sii3m1mPXvhiGX0Unc8TkLZ2rzqG86UKPR5/1GIiKl
         rAfbN9AWJoMW3plHnosZwit15GHPYGU0sQ6dOrsfs5b/WCgnnqataKlalI9EgrhawUUL
         lzc/7uB4YDFEwWzasnGkI+r2Lk4y7O+3tklGZYF5oMEbt4vd6hSo25cRXHdppdBEOkiC
         z/fMN/Quq2hZM+beMI4FT374jMmfJHH0IIxyQ3r+/qW97btKI8tDftwrdf19ZlbpHXnK
         oGEA==
X-Gm-Message-State: APjAAAUMdrjqbfnFpNv8LK/mebOVskqrFzSTIIybXwBPGRRtE6Q+QTz/
        XOGuPCTr8/VBeesHlPLidM5EOCrCGQ8=
X-Google-Smtp-Source: APXvYqy+gzbHyUdRL9gnZYWc8spxT1lXWBy/CFwfDTyW2yF4ZI3vJMX5jz63JWhUaCJ9WqVOknpG1A==
X-Received: by 2002:a2e:943:: with SMTP id 64mr20475535ljj.17.1579721385988;
        Wed, 22 Jan 2020 11:29:45 -0800 (PST)
Received: from uranus.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id y23sm20854173ljk.6.2020.01.22.11.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 11:29:44 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 2814446180B; Wed, 22 Jan 2020 22:29:44 +0300 (MSK)
Date:   Wed, 22 Jan 2020 22:29:44 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, alex.shi@linux.alibaba.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bigeasy@linutronix.de,
        pankaj.laxminarayan.bharadiya@intel.com, aubrey.li@linux.intel.com
Subject: Re: [PATCH] x86/pkeys: add check for pkey "overflow"
Message-ID: <20200122192944.GL2437@uranus>
References: <20200122165346.AD4DA150@viggo.jf.intel.com>
 <20200122185111.GK2437@uranus>
 <99b572a5-6a98-d22a-01f1-8bab60e96155@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b572a5-6a98-d22a-01f1-8bab60e96155@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:09:47AM -0800, Dave Hansen wrote:
> On 1/22/20 10:51 AM, Cyrill Gorcunov wrote:
> >> +	/*
> >> +	 * This code should only be called with valid 'pkey'
> >> +	 * values originating from in-kernel users.  Complain
> >> +	 * if a bad value is observed.
> >> +	 */
> >> +	WARN_ON_ONCE(pkey >= arch_max_pkey());
>
> > Should not we rather abort this operation and exit with EINVAL
> > or something similar instead of calling wrmsr with overflowed
> > value? IOW,
> > 
> > 	if (pkey >= arch_max_pkey()) {
> > 		WARN_ON_ONCE(1);
> > 		return -EINVAL;
> > 	}
> 
> I don't feel strongly about it.  The reason I didn't do that is to
> minimize the chance that this would cause any functional regression.

OK, I don't mind leaving just WARN_ON_ONCE.

> 
> It's not a huge chance, but I've certainly fat-fingered my share of
> off-by-one bugs.

Heh :)
