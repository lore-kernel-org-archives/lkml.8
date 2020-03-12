Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477A9C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFF820746
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="TfmuNTiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgCLODa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:03:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35229 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgCLODa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:03:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id d5so7284857wrc.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gZ8EzvWOoYPssGlE3Bc08q7j/BuTfnqODyWmkhQlWkA=;
        b=TfmuNTiDZFVaKt1FsbjC8KD47kKTzeJiW0a5jYgMkGEHRDgSlpXWqwgP9A7Gf33Eld
         aml8lOwBZNhMGI52wgky/dJ3sd2Cvhad5IH02L91tKg6lIeYC0MhdZ2sdzNY2oSomsNY
         /ZHFB9z2P8NlaXCugSOWKuHmS2oJd8Dx2iKz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gZ8EzvWOoYPssGlE3Bc08q7j/BuTfnqODyWmkhQlWkA=;
        b=RBKTVZX+oH9D1ASyF1L6jbHhKJjixBSuk5pcmjXPOXrYIkqsUOCDAvHCWN3UC9SnDR
         zqRpxwTcGsfV4xMbtjRlAH9QNkPPMvnTKI+yKJVArNZYyPLypQAjOK756qxmn0xiAHce
         Znb3D9Oyu/kjzshjr7Ia8MCvIU+JBI9Rjoq6ynAqa1ExNZBOVLdfdvdX04kOzNIBiX7O
         okMNWkBDyPgWpHh05IJddpchfAgnwehjN6VHXcgvHJYiJmK13JNpLn9GG67xTso+RHqD
         aXH5ZiLM95XHA/p9TWyFDOxO1yreQrU53WtPbu1n66rfpWy+hO+eysDiX9Ym4poKO4Hp
         eILw==
X-Gm-Message-State: ANhLgQ2UN8rWVBNmPyTRW5RKf4BZzyAcYro1GE2MS9VhlTn3yCAxthSo
        pyEvSpOzmGGUDDAFURjsmXY+rg==
X-Google-Smtp-Source: ADFU+vv1/ATpkRSO8dO42Isg6QmWT0wIt5OWthWLFxdkk6d8XZ/NFK6+zJf5AKfIuiiU1XmqFp5T9A==
X-Received: by 2002:adf:b3d6:: with SMTP id x22mr10936079wrd.242.1584021808040;
        Thu, 12 Mar 2020 07:03:28 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id d63sm12680261wmd.44.2020.03.12.07.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 07:03:27 -0700 (PDT)
Date:   Thu, 12 Mar 2020 14:03:26 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
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
Subject: Re: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Message-ID: <20200312140326.GA1701917@chrisdown.name>
References: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <alpine.DEB.2.21.2003111227230.171292@chino.kir.corp.google.com>
 <BL0PR02MB5601808F36BE202813E9D562E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312133636.GJ22433@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200312133636.GJ22433@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:
>On Thu, Mar 12, 2020 at 12:48:22PM +0000, Ivan Teterevkov wrote:
>> This is exactly what I'm trying to avoid: in some distros there is no way
>> to tackle the configuration early enough, e.g. in systemd-based systems
>> the systemd is the process that starts first and arranges memcg in a way
>> it's configured, but unfortunately, it doesn't offer the swappiness knob.
>
>This sounds like a systemd problem.  Have you talked to the systemd
>people about fixing it in systemd?

Hi there ;-)

In general most of us maintaining cgroups in systemd run with cgroup v2, so 
this isn't a problem we run into in production. The swappiness controls in 
general don't make a whole lot of sense being distributed hierarchically, so 
they've been phased out entirely in cgroup v2.

If there had been a patch years ago implementing this in systemd we'd probably 
have accepted it, but cgroup v1 is dying and I am really not in favour of 
adding more code to massage its rough edges. We already have enough problems 
generated by it already.

However, the following kludge in tmpfiles.d should work to solve your immediate 
problem:

	w /sys/fs/cgroup/memory/system.slice/memory.swappiness - - - - value

Taking my systemd hat off and putting my -mm hat on: let's not add more hacky 
APIs at cgroup v1's behest, or we'll be here until we're pushing up the 
daisies.

Thanks,

Chris
