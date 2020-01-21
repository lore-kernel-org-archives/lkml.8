Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4150C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B28B24655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579608439;
	bh=qlpyw3P06Vv3NMSUE/lxGM8FMm3wUIxQN+5s8d42UcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rXbZgx8vw+jbj1FGI1CRFNJ0+NzhCB6VRWJsA2cR3901oYUPzrrYegU9PyFHKs0g5
	 dlaLhZd87z6PzMX3+QdfvGH4WiNoj2bdNQxLJvxgvNLZ/fZSk5zlehqigLw0NcPg9x
	 T6J2svtm58H3e6drIXrBHCC5GnfbVjMls1s41/oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgAUMHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:07:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33532 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAUMHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:07:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so2941623wrq.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 04:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8+eTFTZWY1O+bS0tfQzZZHJ2QVfVqRuc9/acRYq78eE=;
        b=hiOJXAdP2O+gR+ekHB1Mwz86b2dIgtTLNpA80t2p82XvONwo8BrUJ2NMQPeU5m0jnm
         9mnBESjWlFrZqNNpd0UnrQ8/XUpYnpq5dtH540HwvbbN/Wjv+L3egWr1+aZKlLZA/uez
         RLwt2PGkojlInQC20EhKcMPNGEbWkgZ36LeGsxai91BwcKeo6wsDnWLnFb3iP+XbCO3K
         8MQOrbWa5rEP8ibCMIx4pUUAzkqHs81XayLcgMeTZzRxCKuS5Y0eS5X24uLC7JPevXqw
         HGptcx+PnsFyWZL26gE42SLhrvfPIVD6fZqO3Ci+08+4Ahs9+qEktQ4mG9PKcpvFcKhj
         kHzQ==
X-Gm-Message-State: APjAAAUZKujK7JP/9+sGdZhs0CPkKne7JLjB4qv6qifQNFy3BE3WoB4h
        raCN26042fLlPkwPR4a1dqY=
X-Google-Smtp-Source: APXvYqyxpUkI3wcRNy1BJM6GIVX1qC65Wu9WoeWHqPOsSl8LeuToreKpatoaJ2IPUby2HJ4XnSMCzg==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr4797172wrq.331.1579608436190;
        Tue, 21 Jan 2020 04:07:16 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z83sm3932163wmg.2.2020.01.21.04.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 04:07:14 -0800 (PST)
Date:   Tue, 21 Jan 2020 13:07:14 +0100
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
Message-ID: <20200121120714.GJ29276@dhcp22.suse.cz>
References: <20200117113353.GT19428@dhcp22.suse.cz>
 <c82a0dd7-a99b-6def-83d4-a19fbdd405d9@redhat.com>
 <20200117145233.GB19428@dhcp22.suse.cz>
 <65606e2e-1cf7-de3b-10b1-33653cb41a52@redhat.com>
 <20200117152947.GK19428@dhcp22.suse.cz>
 <CAPcyv4hHHzdPp4SQ0sePzx7XEvD7U_B+vZDT00O6VbFY8kJqjw@mail.gmail.com>
 <25a94f61-46a1-59a6-6b54-8cc6b35790d2@redhat.com>
 <CAPcyv4jvmYRbX9i+1_LvHoTDGABadHbYH3NVkqczKsQ4fsf74g@mail.gmail.com>
 <20200120074816.GG18451@dhcp22.suse.cz>
 <a5f0bd8d-de5e-9f27-5c94-7746a3d20a95@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5f0bd8d-de5e-9f27-5c94-7746a3d20a95@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-01-20 10:14:44, David Hildenbrand wrote:
> On 20.01.20 08:48, Michal Hocko wrote:
> > On Fri 17-01-20 08:57:51, Dan Williams wrote:
> > [...]
> >> Unless the user is willing to hold the device_hotplug_lock over the
> >> evaluation then the result is unreliable.
> > 
> > Do we want to hold the device_hotplug_lock from this user readable file
> > in the first place? My book says that this just waits to become a
> > problem.
> 
> It was the "big hammer" solution for this RFC.
> 
> I think we could do with a try_lock() on the device_lock() paired with a
> device->removed flag. The latter is helpful for properly catching zombie
> devices on the onlining/offlining path either way (and on my todo list).

try_lock would be more considerate. It would at least make any potential
hammering a bit harder.

> > Really, the interface is flawed and should have never been merged in the
> > first place. We cannot simply remove it altogether I am afraid so let's
> > at least remove the bogus code and pretend that the world is a better
> > place where everything is removable except the reality sucks...
> 
> As I expressed already, the interface works as designed/documented and
> has been used like that for years.

It seems we do differ in the usefulness though. Using a crappy interface
for years doesn't make it less crappy. I do realize we cannot remove the
interface but we can remove issues with the implementation and I dare to
say that most existing users wouldn't really notice.

> I tend to agree that it never should have been merged like that.
> 
> We have (at least) two places that are racy (with concurrent memory
> hotplug):
> 
> 1. /sys/.../memoryX/removable
> - a) make it always return yes and make the interface useless
> - b) add proper locking and keep it running as is (e.g., so David can
>      identify offlineable memory blocks :) ).
> 
> 2. /sys/.../memoryX/valid_zones
> - a) always return "none" if the memory is online
> - b) add proper locking and keep it running as is
> - c) cache the result ("zone") when a block is onlined (e.g., in
> mem->zone. If it is NULL, either mixed zones or unknown)
> 
> At least 2. already scream for a proper device_lock() locking as the
> mem->state is not stable across the function call.
> 
> 1a and 2a are the easiest solutions but remove all ways to identify if a
> memory block could theoretically be offlined - without trying
> (especially, also to identify the MOVABLE zone).
> 
> I tend to prefer 1b) and 2c), paired with proper device_lock() locking.
> We don't affect existing use cases but are able to simplify the code +
> fix the races.
> 
> What's your opinion? Any alternatives?

1a) and 2c) if you ask me.
-- 
Michal Hocko
SUSE Labs
