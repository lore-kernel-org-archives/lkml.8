Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E22C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9292722522
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579506501;
	bh=ESoMrB1ai8ZXH9TTW1Cn8bEnDCj+zYfN92K/g1TsCp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O22kl+UFLKDEzxEQu6/fNPFkSjk/yzietzjKiU/k87SYHW/a9TiXOyCxIOElA4osy
	 RsbkUD1lydhiF7dSUlY99mk/YAU/HHOtpUJRy1N4/6pMdz1kTeg2b74I+NE0SUnfwX
	 A3rG8IrPt2d16fQ1y5x1Y9fiDtBeRNtXyY9/hvdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgATHsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:48:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46456 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgATHsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:48:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so28328562wrl.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 23:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zqYxlN8e9d1Xz81Z1GDVgte6q0CcV1j9cxyhLBRYIzc=;
        b=p9HJ4veXNlarLtqol+jWVef50Ud8fmZLsaTdr6oy7YjUfCJ4slTr2I95kv42hZ0G2B
         OLpBphP+Po4QuGnSrO9zHIUJrGrr10wJqjLKK3BEVpndpM34JORhtxvNDNaM6ayslwwW
         HLZza1W04k7HGK1rPrMvMr9DI0EOSzD399z/XOWxB/I/KTlAkVUv8Jui8ly0JoRfyNII
         yYi9d7l+C44a1A8/8v0Ibosrb4fAkifY+Xa6FTJntoc31l7YcbI9rsZj46d5cyKj5dKu
         W+AvtAwVE6BGtw/Atbkfl9x+NtsF12CXazE3KbPc5YQqH6ntItZO2XGoPNm2uD7d3Ogn
         CWhA==
X-Gm-Message-State: APjAAAXEphApqkzNxw2kSVKzsNnOJSrLq4UCZd367Y/Z8WC/LNDtB9rr
        1Ry196x2hDzR10Q0gnFINoGNU93M
X-Google-Smtp-Source: APXvYqz1nmDNYIQNXhicabxXmw6QCSsn8nPgAPz6zQN+UoT7JCsFPNK6ech+vI4kj8faRntichl/eA==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr16459256wrr.215.1579506498444;
        Sun, 19 Jan 2020 23:48:18 -0800 (PST)
Received: from localhost (ip-37-188-138-155.eurotel.cz. [37.188.138.155])
        by smtp.gmail.com with ESMTPSA id u16sm3099104wmj.41.2020.01.19.23.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 23:48:17 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:48:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
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
Message-ID: <20200120074816.GG18451@dhcp22.suse.cz>
References: <20200117105759.27905-1-david@redhat.com>
 <20200117113353.GT19428@dhcp22.suse.cz>
 <c82a0dd7-a99b-6def-83d4-a19fbdd405d9@redhat.com>
 <20200117145233.GB19428@dhcp22.suse.cz>
 <65606e2e-1cf7-de3b-10b1-33653cb41a52@redhat.com>
 <20200117152947.GK19428@dhcp22.suse.cz>
 <CAPcyv4hHHzdPp4SQ0sePzx7XEvD7U_B+vZDT00O6VbFY8kJqjw@mail.gmail.com>
 <25a94f61-46a1-59a6-6b54-8cc6b35790d2@redhat.com>
 <CAPcyv4jvmYRbX9i+1_LvHoTDGABadHbYH3NVkqczKsQ4fsf74g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jvmYRbX9i+1_LvHoTDGABadHbYH3NVkqczKsQ4fsf74g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 08:57:51, Dan Williams wrote:
[...]
> Unless the user is willing to hold the device_hotplug_lock over the
> evaluation then the result is unreliable.

Do we want to hold the device_hotplug_lock from this user readable file
in the first place? My book says that this just waits to become a
problem.

Really, the interface is flawed and should have never been merged in the
first place. We cannot simply remove it altogether I am afraid so let's
at least remove the bogus code and pretend that the world is a better
place where everything is removable except the reality sucks...
-- 
Michal Hocko
SUSE Labs
