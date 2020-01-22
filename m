Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5F1C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629602468C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579689755;
	bh=oC232aLcldtyrM3nflhhR6xMvRyBp754IDnOGVNfIYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AUIDm/0e1UBNh7qIm6AcRq27uLdM6sMEdNNZK2dY15D+hLc5nJk9ZaqQcTfhUy3Z9
	 5i3agcfC3lMQb5yWT9fpBDJvLJgr5efujQAaMg8r6S1OioEXcdRWOQ2wdxHz2srlrG
	 KJfBNPBlXDPCMlVtPpi16rs8TxveoXyS1Vkes1Yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAVKme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:42:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36706 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgAVKme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:42:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so6629107wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 02:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZWrcztGPEdmdljU6rzvPLWUWlGRg7cvJpWEcVwcN7o8=;
        b=k/U0AaJwtoLhpUlr1Z8OEtZUc+8R4HZWPBFdHB69XLaajdysBt1yr2lsjL46K1EQNI
         DqvNLcr3MSp2aXjmGN8BFBjKuS4za22poJV8XHksTdeQyZUBAL195+qHqpJ0DG6IHO7V
         3ytgFGurXlrG/NtEfHTqgE8E9Nurv9mh9Kq1XwAr7JPKBzFf65T7k28VJ3wdIP8SXX2n
         EZDVNLU+BqcQjaKd5FX+G1FTHeyJSqm4RR7dBvTw2wkdUcua5eWGf/C9q1xgLE3bkHbU
         5lahq0mJDKHaIMS0wzvD9/1CnhPP2H7ikeABDr8J7gPyS3LfWZqU8hkYYiNlXxbI5cAH
         ni+A==
X-Gm-Message-State: APjAAAVXnGZXGe4m1fEsfIcwwevVCLpzHiWt9ktyC/eD03EoRjRlt93W
        meD/hkKblgYrmNCW33/NdJU=
X-Google-Smtp-Source: APXvYqwOXY4WlwXUfJ7If8qgml0d4AG62OZDyxS9ZDP0CGgPABYQ40tZm0CAz1TQujq4tDsEx0hzfw==
X-Received: by 2002:a1c:4b01:: with SMTP id y1mr2205649wma.12.1579689752151;
        Wed, 22 Jan 2020 02:42:32 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id b17sm56037447wrp.49.2020.01.22.02.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 02:42:31 -0800 (PST)
Date:   Wed, 22 Jan 2020 11:42:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
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
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        lantianyu1986@gmail.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH RFC v1] mm: is_mem_section_removable() overhaul
Message-ID: <20200122104230.GU29276@dhcp22.suse.cz>
References: <20200117145233.GB19428@dhcp22.suse.cz>
 <65606e2e-1cf7-de3b-10b1-33653cb41a52@redhat.com>
 <20200117152947.GK19428@dhcp22.suse.cz>
 <CAPcyv4hHHzdPp4SQ0sePzx7XEvD7U_B+vZDT00O6VbFY8kJqjw@mail.gmail.com>
 <25a94f61-46a1-59a6-6b54-8cc6b35790d2@redhat.com>
 <CAPcyv4jvmYRbX9i+1_LvHoTDGABadHbYH3NVkqczKsQ4fsf74g@mail.gmail.com>
 <20200120074816.GG18451@dhcp22.suse.cz>
 <a5f0bd8d-de5e-9f27-5c94-7746a3d20a95@redhat.com>
 <20200121120714.GJ29276@dhcp22.suse.cz>
 <a29b49b9-28ad-44fa-6c0b-90cd43902f29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a29b49b9-28ad-44fa-6c0b-90cd43902f29@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-01-20 11:39:08, David Hildenbrand wrote:
> >>> Really, the interface is flawed and should have never been merged in the
> >>> first place. We cannot simply remove it altogether I am afraid so let's
> >>> at least remove the bogus code and pretend that the world is a better
> >>> place where everything is removable except the reality sucks...
> >>
> >> As I expressed already, the interface works as designed/documented and
> >> has been used like that for years.
> > 
> > It seems we do differ in the usefulness though. Using a crappy interface
> > for years doesn't make it less crappy. I do realize we cannot remove the
> > interface but we can remove issues with the implementation and I dare to
> > say that most existing users wouldn't really notice.
> 
> Well, at least powerpc-utils (why this interface was introduced) will
> notice a) performance wise and b) because more logging output will be
> generated (obviously non-offlineable blocks will be tried to offline).

I would really appreciate some specific example for a real usecase. I am
not familiar with powerpc-utils worklflows myself.
-- 
Michal Hocko
SUSE Labs
