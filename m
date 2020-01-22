Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCCAC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752EB21835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJr8Td39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgAVWwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:52:34 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46371 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgAVWwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:52:34 -0500
Received: by mail-qt1-f194.google.com with SMTP id e25so946298qtr.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 14:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TlzFuMN5WGqxTwmnmnvw8wSSnVNjq0KtrS8uU4t4Cyw=;
        b=CJr8Td396b552XC8GS+pTDnJzuUX+RE2nvYHEPgTShH30TM5zB4C0k0TYkP8U+W4i9
         IGvtpVPvJC46R/tRFjXhEx6X0N0zFNM62bGflWwHuF3uXYE5r8uPcVgz4RuCvXp8ICrH
         nvJqtNcoqjjvTlkd6ZjKDC43QEp1gaxEA/f66SjGSOSFGTviT+fbmLRhjEfMzFuBzmjw
         PGCq2+HGcz0pttVFJ+A4vz1abSsf8M/YnxRv98Z4GpkUgusz1SVwqomEBunRVlgICmT9
         nbOzB4zoP5d1IB6+7AymC5LWPE3xpG0m/XZTIbHEOj9J/V1Ti7rJreNPSbIxjy8Y5rzk
         2mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TlzFuMN5WGqxTwmnmnvw8wSSnVNjq0KtrS8uU4t4Cyw=;
        b=YHFcmeDOToy3PeLS8Lc38HcT2PR22dj/PdlvkQfUfM367mySdq18FZjYV/jbH6kXnj
         ZU15gsqHl4J4uF8nb2IBL6Wn7Bsz8/+8Pbj1uaB5ycMSxoW5PW5ZAIL9Mio8LEULI8Jl
         QLCcJg/f6AgYTNzO4k/u+Jtd7ueW8wzEvGsGocTeg5BlOPc4gXoGNm/f4HVoLO3eGaCK
         NzKK0AhMKkE98TI7SCa3uQEZYwyNeXLOgeG8ved2AIEww5eG5enPqLIJxLo3LS3enZaW
         Gz5wZE+6C/TJnjFjhA0Um8tIQ2Pba3Rr1qZy0F38GS3sKsf9iWShiAE6M97pDbziZc2y
         Wv7w==
X-Gm-Message-State: APjAAAWrbfykLpG9uCnRsB7dnwn1dUAf9yYf0n+YD8t+nL6YW1XJCE54
        2jYT6h3wjBdhHLg80Iawxjs=
X-Google-Smtp-Source: APXvYqyDelrmrc5zRUa7Mbumt+Tl4k73BLnMhcmcyoWFRuMoisfwVVLOZD03O+Cdxe4Yv4ca9aVLUw==
X-Received: by 2002:aed:2150:: with SMTP id 74mr12975461qtc.323.1579733552983;
        Wed, 22 Jan 2020 14:52:32 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p19sm41164qte.81.2020.01.22.14.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 14:52:32 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 22 Jan 2020 17:52:30 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v12] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200122225230.GB2331824@rani.riverdale.lan>
References: <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <20191123003056.GA28761@agluck-desk2.amr.corp.intel.com>
 <20191125161348.GA12178@linux.intel.com>
 <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
 <20200114055521.GI14928@linux.intel.com>
 <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
 <20200115225724.GA18268@linux.intel.com>
 <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200122224245.GA2331824@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 05:42:51PM -0500, Arvind Sankar wrote:
> 
> Peter [2] called this a possible DOS vector. If userspace is malicious
> rather than buggy, couldn't it simply ignore SIGBUS?
> 
> [2] https://lore.kernel.org/lkml/20191121131522.GX5671@hirez.programming.kicks-ass.net/

Ignore this last bit, wasn't thinking right.
