Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02073C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4FBB2084D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596654847;
	bh=GS+/d4Ux7f5KySR64sVX9NErnoZYC3TJhkfC+uca/OI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oJ8blGdyb5yKhOx0lVVRfwPWdeEaDIIISpB/QVkOGaSLXUwQ904mA7882sLiDU0VH
	 yFWKPP6N5X620Esvn1WSldjxoeFaZegRkpFw0RQhDPJuecAsIurTNznSP7eOGFa09N
	 s08YIibFgsdACqWtx4ej6pzzkZk589+BlO4lE5mM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgHESIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbgHESFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:05:41 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A086FC061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 11:05:27 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so14261348ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJLLgIEjQbsi/SjTfRAATLA+9JTrjXUP0jdNW6WmMgI=;
        b=eaY7NtzotzWV/MnsZjfDao9T2g2eCy+3wm499kvwu1wBI+Vd7me0Jx1vxfPwpDDz2e
         +1s5SmJEh1SEzTbjd/vRaoC7ncNiNL4Lkyg2YumYQ4UA7w+AEcfjLokkCNp9gUuGZSuL
         cWA3tsPtGDQzsow/KN0TSz2gkofo5VDhkb9Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJLLgIEjQbsi/SjTfRAATLA+9JTrjXUP0jdNW6WmMgI=;
        b=l36RRZ0Tr7noRgEjxe7zP3GJilceKenoNL9FFecDqV27oYrAkXryk7Bhp9zFGSrbrF
         mR56NdULvcqdvj4pkVcYPSnCv3dBvYErfpJjGuQeG2ovPVXsB0Lrbkg+ozF/sjIGZZR+
         f8tOFsbfbZXU+eky9iItPNHi7rsv+L7tLi0XWE4jxtIqBBInFXjcBnPn7Xu1k989ighU
         TlGWsf3aIZyhf7/YlvTopKER3admGbeHIKZO/AJpdapnnAS2bWphXd6CjdeuPNlzgco5
         ulGEhh4cT+5OEtaAs85RXrMZbOWhgO+FRbDDTdZQEN0eL24ovYYAKcRZgnnIoSkWsmiw
         SZbg==
X-Gm-Message-State: AOAM5334DzwbpWEEuk0QMuFbluUIA5nJyjQwV9IwWsH8GrH4xr49OOKp
        L7cA9zzv9u0U8mr2phMTVW8+CoZj8dE=
X-Google-Smtp-Source: ABdhPJxDv2YJIThf/IFG7b54Dzk+Px82xuzn+nZs25PjChZwmR4ijviRC86YGzQEVVZb7lcJXn3X3g==
X-Received: by 2002:a2e:96d9:: with SMTP id d25mr2162879ljj.408.1596650725832;
        Wed, 05 Aug 2020 11:05:25 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id t10sm1189266ljg.60.2020.08.05.11.05.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 11:05:24 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id v9so14261243ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 11:05:24 -0700 (PDT)
X-Received: by 2002:a2e:9252:: with SMTP id v18mr1872739ljg.70.1596650724308;
 Wed, 05 Aug 2020 11:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200805090653.GI23458@shao2-debian>
In-Reply-To: <20200805090653.GI23458@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Aug 2020 11:05:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiuF-0JSmiDe-A--+Z4UbEWQxQ40ftm88aKwSi0FLvM+g@mail.gmail.com>
Message-ID: <CAHk-=wiuF-0JSmiDe-A--+Z4UbEWQxQ40ftm88aKwSi0FLvM+g@mail.gmail.com>
Subject: Re: [mm] 2a9127fcf2: vm-scalability.throughput 130.0% improvement
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W00t!

Usually I think these kinds of big changes are likely outright bugs,
but this time I'll take it, because that improvement was the point and
aim of the change even if I didn't have numbers to back up my BS.

              Linus

On Wed, Aug 5, 2020 at 2:07 AM kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed a 130.0% improvement of vm-scalability.throughput due to commit:
>
> commit: 2a9127fcf2296674d58024f83981f40b128fffea ("mm: rewrite wait_on_page_bit_common() logic")
