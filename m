Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420C2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1529F2467F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilMJuYBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgAVKPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:15:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27991 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729098AbgAVKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579688118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HuN8xwBV9YhqHIBUUs/6FS3OY1fEoZoqFPlPS7k1hAM=;
        b=ilMJuYBKxqHAda4EtCfE4TkCwTS2C/V6fReycpWalxHW1M90qTUZuhuiN9RyGiSJ61Jejo
        hHrnEOEWwY1qTSNakQpsIu/HTKkmSgD4A70KPqbw84se25Erxq6dIk+GMtYvkTcICa6Pa1
        dnoAswCpFc5zklbbakwaDsKGn+dI3hY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-eQlIZRpqMSSucKgNZU4cZw-1; Wed, 22 Jan 2020 05:15:15 -0500
X-MC-Unique: eQlIZRpqMSSucKgNZU4cZw-1
Received: by mail-wr1-f72.google.com with SMTP id u18so2789519wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 02:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HuN8xwBV9YhqHIBUUs/6FS3OY1fEoZoqFPlPS7k1hAM=;
        b=BqCm3Hb8TPf8ba36facDLrRR+vYjYeTRCupda2nMYLaDVftVHpTdlPP3DRuezBPkNd
         kjLrHY5nVHMu1k00SxJyzaPhUO+EAFS3aIkveiy4y5eE2vda1Nqb06bc6K0QIE1dxFGl
         ChFUe3OIpaepJ3/dFGEwbgLfkYseGHvB9fa8PSHr6BKRO22gjPgiPnjP7zBE75D7689l
         JIL06G1nUbbT64Xhk0NjzuDl9KWClG+G9hF1cD51302F79APUbbO7G+qGyGZ37anpsFJ
         9jSZLoQgWb/egdSUSj0xyN9iv4br7p1snUd9prp2hzrq8vFiYnjeCt5P9OexFAFrVdJb
         qZDw==
X-Gm-Message-State: APjAAAVshcBClKS2p3yJszf17QBLGu/gKNDrejTgLzfCLcloL+4a5paY
        w9rmrHaQtKigHiJiN2i9zx0d6+vZvvCndhjaMqrzIQmAnkJHG9neuwESyx7YruMyu5JUdWPH4mb
        tu+KToOz6ax/njLDWNKgymTut
X-Received: by 2002:a1c:4144:: with SMTP id o65mr2093337wma.81.1579688114096;
        Wed, 22 Jan 2020 02:15:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4aJRil/tx8VppIJLye7IN3S0YAWx4OvHVzJ7tulPLojRCiJc2Ih8d67ITRZEjrA1rix0gpA==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr2093323wma.81.1579688113923;
        Wed, 22 Jan 2020 02:15:13 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id t1sm3484231wma.43.2020.01.22.02.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 02:15:13 -0800 (PST)
Subject: Re: [POC 11/23] livepatch: Safely detect forced transition when
 removing split livepatch modules
To:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200117150323.21801-1-pmladek@suse.com>
 <20200117150323.21801-12-pmladek@suse.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <2d92bc17-0844-54dd-b6ea-8d89ce2d590b@redhat.com>
Date:   Wed, 22 Jan 2020 10:15:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200117150323.21801-12-pmladek@suse.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 1/17/20 3:03 PM, Petr Mladek wrote:
> The information about forced livepatch transition is currently stored
> in struct klp_patch. But there is not any obvious safe way how to
> access it when the split livepatch modules are removed.
> 

If that's the only motivation to do this, klp_objects could have a 
reference to the klp_patch they are part of. This could easily be set 
when adding the klp_object to the klp_patch->obj_list in 
klp_init_object_early() .

Having this reference could also prove useful in future scenarios.

Cheers,

-- 
Julien Thierry

