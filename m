Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD14C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB6C2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579719685;
	bh=CHM75zSZ/TedncarmQL8C+IVurU7Wx4TGIyw4JQRH6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eLoGhv8ux23hSWE+4Y/1XtxhQP233x8jrGhlpzXp4vYIfdmQKcbz1vjLxG80KRYfi
	 dM9AX3cLUoEfaF4GlW8YqzAHo4BDlH4IfB+QROJlf9eUklUuo302fIPvHJkg9Gw7T8
	 G1MMMOp+9mmO7S4oDeKUDOrOpjplT5/jRqp6iqng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgAVTBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:01:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43588 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:01:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so222769wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 11:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fT9C07XJeWXduryKww0OrfVFvwMrniAzDyvK44e5lz0=;
        b=i33W+hhv50wd1Mn0ylRUIbsk49bnc0j1JhGffWnCXB5TRsHSEWc3ywczNC+ogDH95q
         oIn6Qkde6i1Lz7MN0L/CUTPFYgJsT7hHufn5kI22A2gGYdDHewiS8e3N29x8ZZy+5xz0
         X7mt81ZlARKSmn3zGcqBcZYeOxI2Ar/EmbJmiAwrdr3MtOZw1wmFtd9TpNNuAkVyfmae
         4EQ3EuYK02KgGElJD283lZUHsNoZev8xMRB5IUjwYGgze+/9jNpev+QRXRYEPP1hX9gv
         cA/G6a56YnwZ2FTC37LSCm+iLPBIgyCu1X45U+2FJLDxAV4zz/s3vejqgBKdZpA+k6tf
         9pVg==
X-Gm-Message-State: APjAAAX01gzbD0uD7ImptkIGMg15lTKQEDRIP06rvJYqQ3w2qPqzT7GI
        DEegINeHYdYgFA9N/q3Fx5Q=
X-Google-Smtp-Source: APXvYqxPdbYCg4L9bE7BRZEYEC1YrA7Upz5yoZhAO3MKUClY2b0pknHNAtukj+4rsWFGeDRl6v6VSg==
X-Received: by 2002:adf:f484:: with SMTP id l4mr13322597wro.207.1579719682852;
        Wed, 22 Jan 2020 11:01:22 -0800 (PST)
Received: from localhost (ip-37-188-226-95.eurotel.cz. [37.188.226.95])
        by smtp.gmail.com with ESMTPSA id a132sm4927254wme.3.2020.01.22.11.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 11:01:21 -0800 (PST)
Date:   Wed, 22 Jan 2020 20:01:20 +0100
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
Message-ID: <20200122190120.GC29276@dhcp22.suse.cz>
References: <CAPcyv4jvmYRbX9i+1_LvHoTDGABadHbYH3NVkqczKsQ4fsf74g@mail.gmail.com>
 <20200120074816.GG18451@dhcp22.suse.cz>
 <a5f0bd8d-de5e-9f27-5c94-7746a3d20a95@redhat.com>
 <20200121120714.GJ29276@dhcp22.suse.cz>
 <a29b49b9-28ad-44fa-6c0b-90cd43902f29@redhat.com>
 <20200122104230.GU29276@dhcp22.suse.cz>
 <98b6c208-b4dd-9052-43f6-543068c649cc@redhat.com>
 <816ddd66-c90b-76f1-f4a0-72fe41263edd@redhat.com>
 <20200122164618.GY29276@dhcp22.suse.cz>
 <626d344e-8243-c161-cd07-ed1276eba73d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626d344e-8243-c161-cd07-ed1276eba73d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-01-20 19:15:47, David Hildenbrand wrote:
[...]
> c) CC relevant people I identify (lsmem/chmem/powerpc-utils/etc.) on the
> patch to see if we are missing other use cases/users/implications.
> 
> Sounds like a plan?

I would start with this step. Thanks!
-- 
Michal Hocko
SUSE Labs
