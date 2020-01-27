Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8487FC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473FA21739
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580134601;
	bh=VXjYEJj3UelbR/kPZSM2sru72nT+0NHrWpiKo6RVWJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gskn1pyT/Bo56RAkodWg2JKBca4URR2jGVGNmdRGPiagJ9/oTdwnbbp2sSjrFc9TM
	 4L8d839+7EuZh40m2aoWeJGvStzY6WDEzjxhFS2ClD3uPVTupgyO0T8TvVQjameSFm
	 0mk0nCQAZT0aubeVBj4dodoUKtOXhyv8hi2xEmi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgA0OQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:16:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34068 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbgA0OQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:16:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so11507139wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 06:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DkvRnFrIduPIix090QyLIYPQKb3q4K6CEnQkAFKQZwg=;
        b=q0K75DCgQu5INZGVpGN0/KoyjtYdVCcMc41ncZC97USdvHF7ouH5EJM1vt49oMY/h1
         vesVdkVV/O9OH/Zr/kn5D82sN4ckMOjZ24KhMpmh6aFrtSgUUl9hHAGck1MLDpDwhAdV
         SzuSR4lHuiQsbyuHoHjs830b/ryQIWJ97T+s47KJS7VuNek1PbJ59Kx9Y2p+CKs7CM7+
         iL7O6IVukobgdFgWreyU8ovvYlbINUOjwD5aAzIIujmkqPNz64sMPTFa7ICAqO8wzTLW
         8ZK9PKAjsl9o8HrMZ2XqPX1yNeWhQU5HwnDPuHzKP55f09bdB9NvOX79H9GkQpS4l+EY
         dl6A==
X-Gm-Message-State: APjAAAWJSsH12MA7lalIBhMa19qiuqjov2tcjY6wm8CYaSkuQuUcoPCl
        2BTeE/EDtMOUzRKb0ja1eFU=
X-Google-Smtp-Source: APXvYqzjTmKdv356FLcmpgivvubhHonm9BDTJSRy6tE0JEMYnoqthPlwXla/efzG9MFagbAvTJLFxg==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr21637678wrv.79.1580134598275;
        Mon, 27 Jan 2020 06:16:38 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id q15sm20947373wrr.11.2020.01.27.06.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 06:16:37 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:16:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Luigi Semenzato <semenzato@google.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>
Subject: Re: [PATCH 1/2] Documentation: clarify limitations of hibernation
Message-ID: <20200127141637.GL1183@dhcp22.suse.cz>
References: <20191226220205.128664-1-semenzato@google.com>
 <20191226220205.128664-2-semenzato@google.com>
 <20200106125352.GB9198@dhcp22.suse.cz>
 <CAA25o9S7EzQ0xcoxuWtYr2dd0WB4KSQNP4OxPb2gAeaz0EgomA@mail.gmail.com>
 <20200108114952.GR32178@dhcp22.suse.cz>
 <CAA25o9Q4XP8weCNcTr1ZT9N7Y3V=B90mK8mykLOyy=-4RJ_uHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA25o9Q4XP8weCNcTr1ZT9N7Y3V=B90mK8mykLOyy=-4RJ_uHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-01-20 08:37:12, Luigi Semenzato wrote:
[...]
> The purpose of my documentation patch was to make it clearer that
> hibernation may fail in situations in which suspend-to-RAM works; for
> instance, when there is no swap, and anonymous pages are over 50% of
> total RAM.  I will send a new version of the patch which hopefully
> makes this clearer.

I was under impression that s2disk is pretty much impossible without any
swap.
-- 
Michal Hocko
SUSE Labs
