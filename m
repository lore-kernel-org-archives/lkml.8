Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BB4C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63BB214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t31A+SbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgBFUbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:31:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45531 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFUbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:31:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so10402pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPfBWVjSrQlutcw1BrAjL4XXYPCEqBan2GAZ0ciyj6I=;
        b=t31A+SbTqXDM3lEZg4KVayrqxz74VfDSMz0w2WvaMJXsYL+/wwwhrDYGEX2qgqmKyS
         T9ENHQjxDjxiYZAQ35oSiJpV/SQn15eayrkfZJQv9jG0sXDmaERveWlSnAjoDYNh+bbx
         WDpQAd2lWiS0RqL1JIdMx+3Cc9HT6I8SWPZK/Hlt3ZZo16vX0lZ5PD0rmELFccZh70an
         UC8dwfmSlUYELL5HjybT4BbBLDBT20kVPbo5MOWC9WI/bxqb77W4J1rv0/AIdMvHeTQG
         sXirGfv/kByGfH7S/dFS+IkZMUn+NgMFrWwyWWKgJBAXYnmDnVlBjkhI1ILmbIp1rPQC
         IYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPfBWVjSrQlutcw1BrAjL4XXYPCEqBan2GAZ0ciyj6I=;
        b=SfgAIduHklTZDbl8UO0QlbCgzYSbawk4B0oUaSTZ3t6CIV/93sfLk8ToS28p7hY0YR
         6jENhdYLTn+kRMP8gFqXgKS0Hn8uXbdQMHuEMQpWsUUAa/6Fn00RQ5SuRFByWonkHfj9
         nxcpkRH7QFO3Uz92YfmjNPOuyNvxFJLQd7VqfzL3qVwLF7yN45kGGS2jOXgdJeuiAai5
         R36uCW/DFyaZhqKpo4De3Q3nSM2C3FXlL2/lb4pHFoRKlAUZqWOYxazU5Jo+7cJTp11d
         Xhilcsl2jY6cmSaA1cOHb6yrAZpV12Efjl9H/YbAdl8DmU6CmpRebrn6MQ1cjhUJAo8S
         ab7Q==
X-Gm-Message-State: APjAAAVs9VpmkJGCcAPE/nhORVlos8y6ZXE0ySoWuYl6RFIcXQJnIQui
        Z5TraRUgAIfSjsWrj2s/Stf7SH7V
X-Google-Smtp-Source: APXvYqzUg01IbqeYCsdPP/DQ0kp6K10e48GyKhji0m1indNoTWW7YrDDzFrVl7ixXMHgdWzthxpSVQ==
X-Received: by 2002:a17:90a:a881:: with SMTP id h1mr6727767pjq.50.1581021109086;
        Thu, 06 Feb 2020 12:31:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h13sm161679pjc.9.2020.02.06.12.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 12:31:48 -0800 (PST)
Date:   Thu, 6 Feb 2020 12:31:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5 17/17] powerpc/32s: Enable CONFIG_VMAP_STACK
Message-ID: <20200206203146.GA23248@roeck-us.net>
References: <cover.1576916812.git.christophe.leroy@c-s.fr>
 <2e2509a242fd5f3e23df4a06530c18060c4d321e.1576916812.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e2509a242fd5f3e23df4a06530c18060c4d321e.1576916812.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2019 at 08:32:38AM +0000, Christophe Leroy wrote:
> A few changes to retrieve DAR and DSISR from struct regs
> instead of retrieving them directly, as they may have
> changed due to a TLB miss.
> 
> Also modifies hash_page() and friends to work with virtual
> data addresses instead of physical ones. Same on load_up_fpu()
> and load_up_altivec().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

This patch results in qemu boot failures (mac99 with pmac32_defconfig).
Images fail silently; there is no console output. Reverting the patch
fixes the problem. Bisect log is attached below.

Assuming this was tested on real hardware, am I correct to assume that qemu
for ppc32 (more specifically, qemu's mac99 and g3beige machines) no longer
works with the upstream kernel ?

Thanks,
Guenter

---
# bad: [33b40134e5cfbbccad7f3040d1919889537a3df7] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
# good: [d4e9056daedca3891414fe3c91de3449a5dad0f2] initramfs: do not show compression mode choice if INITRAMFS_SOURCE is empty
git bisect start '33b40134e5cf' 'd4e9056daedc'
# good: [9717c1cea16e3eae81ca226f4c3670bb799b61ad] Merge tag 'drm-next-2020-02-04' of git://anongit.freedesktop.org/drm/drm
git bisect good 9717c1cea16e3eae81ca226f4c3670bb799b61ad
# bad: [4c25df5640ae6e4491ee2c50d3f70c1559ef037d] Merge branch 'topic/user-access-begin' into next
git bisect bad 4c25df5640ae6e4491ee2c50d3f70c1559ef037d
# good: [846a17a53aeeee426cbc1252f517a6660eab1427] powerpc/powernv: Use common code for the symbol_map export
git bisect good 846a17a53aeeee426cbc1252f517a6660eab1427
# good: [afe1ec5ab83029baf0f8368a255dc6b998bde576] powerpc/8xx: Split breakpoint exception
git bisect good afe1ec5ab83029baf0f8368a255dc6b998bde576
# bad: [43e76cd368fbb67e767da5363ffeaa3989993c8c] powerpc: Do not consider weak unresolved symbol relocations as bad
git bisect bad 43e76cd368fbb67e767da5363ffeaa3989993c8c
# bad: [af1725d2493dcad4eeb7e63141678181fcd8a2ff] powerpc/kconfig: Move CONFIG_PPC32 into Kconfig.cputype
git bisect bad af1725d2493dcad4eeb7e63141678181fcd8a2ff
# good: [94dd54c51a410b9ffa6356c3ed2ab0317f998ded] powerpc/32s: Avoid crossing page boundary while changing SRR0/1.
git bisect good 94dd54c51a410b9ffa6356c3ed2ab0317f998ded
# bad: [0f9aee0cb9da7db7d96f63cfa2dc5e4f1bffeb87] powerpc/mm: Don't log user reads to 0xffffffff
git bisect bad 0f9aee0cb9da7db7d96f63cfa2dc5e4f1bffeb87
# bad: [cd08f109e26231b279bcc0388428afcac6408ec6] powerpc/32s: Enable CONFIG_VMAP_STACK
git bisect bad cd08f109e26231b279bcc0388428afcac6408ec6
# first bad commit: [cd08f109e26231b279bcc0388428afcac6408ec6] powerpc/32s: Enable CONFIG_VMAP_STACK
