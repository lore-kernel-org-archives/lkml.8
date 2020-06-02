Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4157EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E752D207D0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591083236;
	bh=sirDg1xJuxbZggDxmpG6hoGYOo2fRytgIE+Gmort8gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MQnFJ6Kx3RyZZqWDasRSR1jTYRgrfRWfo7q46ZDGhr/7JzbymoqL9Ghpwvcra+gCp
	 YpGLG7BQiVjWCadh8c7K+MC4xk/iVX5BrdNOZuJEtVGrNk2MHMn42JrMxTUKvJrU+q
	 wRv0seqSv57n5VFvqZiDov02l7bPVpjzyfipA/Rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgFBHdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgFBHdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:33:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263BAC061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 00:33:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so2298938wru.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 00:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MNE2ZaZoGCsQab8S1AhA7MsjetryRQlYEryj4Ashfjo=;
        b=JbdpIHPQLNIKUWIiEIkVyKFCPCv+GqdRpJF2bSjHHiVUpO7JdMEQpH2ZEODHJkmK9E
         G9EfOIHnWpFkx8+0l0geJ14u21Vc++S17CACfYSctHnR3ud8G3JujnpOArpqJMWrKeCB
         sgxUeyL3vA/oBNqXX6NoVRXtwjsyFFxwSwa3XJAZPSKiTx22IXx1jGj2q0XNlAefSW5O
         F8PDXjqMQnkWwvX3+oFSLPC1EpM3DpStW3Ca339TuWtIUEltPXeObp5HvMo0G+mRisiI
         h/vT20Dd4KzPJ/dECFyszYTzq0WK27Z0U9PwcBnQB8iRrM4Tlo858WKzJGoxoia3YVBi
         d5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MNE2ZaZoGCsQab8S1AhA7MsjetryRQlYEryj4Ashfjo=;
        b=OIP0VQ/yNSJ1R4MkBdekQvXTjBEcvKV6sFF9ZpMZTHM7zibB1pX8spkDm/okHNECVk
         LJ6yWljMmeNFQbxp6s4N8cpXAmyK+Olo0V5d4aEPuPyulSUOAobG8cYELuEX14klJTDg
         ngjU/dzW8U+l7HN3FzE4V4VyYrfluZ+tZz65CMrVq3AXSkjgNDJyPlLLUC8Ic+Gxk0Ih
         sc+y1b2Pyo98S+VI9ZBJDEJKgQkkKFFW6vhSHxqP66FnbXPRlZ27Sa8wP6uzjh476M3K
         vLvhZo3bczsNXAppE6FshsUpERv+nrQK8E8YKRiE/a/cR95fP3SIm9xneL9Mdb4ZdhaZ
         B2rQ==
X-Gm-Message-State: AOAM531H9mqkhbPv2k9hG5ij/456OGSkdb4WEjFUstgOS4n52r5sX61v
        PwjcruyTp/D2PY18JkEN/c3t3Gf4
X-Google-Smtp-Source: ABdhPJwo7nfA/TWpDdc309CnVGj/liJ4+ZVx+NR+APvIEu3TpCeFlLxQkFPF4YHGb00DLJHiRhxyFw==
X-Received: by 2002:a05:6000:1292:: with SMTP id f18mr25551203wrx.208.1591083232833;
        Tue, 02 Jun 2020 00:33:52 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u13sm2247942wmm.6.2020.06.02.00.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 00:33:52 -0700 (PDT)
Date:   Tue, 2 Jun 2020 09:33:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
        akpm@linux-foundation.org, bp@alien8.de,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org
Subject: Re: [GIT PULL] x86/mm changes for v5.8
Message-ID: <20200602073350.GA481221@gmail.com>
References: <20200601170102.GA1346815@gmail.com>
 <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Balbir Singh <sblbir@amazon.com> wrote:

> > At a _minimum_, SMT being enabled should disable this kind of crazy
> > pseudo-security entirely, since it is completely pointless in that
> > situation. Scheduling simply isn't a synchronization point with SMT
> > on, so saying "sure, I'll flush the L1 at context switch" is beyond
> > stupid.
> >
> > I do not want the kernel to do things that seem to be "beyond stupid".
> >
> > Because I really think this is just PR and pseudo-security, and I
> > think there's a real cost in making people think "oh, I'm so special
> > that I should enable this".
> >
> > I'm more than happy to be educated on why I'm wrong, but for now I'm
> > unpulling it for lack of data.
> >
> > Maybe it never happens on SMT because of all those subtle static
> > branch rules, but I'd really like to that to be explained.
> 
> The documentation calls out the SMT restrictions.

That's not what Linus suggested though, and you didn't answer his 
concerns AFAICS.

The documentation commit merely mentions that this feature is useless 
with SMT:

  0fcfdf55db9e: ("Documentation: Add L1D flushing Documentation")

+Limitations
+-----------
+
+The mechanism does not mitigate L1D data leaks between tasks belonging to
+different processes which are concurrently executing on sibling threads of
+a physical CPU core when SMT is enabled on the system.
+
+This can be addressed by controlled placement of processes on physical CPU
+cores or by disabling SMT. See the relevant chapter in the L1TF mitigation
+document: :ref:`Documentation/admin-guide/hw-vuln/l1tf.rst <smt_control>`.

Linus is right that the proper response is for this feature to do 
*nothing* if SMT is enabled on affected CPUs - but that's not 
implemented in the patches ...

Or rather, we should ask a higher level question as well, maybe we 
should not do this feature at all?

Typically cloud computing systems such as AWS will have SMT enabled, 
because cloud computing pricing is essentially per vCPU, and they want 
to sell the hyperthreads as vCPUs. So the safest solution, disabling 
SMT on affected systems, is not actually done, because it's an 
economic non-starter. (I'd like to note the security double standard 
there: the most secure option, to disable SMT, is not actually used ...)

BTW., I wonder how Amazon is solving the single-vCPU customer workload 
problem on AWS: if the vast majority of AWS computing capacity is 
running on a single vCPU, because it's the cheapest tier and because 
it's more than enough capacity to run a website. Even core-scheduling 
doesn't solve this fundamental SMT security problem: separate customer 
workloads *cannot* share the same core - but this means that the 
single-vCPU workloads will only be able to utilize 50% of all 
available vCPUs if they are properly isolated.

Or if the majority of AWS EC2 etc. customer systems are using 2,4 or 
more vCPUs, then both this feature and 'core-scheduling' is 
effectively pointless from a security POV, because the cloud computing 
systems are de-facto partitioned into cores already, with each core 
accounted as 2 vCPUs.

The hour-up-rounded way AWS (and many other cloud providers) account 
system runtime costs suggests that they are doing relatively static 
partitioning of customer workloads already, i.e. customer workloads 
are mapped to actual physical hardware in an exclusive fashion, with 
no overcommitting of physical resources and no sharing of cores 
between customers.

If I look at the pricing and capabilities table of AWS:

  https://aws.amazon.com/ec2/pricing/on-demand/

Only the 't2' and 't3' On-Demand instances have 'Variable' pricing, 
which is only 9% of the offered 228 configurations.

I.e. I strongly suspect that neither L1D flushing nor core-scheduling 
is actually required on affected vulnerable CPUs to keep customer 
workloads isolated from each other, on the majority of cloud computing 
systems, because they are already isolated via semi-static 
partitioning, using pricing that reflects static partitioning.

Thanks,

	Ingo
