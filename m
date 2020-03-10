Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B2CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477AD21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn0IsAwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgCJSSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:18:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46035 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJSSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:18:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id c145so7883604qke.12;
        Tue, 10 Mar 2020 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FDcMX1PePznyO53o+CArnNkwwdbPpxO8cnWHJEtCj+w=;
        b=nn0IsAwnKmmT34whzS9D7vKKkobczy4+Jxv15WjpHhMcBo1iiSXUhNZ5zfQV7rhPJ+
         BdKtWzLr2klQ4aM0rvu22HimGCGL9E5oxIC4bQAxUgCtV9abiaMR061IWgp3G6slG26L
         ZvaFCGXif+EiTWwqW1Tb8/JCtJCOpSem0oPp+FHG7Qf2KhEi585uzhlL324shD/cToA5
         cbAETcjOTJzOa1Ncn2t1AzDau/faVKd34tpUQGZrqrj2z9YlTgKRUAkR7EE2VTyufKKd
         fKd5NMEYQJS30mQwg3bXHMAuMZOC8XoKsbWxYLD3Wbg8WYu1NquHHuYC+/q3MI3bKYcL
         /sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FDcMX1PePznyO53o+CArnNkwwdbPpxO8cnWHJEtCj+w=;
        b=aNeFHvnUTgRkxLB766S7LM7uDk3bCDTwab6/xX2KkxXge6uNfd/S1y2Yw7JBOVcfqe
         MGY20MVZXGXJDFRShMF0332AudtbC0qojlYsp4NNGCwa6/UZiX/ZtO/SH1IDsWHrTO2m
         Z2Ac4kraW/Qezm29z94AoXfeik86s3Y6YL+CY2OxTaBASPHZFdZiFyw1xApOXGzaCSUZ
         uNwg6JmfJC5f+RiBzANrMwI/6Kry/VC5+EDY0gMto8J4NDqpSGJT0eFH8T2Iplu1xDD3
         BhbyfE4me1M5CKLdKbKgU6boDRzen03IBY4fzJOz7XzUk6sEyl9OP+qYDm00a5oq3aSS
         +Crw==
X-Gm-Message-State: ANhLgQ02SegARlQkbssKaYaIeZF+9M1gao37/m+e186nnVt1aef1c8xs
        ZGhZNTDKFsEwJXjijsIft+w=
X-Google-Smtp-Source: ADFU+vvDQ6OVjY8tJy/nZ0hNWyGRHkLWwyU0bDUoyYD7chInzxdBRC6g6UidRbT/w0mvlFmonWPVGw==
X-Received: by 2002:a37:6e84:: with SMTP id j126mr19916576qkc.77.1583864322670;
        Tue, 10 Mar 2020 11:18:42 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-149-111.3g.claro.net.br. [179.240.149.111])
        by smtp.gmail.com with ESMTPSA id r46sm8420598qtb.87.2020.03.10.11.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:18:41 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 99BF840009; Tue, 10 Mar 2020 15:18:36 -0300 (-03)
Date:   Tue, 10 Mar 2020 15:18:36 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v4 0/8] powerpc/perf: Add json file metric support for
 the hv_24x7 socket/chip level events
Message-ID: <20200310181836.GA12036@kernel.org>
References: <20200309062552.29911-1-kjain@linux.ibm.com>
 <20200309093506.GB67774@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309093506.GB67774@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 09, 2020 at 10:35:06AM +0100, Jiri Olsa escreveu:
> On Mon, Mar 09, 2020 at 11:55:44AM +0530, Kajol Jain wrote:
> > First patch of the patchset fix inconsistent results we are getting when
> > we run multiple 24x7 events.
> > 
> > Patchset adds json file metric support for the hv_24x7 socket/chip level
> > events. "hv_24x7" pmu interface events needs system dependent parameter
> > like socket/chip/core. For example, hv_24x7 chip level events needs
> > specific chip-id to which the data is requested should be added as part
> > of pmu events.
> > 
> > So to enable JSON file support to "hv_24x7" interface, patchset expose
> > total number of sockets and chips per-socket details in sysfs
> > files (sockets, chips) under "/sys/devices/hv_24x7/interface/".
> > 
> > To get sockets and number of chips per sockets, patchset adds a rtas call
> > with token "PROCESSOR_MODULE_INFO" to get these details. Patchset also
> > handles partition migration case to re-init these system depended
> > parameters by adding proper calls in post_mobility_fixup() (mobility.c).
> > 
> > Patch 6 & 8 of the patchset handles perf tool plumbing needed to replace
> > the "?" character in the metric expression to proper value and hv_24x7
> > json metric file for different Socket/chip resources.
> > 
> > Patch set also enable Hz/hz prinitg for --metric-only option to print
> > metric data for bus frequency.
> > 
> > Applied and tested all these patches cleanly on top of jiri's flex changes
> > with the changes done by Kan Liang for "Support metric group constraint"
> > patchset and made required changes.
> > 
> > Changelog:
> > v3 -> v4
> > - Made changes suggested by jiri.
> 
> could you please mention them next time? ;-)
> 
> > - Apply these patch on top of Kan liang changes.
> 
> Arnaldo, could you please pull the expr flex changes and Kan's
> metric group constraint changes? it's both prereq of this patchset

Both are now in my perf/core branch, will go upstream soon, should I go
and pickup the perf tooling bits in this patchkit?

- Arnaldo
