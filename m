Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2788C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F40A2074E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q12MBO8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgCMVuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:50:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40658 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgCMVuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:50:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id l184so6053385pfl.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 14:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=46YeeqUVBeP6f9VWE0TcC9l1RBNdnWfSZlWXN5Q1peQ=;
        b=Q12MBO8J5q3BOIcGofdprXZE4vWGBITJYUaXfGTjQ4i+07Zsvbe9D0Yxp3znBUOa9l
         rzIqsnvHiat3edhh45n6+RlxGA7K8F642R/7BhawsyAOTdrM+eW52kHz/waBHmkBNDY0
         J5mj56QwAmJKPT/TjAM28pSrBCgc4XDW51ytSNvisO3v/1wpX+//H+q7PQxOQD8HPvID
         xYa9z0Dt3jGRv9rHkFFmS97MKeiMdTncnJzCbKjRsDhLfUHiaPp0b5J9ApDFIuubYMOK
         qBBGbg9CW73Zjqx0uqUkV+IrK3HAJMiaQ3JGnjcgpN1Amn1z1p0N3bhOPUIrOwZ/J4HM
         UPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=46YeeqUVBeP6f9VWE0TcC9l1RBNdnWfSZlWXN5Q1peQ=;
        b=HKAbnkTiWz/q/As3tn/54w3fdL7vD5do1TLd28LPHIYpnEeW3oDupFHQVaRuNWm4TT
         VZ6HEDrK9+NH77e8yrhHbHzrKrV817LjN43oaKoiLS5k+6YvJss9HBuOH8+/ZE9gjdt3
         wS651bVcrgu59usl1VFsZvVLCMCKGDQ95qjq5tBLOs8TyfqkziTycrXDSfi3Pf859PXH
         zQ5IsaoKnELm98UDss9c0OnLyAVII5zjmBYGSW6RSZrHa38v7qPSu1IdO/62cKBS6qz8
         8REzZm6+HtoJQNaT7o/9qk1kgpjuXs1Wvz/8LZ8w/SLumRQPOrJoBMBHZQtjQ4VlTCPr
         V+iw==
X-Gm-Message-State: ANhLgQ0IXLkJ5NmRKjeBV+kRTEs+w1acqeu8DDxzgUrQ6z0x1wFPVH1P
        Z608pbbymHKGhFESUVoJi/PLsA==
X-Google-Smtp-Source: ADFU+vv7+qCBYnf8jXp8urW7VT3VV+9zXwWg78Cbn54lUEZxtUjHr9aXSSf6ZL10vVohjJkqQoJXcg==
X-Received: by 2002:a62:52d7:: with SMTP id g206mr14267709pfb.286.1584136203091;
        Fri, 13 Mar 2020 14:50:03 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c190sm19404916pfa.66.2020.03.13.14.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:50:02 -0700 (PDT)
Date:   Fri, 13 Mar 2020 14:50:01 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Ivan Teterevkov <ivan.teterevkov@nutanix.com>
cc:     Chris Down <chris@chrisdown.name>,
        Matthew Wilcox <willy@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
In-Reply-To: <BL0PR02MB56011828432D343371088516E9FA0@BL0PR02MB5601.namprd02.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.2003131447220.242651@chino.kir.corp.google.com>
References: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com> <alpine.DEB.2.21.2003111227230.171292@chino.kir.corp.google.com> <BL0PR02MB5601808F36BE202813E9D562E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312133636.GJ22433@bombadil.infradead.org> <20200312140326.GA1701917@chrisdown.name> <BL0PR02MB56011828432D343371088516E9FA0@BL0PR02MB5601.namprd02.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020, Ivan Teterevkov wrote:

> The above approach doesn't work for me in el7 with systemd 219 or ubuntu 19
> with systemd 242 because presumably the systemd-tmpfiles services start too
> late. Please find the snippet at the bottom of the email.
> 
> The only approach that seems to work is to set up a service to run:
> 
> $ find /sys/fs/cgroup/memory/ -name memory.swappiness | while read -r name; do echo 0 > "${name}"; done
> 
> I think this is quite ugly because there might be a race condition with
> the systemd that could be creating the slices while the find is running.
> One could suggest constraining the depth and going from top to the
> bottom of the memcg but this still looks inherently unstable.
> 

I'll renew my suggestion of defaulting memcg->swappiness to -1 and then 
letting mem_cgroup_swappiness() return vm_swappiness when 
memcg->swappiness == -1.

