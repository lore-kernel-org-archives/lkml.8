Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF26C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BDD208C9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590532294;
	bh=i/LsJ/7HDxl1uraGohIpTv1UEEpLZgqDBmcvFSkYrRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MJKPPryqiRC4eTkiK9LvhS2TfEnwzPKA+g2iyOL1WVy6oK1U5C3Ql0yRZY16VvaHb
	 onmEqRL8YDRQKMezg0b4m74O6n50/p6y++fIG5Tff3IJerBhr2x715XO9GXoaoUkMV
	 jnqUVNhL0I7n/V9fO4w52UhX450AS8aJFO5pt55Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392128AbgEZWbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389482AbgEZWbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:31:33 -0400
Received: from kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9454F20899;
        Tue, 26 May 2020 22:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590532292;
        bh=i/LsJ/7HDxl1uraGohIpTv1UEEpLZgqDBmcvFSkYrRs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L1hQtRDvn7ylGIClnE51U8xDbKeptk9RRRcxjD8KvV0vnGtqXOx6okqH3wGQU2F4s
         AMxHim9tkh3trTRi+/Dihhe2jPHiIQ7YHpjVMePw/F7mtxQxe5ipm41gvPbE0O1/f+
         WqWQhzzVJGfznE1VeNIwnVlo+h9/gVYBJXg1JpOk=
Date:   Tue, 26 May 2020 15:31:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Statsfs: a new ram-based file system for Linux
 kernel statistics
Message-ID: <20200526153128.448bfb43@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20200526110318.69006-1-eesposit@redhat.com>
References: <20200526110318.69006-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 13:03:10 +0200 Emanuele Giuseppe Esposito wrote:
> There is currently no common way for Linux kernel subsystems to expose
> statistics to userspace shared throughout the Linux kernel; subsystems have
> to take care of gathering and displaying statistics by themselves, for
> example in the form of files in debugfs. For example KVM has its own code
> section that takes care of this in virt/kvm/kvm_main.c, where it sets up
> debugfs handlers for displaying values and aggregating them from various
> subfolders to obtain information about the system state (i.e. displaying
> the total number of exits, calculated by summing all exits of all cpus of
> all running virtual machines).
> 
> Allowing each section of the kernel to do so has two disadvantages. First,
> it will introduce redundant code. Second, debugfs is anyway not the right
> place for statistics (for example it is affected by lockdown)
> 
> In this patch series I introduce statsfs, a synthetic ram-based virtual
> filesystem that takes care of gathering and displaying statistics for the
> Linux kernel subsystems.
> 
> The file system is mounted on /sys/kernel/stats and would be already used
> by kvm. Statsfs was initially introduced by Paolo Bonzini [1].

What's the direct motivation for this work? Moving KVM stats out of
debugfs?

In my experience stats belong in the API used for creating/enumerating
objects, statsfs sounds like going in the exact opposite direction -
creating a parallel structure / hierarchy for exposing stats. I know
nothing about KVM but are you sure all the info that has to be exposed
will be stats?

In case of networking we have the basic stats in sysfs, under the
netdevice's kobject. But since we're not using sysfs much any more 
for config, new stats are added in netlink APIs. Again - same APIs
used for enumeration and config.

