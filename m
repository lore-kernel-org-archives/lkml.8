Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC805C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D932073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579260838;
	bh=bkN7VjEkNSAq/nHwddwONb1PDmkFA9AYVNerP16qYmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y73ZY1/DwfANK8vrBroJjUbRFgdRp/SkXcceJ53P7srZ3e3/YYJk9yqdO9RZXsqZy
	 16ssUfzOvrB1e3iv06K5gWmrD3PiABS2MBm9+jDy7xHaWET/L77Dp2/5OmLmMh7QnI
	 ZlB8r55A0r25PN5b4G4wh/X1klA9h0PL9aCYvL7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgAQLd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:33:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53369 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgAQLd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:33:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so7087217wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 03:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pS6tGirNA5l2St8BRcYo+tvzqyq6o10cg8yYZAWBJ5A=;
        b=R4WBC+VlWYvqC6axq3f652mGllQUkBGx/sHGU8GcbsnRmab9wZJRNhElFlhv3vw/c4
         3liEsKxX+b5K3Zhvne+Xm8xeuRB31Gcou4rxtAexnqdnXjLcriN3HnqS7vcvDmeip/cE
         qGzBTYSBnCfgk6zK5x4JJkq2gaM8Foa1LUa20XQZLjffSI2TFYZaYgfkHBQLSGaplqRt
         CcQSf0FI+45dXBvchsVJHmMngoSdXqQBvjB4UzH9b549l+7k9+GKqfYG7ytZd37fSYx7
         Li1/WnCVYOb6+8j/mJvYcH+/GGQiJ6OwOhdfpGkPOi5Pgm/XFEmWb8E5wFMsYTyavLSL
         NFUw==
X-Gm-Message-State: APjAAAWWy8/SLYyb0BzPliitm0lorbwgytMv3GBK5MgrRMpvWlUGKexm
        uloNP1K3yKnyH5choUtbjHo=
X-Google-Smtp-Source: APXvYqxYYwk3Ieuhh1JlXLR3/Y6vU+ft9LXH9FfnZA5oIVuyDDQ22H4//+d0cssKHwtPEfLC9wp91g==
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr4294224wmf.56.1579260834716;
        Fri, 17 Jan 2020 03:33:54 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id t12sm33450532wrs.96.2020.01.17.03.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:33:54 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:33:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        lantianyu1986@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC v1] mm: is_mem_section_removable() overhaul
Message-ID: <20200117113353.GT19428@dhcp22.suse.cz>
References: <20200117105759.27905-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117105759.27905-1-david@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 11:57:59, David Hildenbrand wrote:
> Let's refactor that code. We want to check if we can offline memory
> blocks. Add a new function is_mem_section_offlineable() for that and
> make it call is_mem_section_offlineable() for each contained section.
> Within is_mem_section_offlineable(), add some more sanity checks and
> directly bail out if the section contains holes or if it spans multiple
> zones.

I didn't read the patch (yet) but I am wondering. If we want to touch
this code, can we simply always return true there? I mean whoever
depends on this check is racy and the failure can happen even after
the sysfs says good to go, right? The check is essentially as expensive
as calling the offlining code itself. So the only usecase I can think of
is a dumb driver to crawl over blocks and check which is removable and
try to hotremove it. But just trying to offline one block after another
is essentially going to achieve the same.

Or does anybody see any reasonable usecase that would break if we did
that unconditional behavior?
-- 
Michal Hocko
SUSE Labs