I don't think the act of creating a memcg and not initializing the 
swappiness value implies that the existing value meets your expectation.

> This is why I ended up with the vm_swappiness patch (which I don't
> quite like myself) but this appears to be the only rock solid option
> unless I've missed anything obvious. There is no doubt that cgroup v1
> is due for replacement and vm_swappiness is frightening but they still
> have certain advantages to employ until they are history.
> 
> $ systemctl --version
> systemd 242 (242)
> +PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid
> 
> $ cat /etc/lsb-release
> DISTRIB_ID=Ubuntu
> DISTRIB_RELEASE=19.10
> DISTRIB_CODENAME=eoan
> DISTRIB_DESCRIPTION="Ubuntu 19.10"
> 
> $ uname -a
> Linux ubuntu 5.6.0-rc5-custom #1 SMP Wed Mar 11 14:59:15 GMT 2020 x86_64 x86_64 x86_64 GNU/Linux
> 
> $ tail -1 /etc/sysctl.conf
> vm.swappiness=10
> 
> $ cat /etc/tmpfiles.d/10-swap.conf
> w /sys/fs/cgroup/memory/system.slice/memory.swappiness - - - - 20
> w /sys/fs/cgroup/memory/user.slice/memory.swappiness   - - - - 30
> 
> $ find /sys/fs/cgroup/memory -name memory.swappiness | while read -r name; do cat "${name}"; done | sort | uniq -c
>       1 10
>      32 20
>       6 30
>      21 60
> 
> $ find /sys/fs/cgroup/memory -name memory.swappiness | while read -r name; do echo "${name}"; cat "${name}"; done | grep --before-context=1 60
> /sys/fs/cgroup/memory/system.slice/systemd-udevd.service/memory.swappiness
> 60
> --
> /sys/fs/cgroup/memory/system.slice/sys-fs-fuse-connections.mount/memory.swappiness
> 60
> /sys/fs/cgroup/memory/system.slice/snap-gnome\x2d3\x2d28\x2d1804-116.mount/memory.swappiness
> 60
> /sys/fs/cgroup/memory/system.slice/snap-gnome\x2dlogs-81.mount/memory.swappiness
> 60
> /sys/fs/cgroup/memory/system.slice/sys-kernel-config.mount/memory.swappiness
> 60
> --
> /sys/fs/cgroup/memory/system.slice/snap-core-7917.mount/memory.swappiness
> 60
> /sys/fs/cgroup/memory/system.slice/sys-kernel-debug.mount/memory.swappiness
> 60
> --
> /sys/fs/cgroup/memory/system.slice/snap-gnome\x2dcharacters-399.mount/memory.swappiness
> 60
> /sys/fs/cgroup/memory/system.slice/swapfile.swap/memory.swappiness
> 60
> --
> /sys/fs/cgroup/memory/system.slice/snap-gtk\x2dcommon\x2dthemes-1440.mount/memory.swappiness
> 60
> /sys/fs/cgroup/memory/system.slice/snap-gnome\x2dcharacters-317.mount/memory.swappiness
> 60
> --
> /sys/fs/cgroup/memory/system.slice/systemd-journald.service/memory.swappiness
> 60
> --
> /sys/fs/cgroup/memory/system.slice/dev-mqueue.mount/memory.swappiness
> 60
> --
> /sys/fs/cgroup/memory/system.slice/snap-gtk\x2dcommon\x2dthemes-1353.mount/memory.swappiness
> 60
> /sys/fs/cgroup/memory/system.slice/snap-core-8689.mount/memory.swappiness
> 60
> --
> /sys/fs/cgroup/memory/system.slice/snap-gnome\x2d3\x2d28\x2d1804-71.mount/memory.swappiness
> 60
> --
> /sys/fs/cgroup/memory/system.slice/snap-core18-1668.mount/memory.swappiness
> 60
> --
> /sys/fs/cgroup/memory/system.slice/snap-gnome\x2dcalculator-501.mount/memory.swappiness
> 60
> --
> /sys/fs/cgroup/memory/system.slice/dev-hugepages.mount/memory.swappiness
> 60
> --
> /sys/fs/cgroup/memory/system.slice/snap-gnome\x2dcalculator-544.mount/memory.swappiness
> 60
> --
> /sys/fs/cgroup/memory/system.slice/snap-core18-1223.mount/memory.swappiness
> 60
> 
