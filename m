Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41732C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206E12467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579720148;
	bh=SF82HcEZFZ0i+y/moyJ5f2m5rvBDb1vcPQtK9Lh3P0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zfQCUHYc0dV9H/w+g0B9SBv4rharT60zw9srH89myUWqELAGf/UdVac5AAbu4aNlH
	 3UxmQE4BiJSPw3FwGgUEhSoq7pkEVriaKWlS8fNFCqWWxhAU0MIEog+qM8E5WelOX0
	 q+qb9A6c2Vy3TicUwIuBS3kHpBstEtbzyR8blvJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAVTJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:09:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38041 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVTJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:09:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so283746wrh.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 11:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jDrouBSrTch1oRjGKu1kF0MMLpGbHzjzsyn2ncqxth4=;
        b=pI5r8bF6dNG0uxYTSCzx34d5ZsAwoIs+p5NbHvIJuJGtEBn5Fk8KhWxX1bbGeOV8Sk
         zwL0e5Hcxnwa2tZSRo5x/wQ+lxyoBypXsKwSibl7vhXDpvuqInt7MtiC2Ham0hAibODr
         A3pfdUWOXgyr9SVVK+veP+0UeriRozlNFmOc2W1/kmQmSkZzVdtsMSwukGDm7jrhbsdQ
         yKiTPnwiJG76pMVd/uFurHYbE3g0sy+hMOtPj6B1x+ix/tZr/WieEgwnEvmdhvdPmRs1
         dk6n2FxNqhjeZO9UNb8ucdcPR8DwqQ9LD4hIHXFOPDXdhlJoDPi2N+dsEKL4uiJaL6f7
         W+9g==
X-Gm-Message-State: APjAAAV5obcmtgTYOwydFCIUmSddJoU4RuWGLestNJSIzWv96Y2P2u5e
        1wSkBBgTeYLKA2dCPcRnRBk=
X-Google-Smtp-Source: APXvYqzMXEKmV9WZyNBUnEiqdP7WtvzjVGR6C9yz/OiUdoKzI0eFO2vOshMLGfSUDVyLMFtEMLdlbg==
X-Received: by 2002:adf:e290:: with SMTP id v16mr13251085wri.16.1579720145425;
        Wed, 22 Jan 2020 11:09:05 -0800 (PST)
Received: from localhost (ip-37-188-226-95.eurotel.cz. [37.188.226.95])
        by smtp.gmail.com with ESMTPSA id x11sm5147651wmg.46.2020.01.22.11.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 11:09:04 -0800 (PST)
Date:   Wed, 22 Jan 2020 20:09:03 +0100
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
Message-ID: <20200122190903.GD29276@dhcp22.suse.cz>
References: <a5f0bd8d-de5e-9f27-5c94-7746a3d20a95@redhat.com>
 <20200121120714.GJ29276@dhcp22.suse.cz>
 <a29b49b9-28ad-44fa-6c0b-90cd43902f29@redhat.com>
 <20200122104230.GU29276@dhcp22.suse.cz>
 <98b6c208-b4dd-9052-43f6-543068c649cc@redhat.com>
 <816ddd66-c90b-76f1-f4a0-72fe41263edd@redhat.com>
 <20200122164618.GY29276@dhcp22.suse.cz>
 <626d344e-8243-c161-cd07-ed1276eba73d@redhat.com>
 <20200122183809.GB29276@dhcp22.suse.cz>
 <f35cbe9e-b8bf-127e-698f-d08972d30614@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f35cbe9e-b8bf-127e-698f-d08972d30614@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-01-20 19:46:15, David Hildenbrand wrote:
> On 22.01.20 19:38, Michal Hocko wrote:
[...]
> > How exactly is check + offline more optimal then offline which makes
> > check as its first step? I will get to your later points after this is
> > clarified.
> 
> Scanning (almost) lockless is more efficient than bouncing back and
> forth with the device_hotplug_lock, mem_hotplug_lock, cpu_hotplug_lock
> and zone locks - as far as I understand.

All but the zone lock shouldn't be really contended and as such
shouldn't cause any troubles. zone->lock really depends on the page
allocator usage of course. But as soon as we have a contention then it
is just more likely that the result is less reliable.

I would be also really curious about how much actual time could be saved
by this - some real numbers - because hotplug operations shouldn't
happen so often that this would stand out. At least that is my
understanding.

> And as far as I understood, that was the whole reason of the original
> commit.

Well, I have my doubts but it might be just me and I might be wrong. My
experience from a large part of the memory hotplug functionality is that
it was driven by a good intention but without a due diligence to think
behind the most obvious usecase. Having a removable flag on the memblock
sounds like a neat idea of course. But an inherently racy flag is just
borderline useful.

Anyway, I will stop at this moment and wait for real usecases.

Thanks!
-- 
Michal Hocko
SUSE Labs
